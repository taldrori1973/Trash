package com.radware.vision.infra.base.pages.system.generalsettings.apmsettings;

import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 9/4/2014.
 */
public class APMSettings extends WebUIVisionBasePage {
    String tableLabel = "SharePath.SharePathConfig.Table";

    public APMSettings() {
        super("APM Settings", "SharePath.SharePathConfig.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getAPMSettingsNode());
    }
    public WebUITable getAPMSettingsTable() {
        WebUITable table = (WebUITable)container.getTableById(tableLabel);
        return table;
    }
}
