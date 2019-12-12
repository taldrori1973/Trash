package com.radware.vision.infra.base.pages.alerts;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.restcommands.RestCommands;
import com.radware.restcore.VisionRestClient;
import com.radware.urlbuilder.vision.VisionUrlPath;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.testhandlers.alerts.AlertsUtils.AcknowledgementSetter;
import com.radware.vision.infra.testhandlers.alerts.AlertsUtils.DeviceTypeSetter;
import com.radware.vision.infra.testhandlers.alerts.AlertsUtils.ModuleSetter;
import com.radware.vision.infra.testhandlers.alerts.AlertsUtils.SeveritySetter;
import com.radware.vision.infra.utils.WebUIStringsVision;
import junit.framework.SystemTestCase4;
import org.openqa.selenium.support.How;

import java.util.List;

public class AlertFilter extends WebUIVisionBasePage {
    public AlertFilter() {
        super("Alerts Table", "AlertBrowser.Filter.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getAlertsFilterTab());
    }

    public void selectAllDevices(boolean selectAllDevices) {
        WebUICheckbox selectAll = (WebUICheckbox) container.getCheckbox("Select All Devices");
        if (selectAllDevices)
            selectAll.check();
        else
            selectAll.uncheck();
    }

    public void setRaisedTime(String raisedTimeUnit, String raisedTimeValue) {
        WebUIDropdown timeUnitCombo = new WebUIDropdown();
        WebUIDropdown timeValueCombo = new WebUIDropdown();

        timeUnitCombo.setLocator(new ComponentLocator(How.ID, WebUIStringsVision.getRaisedLastTimeUnitCombo()));
        timeUnitCombo.find(true, true);
        setDropdownIfNotEmpty(timeUnitCombo, raisedTimeUnit);
        if ((raisedTimeUnit.toLowerCase()).contains("hour")) {
            timeValueCombo.setLocator(new ComponentLocator(How.ID, WebUIStringsVision.getRaisedLastValHourCombo()));
        } else if ((raisedTimeUnit.toLowerCase()).contains("minute")) {
            timeValueCombo.setLocator(new ComponentLocator(How.ID, WebUIStringsVision.getRaisedLastValMinCombo()));
        } else {
            SystemTestCase4.report.report("Incorrect time UNIT is provided", Reporter.FAIL);
        }
        timeValueCombo.find(true, true);
        setDropdownIfNotEmpty(timeValueCombo, raisedTimeValue);
    }

    public void setRaisedTimeRest(String raisedTimeUnit, String raisedTimeValue, VisionRestClient visionRestClient) {
        String restUrl = VisionUrlPath.mgmt().system().config().item().alertfilter().build();
        RestCommands restCommands = new RestCommands(visionRestClient);
        String body = String.format("{\"raisedInTheLastTimeUnit\":\"%s\",\"raisedInTheLastInt\":\"%s\"}", raisedTimeUnit, raisedTimeValue != null ? raisedTimeValue : "1");
        String result = restCommands.putLocalCommand(restUrl, body, false);
    }

    public void setSeverity(List<String> severityList) {
        SeveritySetter setter = new SeveritySetter();
        setter.uncheckSeverityAll();
        setter.checkSeverityList(severityList);
    }

    public void setModules(List<String> modulesList) {
        ModuleSetter setter = new ModuleSetter();
        setter.uncheckModulesAll();
        setter.checkModules(modulesList);
    }

    public void setDeviceType(List<String> deviceTypesList) {
        DeviceTypeSetter setter = new DeviceTypeSetter();
        setter.uncheckDeviceTypeAll();
        setter.checkDeviceTypeList(deviceTypesList);
    }

    public void setAckUnackStatus(List<String> ackStatusList) {
        AcknowledgementSetter setter = new AcknowledgementSetter();
        setter.checkAckStatusList(ackStatusList);
    }

    public void setRestoreDefaultFilter(boolean restoreDefaults) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsRestoreDefaultsButton());

        if (restoreDefaults) {
            (new WebUIComponent(locator)).click();
        }
    }

    public void clickSubmitButton() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsFIlterSubmitButton());
        (new WebUIComponent(locator)).click();
    }

    private void setDropdownIfNotEmpty(WebUIDropdown taskElement, String value) {
        if (value != null && !value.isEmpty()) {
            taskElement.selectOptionByText(value);

        }
    }
}
