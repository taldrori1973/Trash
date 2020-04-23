package com.radware.vision.bddtests.alteon.securitymonitoring.dashboardview;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection.SslInspectionHandler;
import com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection.enums.DeleteOrLeaveIt;
import com.radware.vision.infra.testhandlers.rbac.enums.EnableDisableEnum;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class SslInspectionSteps {

    @When("^UI SSL Inspection, Set Global Time Filter To \"(.*)\"$")
    public void setReportsGlobalTimeFilter(String quickRange) throws TargetWebElementNotFoundException {
        SslInspectionHandler.selectGlobalTimeFilter(quickRange);
    }


    @When("^UI SSl Inspection Reports Settings, Delete And Confirm Report With Report Title \"(.*)\"$")
    public void deleteReportAndConfirm(String reportTitle) {
        SslInspectionHandler.ReportsSettings.clickOnDeleteBaseTestUtils.reportTitle);
        SslInspectionHandler.ReportsSettings.clickOnYesDeleteOrLeaveIt(reportTitle, DeleteOrLeaveIt.YES_DELETE_IT);

    }

    @When("^UI SSl Inspection Reports Settings, Delete And Leave Report With Report Title \"(.*)\"$")
    public void deleteReportAndLeaveIt(String reportTitle) {
        SslInspectionHandler.ReportsSettings.clickOnDeleteBaseTestUtils.reportTitle);
        SslInspectionHandler.ReportsSettings.clickOnYesDeleteOrLeaveIt(reportTitle, DeleteOrLeaveIt.LEAVE_IT);

    }

    @Then("^UI SSl Inspection Reports Settings, Check If Report with Report Title \"(.*)\" Exist's$")
    public void verifyThatReportExists(String reportTitle) {

        if (!SslInspectionHandler.ReportsSettings.verifyIfReportExists(reportTitle)) {
            BaseTestUtils.report("Report with Report Title : " + reportTitle + " Does Not Exist's", Reporter.FAIL);
            WebUIUtils.generateAndReportScreenshot();
        }

    }

    @Then("^UI SSl Inspection Reports Settings, Check If Report with Report Title \"(.*)\" Does Not Exist$")
    public void verifyThatReportDoesNotExists(String reportTitle) {

        if (SslInspectionHandler.ReportsSettings.verifyIfReportExists(reportTitle)) {
            BaseTestUtils.report("Report with Report Title : " + reportTitle + " Does Exist's", Reporter.FAIL);
            WebUIUtils.generateAndReportScreenshot();
        }

    }

    @Given("^UI SSl Inspection Reports Settings, Enable Report With Report Title \"(.*)\"$")
    public void enableReport(String reportTitle) {
        SslInspectionHandler.ReportsSettings.enableDisableBaseTestUtils.reportTitle, EnableDisableEnum.ENABLE);

    }

    @Given("^UI SSl Inspection Reports Settings, Disable Report With Report Title \"(.*)\"$")
    public void disableReport(String reportTitle) {
        SslInspectionHandler.ReportsSettings.enableDisableBaseTestUtils.reportTitle, EnableDisableEnum.DISABLE);

    }
}
