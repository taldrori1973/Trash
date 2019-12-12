package com.radware.vision.infra.base.pages.dashboards.securitycontrolcenter;

import com.radware.automation.webui.widgets.api.TextField;
import com.radware.automation.webui.widgets.api.VerticalTab;
import com.radware.automation.webui.widgets.api.datetime.DateField;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;


public class SecurityControlCenter extends WebUIVisionBasePage {

    public SecurityControlCenter() {
        super("Security Control Center", "SecurityControlCenter.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getSecurityControlCenterNode());
    }

    public void openERTActiveDDoSFeed() {
        VerticalTab dDoSFeedTap = container.getVerticalTab("ERT Active Attackers Feed");
        dDoSFeedTap.click();
    }

    public String getDefenseProDevicesUpdatedInLastRun(){
        TextField devicesUpdatedinLastRun = container.getTextField("DefensePro Devices Updated in Last Run");
        return devicesUpdatedinLastRun.getValue();
    }

    public String getDefenseProDevicesNotUpdatedInLastRun(){
        TextField devicesNotUpdatedInLastRun = container.getTextField("DefensePro Devices Not Updated in Last Run");
        return devicesNotUpdatedInLastRun.getValue();
    }

    public String getDefenseProDevicesNotUsingDDoSFeedSubscription(){
        TextField devicesNotSubscribed = container.getTextField("DefensePro Devices Not Using ERT Active Attackers Feed Subscription");
        return devicesNotSubscribed.getValue();
    }

    public String getLastRun(){
        DateField lastRunDate = container.getDateField("Last Run");
        return lastRunDate.getWebElement().getAttribute("value");
    }
}
