package com.radware.vision.bddtests.clioperation.LLS;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.base.TestBase;
import com.radware.vision.enums.ConfigSyncMode;
import com.radware.vision.systemManagement.visionConfigurations.ManagementInfo;
import com.radware.vision.vision_handlers.system.ConfigSync;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;

import static com.radware.vision.base.WebUITestBase.restTestBase;

public class LLSSteps {


    protected static ManagementInfo managementInfo = TestBase.getVisionConfigurations().getManagementInfo();
    protected static ClientConfigurationDto clientConfigurations = TestBase.getSutManager().getClientConfigurations();

    @Given("^CLI LLS standalone install, \"(FNO|offline|UAT)\" mode, timeout (\\d+)$")
    public void standbyInstall(String mode, int timeout) {
        try {
            LLSHandler.standaloneInstall(mode, timeout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI LLS Service Start,with timeout (\\d+)$")
    public void llsServiceStart(int timeout) {
        try {
            LLSHandler.llsServiceStart(timeout);
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
//            ConfigSync.setMode(standbyServerCli,ConfigSyncMode.getConstant(mode),1000*1000, "y");
            ConfigSync.setModeWitoutServices(standbyServerCli, ConfigSyncMode.getConstant(mode), 1000 * 1000, "y");
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
//            CliOperations.runCommand(backupServerCli,"system config-sync peer set "+mainIP);
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
//            ConfigSync.setPeer(backupServerCli, mainIP);
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

    @Given("^CLI LLS HA validate License Activation: \"(.*)\", on the standby machine,timeout (\\d+)$")
    public void waitForLicenseActivation(String entitlementID, int timeout) {
        try {
            String backup = restTestBase.getVisionServerHA().getHost_2();
            RadwareServerCli backupServerCli = new RadwareServerCli(backup, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
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
