package com.radware.vision.infra.base.pages.system.generalsettings.licensemanagement;

import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 9/4/2014.
 */
public class LicenseManagement extends WebUIVisionBasePage {
    String tableLabel = "License";

    public LicenseManagement() {
        super("License Management", "MgtServer.VisionLicensesManagement.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getLicenseManagementNode());
    }

    public WebUITable getLicenseManagementTable() {
        WebUITable table = (WebUITable) container.getTable(tableLabel);
        return table;
    }

}
