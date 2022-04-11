package com.radware.vision.automation.base;
/*

 */

import basejunit.RestTestBase;
import com.radware.automation.RadAutoDB;
import com.radware.automation.bdd.filtering.IgnoreList;
import com.radware.automation.bdd.reporter.BddReporterManager;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.reports.AutomationTestReporter;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;
import com.radware.vision.automation.AutoUtils.SUT.dtos.CliConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.systemManagement.licenseManagement.LicenseGenerator;
import com.radware.vision.automation.systemManagement.serversManagement.ServersManagement;
import com.radware.vision.automation.systemManagement.visionConfigurations.ManagementInfo;
import com.radware.vision.automation.systemManagement.visionConfigurations.SetupImpl;
import com.radware.vision.automation.systemManagement.visionConfigurations.VisionConfigurations;
import com.radware.vision.vision_project_cli.menu.Menu;
import cucumber.runtime.junit.FeatureRunner;

import java.net.Inet4Address;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.time.LocalDateTime;
import java.util.Enumeration;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public abstract class TestBase {

    public static SUTManager sutManager;
    protected static VisionConfigurations visionConfigurations;
    protected static ServersManagement serversManagement;

    protected static ManagementInfo managementInfo;
    protected static ClientConfigurationDto clientConfigurations;
    protected static CliConfigurationDto cliConfigurations;
    protected static LocalDateTime testStartTime;
    public static RestTestBase restTestBase;
    public static AutomationTestReporter automationTestReporter;

    static {
        try {
            sutManager = SUTManagerImpl.getInstance();
            serversManagement = new ServersManagement();
            if (connectOnInit()) {
                setManagementInfo();
                // ToDo - Handle interface G2 and add device driver for simulators
//                setDeviceSettings();
            }
            clientConfigurations = getSutManager().getClientConfigurations();
            cliConfigurations = getSutManager().getCliConfigurations();
            testStartTime = LocalDateTime.now();
            restTestBase = new RestManagement();
            restTestBase.init();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    private static void setDeviceSettings() {
        SetupImpl setup = new SetupImpl();
        try
        {
            setup.buildSetup();
        }
        catch (Exception ignore){}
    }

    public static void dBAccessCommand() {
        try {
            String ip = "0.0.0.0";
            ip = getMyHostIP();
            String dbAccessCommand = Menu.system().database().access().display().build();
            CliOperations.runCommand(serversManagement.getRadwareServerCli().get(), dbAccessCommand);
            Matcher matcher = Pattern.compile(dbAccessCommand + "(([\n\r].*)*)(\\[.*\\$)").matcher(CliOperations.lastOutput);

            if(!matcher.find() || !matcher.group(1).contains(ip))
            {
                CliOperations.runCommand(serversManagement.getRadwareServerCli().get(), Menu.system().database().access().revoke().build() + " " + "all");
                String command = Menu.system().database().access().grant().build() + " " + ip;
                CliOperations.runCommand(serversManagement.getRadwareServerCli().get(), command);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.PASS_NOR_FAIL);
        }
    }

    public static String getMyHostIP() throws SocketException {
        String ip = "";
        Enumeration en = NetworkInterface.getNetworkInterfaces();
        while (en.hasMoreElements()) {
            NetworkInterface i = (NetworkInterface) en.nextElement();
            for (Enumeration en2 = i.getInetAddresses(); en2.hasMoreElements(); ) {
                InetAddress addr = (InetAddress) en2.nextElement();
                if (!addr.isLoopbackAddress()) {
                    if (addr instanceof Inet4Address) {
                        ip = addr.getHostAddress();
                        break;
                    }
                }
            }
        }
        return ip;
    }

    public static ServersManagement getServersManagement() {
        return serversManagement;
    }

    public static VisionConfigurations getVisionConfigurations() {
        return visionConfigurations;
    }

    public static SUTManager getSutManager() {
        return sutManager;
    }

    public static LocalDateTime getTestStartTime() {
        return testStartTime;
    }

    public static void setManagementInfo(){
        visionConfigurations = new VisionConfigurations();
        LicenseGenerator.MAC_ADDRESS = visionConfigurations.getManagementInfo().getMacAddress();
        managementInfo = getVisionConfigurations().getManagementInfo();
        // ToDo - need to add another function for dBAccessCommand
        dBAccessCommand();
    }


    public void publishBddResults() {
        String status = BddReporterManager.isResultPass() ? "Passed" : "Failed";

        Integer testCaseId = BddReporterManager.getStepId();

        if (testCaseId != null && IgnoreList.getInstance().getIgnoreList().containsKey(testCaseId.toString()))
            status = "Failed";

        if (BddReporterManager.getAutoStepId() != null) {
            updatePortalVisionBuildAndVersion();
            RadAutoDB.getInstance().autoStepTbl.updateStepResult(BddReporterManager.getAutoStepId(), status);
            if (status.equals("Failed"))
                RadAutoDB.getInstance().autoStepFailReasonTbl.createStepFailReason(BddReporterManager.getAutoStepId(), "Error", BddReporterManager.getAllResult(), "", "", "");
        }
    }

    public void updatePortalVisionBuildAndVersion() {
        try {
            FeatureRunner.update_version_build_mode(managementInfo.getVersion(),
                    managementInfo.getBuild(),
                    BddReporterManager.getRunMode());
            FeatureRunner.update_station_sutName(serversManagement.getRootServerCLI().get().getHost(), System.getProperty("SUT"));
        } catch (Exception e) {
            BaseTestUtils.report("publish BDD results Failure!!! ", Reporter.PASS_NOR_FAIL);
        }
    }

    public static boolean connectOnInit() {
        return !sutManager.getClientConfigurations().getHostIp().equals("") &&
                !sutManager.getDeployConfigurations().getSetupMode().toLowerCase().contains("fresh install");
    }

}
