package com.radware.vision.bddtests.clioperation.LLS;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums.ConfigSyncMode;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums.LLSStateCMDs;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.automation.systemManagement.visionConfigurations.ManagementInfo;
import com.radware.vision.highavailability.HAHandler;
import com.radware.vision.lls.LLSHandler;
import com.radware.vision.system.ConfigSync;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;

public class LLSSteps extends TestBase {


    protected static ManagementInfo managementInfo = TestBase.getVisionConfigurations().getManagementInfo();
    protected static ClientConfigurationDto clientConfigurations = TestBase.getSutManager().getClientConfigurations();
    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();

    @Given("^CLI LLS standalone install, \"(FNO|offline|UAT)\" mode, timeout (\\d+)$")
    public void standbyInstall(String mode, int timeout) {
        try {
            LLSHandler.standaloneInstall(radwareServerCli, mode, timeout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI LLS Service Start,with timeout (\\d+)$")
    public void llsServiceStart(int timeout) {
        try {
            LLSHandler.llsServiceStart(radwareServerCli, timeout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI LLS Service Stop with timeout (\\d+)$")
    public void llsServiceStop(int timeout) {
        try {
            LLSHandler.llsServiceStop(radwareServerCli, timeout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI LLS SET State \"(enable|disable)\" with timeout (\\d+)$")
    public void llsSetState(String cmd, int timeout) {
        try {
            LLSHandler.llsSetState(radwareServerCli, timeout, LLSStateCMDs.getConstant(cmd));
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI set target vision Host_2 \"(active|standby|disabled)\"$")
    public void setTargetVision(String mode) {
        try {
            String standby = restTestBase.getVisionServerHA().getHost_2();
            RadwareServerCli standbyServerCli = new RadwareServerCli(standby, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
            standbyServerCli.init();
            standbyServerCli.connect();
            ConfigSync.setModeWitouthServices(standbyServerCli, ConfigSyncMode.getConstant(mode), 1000 * 1000, "y");
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Set host2 config sync peer$")
    public void setConfigSyncPeer() {
        try {
            String mainIP = clientConfigurations.getHostIp();
            String backup = restTestBase.getVisionServerHA().getHost_2();
            RadwareServerCli backupServerCli = new RadwareServerCli(backup, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
            backupServerCli.init();
            backupServerCli.connect();
            ConfigSync.setPeer(backupServerCli, mainIP);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI LLS HA backup install, \"(FNO|offline|UAT)\" mode, timeout (\\d+)$")
    public void backupInstall(String mode, int timeout) {
        try {
            LLSHandler.HAbackupInstall(mode, timeout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI LLS HA main install, \"(FNO|offline|UAT)\" mode, timeout (\\d+)$")
    public void mainInstall(String mode, int timeout) {
        try {
            LLSHandler.HAMainInstall(mode, timeout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI LLS wait to logs HA$")
    public void waitTologs() {
        try {
            String mainIP = restTestBase.getRootServerCli().getHost();
            String backup = restTestBase.getVisionServerHA().getHost_2();
            RadwareServerCli backupServerCli = new RadwareServerCli(backup, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
            backupServerCli.init();
            backupServerCli.disconnect();
            backupServerCli.connect();
            LLSHandler.waitForInstallationInLogsHA(backupServerCli, 10000, "backup", mainIP, backup);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI LLS validate installation with expected: \"(.*)\", timeout (\\d+)$")
    public void waitForInstallation(String expected, int timeout) {
        try {
            LLSHandler.waitForInstallation(null, timeout, expected);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI LLS validate installation with expected: \"(.*)\", timeout (\\d+) on vision 2$")
    public void waitForInstallationVision2(String expected, int timeout) {
        try {
            String sourceIP = restTestBase.getVisionServerHA().getHost_2();
            RadwareServerCli radwareServerCli = new RadwareServerCli(sourceIP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
            if (!radwareServerCli.isConnected()) {
                radwareServerCli.connect();
            }
            LLSHandler.waitForInstallation(radwareServerCli, timeout, expected);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI LLS HA validate License Activation: \"(.*)\", on the standby machine,timeout (\\d+)$")
    public void waitForLicenseActivation(String entitlementID, int timeout) {
        try {
            RadwareServerCli backupServerCli = new RadwareServerCli(HAHandler.visionServerHA.getHost_2(), restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
            backupServerCli.init();
            backupServerCli.disconnect();
            backupServerCli.connect();
            LLSHandler.waitForLicenseActivation(backupServerCli, timeout, entitlementID);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI LLS HA validate URL in \"(main|backup)\" machine,timeout (\\d+)$")
    public void validateURLHA(String type, long timout) {
        try {
            LLSHandler.validateURLHA(type, timout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI LLS stanadlone validate URL in main Machine,timeout (\\d+)$")
    public void validateURL(long timout) {
        try {
            LLSHandler.validateURLStandalone(timout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
