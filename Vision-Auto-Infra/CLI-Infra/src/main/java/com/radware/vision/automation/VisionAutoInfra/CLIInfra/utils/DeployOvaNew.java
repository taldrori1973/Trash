package com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.vmware.vim25.*;
import com.vmware.vim25.mo.*;
import org.apache.commons.io.FilenameUtils;

import javax.net.ssl.*;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.rmi.RemoteException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class DeployOvaNew {

    static {
        disableSslVerification();
    }

    public static void disableSslVerification() {
        try {
            // Create a trust manager that does not validate certificate chains
            TrustManager[] trustAllCerts = new TrustManager[]{new X509TrustManager() {
                @Override
                public java.security.cert.X509Certificate[] getAcceptedIssuers() {
                    return null;
                }

                @Override
                public void checkClientTrusted(X509Certificate[] certs, String authType) {
                }

                @Override
                public void checkServerTrusted(X509Certificate[] certs, String authType) {
                }
            }};

            // Install the all-trusting trust manager
            SSLContext sc = SSLContext.getInstance("SSL");
            sc.init(null, trustAllCerts, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());

            // Create all-trusting host name verifier
            HostnameVerifier allHostsValid = new HostnameVerifier() {

                @Override
                public boolean verify(String hostname, SSLSession session) {
                    return true;
                }
            };

            // Install the all-trusting host verifier
            HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
        } catch (

                NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (KeyManagementException e) {
            e.printStackTrace();
        }
    }

    private ServiceInstance si;
    private static final String DATASTORE = "Datastore";
    private static final String DATACENTER = "Datacenter";

    public DeployOvaNew(String vcenterUrl, String userName, String password) {
        try {
            si = new ServiceInstance(new URL(vcenterUrl), userName, password, true);
        } catch (RemoteException | MalformedURLException e) {
            System.err.println("Unable to connect to vCenter..." + vcenterUrl);
        }
    }

    public String deployVMAndGetip(String hostip, String ovaUrl, File ovfDestFolder, String newVmName,
                                          String networkName, String resourcePool, String dataStores) throws Exception {
        VirtualMachine vm = deployOVF(hostip, ovaUrl, ovfDestFolder, newVmName, networkName, resourcePool, dataStores);
        return getValidIpAddress(vm, "10.205");
    }

    public VirtualMachine deployOVF(String hostip, String ovaUrl, File ovfDestFolder, String newVmName,
                                    String networkName, String resourcePool, String dataStores) throws Exception {
        VirtualMachine vm = null;
        Datastore datastore = null;
        HostSystem hs = null;
        Datacenter dc = null;
        try {
            datastore = (Datastore) new InventoryNavigator(si.getRootFolder()).searchManagedEntity(DATASTORE,
                    dataStores);
            hs = (HostSystem) si.getSearchIndex().findByIp(null, hostip, false);
            dc = getDatacenterFromHost(si, hs);
            ResourcePool rp = getResourcePool(si.getRootFolder(), resourcePool);
            OvfManager ovfManager = si.getOvfManager();
            OvfCreateImportSpecParams ovfCreateImpSpecParms = new OvfCreateImportSpecParams();
            ovfCreateImpSpecParms.setDiskProvisioning(OvfCreateImportSpecParamsDiskProvisioningType.thin.toString());
            ovfCreateImpSpecParms.setEntityName(newVmName);
            ovfCreateImpSpecParms.setDiskProvisioning("thin");
            ovfCreateImpSpecParms.setLocale("US");
            ovfCreateImpSpecParms.setDeploymentOption("");
            ovfCreateImpSpecParms.setNetworkMapping(getNetworkMapping(hs, networkName));
            ovfCreateImpSpecParms.setHostSystem(hs.getMOR());
            ovfCreateImpSpecParms.setPropertyMapping(null);
            UnTar.untarTarUrl(ovaUrl, ovfDestFolder.getAbsolutePath());
            final String fileName = FilenameUtils.getBaseName(ovaUrl);
            String ovfPath = ovfDestFolder + "/" + fileName + ".ovf";
            StringBuffer buffer = new StringBuffer();
            String ovfDescriptor = null;
            FileReader fr = new FileReader(ovfPath);
            BufferedReader br = new BufferedReader(fr);
            String line = "";
            while ((line = br.readLine()) != null) {
                System.out.println(line);
                buffer.append(line).append("\n");
            }
            fr.close();
            ovfDescriptor = buffer.toString();
            Path path = Paths.get(ovfPath);
            ovfPath = path.getParent().toString().replace("\\", "/") + "/";
            System.out.println("ovfFilePath Parent::" + ovfPath);
            OvfCreateImportSpecResult ovfCreateImpSpecResult = ovfManager.createImportSpec(ovfDescriptor, rp,
                    datastore, ovfCreateImpSpecParms);
            HttpNfcLease httpNfcLease = rp.importVApp(ovfCreateImpSpecResult.getImportSpec(),
                    dc.getVmFolder(), hs);
            System.out.println("ovfFilePath Parent::" + ovfPath);
            Thread thread = uploadVMDK(httpNfcLease, ovfCreateImpSpecResult, hs.getName(), ovfPath);
//            int percent = 1;
//            while (thread.isAlive()) {
//                httpNfcLease.httpNfcLeaseProgress(percent);
//                if (percent < 100) {
//                    percent++;
//                }
//                Thread.sleep(3000);
//            }
            httpNfcLease.httpNfcLeaseComplete();
            vm = new VirtualMachine(si.getServerConnection(), httpNfcLease.getInfo().getEntity());
            System.out.println("Successfully VM deployed::" + vm.getName());
            Task task1 = vm.powerOnVM_Task(hs);
            BaseTestUtils.reporter.report("Turning VM power on");
            task1.waitForTask();
        } catch (Exception e) {
            System.err.println("Error::" + e.getMessage());
        }
        return vm;
    }

    public Datacenter getDatacenterFromHost(ServiceInstance si, HostSystem hs) {
        Datacenter dc = null;
        ManagedEntity me = hs.getParent();
        boolean status = false;
        String type = null;
        while (!status) {
            type = me.getMOR().getType();
            if (type.equalsIgnoreCase(DATACENTER)) {
                dc = new Datacenter(si.getServerConnection(), me.getMOR());
                status = true;
            } else {
                me = me.getParent();
            }
        }
        return dc;
    }

    public Thread uploadVMDK(HttpNfcLease httpNfcLease, OvfCreateImportSpecResult importSpecResult, String hostName,
                             String ovfFilePath) {
        UploadVMDK uploadVmdk = new UploadVMDK(httpNfcLease, importSpecResult, hostName, ovfFilePath);
        Thread thread = new Thread(uploadVmdk);
        thread.start();
        return thread;
    }

    public static long addTotalBytes(OvfCreateImportSpecResult ovfImportResult) {
        OvfFileItem[] fileItems = ovfImportResult.getFileItem();
        long totalBytes = 0;
        if (fileItems != null) {
            for (OvfFileItem ovfFI : fileItems) {
                System.out.println("DeviceId: " + ovfFI.getDeviceId());
                System.out.println("Path: " + ovfFI.getPath());
                System.out.println("Size: " + ovfFI.getSize());
                totalBytes += ovfFI.getSize();
            }
            System.out.println("Total Bytes::" + totalBytes);
        }
        return totalBytes;
    }

    private static void uploadVMDKFile(String vmdkFile, String url) throws IOException {
        System.out.println("Enter into uploadVMDK::" + vmdkFile + " , " + url);
        HttpsURLConnection.setDefaultHostnameVerifier(new HostnameVerifier() {
            public boolean verify(String urlHostName, SSLSession session) {
                return true;
            }
        });
        int CHUCK_LEN = 64 * 1024;
        HttpsURLConnection httpConn = (HttpsURLConnection) new URL(url).openConnection();
        httpConn.setDoOutput(true);
        httpConn.setUseCaches(false);
        httpConn.setChunkedStreamingMode(100 * 1024 * 1024);
        httpConn.setRequestMethod("POST");
        httpConn.setRequestProperty("Connection", "Keep-Alive");
        httpConn.setRequestProperty("Expect", "100-continue");
        httpConn.setRequestProperty("Overwrite", "t");
        httpConn.setRequestProperty("Content-Type", "application/x-vnd.vmware-streamVmdk");
        httpConn.setRequestProperty("Content-Length", Long.toString(new File(vmdkFile).length()));
        httpConn.connect();
        BufferedOutputStream bos = new BufferedOutputStream(httpConn.getOutputStream());
        BufferedInputStream diskis = new BufferedInputStream(new FileInputStream(vmdkFile));
        int bytesAvailable = diskis.available();
        int bufferSize = Math.min(bytesAvailable, CHUCK_LEN);
        byte[] buffer = new byte[bufferSize];
        long totalBytesUploaded = 0;
        while (true) {
            int bytesRead = diskis.read(buffer, 0, bufferSize);
            if (bytesRead == -1) {
                break;
            }
            totalBytesUploaded += bytesRead;
            bos.write(buffer, 0, bufferSize);
            bos.flush();

        }
        System.out.println("Total Bytes Uploaded: " + totalBytesUploaded);
        diskis.close();
        bos.flush();
        bos.close();
        httpConn.disconnect();
    }

    private static OvfNetworkMapping[] getNetworkMapping(HostSystem host, String networkName) throws Exception {
        String vmNetwork = "VM Network";
        String net_50 = "Net_50";
        List<OvfNetworkMapping> ovfNetworkMappings= new ArrayList<>();
        for (Network network : host.getNetworks()) {
            if (network.getName().equals(networkName) || network.getName().equals(net_50) || network.getName().equals(vmNetwork)) {
                OvfNetworkMapping networkMapping = new OvfNetworkMapping();
                networkMapping.setName(network.getName());
                networkMapping.setNetwork(network.getMOR());
                ovfNetworkMappings.add(networkMapping);
            }
        }

        if (ovfNetworkMappings.isEmpty()) {
            throw new Exception("Network: " + networkName + " was not found.");
        }
        OvfNetworkMapping[] ovfNetworks = new OvfNetworkMapping[ovfNetworkMappings.size()];
        ovfNetworkMappings.toArray(ovfNetworks);
        return ovfNetworks;
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

    public String getValidIpAddress(VirtualMachine virtualMachine, String ipPrefix) throws Exception {
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
                ArrayList<String> ipsList = new ArrayList<>(Arrays.asList(currentNic.getIpAddress() != null ? currentNic.getIpAddress() : new String[0]));
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
        return availableIpList.get(0);
    }

    private class UploadVMDK extends Thread {
        private HttpNfcLease httpNfcLease;
        private OvfCreateImportSpecResult importSpecResult;
        private String hostName;
        private String ovfFilePath;

        UploadVMDK(HttpNfcLease httpNfcLease, OvfCreateImportSpecResult importSpecResult, String hostName,
                   String ovfFilePath) {
            this.httpNfcLease = httpNfcLease;
            this.importSpecResult = importSpecResult;
            this.hostName = hostName;
            this.ovfFilePath = ovfFilePath;
        }

        public void run() {
            try {
                HttpNfcLeaseState state;
                while (true) {
                    state = httpNfcLease.getState();
                    if (state == HttpNfcLeaseState.ready || state == HttpNfcLeaseState.error)
                        break;
                }
                if (state == HttpNfcLeaseState.ready) {
                    HttpNfcLeaseInfo httpNfcLeaseInfo = httpNfcLease.getInfo();
                    httpNfcLeaseInfo.setLeaseTimeout(300 * 1000 * 1000);
                    HttpNfcLeaseDeviceUrl[] nfcDeviceUrls = httpNfcLeaseInfo.getDeviceUrl();
                    for (HttpNfcLeaseDeviceUrl nfsDeviceUrl : nfcDeviceUrls) {
                        String deviceKey = nfsDeviceUrl.getImportKey();
                        for (OvfFileItem ovfFileItem : importSpecResult.getFileItem()) {
                            if (deviceKey.equals(ovfFileItem.getDeviceId())) {
                                String vmdkFile = ovfFilePath + ovfFileItem.getPath();
                                uploadVMDKFile(vmdkFile, nfsDeviceUrl.getUrl().replace("*", hostName));
                                System.out.println("Successfully completed uploading the VMDK::" + vmdkFile);
                            }
                        }
                    }
                }

            } catch (Exception e) {
                System.err.println("Error::" + e.getMessage());
            }
        }
    }
}
