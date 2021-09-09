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
import com.radware.vision.automation.systemManagement.licenseManagement.LicenseGenerator;
import com.radware.vision.automation.systemManagement.serversManagement.ServersManagement;
import com.radware.vision.automation.systemManagement.visionConfigurations.ManagementInfo;
import com.radware.vision.automation.systemManagement.visionConfigurations.VisionConfigurations;
import cucumber.runtime.junit.FeatureRunner;

import java.time.LocalDateTime;


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
            if (connectOnInit()) {
                visionConfigurations = new VisionConfigurations();
                LicenseGenerator.MAC_ADDRESS = visionConfigurations.getManagementInfo().getMacAddress();
                managementInfo = getVisionConfigurations().getManagementInfo();

            }
            serversManagement = new ServersManagement();
            clientConfigurations = getSutManager().getClientConfigurations();
            cliConfigurations = getSutManager().getCliConfigurations();
            testStartTime = LocalDateTime.now();
            restTestBase = new RestManagement();
            try {
                restTestBase.init();
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

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


    public void publishBddResults() {
        String status = BddReporterManager.isResultPass() ? "Passed" : "Failed";

        Integer testCaseId = BddReporterManager.getStepId();

        if (testCaseId != null && IgnoreList.getInstance().getIgnoreList().containsKey(testCaseId.toString()))
            status = "Failed";

        if (BddReporterManager.getAutoStepId() != null) {
            updatePoratlVisionBuildAndVersion();
            RadAutoDB.getInstance().autoStepTbl.updateStepResult(BddReporterManager.getAutoStepId(), status);
            if (status.equals("Failed"))
                RadAutoDB.getInstance().autoStepFailReasonTbl.createStepFailReason(BddReporterManager.getAutoStepId(), "Error", BddReporterManager.getAllResult(), "", "", "");
        }
    }

    public void updatePoratlVisionBuildAndVersion() {
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
        return sutManager.getDeployConfigurations().getSetupMode().toLowerCase().contains("fresh install") ? false : true;
    }

}
