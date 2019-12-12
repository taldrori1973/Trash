package com.radware.vision.infra.base.pages.system.deviceresources.devicebackups;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 9/4/2014.
 */
public class DeviceBackups extends WebUIVisionBasePage {
    String tableId = "DeviceFile";

    public DeviceBackups() {
        super("Device Backups", "MgtServer.MC.DeviceConfigurationFiles.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getDeviceBackupsNode());
    }

    public WebUITable getDeviceBackupsTable() {
        WebUITable table = (WebUITable) container.getTableById(tableId);
        return table;
    }

    public void downloadSelectedFileClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getDeviceFileDownload());
        (new WebUIComponent(locator)).click();
    }


}
