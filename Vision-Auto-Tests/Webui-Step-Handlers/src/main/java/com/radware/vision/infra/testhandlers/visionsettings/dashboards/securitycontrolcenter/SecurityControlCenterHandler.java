package com.radware.vision.infra.testhandlers.visionsettings.dashboards.securitycontrolcenter;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.infra.base.pages.dashboards.securitycontrolcenter.SecurityControlCenter;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;


public class SecurityControlCenterHandler {

    public static void openERTActiveDDoSFeed() {
        SecurityControlCenter securityControlCenter = new SecurityControlCenter();
        securityControlCenter.openERTActiveDDoSFeed();
    }

    /*
    * ERT Active Attackers Feed Tap handler
    */
    public static boolean verifyDefenseProDevicesUpdatedInLastRun(String expectedDevicesNum) {
        SecurityControlCenter securityControlCenter = new SecurityControlCenter();
        String actualDevicesNum = securityControlCenter.getDefenseProDevicesUpdatedInLastRun();
        if (actualDevicesNum.equals(expectedDevicesNum)) {
            return true;
        }
        return false;
    }

    public static boolean verifyDefenseProDevicesNotUpdatedInLastRun(String expectedDevicesNum) {
        SecurityControlCenter securityControlCenter = new SecurityControlCenter();
        String actualDevicesNum = securityControlCenter.getDefenseProDevicesNotUpdatedInLastRun();
        if (actualDevicesNum.equals(expectedDevicesNum)) {
            return true;
        }
        return false;
    }

    public static boolean verifyDefenseProDevicesNotUsingDDoSFeedSubscription(String expectedDevicesNum) {
        SecurityControlCenter securityControlCenter = new SecurityControlCenter();
        String actualDevicesNum = securityControlCenter.getDefenseProDevicesNotUsingDDoSFeedSubscription();
        if (actualDevicesNum.equals(expectedDevicesNum)) {
            return true;
        }
        return false;
    }

    public static void verifyLastRun(String expectedLastRun) throws Exception {
        SecurityControlCenter securityControlCenter = new SecurityControlCenter();
        String actualLastRun = securityControlCenter.getLastRun();
        if (!actualLastRun.equals(expectedLastRun)) {
            throw new Exception("Last run in Security Control Center: " + actualLastRun + "  isn't equal to: " + expectedLastRun);
        }
    }

    public static boolean IsPageVisible(Boolean visible) {
        WebUIVisionBasePage.navigateToPage("Dashboards");
        WebElement securityControlTab = WebUIUtils.fluentWait(new ComponentLocator(How.ID, "gwt-debug-security_control_center_Tab").getBy(), WebUIUtils.SHORT_WAIT_TIME, false);

        if (visible && securityControlTab == null || !visible && securityControlTab != null) return false;

        return true;

    }
}
