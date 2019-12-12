package com.radware.vision.infra.base.pages.system.deviceresources.devicesubscriptions;

import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

public class DeviceSubscriptions extends WebUIVisionBasePage {
    String tableName = "Device Subscriptions";

    public DeviceSubscriptions() {
        super("Device Subscriptions", "MgtServer.MC.DeviceSubscriptions.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getDeviceSubscriptionsNode());
    }

    public WebUITable getDeviceSubscriptionsTable() {
        WebUITable table = (WebUITable) container.getTable(tableName);
        return table;
    }

}
