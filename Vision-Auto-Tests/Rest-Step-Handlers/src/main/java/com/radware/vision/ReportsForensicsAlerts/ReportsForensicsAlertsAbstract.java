package com.radware.vision.ReportsForensicsAlerts;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import org.openqa.selenium.WebElement;

import java.util.Map;

abstract class ReportsForensicsAlertsAbstract implements ReportsForensicsAlertsInterface {
    StringBuilder errorMessages = new StringBuilder();
    final String checkedNotCheckedAttribute = "data-debug-checked";


    protected void createName(String name) throws Exception {
        getWebElement("REPORTPARAMETERS_Name").click();
        BasicOperationsHandler.setTextField("ReportName_input", "", name, true);
        if (getWebElement("ReportName_input").getAttribute("value").equals(name))
            throw new Exception("Filling report name doesn't succeed");
    }

    protected void selectTime(Map<String, String> map) {

    }

    protected void selectScheduling(Map<String, String> map) {

    }

    protected void selectShare(Map<String, String> map) {

    }

    protected void selectScopeSelection() {

    }

    final WebElement getWebElement(String label)
    {
        return getWebElement(label, "");
    }
    final protected WebElement getWebElement(String label, String params)
    {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        return WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
    }

}
