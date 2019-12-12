package com.radware.vision.infra.base.pages.system.generalsettings;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.base.pages.alerts.AlertBrowser;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.system.generalsettings.apmsettings.APMSettings;
import com.radware.vision.infra.base.pages.system.generalsettings.basicparameters.BasicParameters;
import com.radware.vision.infra.base.pages.system.generalsettings.devicedrivers.DeviceDrivers;
import com.radware.vision.infra.base.pages.system.generalsettings.display.Display;
import com.radware.vision.infra.base.pages.system.generalsettings.licensemanagement.LicenseManagement;
import com.radware.vision.infra.base.pages.system.generalsettings.monitoring.Monitoring;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

public class GeneralSettings extends WebUIVisionBasePage {
    public DeviceDrivers deviceDriversMenu() {
        return (DeviceDrivers) new DeviceDrivers().openPage();
    }

    public BasicParameters basicParametersMenu() {
        return (BasicParameters) new BasicParameters().openPage();
    }

    public Display displayMenu() {
        return (Display) new Display().openPage();
    }

    public Monitoring monitoringMenu() {
        return (Monitoring) new Monitoring().openPage();
    }


    public LicenseManagement licenseManagementMenu() {
        return (LicenseManagement) new LicenseManagement().openPage();
    }

    public APMSettings apmSettingsMenu() {
        return (APMSettings) new APMSettings().openPage();
    }

    public AlertBrowser AlertBrowserMenu() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertSettingsLeaf());
        if (!isNodeExpanded(locator)) {
            (new WebUIComponent(locator)).click();
        }
        return (AlertBrowser) new AlertBrowser().openPage();
    }

    private boolean isNodeExpanded(ComponentLocator rootNodeLocator) {
        String rootNodeLocatorValue = rootNodeLocator.getLocatorValue();
        ComponentLocator locator = new ComponentLocator(rootNodeLocator.getLocatorType(), rootNodeLocatorValue.substring(0, rootNodeLocatorValue.indexOf("-content")));
        return (new WebUIComponent(locator)).isExpanded();
    }
}
