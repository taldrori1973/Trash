package com.radware.vision.automation.Deploy;

import com.aqua.sysobj.conn.CliConnectionImpl;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.RestBasicConsts;
import com.radware.restcore.VisionRestClient;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.VisionRadwareFirstTime;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.DeployOva;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.ReflectionUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.RegexUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.VMNetworkingOps;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.vision_tests.CliTests;

import java.io.File;
import java.util.*;

import static com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations.*;

public class NewVmHandler extends TestBase {
    private static final String licenseKeyPrefix = "vision-activation";
    private static String targetVisionMacAddress;
    public VisionRadwareFirstTime visionRadwareFirstTime;
    private static final String imagesPath = "/var/lib/libvirt/images/";
    private static final String warning = " Warning \n Some of the packages you have selected for install are missing  \n " +
            "dependencies or conflict with another package. You can exit the \n " +
            "installation, go back and change your package selections, or    \n " +
            "continue installing these packages without their dependencies.";

    public NewVmHandler() {
        CliTests.isFirstTimeScenario = true;

        try {
            //host - vSphere
            String hostIp = Objects.requireNonNull(sutManager.getEnvironment().orElse(null)).getHostIp();
            String vmName = sutManager.getEnvironment().orElse(null).getName();

            //Server - VM
            String hostUser = sutManager.getClientConfigurations().getUserName();
            String hostPassword = sutManager.getClientConfigurations().getPassword();
            String vmIp = sutManager.getClientConfigurations().getHostIp();
            String netMask = sutManager.getEnvironment().orElse(null).getNetMask();
            String gateway = sutManager.getEnvironment().orElse(null).getGateWay();
            String primaryDns = sutManager.getEnvironment().orElse(null).getDnsServerIp();
            String physicalManagement = sutManager.getEnvironment().orElse(null).getPhysicalManagement();

            this.visionRadwareFirstTime = new VisionRadwareFirstTime(hostUser, hostPassword, hostIp, netMask, gateway, primaryDns, physicalManagement, vmName, vmIp);
        } catch (Exception var2) {
            BaseTestUtils.report("Failed to read sut object " + var2.getMessage(), 1);
        }

    }

    public NewVmHandler(String machine, String cli) {
        CliTests.isFirstTimeScenario = true;

        try {
//            TODO kvision
//            this.visionRadwareFirstTime = (VisionRadwareFirstTime)this.system.getSystemObject(machine);
//            this.visionCli = (VisionCli)this.system.getSystemObject(cli);
        } catch (Exception var4) {
            BaseTestUtils.report("Failed to read sut object " + var4.getMessage(), 1);
        }

    }

    public void firstTimeWizardQCow2(String version, String specificVisionBuild, String fileUrl, String md5DevArt) {
        long timeOut = 3600000L;
        ArrayList<String> messages = new ArrayList();
        String fileNotFound = "Error 15: File not found\n";
        messages.add(fileNotFound);
        messages.add(warning);
        String mysqlSocketProblem = "Can't connect to local MySQL server";
        messages.add(mysqlSocketProblem);
        String vmName = String.format("%s_%s", sutManager.getServerName(), sutManager.getClientConfigurations().getHostIp());
        int downloadTimeOutInSec = 60 * 60;

        try {
            // ToDo - check why setConnectOnInit is true
            this.visionRadwareFirstTime.setConnectOnInit(false);
            this.visionRadwareFirstTime.setUser(sutManager.getEnvironment().get().getUser());
            this.visionRadwareFirstTime.setPassword(sutManager.getEnvironment().get().getPassword());
            runCommand(this.visionRadwareFirstTime, "rm -rf " + imagesPath + vmName + ".qcow2");
            runCommand(this.visionRadwareFirstTime, "cd " + imagesPath);
            String curlCommand = String.format("curl -m %d -o %s.qcow2 %s", downloadTimeOutInSec, vmName, fileUrl);
            runCommand(this.visionRadwareFirstTime, curlCommand, downloadTimeOutInSec * 1000);
            checkMd5AfterDeploy(vmName, md5DevArt);

            StringJoiner installCommand = new StringJoiner(" ");
            installCommand.add("virt-install").add("--name " + vmName).add("--noautoconsole ");
            installCommand.add("--ram 24576").add("--vcpus 8").add("--import").add("--disk " + imagesPath + vmName + ".qcow2,bus=virtio").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--graphics none").add("--video cirrus").add("--serial pty");

            String promptBuildName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1, fileUrl.lastIndexOf(".")).toLowerCase();
            // ToDo hardcoded - ubuntu version
            String ubuntuVersion = "20.04.2";
            this.visionRadwareFirstTime.editPromptStringFormat("Ubuntu %s LTS %s ttyS0", ubuntuVersion, promptBuildName);
            runCommand(this.visionRadwareFirstTime, installCommand.toString(), 5 * 60 * 1000, false, false, true);
            //wait for installation to progress
            BaseTestUtils.report("Waiting for deploy to start", Reporter.PASS_NOR_FAIL);
            Thread.sleep((6 * 60 * 1000L));
            boolean isShutoff;
            this.isContained(messages, vmName, specificVisionBuild, version);

            runCommand(this.visionRadwareFirstTime, "virsh list --all");
            isShutoff = RegexUtils.isStringContainsThePattern(vmName + ".*running.*", lastOutput.trim());
            if (!isShutoff) {
                this.deleteKvm(vmName);
                BaseTestUtils.report(" VM: '" + vmName + "' did not deploy or did not start as expected", Reporter.FAIL);
            }

            //change user and password from host to vision radware
            this.visionRadwareFirstTime.changeCommandToSendForPrompt("login:", cliConfigurations.getRadwareServerCliUserName());
            this.visionRadwareFirstTime.changeCommandToSendForPrompt("Password:", cliConfigurations.getRadwareServerCliPassword());
            //This will run the first time wizard
            runCommand(this.visionRadwareFirstTime, "virsh console " + vmName + " --force", (int) timeOut, false, false, true, null, true);


            UvisionServer.waitForUvisionServerServicesStatus(serversManagement.getRadwareServerCli().orElse(null), UvisionServer.UVISON_DEFAULT_SERVICES, 45 * 60);

        } catch (Exception e) {
            BaseTestUtils.report("Failed to deploy server " + vmName + "with the following error:\n" +
                    e.getMessage(), Reporter.FAIL);
        } finally {
            runCommand(this.visionRadwareFirstTime, "rm -rf " + imagesPath + vmName + ".qcow2");
        }
    }
    public void checkMd5AfterDeploy(String vmName, String md5DevArt){
        runCommand(this.visionRadwareFirstTime,"md5sum " + imagesPath + vmName + ".qcow2 ", 6 * 60 * 1000);
        String md5CLI = this.visionRadwareFirstTime.getLastRow();
        String[] md5Output = md5CLI.split(" ");
        String md5_from_cli = md5Output[0];
        if(!md5_from_cli.equals(md5DevArt)){
            BaseTestUtils.report("Md5 from cli is not match to md5 from devArt101", Reporter.FAIL);
        }
    }

    public void firstTimeWizardKVM(boolean isAPM, String version, String specificVisionBuild, String fileUrl, String Md5) throws Exception {
        long timeOut = 3600000L;
        ArrayList messages = new ArrayList();
        String fileNotFound = "Error 15: File not found\n";
        messages.add(fileNotFound);
        messages.add(warning);
        String mysqlSocketProblem = "Can't connect to local MySQL server";
        messages.add(mysqlSocketProblem);
        String vmName = String.format("%s_%s", sutManager.getServerName(), sutManager.getClientConfigurations().getHostIp());
        // ToDo - check why setConnectOnInit is true
        this.visionRadwareFirstTime.setConnectOnInit(false);
        runCommand(this.visionRadwareFirstTime, "rm -rf " + imagesPath + vmName + ".qcow2");
        runCommand(this.visionRadwareFirstTime, "cd " + imagesPath);
        runCommand(this.visionRadwareFirstTime, "wget " + fileUrl + " -O " + vmName + ".qcow2", 25 * 60 * 1000);
        StringJoiner installCommand = new StringJoiner(" ");
        installCommand.add("virt-install").add("--name " + vmName);
        String selectCommand;
        if (isAPM) {
            installCommand.add("--ram 32768").add("--vcpus 12").add("--disk " + imagesPath + vmName + ".img,size=250,bus=virtio,format=qcow2").add("--disk " + imagesPath + vmName + "_APM.img,size=350,bus=virtio,format=qcow2").add("--cdrom " + imagesPath + vmName + ".iso").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--network network=TAG.502.ADC.Servers,model=virtio").add("--graphics none").add("--video cirrus").add("--serial pty");
            selectCommand = "A";
        } else {
            //        installCommand.add("--ram 24576").add("--vcpus 8").add("--disk " + vmName + ".img,size=250,bus=virtio").add("--cdrom " + imagesPath + vmName + ".iso").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--graphics none").add("--video cirrus").add("--serial pty");
            installCommand.add("--ram 24576").add("--vcpus 8").add("--import").add("--disk " + imagesPath + vmName + ".qcow2,bus=virtio").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--network bridge=management,model=virtio").add("--graphics none").add("--video cirrus").add("--serial pty");
            selectCommand = "I";
        }
        String promptBuildName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1, fileUrl.lastIndexOf(".")).toLowerCase();
        // ToDo hardcoded - ubuntu version
        String ubuntuVersion = "20.04.2";
        this.visionRadwareFirstTime.editPromptStringFormat("Ubuntu %s LTS %s ttyS0", ubuntuVersion, promptBuildName);
        runCommand(this.visionRadwareFirstTime, installCommand.toString(), (int) timeOut);
        Thread.sleep(15000L);
        runCommand(this.visionRadwareFirstTime, "radware", 5 * 60 * 1000);
        boolean isShutoff;
        if (selectCommand.equals("A")) {
            runCommand(this.visionRadwareFirstTime, selectCommand, 60000, false, false, false, null, true);
            selectCommand = "\r";
            Thread.sleep(120000L);
            runCommand(this.visionRadwareFirstTime, "yes", 60000, false, false, false, null, true);
            Thread.sleep(660000L);
            long startTime = System.currentTimeMillis();
            long maxTimeOut = 7200000L;

            boolean pingResult;
            long currentTime;
            do {
                this.visionRadwareFirstTime.changeCommandToSendForPrompt("vision.radware login: ", "radware");
                runCommand(this.visionRadwareFirstTime, "virsh start " + vmName, 60000, false, false, false, null, true);
                runCommand(this.visionRadwareFirstTime, "virsh console " + vmName + " --force", 60000, false, false, false, null, true);
                try {
                    runCommand(this.visionRadwareFirstTime, selectCommand, (int) timeOut, true, false, true, null, true, false);
                } catch (Exception ignored) {
                }
                this.isContained(messages, vmName, specificVisionBuild, version);
                runCommand(this.visionRadwareFirstTime, "virsh list --all");
                isShutoff = RegexUtils.isStringContainsThePattern(vmName + ".*shut off.*", lastOutput.trim());
                runCommand(this.visionRadwareFirstTime, "ping -c 4 " + Objects.requireNonNull(sutManager.getEnvironment().orElse(null)).getHostIp(), 180000, true, false, true, null, true, false);
                pingResult = RegexUtils.isStringContainsThePattern("100% packet loss", lastOutput.trim());
                currentTime = System.currentTimeMillis();
            } while ((isShutoff || pingResult) & currentTime - startTime < maxTimeOut);

            if (pingResult && !isShutoff) {
                this.visionRadwareFirstTime.connect();
                runCommand(this.visionRadwareFirstTime, "virsh destroy " + vmName, 180000);
                runCommand(this.visionRadwareFirstTime, "virsh start " + vmName, 180000);
                runCommand(this.visionRadwareFirstTime, "virsh console " + vmName + " --force", 60000, false, false, false, null, true);
                runCommand(this.visionRadwareFirstTime, selectCommand, (int) timeOut, true, false, true, null, true, false);
            }
        }

/*        try {
            CliOperations.runCommand(this.visionRadwareFirstTime, selectCommand, (int) timeOut);
        } catch (Exception var22) {
            this.isContained(messages, vmName, specificVisionBuild, version);
            throw new Exception(var22.getMessage());
        }*/

        this.isContained(messages, vmName, specificVisionBuild, version);
        this.visionRadwareFirstTime.connect();
        runCommand(this.visionRadwareFirstTime, "rm -rf " + imagesPath + vmName + ".qcow2");
        runCommand(this.visionRadwareFirstTime, "virsh list --all");
        runCommand(this.visionRadwareFirstTime, "virsh list --all");
        isShutoff = RegexUtils.isStringContainsThePattern(vmName + ".*running.*", lastOutput.trim());
        if (!isShutoff) {
            this.deleteKvm(vmName);
            BaseTestUtils.report(" The vm : '" + vmName + "' is not exist! failed to be created successfully ", 1);
        }
        RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().orElse(null);
        if (VisionServer.waitForVisionServerServicesToStartHA(radwareServerCli, 2700000L)) {
            BaseTestUtils.reporter.report("All services up");
        } else {
            BaseTestUtils.report("Not all services up.", 1);
        }

    }

    private void isContained(ArrayList<String> list, String vmName, String specificVisionBuild, String fullNameVersion) {
        Iterator var5 = list.iterator();

        while (var5.hasNext()) {
            String message = (String) var5.next();
            if (RegexUtils.isStringContainsThePattern(message, this.visionRadwareFirstTime.getTestAgainstObject().toString())) {
                runCommand(this.visionRadwareFirstTime, "rm -rf " + imagesPath + "APSoluteVision-Serial_console-" + fullNameVersion + "*");
                this.deleteKvm(vmName);
                BaseTestUtils.report(" No " + vmName + " created , we have a problem with a build : '" + specificVisionBuild + "',we get problem stuck on : " + message + " ", Reporter.FAIL);
            }
        }

    }

    public void deleteKvm(String vmName) {
        runCommand(this.visionRadwareFirstTime, "virsh destroy " + vmName);
        runCommand(this.visionRadwareFirstTime, "virsh undefine " + vmName);
        runCommand(this.visionRadwareFirstTime, "virsh vol-delete " + imagesPath + vmName + ".img");
        runCommand(this.visionRadwareFirstTime, "virsh vol-delete " + imagesPath + vmName + "_APM.img");
    }

    public void firstTimeWizardOva(String ovaUrl, boolean isAPM, String vCenterURL, String userName, String password, String hostip, String specificVisionBuild, String newVmName, String containedDVS, String networkName, String resourcePool, String destFolder, String dataStores) {
        VMNetworkingOps vmNetworkingOps = new VMNetworkingOps(vCenterURL, hostip, userName, password);
        try {
            File outputDir = new File(System.getProperty("user.dir"));
            BaseTestUtils.reporter.report("Working Directory is " + outputDir.getAbsolutePath());
            BaseTestUtils.reporter.report("OVA URL: " + ovaUrl);
            newVmName = newVmName + "(" + specificVisionBuild + ")_" + DeployOva.getOVADateFormat().format(new Date());
            BaseTestUtils.reporter.report("Creating VM: " + newVmName);

            String ip = DeployOva.deployOvfFromUrlAndGetIp(vCenterURL, userName, password, hostip, ovaUrl, outputDir, newVmName, networkName, null, containedDVS, resourcePool, destFolder, dataStores, isAPM);
            if (ip == null || ip.equals("")) {
                BaseTestUtils.report("Could not retrieve an IP address from vSphere", 1);
            }

            RootServerCli rootServerCli = serversManagement.getRootServerCLI().orElse(null);
            rootServerCli.setHost(ip);
            if (!waitForServerConnection(2700000L, rootServerCli)) {
                BaseTestUtils.report("Could not connect to device: " + ip, 1);
            }

            BaseTestUtils.reporter.startLevel("Vision First time wizard");
            String expectedFile = "/var/local";
            if (!rootServerCli.checkDeploymentComplete(expectedFile, 2700000L)) {
                BaseTestUtils.reporter.report("Vision Server Initial Deployment took longer than usual.\nThis may indicate an improper Vision Server installation", 1);
            }

            try {
                this.visionRadwareFirstTime.setHost(ip);
                this.visionRadwareFirstTime.connect();
                runCommand(this.visionRadwareFirstTime, ip, 1200000);
                // ToDo kvision check what for this lines
                //CliOperations.runCommand(this.visionRadwareFirstTime, "y", 1200000, true, false, false);
            } catch (Exception var23) {
            }
            ip = sutManager.getClientConfigurations().getHostIp();
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

            try {
                this.visionRadwareFirstTime.setHost(ip);
                waitForServerConnection(2700000L, this.visionRadwareFirstTime);
                Thread.sleep(600000L);
            } catch (Exception ignored) {
            }

            rootServerCli.setHost(ip);
            UvisionServer.waitForUvisionServerServicesStatus(serversManagement.getRadwareServerCli().orElse(null), UvisionServer.UVISON_DEFAULT_SERVICES, 45 * 60);
            this.initialRestLogin(900000L);
            BaseTestUtils.reporter.report("License Key updated.");
        } catch (Exception var24) {
            BaseTestUtils.report(var24.getMessage(), 1);
        } finally {
            this.visionRadwareFirstTime.setConnectRetries(3);
        }

    }
//            TODO kvision - Physical is not stable need to re-write
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
//            isContained = RegexUtils.isStringContainsThePattern(warning, this.visionRadwareFirstTime.getTestAgainstObject().toString());
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
//            this.ignoreCommandException("", true, true, timeout, fileSizeError + "||" + warning, specificVisionBuild);
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

//    private void ignoreCommandException(String command, boolean prompt, boolean enter, long timeout, String error, String specificVisionBuild) {
//        if (error != null && !error.isEmpty() && !error.equals(" ")) {
//            String[] array = error.split("\\|\\|");
//
//            try {
//                CliOperations.runCommand(this.visionRadwareFirstTime, command, (int) timeout, false, false, prompt, null, enter);
//            } catch (Exception var16) {
//                String[] var10 = array;
//                int var11 = array.length;
//
//                for (int var12 = 0; var12 < var11; ++var12) {
//                    String errors = var10[var12];
//                    boolean isContained = RegexUtils.isStringContainsThePattern(errors, this.visionRadwareFirstTime.getTestAgainstObject().toString());
//                    if (isContained) {
//                        BaseTestUtils.report(" No " + this.visionRadwareFirstTime.getIp() + " created , we have a problem with a build : '" + specificVisionBuild + "',we get problem : " + errors + " ", 1);
//                    }
//                }
//            }
//        } else {
//            try {
//                CliOperations.runCommand(this.visionRadwareFirstTime, command, (int) timeout, false, false, prompt, null, enter);
//            } catch (Exception ignored) {
//            }
//        }
//
//    }

    public static boolean waitForServerConnection(long timeout, CliConnectionImpl connection) throws InterruptedException {
        long startTime = System.currentTimeMillis();

        while (System.currentTimeMillis() - startTime < timeout) {
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
            String licenseKey = licenseKeyPrefix + "-" + ReflectionUtils.invokePrivateMethod("generateLicenseString", targetVisionMacAddress, licenseKeyPrefix);
            VisionRestClient visionRestClient = new VisionRestClient(this.visionRadwareFirstTime.getIp(), licenseKey, RestBasicConsts.RestProtocol.HTTPS);
            long startTime = System.currentTimeMillis();

            while (System.currentTimeMillis() - startTime < timeout) {
                try {
                    visionRestClient.login(this.visionRadwareFirstTime.getUser(), this.visionRadwareFirstTime.getPassword(), licenseKey, 1);
                    return;
                } catch (Exception ignored) {
                }
            }
        } catch (Exception var9) {
            BaseTestUtils.report(var9.getMessage(), 1);
        }

    }
}

