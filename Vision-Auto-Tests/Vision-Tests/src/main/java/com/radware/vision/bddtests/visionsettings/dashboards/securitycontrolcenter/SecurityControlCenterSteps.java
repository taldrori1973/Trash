package com.radware.vision.bddtests.visionsettings.dashboards.securitycontrolcenter;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.BaseTasksHandler;
import com.radware.vision.infra.testhandlers.visionsettings.dashboards.securitycontrolcenter.SecurityControlCenterHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

public class SecurityControlCenterSteps extends VisionUITestBase {

    public SecurityControlCenterSteps() throws Exception {
    }

    @Given("^UI Open ERT Active DDoS Feed$")
    public void openERTActiveDDoSFeed() {
        try {
            SecurityControlCenterHandler.openERTActiveDDoSFeed();
            BasicOperationsHandler.delay(10);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to open ERT Active DDoS Feed Tap: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /*
     * ERT Active DDoS Feed Tap tests
     */

    @Then("^UI Validate DefensePro devices updated in last run equal to \"(.*)\"$")
    public void verifyDefenseProDevicesUpdatedInLastRun(String expectedDevicesNum) {
        try {
            if (!SecurityControlCenterHandler.verifyDefenseProDevicesUpdatedInLastRun(expectedDevicesNum)) {
                BaseTestUtils.report("Updated DP's number isn't as expected", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to verify DefensePro devices updated in last run: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Validate DefensePro devices not updated in last run equal to \"(.*)\"$")
    public void verifyDefenseProDevicesNotUpdatedInLastRun(String expectedDevicesNum) {
        try {
            if (!SecurityControlCenterHandler.verifyDefenseProDevicesNotUpdatedInLastRun(expectedDevicesNum)) {
                BaseTestUtils.report("Not updated DP's number isn't as expected", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to verify DefensePro devices not updated in last run: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Validate DefensePro devices not using Attackers feed subscription equal to \"(.*)\"$")
    public void verifyDefenseProDevicesNotUsingDDoSFeedSubscription(String expectedDevicesNum) {
        try {
            if (!SecurityControlCenterHandler.verifyDefenseProDevicesNotUsingDDoSFeedSubscription(expectedDevicesNum)) {
                BaseTestUtils.report("devices not using Attackers feed subscription number isn't as expected", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to verify DefensePro devices not using Attackers feed subscription: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Validate last DDoS feed update date equal to \"(.*)\" task last run date$")
    public void verifyLastDDoSFeedUpdateEqualToTaskDate(String taskName) {
        try {
            String expectedLastRun = BaseTasksHandler.getLastExecutionDateString(taskName, restTestBase.getVisionRestClient());
            SecurityControlCenterHandler.verifyLastRun(expectedLastRun);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to verify last DDoS feed update: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Validate last DDoS feed update equal to \"(.*)\"$")
    public void verifyLastDDoSFeedUpdate(String expectedLastRun) {
        try {
            SecurityControlCenterHandler.verifyLastRun(expectedLastRun);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to verify last DDoS feed update: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @Then("^UI Security Control Center visible : \"([^\"]*)\"$")
    public void uiSecurityControlCenterVisible(boolean visible) {
        if (!SecurityControlCenterHandler.IsPageVisible(visible)) {
            ReportsUtils.reportAndTakeScreenShot("Security Control Center, visibility : " + visible + " does not match", Reporter.FAIL);
        }
    }
}
