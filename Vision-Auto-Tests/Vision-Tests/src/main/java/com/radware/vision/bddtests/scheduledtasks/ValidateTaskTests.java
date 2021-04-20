package com.radware.vision.bddtests.scheduledtasks;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.BaseTasksHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.validateScheduledTasks.ValidateTasksHandler;
import cucumber.api.java.en.Then;
import org.junit.After;


public class ValidateTaskTests extends VisionUITestBase {

    String defaultFileName = "/cm:/db_f.bin";

    public ValidateTaskTests() throws Exception {
    }

    @After
    public void cleanup() throws Exception {
        BasicOperationsHandler.scheduler(false);
    }


    @Then("^UI Remove Security Signature File from DP Device with index (\\d+) with filePathToDelete \"(.*)\"$")
    public void removeSecuritySignatureFile(int deviceIndex, String filePathToDelete) {
        String deviceIp = "";
        try {
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, deviceIndex);
            deviceIp = deviceInfo.getDeviceIp();
            updateNavigationParser(deviceIp);
            if (filePathToDelete == null || filePathToDelete.isEmpty()) {
                ValidateTasksHandler.removeDpSecurityFileRepeater(deviceIp, serversManagement.getRootServerCLI().get(), "", "", defaultFileName, 5);
            } else {
                ValidateTasksHandler.removeDpSecurityFileRepeater(deviceIp, serversManagement.getRootServerCLI().get(), "", "", filePathToDelete, 5);

            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to remove Security Signature files for device: " + deviceIp + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Verify Task Existence with taskName \"(.*)\"$")
    public void verifyTaskExistence(String taskName) {
        try {
            String columnName = "Name";
            if (BaseTasksHandler.validateTaskCreationMain(columnName, taskName)) {
                BaseTestUtils.report("Task appear in the Scheduler task table", Reporter.PASS);
            } else {
                BaseTestUtils.report("Task not appear in the Scheduler task table", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }
}
