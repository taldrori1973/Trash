package com.radware.vision.tests.dp.securitymonitoring.dashboradview.currentattackstable;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.By;

/**
 * Created by moaada on 8/6/2017.
 */
public class CurrentAttacksTableTests extends WebUITestBase {

    String attackCategory;
    String status;
    String policy;


    @Test
    @TestProperties(name = "verify first row values", paramsInclude = {"deviceName", "attackCategory", "status", "policy"})
    public void checkIfRowExists() {

        if (getDeviceName() == null || attackCategory == null || status == null || policy == null) {
            BaseTestUtils.report("One of the test params equal to null", Reporter.FAIL);
        }
        try {
            BaseHandler.lockUnlockDevice(getDeviceName(), "SitesAndClusters", DeviceState.Lock.getDeviceState(), false);
            WebUIVisionBasePage.navigateToPage("Security Monitoring->Dashboard View->Current Attacks Table");

            WebUIUtils.getDriver().switchTo().frame("security-dashboard-table");
            final String parentXpath = "/html/body/div[1]/ng-include/section/section/section/div[3]/rw-table2/section/div[1]/div[2]/table/tbody/tr/";

            String attackCategory = WebUIUtils.fluentWaitGetText(By.xpath(parentXpath + "td[2]/div/rw-table-cell2/span"), WebUIUtils.DEFAULT_WAIT_TIME, false);
            String status = WebUIUtils.fluentWaitGetText(By.xpath(parentXpath + "td[3]/div/rw-table-cell2/span"), WebUIUtils.DEFAULT_WAIT_TIME, false);
            String policy = WebUIUtils.fluentWaitGetText(By.xpath(parentXpath + "td[8]/div/rw-table-cell2/span[2]"), WebUIUtils.DEFAULT_WAIT_TIME, false);

            if (this.attackCategory.equals(attackCategory) && this.status.equals(status) && this.policy.equals(policy)) {

                BaseTestUtils.report("Verification succeeded ", Reporter.PASS);
            } else {

                BaseTestUtils.report("Values does not match", Reporter.FAIL);
                BaseTestUtils.reporter.report("Actual | Input");
                BaseTestUtils.reporter.report("-------------");
                BaseTestUtils.reporter.report(attackCategory + " | " + getAttackCategory());
                BaseTestUtils.reporter.report(status + " | " + getStatus());
                BaseTestUtils.reporter.report(policy + " | " + getPolicy());


            }


        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            //go back to default
            WebUIUtils.getDriver().switchTo().defaultContent();
            BaseHandler.lockUnlockDevice(getDeviceName(), "SitesAndClusters", DeviceState.UnLock.getDeviceState(), false);

        }

    }

    @Test
    @TestProperties(name = "check first any policy", paramsInclude = {"deviceName", "policy"})
    public void checkFirstAnyPolicy() {

        if (getDeviceName() == null || policy == null) {
            BaseTestUtils.report("One of the test params equal to null", Reporter.FAIL);
        }

        BaseHandler.lockUnlockDevice(getDeviceName(), "SitesAndClusters", DeviceState.Lock.getDeviceState(), false);
        try {
            WebUIVisionBasePage.navigateToPage("Security Monitoring->Dashboard View->Current Attacks Table");
            //wait until page gets loaded
            BasicOperationsHandler.delay(3);

            WebUIUtils.getDriver().switchTo().frame("security-dashboard-table");
            WebUIUtils.fluentWaitClick(By.xpath("/html/body/div[1]/ng-include/section/zippy/div/span"), WebUIUtils.SHORT_WAIT_TIME, false);


            final String parentXpath = "/html/body/div[1]/ng-include/section/zippy/div/div/div/div/div[2]/rw-table3/section/div[1]/table/tbody/tr/";
            String deviceName = WebUIUtils.fluentWaitGetText(By.xpath(parentXpath + "td[2]/span"), WebUIUtils.DEFAULT_WAIT_TIME, false);
            String policy = WebUIUtils.fluentWaitGetText(By.xpath(parentXpath + "td[3]/span"), WebUIUtils.DEFAULT_WAIT_TIME, false);

            if (getDeviceName().equals(deviceName) && this.policy.equals(policy)) {
                BasicOperationsHandler.takeScreenShot();
                BaseTestUtils.report("Test succeeded : both value are equal to expected value", Reporter.PASS);
            } else {
                BasicOperationsHandler.takeScreenShot();
                BaseTestUtils.report("Test failed: some or all value not equal to the expected value", Reporter.FAIL);
            }


        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            //go back to default
            WebUIUtils.getDriver().switchTo().defaultContent();
            BaseHandler.lockUnlockDevice(getDeviceName(), "SitesAndClusters", DeviceState.UnLock.getDeviceState(), false);
        }


    }


    public String getAttackCategory() {
        return attackCategory;
    }

    public void setAttackCategory(String attackCategory) {
        this.attackCategory = attackCategory;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPolicy() {
        return policy;
    }

    public void setPolicy(String policy) {
        this.policy = policy;
    }


}
