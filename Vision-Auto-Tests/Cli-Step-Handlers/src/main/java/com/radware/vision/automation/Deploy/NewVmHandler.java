package com.radware.vision.automation.Deploy;

import com.aqua.sysobj.conn.CliConnectionImpl;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.licensekeys.LicenseRepository;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.restcore.RestBasicConsts;
import com.radware.restcore.VisionRestClient;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.ReflectionUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.RegexUtils;
import ch.ethz.ssh2.log.Logger;
import com.radware.vision.test_utils.DeployOva;
import com.radware.vision.test_utils.VMNetworkingOps;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.vision_project_cli.VisionCli;
import com.radware.vision.vision_project_cli.VisionRadwareFirstTime;
import com.radware.vision.vision_tests.CliTests;

import java.util.ArrayList;
import java.util.StringJoiner;
import java.io.File;
import java.util.Date;
import java.util.Iterator;

public class NewVmHandler extends CliTests {
    private static final String licenseKeyPrefix = "vision-activation";
    private static String targetVisionMacAddress;
    public VisionRadwareFirstTime visionRadwareFirstTime;
    private static final String ARTIFACT_URL = "http://10.175.95.151:8081/artifactory/vision-snapshot-local";
    private static final String RELEASE_ARTIFACT_URL = "http://10.175.95.151:8081/artifactory/vision-release-local";
    private final String error = " Warning \n Some of the packages you have selected for install are missing  \n dependencies or conflict with another package. You can exit the \n installation, go back and change your package selections, or    \n continue installing these packages without their dependencies.";
    private static final String imagesPath = "/var/lib/libvirt/images/";

    public NewVmHandler() {
        CliTests.isFirstTimeScenario = true;

        try {
            this.visionRadwareFirstTime = (VisionRadwareFirstTime)this.system.getSystemObject("visionRadwareFirstTime");
            this.visionCli = (VisionCli)this.system.getSystemObject("visionCli");
        } catch (Exception var2) {
            BaseTestUtils.report("Failed to read sut object " + var2.getMessage(), 1);
        }

    }

    public NewVmHandler(String machine, String cli) {
        CliTests.isFirstTimeScenario = true;

        try {
            this.visionRadwareFirstTime = (VisionRadwareFirstTime)this.system.getSystemObject(machine);
            this.visionCli = (VisionCli)this.system.getSystemObject(cli);
        } catch (Exception var4) {
            BaseTestUtils.report("Failed to read sut object " + var4.getMessage(), 1);
        }

    }

//    public String getArtifactUrl(String buildNumber, String fileName, String VISION_VERISON) throws Exception {
//        String ArtifactURL;
//        if (!URLUtil.isReachableURL(http://10.175.95.151:8081/artifactory/vision-snapshot-local/ + VISION_VERISON + "/" + buildNumber + "/" + fileName)) {
//            ArtifactURL = http://10.175.95.151:8081/artifactory/vision-release-local/ + VISION_VERISON + "/" + buildNumber + "/" + fileName;
//        } else {
//            if (URLUtil.isReachableURL(http://10.175.95.151:8081/artifactory/vision-release-local/ + VISION_VERISON + "/" + buildNumber + "/" + fileName)) {
//                throw new IllegalStateException("Could not find a build with a valid file to deploy.");
//            }
//
//            ArtifactURL = http://10.175.95.151:8081/artifactory/vision-release-local/ + VISION_VERISON + "/" + buildNumber + "/" + fileName;
//        }
//
//        return ArtifactURL;
//    }

    public void firstTimeWizardKVM(boolean isAPM, String version, String specificVisionBuild, String fileUrl) throws Exception {
        long timeOut = 3600000L;
        ArrayList<String> messages = new ArrayList();
        String fileNotFound = "Error 15: File not found\n";
        messages.add(fileNotFound);
        messages.add(" Warning \n Some of the packages you have selected for install are missing  \n dependencies or conflict with another package. You can exit the \n installation, go back and change your package selections, or    \n continue installing these packages without their dependencies.");
        String mysqlSocketProblem = "Can't connect to local MySQL server";
        messages.add(mysqlSocketProblem);
        String vmName = this.visionRadwareFirstTime.getVmName() + this.visionRadwareFirstTime.getIp();
        InvokeUtils.invokeCommand("rm -rf /var/lib/libvirt/images/" + vmName + ".iso", this.visionRadwareFirstTime);
        InvokeUtils.invokeCommand("cd /var/lib/libvirt/images/", this.visionRadwareFirstTime);
        InvokeUtils.invokeCommand((Logger)null, "wget " + fileUrl + " -O " + vmName + ".iso", this.visionRadwareFirstTime, 600000L);
        StringJoiner installCommand = new StringJoiner(" ");
        installCommand.add("virt-install").add("--name " + vmName);
        String selectCommand;
        if (isAPM) {
            installCommand.add("--ram 32768").add("--vcpus 12").add("--disk /var/lib/libvirt/images/" + vmName + ".img,size=250,bus=virtio,format=qcow2").add("--disk /var/lib/libvirt/images/" + vmName + "_APM.img,size=350,bus=virtio,format=qcow2").add("--cdrom /var/lib/libvirt/images/" + vmName + ".iso").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--network network=TAG.502.ADC.Servers,model=virtio").add("--graphics none").add("--video cirrus").add("--serial pty");
            selectCommand = "A";
        } else {
            installCommand.add("--ram 24576").add("--vcpus 8").add("--disk " + vmName + ".img,size=250,bus=virtio").add("--cdrom /var/lib/libvirt/images/" + vmName + ".iso").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--graphics none").add("--video cirrus").add("--serial pty");
            selectCommand = "I";
        }

        this.visionRadwareFirstTime.changeCommandToSendForPrompt("vision.radware login: ", "radware");
        InvokeUtils.invokeCommand((Logger)null, installCommand.toString(), this.visionRadwareFirstTime, 30000L, false, false, false);
        Thread.sleep(15000L);
        boolean isShutoff;
        if (selectCommand.equals("A")) {
            timeOut = 3000000L;
            InvokeUtils.invokeCommand((Logger)null, selectCommand, this.visionRadwareFirstTime, 60000L, false, false, false, (String)null, true);
            selectCommand = "\r";
            Thread.sleep(120000L);
            InvokeUtils.invokeCommand((Logger)null, "yes", this.visionRadwareFirstTime, 60000L, false, false, false, (String)null, true);
            Thread.sleep(660000L);
            long startTime = System.currentTimeMillis();
            long maxTimeOut = 7200000L;

            boolean pingResult;
            long currentTime;
            do {
                this.visionRadwareFirstTime.changeCommandToSendForPrompt("vision.radware login: ", "radware");
                InvokeUtils.invokeCommand((Logger)null, "virsh start " + vmName, this.visionRadwareFirstTime, 60000L, false, false, false, (String)null, true);
                InvokeUtils.invokeCommand((Logger)null, "virsh console " + vmName + " --force", this.visionRadwareFirstTime, 60000L, false, false, false, (String)null, true);

                try {
                    InvokeUtils.invokeCommand((Logger)null, selectCommand, this.visionRadwareFirstTime, timeOut, true, false, true, (String)null, true, false);
                } catch (Exception var23) {
                }

                this.isContained(messages, vmName, specificVisionBuild, version);
                InvokeUtils.invokeCommand((Logger)null, "virsh list --all", this.visionRadwareFirstTime);
                isShutoff = RegexUtils.isStringContainsThePattern(vmName + ".*shut off.*", this.visionRadwareFirstTime.getTestAgainstObject().toString());
                InvokeUtils.invokeCommand((Logger)null, "ping -c 4 " + this.visionRadwareFirstTime.getIp(), this.visionRadwareFirstTime, 180000L, true, false, true, (String)null, true, false);
                pingResult = RegexUtils.isStringContainsThePattern("100% packet loss", this.visionRadwareFirstTime.getTestAgainstObject().toString());
                currentTime = System.currentTimeMillis();
            } while((isShutoff || pingResult) & currentTime - startTime < maxTimeOut);

            if (pingResult && !isShutoff) {
                this.visionRadwareFirstTime.connect();
                InvokeUtils.invokeCommand((Logger)null, "virsh destroy " + vmName, this.visionRadwareFirstTime, 180000L);
                InvokeUtils.invokeCommand((Logger)null, "virsh start " + vmName, this.visionRadwareFirstTime, 180000L);
                InvokeUtils.invokeCommand((Logger)null, "virsh console " + vmName + " --force", this.visionRadwareFirstTime, 60000L, false, false, false, (String)null, true);
                InvokeUtils.invokeCommand((Logger)null, selectCommand, this.visionRadwareFirstTime, timeOut, true, false, true, (String)null, true, false);
            }
        }

        try {
            InvokeUtils.invokeCommand((Logger)null, selectCommand, this.visionRadwareFirstTime, timeOut);
        } catch (Exception var22) {
            this.isContained(messages, vmName, specificVisionBuild, version);
            throw new Exception(var22.getMessage());
        }

        this.isContained(messages, vmName, specificVisionBuild, version);
        this.visionRadwareFirstTime.connect();
        InvokeUtils.invokeCommand("rm -rf /var/lib/libvirt/images/" + vmName + ".iso", this.visionRadwareFirstTime);
        InvokeUtils.invokeCommand("virsh list --all", this.visionRadwareFirstTime);
        isShutoff = RegexUtils.isStringContainsThePattern(vmName + ".*running.*", this.visionRadwareFirstTime.getTestAgainstObject().toString());
        if (!isShutoff) {
            this.deleteKvm(vmName);
            BaseTestUtils.report(" The vm : '" + vmName + "' is not exist! failed to be created successfully ", 1);
        }

        RadwareServerCli radwareServerCli = this.visionCli.visionServer.visionRadware;
        if (VisionServer.waitForVisionServerServicesToStartHA(radwareServerCli, 2700000L)) {
            BaseTestUtils.reporter.report("All services up");
        } else {
            BaseTestUtils.report("Not all services up.", 1);
        }

    }

    private void isContained(ArrayList<String> list, String vmName, String specificVisionBuild, String fullNameVersion) throws Exception {
        Iterator var5 = list.iterator();

        while(var5.hasNext()) {
            String message = (String)var5.next();
            if (RegexUtils.isStringContainsThePattern(message, this.visionRadwareFirstTime.getTestAgainstObject().toString())) {
                InvokeUtils.invokeCommand("rm -rf /var/lib/libvirt/images/APSoluteVision-Serial_console-" + fullNameVersion + "*", this.visionRadwareFirstTime);
                this.deleteKvm(vmName);
                BaseTestUtils.report(" No " + vmName + " created , we have a problem with a build : '" + specificVisionBuild + "',we get problem stuck on : " + message + " ", 1);
            }
        }

    }

    public void deleteKvm(String vmName) throws Exception {
        InvokeUtils.invokeCommand("virsh destroy " + vmName, this.visionRadwareFirstTime);
        InvokeUtils.invokeCommand("virsh undefine " + vmName, this.visionRadwareFirstTime);
        InvokeUtils.invokeCommand("virsh vol-delete /var/lib/libvirt/images/" + vmName + ".img", this.visionRadwareFirstTime);
        InvokeUtils.invokeCommand("virsh vol-delete /var/lib/libvirt/images/" + vmName + "_APM.img", this.visionRadwareFirstTime);
    }

    public void firstTimeWizardOva(String ovaUrl, boolean isAPM, String vCenterURL, String userName, String password, String hostip, String specificVisionBuild, String newVmName, String containedDVS, String networkName, String resourcePool, String destFolder, String dataStores) {
        VMNetworkingOps vmNetworkingOps = new VMNetworkingOps(vCenterURL, hostip, userName, password);

        try {
            File outputDir = new File(System.getProperty("user.dir"));
            BaseTestUtils.reporter.report("Working Directory is " + outputDir.getAbsolutePath());
            BaseTestUtils.reporter.report("OVA URL: " + ovaUrl);
            newVmName = newVmName + "(" + specificVisionBuild + ")_" + DeployOva.getOVADateFormat().format(new Date());
            BaseTestUtils.reporter.report("Creating VM: " + newVmName);
            String ip = DeployOva.deployOvfFromUrlAndGetIp(vCenterURL, userName, password, hostip, ovaUrl, outputDir, newVmName, networkName, LicenseRepository.getInstance().getMacByProject(this.visionCli.getTestProject()), containedDVS, resourcePool, destFolder, dataStores, isAPM);
            if (ip == null || ip.equals("")) {
                BaseTestUtils.report("Could not retrieve an IP address from vSphere", 1);
            }

            this.visionCli.visionServer.visionRoot.setHost(ip);
            if (!waitForServerConnection(2700000L, this.visionCli.visionServer.visionRoot)) {
                BaseTestUtils.report("Could not connect to device: " + ip, 1);
            }

            BaseTestUtils.reporter.startLevel("Vision First time wizard");
            String expectedFile = "/var/lock/subsys/local";
            if (!this.visionCli.visionServer.visionRoot.checkDeploymentComplete(expectedFile, 2700000L)) {
                BaseTestUtils.reporter.report("Vision Server Initial Deployment took longer than usual.\nThis may indicate an improper Vision Server installation", 1);
            }

            try {
                this.visionRadwareFirstTime.setHost(ip);
                this.visionRadwareFirstTime.connect();
                InvokeUtils.invokeCommand((Logger)null, "y", this.visionRadwareFirstTime, 1200000L, true, false, false);
                Thread.sleep(240000L);
                this.visionRadwareFirstTime.close();
            } catch (Exception var23) {
            }

            String[] networkIfcs;
            if (!isAPM) {
                networkIfcs = new String[]{"Network adapter 1", "Network adapter 2", "Network adapter 3"};
            } else {
                networkIfcs = new String[]{"Network adapter 1", "Network adapter 2"};
            }

            vmNetworkingOps.changeVMNicPortGroup(vCenterURL, newVmName, networkIfcs, networkName, containedDVS, false);
            vmNetworkingOps.resetVm(newVmName);
            targetVisionMacAddress = vmNetworkingOps.getMacAddress(newVmName);
            if (targetVisionMacAddress == null) {
                BaseTestUtils.reporter.report("Could not retrieve any of the ethernet Mac Address. License registration will fail.\nPlease manually add the required license to Vision Server.", 0);
            }

            this.visionRadwareFirstTime.setHost(this.visionRadwareFirstTime.getIp());
            waitForServerConnection(2700000L, this.visionRadwareFirstTime);
            if (VisionServer.waitForVisionServerServicesToStart(this.visionRadwareFirstTime, 2700000L)) {
                BaseTestUtils.reporter.report("All services up");
            } else {
                BaseTestUtils.report("Not all services up.", 1);
            }

            this.initialRestLogin(900000L);
            BaseTestUtils.reporter.report("License Key updated.");
        } catch (Exception var24) {
            BaseTestUtils.report(var24.getMessage(), 1);
        } finally {
            this.visionRadwareFirstTime.setConnectRetries(3);
            this.visionCli.visionServer.visionRoot.setHost(this.visionRadwareFirstTime.getIp());
        }

    }
//            TODO kvision - Phisical is not stable need to re-write
//    public void firstTimeWizardIso(String version, String build, String isoFilePath, String tarFilePath, String othersFilesFileName) throws Exception {
//        String promptString = "vision.radware login: ";
//        String promptCommand = "radware";
//        ConnectionConfiguration.killConnectionOfDigi(this.visionRadwareFirstTime);
//        ConnectionConfiguration.terminalConnection(this.visionRadwareFirstTime, this.visionRadwareFirstTime.getHost(), EnumConnectionPort.PORT_OF_DIGI_TO_CONNECT_TO_VM.value(), EnumConnectionType.TELNET.value());
//        InvokeUtils.invokeCommand((Logger)null, "route add default gw 10.205.1.1", this.visionRadwareFirstTime);
//        InvokeUtils.invokeCommand((Logger)null, "rm -rf /tmp/AP*", this.visionRadwareFirstTime);
//        InvokeUtils.invokeCommand((Logger)null, "mkdir /root/usb", this.visionRadwareFirstTime);
//        InvokeUtils.invokeCommand((Logger)null, "fdisk -l", this.visionRadwareFirstTime);
//        InvokeUtils.invokeCommand((Logger)null, "fdisk -l | grep FAT32 | awk '{print $1}'", this.visionRadwareFirstTime);
//        String mountPath = this.visionRadwareFirstTime.getLastRow().trim();
//        InvokeUtils.invokeCommand((Logger)null, "mount " + mountPath + " /root/usb", this.visionRadwareFirstTime);
//        InvokeUtils.invokeCommand((Logger)null, "rm -rf /root/usb/APSoluteVision*.iso", this.visionRadwareFirstTime);
//        InvokeUtils.invokeCommand((Logger)null, "rm -rf /root/usb/Vision*.tar.gz", this.visionRadwareFirstTime);
//        InvokeUtils.invokeCommand((Logger)null, "cd /root/usb", this.visionRadwareFirstTime);
//        InvokeUtils.invokeCommand((Logger)null, "wget " + isoFilePath, this.visionRadwareFirstTime, 480000L);
//        boolean isContained = RegexUtils.isStringContainsThePattern(DeployErrors.HTTP_NOT_FOUND.getError(), this.visionRadwareFirstTime.getTestAgainstObject().toString());
//        boolean isLarge = RegexUtils.isStringContainsThePattern(DeployErrors.FILE_TOO_LARGE.getError(), this.visionRadwareFirstTime.getTestAgainstObject().toString());
//        if (!isContained && !isLarge) {
//            InvokeUtils.invokeCommand((Logger)null, "wget " + tarFilePath, this.visionRadwareFirstTime, 480000L);
//            isContained = RegexUtils.isStringContainsThePattern(" Warning \n Some of the packages you have selected for install are missing  \n dependencies or conflict with another package. You can exit the \n installation, go back and change your package selections, or    \n continue installing these packages without their dependencies.", this.visionRadwareFirstTime.getTestAgainstObject().toString());
//            if (isContained) {
//                throw new Exception("fail to install the cfg files");
//            } else {
//                InvokeUtils.invokeCommand((Logger)null, "cd /root/usb", this.visionRadwareFirstTime);
//                InvokeUtils.invokeCommand((Logger)null, "tar -xvf /root/usb/" + othersFilesFileName + " --no-same-owner", this.visionRadwareFirstTime, 60000L);
//                isContained = RegexUtils.isStringContainsThePattern(DeployErrors.UNTAR_ERROR.getError(), this.visionRadwareFirstTime.getTestAgainstObject().toString());
//                if (isContained) {
//                    throw new Exception("fail to un-tar the tar file");
//                } else {
//                    this.visionRadwareFirstTime.changeCommandToSendForPrompt(promptString, promptCommand);
//                    this.firstTimeWizardTelnetIso(build);
//                }
//            }
//        } else {
//            throw new Exception("fail to download the iso file");
//        }
//    }

//            TODO kvision - telne Phisical is not stable need to re-write
//    public void firstTimeWizardTelnetIso(String specificVisionBuild) throws Exception {
//        String commandI = "I";
//        long timeout = 1800000L;
//        InvokeUtils.invokeCommand((Logger)null, "reboot", this.visionRadwareFirstTime, 120000L, true, false, false);
//        Thread.sleep(50000L);
//        InvokeUtils.invokeCommand((Logger)null, commandI, this.visionRadwareFirstTime, 1000L, false, false, false, (String)null, false);
//        int sendICount = 0;
//
//        while(sendICount < 20) {
//            this.ignoreCommandException(commandI, false, false, 1000L, (String)null, specificVisionBuild);
//            ++sendICount;
//            Thread.sleep(1000L);
//        }
//
//        this.ignoreCommandException(commandI, true, true, 2L * timeout, (String)null, specificVisionBuild);
//        String fileSizeError = " Warning \n\n The ISO image APSoluteVision-4.80.00-90-x86_64.iso has a size \n which is not a multiple of 2048 bytes.  This may mean it was  \n corrupted on transfer to this computer.\n\n It is recommended that you exit and abort your installation,  \n but you can choose to continue if you think this is in error.";
//
//        for(int i = 0; i < 5; ++i) {
//            this.ignoreCommandException("", true, true, timeout, fileSizeError + "||" + " Warning \n Some of the packages you have selected for install are missing  \n dependencies or conflict with another package. You can exit the \n installation, go back and change your package selections, or    \n continue installing these packages without their dependencies.", specificVisionBuild);
//        }
//
//        InvokeUtils.invokeCommand((Logger)null, "exit", this.visionRadwareFirstTime, 1800000L, false, false, true, (String)null, true);
//        InvokeUtils.invokeCommand((Logger)null, "net ip get", this.visionRadwareFirstTime, 1800000L, false, false, true, (String)null, true);
//        boolean isContained = RegexUtils.isStringContainsThePattern(this.visionRadwareFirstTime.getIp(), this.visionRadwareFirstTime.getTestAgainstObject().toString());
//        if (isContained && this.visionRadwareFirstTime.isConnected()) {
//            ConnectionConfiguration.killConnectionOfDigi(this.visionRadwareFirstTime);
//        } else {
//            throw new Exception("vm is not installed ");
//        }
//    }

    private void ignoreCommandException(String command, boolean prompt, boolean enter, long timeout, String error, String specificVisionBuild) {
        if (error != null && !error.isEmpty() && !error.equals(" ")) {
            String[] array = error.split("\\|\\|");

            try {
                InvokeUtils.invokeCommand((Logger)null, command, this.visionRadwareFirstTime, timeout, false, false, prompt, (String)null, enter);
            } catch (Exception var16) {
                String[] var10 = array;
                int var11 = array.length;

                for(int var12 = 0; var12 < var11; ++var12) {
                    String errors = var10[var12];
                    boolean isContained = RegexUtils.isStringContainsThePattern(errors, this.visionRadwareFirstTime.getTestAgainstObject().toString());
                    if (isContained) {
                        BaseTestUtils.report(" No " + this.visionRadwareFirstTime.getIp() + " created , we have a problem with a build : '" + specificVisionBuild + "',we get problem : " + errors + " ", 1);
                    }
                }
            }
        } else {
            try {
                InvokeUtils.invokeCommand((Logger)null, command, this.visionRadwareFirstTime, timeout, false, false, prompt, (String)null, enter);
            } catch (Exception var15) {
            }
        }

    }

    public static boolean waitForServerConnection(long timeout, CliConnectionImpl connection) throws InterruptedException {
        long startTime = System.currentTimeMillis();

        while(System.currentTimeMillis() - startTime < timeout) {
            try {
                connection.connect();
                return true;
            } catch (Exception var6) {
                Thread.sleep(10000L);
            }
        }

        return false;
    }

    private void initialRestLogin(long timeout) {
        try {
            String licenseKey = "vision-activation-" + ReflectionUtils.invokePrivateMethod("generateLicenseString", new Object[]{targetVisionMacAddress, "vision-activation"});
            VisionRestClient visionRestClient = new VisionRestClient(this.visionRadwareFirstTime.getIp(), licenseKey, RestBasicConsts.RestProtocol.HTTPS);
            long startTime = System.currentTimeMillis();

            while(System.currentTimeMillis() - startTime < timeout) {
                try {
                    visionRestClient.login(this.visionRadwareFirstTime.getUser(), this.visionRadwareFirstTime.getPassword(), licenseKey, 1);
                    return;
                } catch (Exception var8) {
                }
            }
        } catch (Exception var9) {
            BaseTestUtils.report(var9.getMessage(), 1);
        }

    }
}

