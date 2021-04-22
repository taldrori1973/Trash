package com.radware.vision.automation.AutoUtils.vision_handlers;

import com.github.junrar.rarfile.HostSystem;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.utils.URLUtils;

import com.vmware.vim25.*;
import com.vmware.vim25.mo.*;
import org.apache.commons.io.FilenameUtils;

import javax.mail.Folder;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLSession;
import java.io.*;
import java.net.URL;
import java.rmi.RemoteException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author Hadar Elbaz
 */

public class DeployOva {

    private static final int CHUCK_LEN = 64 * 1024;

    public static LeaseProgressUpdater leaseUpdater;

    public static String deployOvfFromUrlAndGetIp(String targetUrl, String userName, String password, String hostip, String ovaUrl,
                                                  File ovfDestFolder, String newVmName, String networkName, String resourcePool, String destFolder, String dataStores, boolean isAPM)
            throws Exception {

        ServiceInstance si = new ServiceInstance(new URL(targetUrl), userName, password, true);
        UnTar.untarTarUrl(ovaUrl, ovfDestFolder.getAbsolutePath());
        final String fileName = FilenameUtils.getBaseName(ovaUrl);
        String ovfpath = ovfDestFolder + "/" + fileName + ".ovf";

        BaseTestUtils.reportInfoMessage("Depolying OVF file " + ovfpath);
        HostSystem host = (HostSystem) si.getSearchIndex().findByIp(null, hostip, false);
        OvfCreateImportSpecParams importSpecParams = new OvfCreateImportSpecParams();
        importSpecParams.setHostSystem(host.getMOR());
        importSpecParams.setLocale("US");
        importSpecParams.setEntityName(newVmName);
        importSpecParams.setDiskProvisioning("thin");
        importSpecParams.setDeploymentOption("");
        importSpecParams.setNetworkMapping(new OvfNetworkMapping[]{getNetworkMapping(host, networkName)});
        importSpecParams.setPropertyMapping(null);

        String ovfDescriptor = getOvfDescriptor(ovfpath);
        ovfDescriptor = ovfDescriptor.replaceAll("&gt;", ">");
        ovfDescriptor = ovfDescriptor.replaceAll("&lt;", "<");
        if (ovfDescriptor == null) {
            si.getServerConnection().logout();
            return null;
        }
        ResourcePool rp = getResourcePool(si.getRootFolder(), resourcePool);

        Folder vmFolder = destFolder == null ? null : getVmFolder(rp, destFolder);

        Datastore dataStore = getDataStore(host, dataStores);
        
        BaseTestUtils.reportInfoMessage("Host Name : " + host.getName());
        BaseTestUtils.reportInfoMessage("Network : " + host.getNetworks()[1].getName());
        BaseTestUtils.reportInfoMessage("Datastore : " + dataStore.getName());
        BaseTestUtils.reportInfoMessage("userName : " + userName);
        BaseTestUtils.reportInfoMessage("password : " + password);
        BaseTestUtils.reportInfoMessage("destFolder : " + destFolder);


        OvfCreateImportSpecResult ovfImportResult = si.getOvfManager().createImportSpec(ovfDescriptor, rp, dataStore, importSpecParams);

        if (ovfImportResult == null) {
            si.getServerConnection().logout();
            return null;
        }

        long totalBytes = addTotalBytes(ovfImportResult);
        BaseTestUtils.reportInfoMessage("Total bytes: " + totalBytes);

        HttpNfcLease httpNfcLease = rp.importVApp(ovfImportResult.getImportSpec(), vmFolder, host);

        // Wait until the HttpNfcLeaseState is ready
        HttpNfcLeaseState hls;
        for (; ; ) {
            hls = httpNfcLease.getState();
            if (hls == HttpNfcLeaseState.ready || hls == HttpNfcLeaseState.error) {
                break;
            }
        }

        if (hls.equals(HttpNfcLeaseState.ready)) {
            BaseTestUtils.reportInfoMessage("HttpNfcLeaseState: ready ");
            HttpNfcLeaseInfo httpNfcLeaseInfo = (HttpNfcLeaseInfo) httpNfcLease.getInfo();
            printHttpNfcLeaseInfo(httpNfcLeaseInfo);

            leaseUpdater = new LeaseProgressUpdater(httpNfcLease, 5000);
            leaseUpdater.start();

            HttpNfcLeaseDeviceUrl[] deviceUrls = httpNfcLeaseInfo.getDeviceUrl();

            long bytesAlreadyWritten = 0;
            for (HttpNfcLeaseDeviceUrl deviceUrl : deviceUrls) {
                String deviceKey = deviceUrl.getImportKey();
                for (OvfFileItem ovfFileItem : ovfImportResult.getFileItem()) {
                    if (deviceKey.equals(ovfFileItem.getDeviceId())) {
                        BaseTestUtils.reportInfoMessage("Import key==OvfFileItem device id: " + deviceKey);
                        String absoluteFile = new File(ovfpath).getParent() + File.separator + ovfFileItem.getPath();
                        String urlToPost = deviceUrl.getUrl().replace("*", hostip);


                        uploadVmdkFile(ovfFileItem.isCreate(), absoluteFile, urlToPost, bytesAlreadyWritten, totalBytes);
                        bytesAlreadyWritten += ovfFileItem.getSize();

                        BaseTestUtils.reportInfoMessage("Completed uploading the VMDK file:" + absoluteFile);
                    }
                }
            }
            leaseUpdater.interrupt();
            httpNfcLease.httpNfcLeaseProgress(100);
            httpNfcLease.httpNfcLeaseComplete();
        }


        deleteOvaDeploymentFiles(ovfDestFolder, fileName);

        BaseTestUtils.reportInfoMessage("Scanning VMs under Resource pool " + resourcePool + " for getting the IP of " + newVmName + " VM");
        VirtualMachine[] vms1 = rp.getVMs();
        VirtualMachine currentVm = null;
        for (VirtualMachine vm : vms1) {
            BaseTestUtils.reportInfoMessage("vm: " + vm.getName() + " parent: " + ((Folder) vm.getParent()).getName());
            BaseTestUtils.reportInfoMessage("IP: " + vm.getGuest().getIpAddress());
            if (vm.getName().equals(newVmName)) {
                currentVm = vm;
                break;
            }
        }
        if (currentVm == null) {
            si.getServerConnection().logout();
            return null;
        }

//        // Set reachable network for initial configuration
        VMNetworkingOps vmNetworkingOps = new VMNetworkingOps(targetUrl, hostip, userName, password);

//        if (macAddr != null && !macAddr.equals("")) {
//            vmNetworkingOps.setVMMacAddress(newVmName, macAddr, networkName);
//        }
        //========== set memoryDB size ====================
        if (!isAPM) {
            vmNetworkingOps.setMemoryConfiguration(newVmName, MemoryDbSize.DEFAULT_MEMORY_DB_SIZE.getMemorySize());
        }
        //=================================================
        Task task1 = currentVm.powerOnVM_Task(host);
        BaseTestUtils.reportInfoMessage("Turning VM power on");
        task1.waitForTask();


        ////////////
        // Wait for ip, check every 30 sec for 5 minutes.
        String ip = null;
        long startTime = System.currentTimeMillis();
        if (!isAPM) {
            ip = getValidIpAddress(currentVm, "10.205");
        } else {
            ip = waitForValidIp(currentVm);
        }

        BaseTestUtils.reportInfoMessage("Final IP: " + ip);

        si.getServerConnection().logout();
        return ip;
    }
    //================================ Temp Method ==========================
    public static String deployOvfFromUrlAndGetIp(String targetUrl, String userName, String password, String hostip, String ovaUrl,
                                                  File ovfDestFolder, String newVmName, String networkName, String macAddr, String containedDVS, String resourcePool, String destFolder, String dataStores, boolean isAPM)
            throws Exception {

        ServiceInstance si = new ServiceInstance(new URL(targetUrl), userName, password, true);
        UnTar.untarTarUrl(ovaUrl, ovfDestFolder.getAbsolutePath());
        final String fileName = FilenameUtils.getBaseName(ovaUrl);
        String ovfPath = ovfDestFolder + "/" + fileName + ".ovf";

        BaseTestUtils.reporter.startLevel("Deploying OVF file " + ovfPath);
        HostSystem host = (HostSystem) si.getSearchIndex().findByIp(null, hostip, false);
        OvfCreateImportSpecParams importSpecParams = new OvfCreateImportSpecParams();
        importSpecParams.setHostSystem(host.getMOR());
        importSpecParams.setLocale("US");
        importSpecParams.setEntityName(newVmName);
        importSpecParams.setDiskProvisioning("thin");
        importSpecParams.setDeploymentOption("");
        importSpecParams.setNetworkMapping(new OvfNetworkMapping[]{getNetworkMapping(host, networkName)});
        importSpecParams.setPropertyMapping(null);

        String ovfDescriptor = getOvfDescriptor(ovfPath);
        ovfDescriptor = ovfDescriptor.replaceAll("&gt;", ">");
        ovfDescriptor = ovfDescriptor.replaceAll("&lt;", "<");
        if (ovfDescriptor == null) {
            si.getServerConnection().logout();
            return null;
        }
        ResourcePool rp = getResourcePool(si.getRootFolder(), resourcePool);

        Folder vmFolder = destFolder == null ? null : getVmFolder(rp, destFolder);

        Datastore dataStore = getDataStore(host, dataStores);

        BaseTestUtils.reporter.report("Host Name : " + host.getName());
        BaseTestUtils.reporter.report("Network : " + host.getNetworks()[1].getName());
        BaseTestUtils.reporter.report("Datastore : " + dataStore.getName());
        BaseTestUtils.reporter.report("userName : " + userName);
        BaseTestUtils.reporter.report("password : " + password);
        BaseTestUtils.reporter.report("destFolder : " + destFolder);


        OvfCreateImportSpecResult ovfImportResult = si.getOvfManager().createImportSpec(ovfDescriptor, rp, dataStore, importSpecParams);

        if (ovfImportResult == null) {
            si.getServerConnection().logout();
            return null;
        }

        long totalBytes = addTotalBytes(ovfImportResult);
        BaseTestUtils.reporter.report("Total bytes: " + totalBytes);

        HttpNfcLease httpNfcLease = rp.importVApp(ovfImportResult.getImportSpec(), vmFolder, host);

        // Wait until the HttpNfcLeaseState is ready
        HttpNfcLeaseState hls;
        for (; ; ) {
            hls = httpNfcLease.getState();
            if (hls == HttpNfcLeaseState.ready || hls == HttpNfcLeaseState.error) {
                break;
            }
        }

        if (hls.equals(HttpNfcLeaseState.ready)) {
            BaseTestUtils.reporter.report("HttpNfcLeaseState: ready ");
            HttpNfcLeaseInfo httpNfcLeaseInfo = (HttpNfcLeaseInfo) httpNfcLease.getInfo();
            printHttpNfcLeaseInfo(httpNfcLeaseInfo);

            leaseUpdater = new LeaseProgressUpdater(httpNfcLease, 5000);
            leaseUpdater.start();

            HttpNfcLeaseDeviceUrl[] deviceUrls = httpNfcLeaseInfo.getDeviceUrl();

            long bytesAlreadyWritten = 0;
            for (HttpNfcLeaseDeviceUrl deviceUrl : deviceUrls) {
                String deviceKey = deviceUrl.getImportKey();
                for (OvfFileItem ovfFileItem : ovfImportResult.getFileItem()) {
                    if (deviceKey.equals(ovfFileItem.getDeviceId())) {
                        BaseTestUtils.reporter.report("Import key==OvfFileItem device id: " + deviceKey);
                        String absoluteFile = new File(ovfPath).getParent() + File.separator + ovfFileItem.getPath();
                        String urlToPost = deviceUrl.getUrl().replace("*", hostip);


                        uploadVmdkFile(ovfFileItem.isCreate(), absoluteFile, urlToPost, bytesAlreadyWritten, totalBytes);
                        bytesAlreadyWritten += ovfFileItem.getSize();

                        BaseTestUtils.reporter.report("Completed uploading the VMDK file:" + absoluteFile);
                    }
                }
            }
            leaseUpdater.interrupt();
            httpNfcLease.httpNfcLeaseProgress(100);
            httpNfcLease.httpNfcLeaseComplete();
        }

        BaseTestUtils.reporter.stopLevel();

        deleteOvaDeploymentFiles(ovfDestFolder, fileName);

        BaseTestUtils.reporter.startLevel("Scanning VMs under Resource pool " + resourcePool + " for getting the IP of " + newVmName + " VM");
        VirtualMachine[] vms1 = rp.getVMs();
        VirtualMachine currentVm = null;
        for (VirtualMachine vm : vms1) {
            BaseTestUtils.reporter.report("vm: " + vm.getName() + " parent: " + ((Folder) vm.getParent()).getName());
            BaseTestUtils.reporter.report("IP: " + vm.getGuest().getIpAddress());
            if (vm.getName().equals(newVmName)) {
                currentVm = vm;
                break;
            }
        }
        if (currentVm == null) {
            si.getServerConnection().logout();
            return null;
        }

//        // Set reachable network for initial configuration
        VMNetworkingOps vmNetworkingOps = new VMNetworkingOps(targetUrl, hostip, userName, password);

        //========== set memoryDB size ====================
//        if (!isAPM) {
//            vmNetworkingOps.setMemoryConfiguration(newVmName, MemoryDbSize.DEFAULT_MEMORY_DB_SIZE.getMemorySize());
//        }
        //=================================================
        Task task1 = currentVm.powerOnVM_Task(host);
        BaseTestUtils.reporter.report("Turning VM power on");
        task1.waitForTask();


        // Wait for ip, check every 30 sec for 5 minutes.
        String ip;
        if (!isAPM) {
            ip = getValidIpAddress(currentVm, "10.205");
        } else {
            ip = waitForValidIp(currentVm);
        }

        BaseTestUtils.reporter.report("Final IP: " + ip);

        si.getServerConnection().logout();
        BaseTestUtils.reporter.stopLevel();
        return ip;
    }

    public static String waitForValidIp(VirtualMachine virtualMachine) throws Exception {
        String ip = null;
        try {
            long startTime = System.currentTimeMillis();
            do {
                Thread.sleep(2000);
                try {
                    ip = virtualMachine.getGuest().getIpAddress();
                } catch (Exception e) {

                }
            } while ((ip == null && ((startTime + 40 * 60 * 1000) > System.currentTimeMillis())));
        } catch (Exception e) {
            throw new Exception(e);
        }
        return ip;
    }

    public static String getValidIpAddress(VirtualMachine virtualMachine, String ipPrefix) throws Exception {
        List<GuestNicInfo> guestNics = new ArrayList<>();
        List<String> availableIpList = null;
        try {
            long startTime = System.currentTimeMillis();
            do {
                Thread.sleep(2000);
                try {
                    if (virtualMachine != null) {
                        GuestInfo guestInfo = virtualMachine.getGuest();
                        if (guestInfo != null) {
                            guestNics.addAll(Arrays.asList(guestInfo.getNet()));
                        }
                    }
                } catch (Exception e) {
                    continue;
                }
            } while ((guestNics.size() == 0 && ((startTime + 40 * 60 * 1000) > System.currentTimeMillis())));
            availableIpList = new ArrayList<>();
            for (GuestNicInfo currentNic : guestNics) {
                if (currentNic == null) {
                    continue;
                }
                ArrayList<String> ipsList = new ArrayList<String>(Arrays.asList(currentNic.getIpAddress() != null ? currentNic.getIpAddress() : new String[0]));
                for (String currentIp : ipsList) {
                    if (currentIp == null) {
                        continue;
                    }
                    if (currentIp.startsWith(ipPrefix)) {
                        availableIpList.add(currentIp);
                    }
                }
            }
//      Find any valid IP address to use
            for (String currentIp : availableIpList) {
                if (currentIp.startsWith(ipPrefix)) {
                    return currentIp;
                }
            }
        } catch (Exception e) {
            throw new Exception(e);
        }
        return availableIpList != null ? availableIpList.get(0) : "10.10.0.10";
    }

    public static boolean setMgmtIpAddress(VirtualMachine virtualMachine, String ipAddress) throws Exception {
        GuestNicInfo[] guestNics = virtualMachine.getGuest().getNet();
        if (guestNics == null) {
            return false;
        }
        ArrayList<GuestNicInfo> nicslist = new ArrayList<GuestNicInfo>(Arrays.asList(guestNics));
        (nicslist.get(1)).setIpAddress(new String[]{ipAddress});
        return true;
    }

    public static void stopStartVmMachines(RadwareServerCli cliConnection, String targetUrl, String hostIp, String resourcePool, String username, String password, String vmNamePrefix, boolean isStopMachine) throws Exception {
        ServiceInstance si = new ServiceInstance(new URL(targetUrl), username, password, true);
        ResourcePool rp = getResourcePool(si.getRootFolder(), resourcePool);

        VirtualMachine[] vms1 = rp.getVMs();
        HostSystem host = (HostSystem) si.getSearchIndex().findByIp(null, hostIp, false);
        for (VirtualMachine vm : vms1) {
            if (vm != null && vm.getName().startsWith(vmNamePrefix)) {
                Task stopStartTask = isStopMachine ? vm.powerOffVM_Task() : vm.powerOnVM_Task(host);
                stopStartTask.waitForTask();
                if (!isStopMachine) {
                    waitForGuest(vm, 20 * 60 * 1000, true);
                    VisionServer.waitForVisionServerServicesToStartHA(cliConnection, 15 * 60 * 1000);
                }
            }
        }
    }

    public static void deleteVmMachines(String targetUrl, String hostIp, String resourcePool, String username, String password, String vmNamePrefix, int deleteMinutes) throws Exception {
        SimpleDateFormat format = getOVADateFormat();

        Calendar deleteCal = Calendar.getInstance();
        deleteCal.add(Calendar.MINUTE, deleteMinutes * -1);
        Date deleteDate = deleteCal.getTime();

        ServiceInstance si = new ServiceInstance(new URL(targetUrl), username, password, true);
        ResourcePool rp = getResourcePool(si.getRootFolder(), resourcePool);

        VirtualMachine[] vms1 = rp.getVMs();
        HostSystem host = (HostSystem) si.getSearchIndex().findByIp(null, hostIp, false);
        String vmName = "";
        for (VirtualMachine vm : vms1) {
            try {
                if (vm != null && vm.getName().startsWith(vmNamePrefix) && vm.getSummary().getRuntime().getPowerState().equals(VirtualMachinePowerState.poweredOff)) {
                    vmName = vm.getName();
                    String timeStr = vmName.substring(vmName.lastIndexOf("_") + 1).replace(" IDT ", " ");
                    Date date = format.parse(timeStr);
                    if (date.before(deleteDate)) {
                        Task shutdownTask = vm.powerOffVM_Task();
                        shutdownTask.waitForTask();
                        Task deleteTask = vm.destroy_Task();
                        deleteTask.waitForTask();
                        BaseTestUtils.reporter.report("Delete VM: " + vmName);
                    }
                }
            } catch (Exception e) {
                String errMsg = String.format("Error at delete VM: %s, Error: %s", vmName, e.getMessage());
                BaseTestUtils.reportInfoMessage(errMsg);
            }
        }
    }

    public static VirtualMachine getVMEntity(String vmName, ResourcePool rp) throws Exception {
        VirtualMachine[] vms1 = rp.getVMs();
        for (VirtualMachine vm : vms1) {
            VirtualMachineRuntimeInfo vmri = vm.getRuntime();
            if (vmri == null) {
                continue;
            }
            if (vm != null && vm.getName().startsWith(vmName) && vmri.getPowerState() == VirtualMachinePowerState.poweredOn) {
                return vm;
            }
        }
        return null;
    }

    private static void waitForGuest(VirtualMachine targetVm, long timeout, boolean waitForGuestHostname)
            throws InterruptedException, RemoteException {

        if (waitForGuestHostname) {
            targetVm.getResourcePool();
            String guestHostName = null;
            do {
                guestHostName = targetVm.getGuest().getHostName();
                if ("".equals(guestHostName)) {
                    Thread.sleep(1000);
                    timeout -= 1000;
                }
            } while ((guestHostName == null || "".equals(guestHostName)) && timeout > 0);
        }
    }


    private static Datastore getDataStore(HostSystem host, String dataStores) throws Exception {
        for (Datastore data : host.getDatastores()) {
            if (data.getName().equals(dataStores)) {
                return data;
            }
        }
        throw new Exception("Can't find Datastore");
    }

    private static Folder getVmFolder(ResourcePool rp, String destFolde) throws Exception {
        Folder vmFolder = null;
        for (VirtualMachine vm : rp.getVMs()) {
            vmFolder = (Folder) vm.getParent();
            if (vmFolder.getName().equals(destFolde)) {
                return vmFolder;
            }
        }
        throw new Exception("Can't find VmFolder");

    }

    private static String getOvfDescriptor(String ovfLocal) throws Exception {
        String ovfDescriptor = readOvfContent(ovfLocal);
        if (ovfDescriptor == null) {
            throw new Exception("Can't find OvfDescriptor");
        }

        ovfDescriptor = escapeSpecialChars(ovfDescriptor);
        return ovfDescriptor;
    }

    private static OvfNetworkMapping getNetworkMapping(HostSystem host, String networkName) throws Exception {

        OvfNetworkMapping networkMapping = new OvfNetworkMapping();

        Network net = null;
        for (Network network : host.getNetworks()) {
            if (network.getName().equals(networkName)) {
                net = network;
                break;
            }
        }

        if (net == null) {
            throw new Exception("Network: " + networkName + " was not found.");
        }

        networkMapping.setName(networkName);
        networkMapping.setNetwork(net.getMOR());

        return networkMapping;
    }

    public static long addTotalBytes(OvfCreateImportSpecResult ovfImportResult) {
        OvfFileItem[] fileItemArr = ovfImportResult.getFileItem();

        long totalBytes = 0;
        if (fileItemArr != null) {
            for (OvfFileItem fi : fileItemArr) {
                printOvfFileItem(fi);
                totalBytes += fi.getSize();
            }
        }
        return totalBytes;
    }

    public static void runVmGuestCommand(String vmName, String command, String arguments, String userName, String password, String targetUrl, String resourcePool) throws Exception {
        ServiceInstance serviceInstance = new ServiceInstance(new URL(targetUrl), userName, password, true);

        ManagedEntity[] mes = new InventoryNavigator(serviceInstance.getRootFolder()).searchManagedEntities("VirtualMachine");
        if (mes == null || mes.length == 0) {
            return;
        }

        GuestOperationsManager gom = serviceInstance.getGuestOperationsManager();
        VirtualMachine vm = getVMEntity(vmName, getResourcePool(serviceInstance.getRootFolder(), resourcePool));

        if (!"guestToolsRunning".equals(vm.getGuest().toolsRunningStatus)) {
            System.out.println("The VMware Tools is not running in the Guest OS on VM: " + vm.getName());
            System.out.println("Exiting...");
            return;
        }

        NamePasswordAuthentication npa = new NamePasswordAuthentication();
        npa.username = "root";
        npa.password = "radware";

        GuestProgramSpec spec = new GuestProgramSpec();
        spec.programPath = command;
        spec.arguments = arguments;

        GuestProcessManager gpm = gom.getProcessManager(vm);
        long pid = gpm.startProgramInGuest(npa, spec);
        System.out.println("pid: " + pid);

        serviceInstance.getServerConnection().logout();
    }

    private static void uploadVmdkFile(boolean put, String diskFilePath, String urlStr, long bytesAlreadyWritten, long totalBytes)
            throws IOException {
        HttpsURLConnection.setDefaultHostnameVerifier(new HostnameVerifier() {
            public boolean verify(String urlHostName, SSLSession session) {
                return true;
            }
        });
        HttpsURLConnection conn = (HttpsURLConnection) new URL(urlStr).openConnection();
        conn.setDoOutput(true);
        conn.setUseCaches(false);
        conn.setChunkedStreamingMode(CHUCK_LEN);
        conn.setRequestMethod(put ? "PUT" : "POST"); // Use a post method to
        // write the file.
        conn.setRequestProperty("Connection", "Keep-Alive");
        conn.setRequestProperty("Content-Type", "application/x-vnd.vmware-streamVmdk");
        conn.setRequestProperty("Content-Length", Long.toString(new File(diskFilePath).length()));
        BufferedOutputStream bos = new BufferedOutputStream(conn.getOutputStream());
        BufferedInputStream diskis = new BufferedInputStream(new FileInputStream(diskFilePath));
        int bytesAvailable = diskis.available();
        int bufferSize = Math.min(bytesAvailable, CHUCK_LEN);
        byte[] buffer = new byte[bufferSize];

        long totalBytesWritten = 0;
        while (true) {
            int bytesRead = diskis.read(buffer, 0, bufferSize);
            if (bytesRead == -1) {
                break;
            }

            totalBytesWritten += bytesRead;
            bos.write(buffer, 0, bufferSize);
            bos.flush();
            int progressPercent = (int) (((bytesAlreadyWritten + totalBytesWritten) * 100) / totalBytes);
            leaseUpdater.setPercent(progressPercent);
        }
        diskis.close();
        bos.flush();
        bos.close();
        conn.disconnect();
    }

    public static String readOvfContent(String ovfFilePath) throws IOException {
        StringBuffer strContent = new StringBuffer();
        BufferedReader in = new BufferedReader(new InputStreamReader(new FileInputStream(ovfFilePath)));
        String lineStr;
        while ((lineStr = in.readLine()) != null) {
            strContent.append(lineStr);
            BaseTestUtils.reportInfoMessage(lineStr);
        }
        in.close();
        return strContent.toString();
    }

    public static String readOvfContent(FileInputStream ovfInputStream) throws IOException {
        StringBuffer strContent = new StringBuffer();
        BufferedReader in = new BufferedReader(new InputStreamReader(ovfInputStream));
        String lineStr;
        while ((lineStr = in.readLine()) != null) {
            strContent.append(lineStr);
            BaseTestUtils.reportInfoMessage(lineStr);
        }
        in.close();
        return strContent.toString();
    }

    private static void printHttpNfcLeaseInfo(HttpNfcLeaseInfo info) {
        BaseTestUtils.reportInfoMessage("================ HttpNfcLeaseInfo ================");
        HttpNfcLeaseDeviceUrl[] deviceUrlArr = info.getDeviceUrl();
        for (HttpNfcLeaseDeviceUrl durl : deviceUrlArr) {
            BaseTestUtils.reportInfoMessage("Device URL Import Key: " + durl.getImportKey());
            BaseTestUtils.reportInfoMessage("Device URL Key: " + durl.getKey());
            BaseTestUtils.reportInfoMessage("Device URL : " + durl.getUrl());
            BaseTestUtils.reportInfoMessage("Updated device URL: " + durl.getUrl());
        }
        BaseTestUtils.reportInfoMessage("Lease Timeout: " + info.getLeaseTimeout());
        BaseTestUtils.reportInfoMessage("Total Disk capacity: " + info.getTotalDiskCapacityInKB());
        BaseTestUtils.reportInfoMessage("==================================================");
    }

    private static void printOvfFileItem(OvfFileItem fi) {
        BaseTestUtils.reportInfoMessage("================ OvfFileItem ================");
        BaseTestUtils.reportInfoMessage("chunkSize: " + fi.getChunkSize());
        BaseTestUtils.reportInfoMessage("create: " + fi.isCreate());
        BaseTestUtils.reportInfoMessage("deviceId: " + fi.getDeviceId());
        BaseTestUtils.reportInfoMessage("path: " + fi.getPath());
        BaseTestUtils.reportInfoMessage("size: " + fi.getSize());
        BaseTestUtils.reportInfoMessage("==============================================");
    }

    public static String escapeSpecialChars(String str) {
        str = str.replaceAll("<", "&lt;");
        return str.replaceAll(">", "&gt;"); // do not escape "&" -> "&amp;",
        // "\"" -> "&quot;"
    }

    /**
     * @throws Exception
     * @author izikp
     * <p>
     * Get the last Successful Build number for the specified job in jenkins
     * returns String.
     */
    public static String getlastSuccessfulBuildNumberFromJenkins(String jenkinsURL, String jobName) throws IOException {
        BaseTestUtils.reporter.startLevel("get last Vision Successful Build Number From Jenkins");
        String lastSuccessfulBuildNumber = "/lastSuccessfulBuild/buildNumber";

        BaseTestUtils.reportInfoMessage(jenkinsURL + "/job/" + jobName + lastSuccessfulBuildNumber);
        String inputLine = URLUtils.getURLRequestResult(jenkinsURL + "/job/" + jobName + lastSuccessfulBuildNumber);
        BaseTestUtils.reportInfoMessage("Latest build: " + inputLine);


        return inputLine;
    }

    public static String getLastSuccessfulBuildNumberFromArtifactory(String jenkinsURL) throws IOException {
        BaseTestUtils.reporter.startLevel("get last Vision Successful Build Number From Jenkins");
        String lastSuccessfulBuildNumber = "/lastSuccessfulBuild/buildNumber";

        BaseTestUtils.reportInfoMessage(jenkinsURL + lastSuccessfulBuildNumber);
        String inputLine = URLUtils.getURLRequestResult(jenkinsURL + lastSuccessfulBuildNumber);
        BaseTestUtils.reportInfoMessage("Latest build: " + inputLine);

        return inputLine;
    }


    public static void deleteOvaDeploymentFiles(File ovfDestFolder, final String fileName) throws Exception {

        BaseTestUtils.reportInfoMessage("Delete the downloaded OVA file and the untared files");
        // create new filename filter
        FilenameFilter fileNameFilter = new FilenameFilter() {

            @Override
            public boolean accept(File dir, String name) {
                if (name.startsWith(fileName)) {
                    return true;
                }
                return false;
            }
        };


        // Delete the un-TAR ova content & folder
        final File[] files = ovfDestFolder.listFiles(fileNameFilter);
        for (File f : files) {
            BaseTestUtils.reportInfoMessage("Deleting" + f.getPath() + f.getName());
            f.delete();
        }




    }

    public static SimpleDateFormat getOVADateFormat() {
        return new SimpleDateFormat("EEE MMM d HH:mm:ss yyyy");
    }

    private static ResourcePool getResourcePool(Folder rootFolder, String resourcePool) throws Exception {
        ManagedEntity[] datacenters = new InventoryNavigator(rootFolder).searchManagedEntities("Datacenter");

        //Datacenter dc = (Datacenter) datacenters[0];
        for (ManagedEntity meDc : datacenters) {
            // ManagedEntity[] resourcePools = new InventoryNavigator(dc).searchManagedEntities("ResourcePool");
            ManagedEntity[] resourcePools = new InventoryNavigator(meDc).searchManagedEntities("ResourcePool");
            for (ManagedEntity me : resourcePools) {
                if (((ResourcePool) me).getName().equals(resourcePool)) {
                    return (ResourcePool) me;
                }
            }
        }
        throw new Exception("Can't find ResourcePool");
    }

    // Sample code for setting user-defined Ip Address to Ethernet card.

//    private void setIpAddress() {

//    VirtualMachine currentVm = null;
//    ServiceInstance si = new ServiceInstance(new URL("https://10.205.200.251/sdk"), "visionAutomation", "1qaz!QAZ", true);
//    ResourcePool rp = getResourcePool(si.getRootFolder(), "RP-QA");
//    VirtualMachine[] vms1 = rp.getVMs();
//    for (VirtualMachine vm : vms1) {
//        BaseTestUtils.reportInfoMessage("vm: " + vm.getName() + " parent: " + ((Folder) vm.getParent()).getName());
//        BaseTestUtils.reportInfoMessage("IP: " + vm.getGuest().getIpAddress());
//        if (vm.getName().equals("aaa")) {
//            currentVm = vm;
//            break;
//        }
//    }
//        CustomizationSpec customizationSpec = new CustomizationSpec();
//        CustomizationAdapterMapping[] customizationAdapterMappings = new CustomizationAdapterMapping[guestNics.length];
//        for(int i = 0; i < guestNics.length; i++) {
//            CustomizationIPSettings customizationIPSettings = new CustomizationIPSettings();
//            CustomizationFixedIp customizationFixedIp = new CustomizationFixedIp();
//            customizationFixedIp.setIpAddress(ipAddress);
//            customizationIPSettings.setIp(customizationFixedIp);
//            customizationIPSettings.setSubnetMask("255.255.0.0");
//            customizationIPSettings.setGateway(new String[]{"172.17.1.1"});
////            CustomizationIPSettings CustomizationIPSettings = new CustomizationIPSettings();
////            CustomizationIPSettings.set
//            customizationAdapterMappings[i] = new CustomizationAdapterMapping();
//            customizationAdapterMappings[i].setAdapter(customizationIPSettings);
//
//            // Dummy configurations
//            CustomizationOptions options = new CustomizationOptions();
//            CustomizationIdentitySettings identity = new CustomizationIdentitySettings();
//            CustomizationGlobalIPSettings globalIPSettings = new CustomizationGlobalIPSettings();
//
//            customizationSpec.setNicSettingMap(customizationAdapterMappings);
//            customizationSpec.setOptions(options);
//            customizationSpec.setGlobalIPSettings(globalIPSettings);
//            customizationSpec.setIdentity(identity);
//        }
//        Task stopVm = currentVm.powerOffVM_Task();
//        stopVm.waitForTask();
//        Task customizationTask = currentVm.customizeVM_Task(customizationSpec);
//        currentVm.reConfigVM_Task(VirtualMachineConfigSpec)
//        customizationTask.waitForTask();
//        return  true;
//    }
}
