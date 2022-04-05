package com.radware.vision.bddtests.analytics.adc;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.testhandlers.analytics.adc.ADCHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.DataTable;
import cucumber.api.java.en.Then;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.Map;

/**
 * Created by MoaadA on 9/6/2018.
 */
public class ADCSteps extends VisionUITestBase {

    public ADCSteps() throws Exception {
    }

    @Then("^UI Validate ADC chart \"(.*)\"$")
    public void validateADCChart(String chartName, DataTable data) {
        List<Map<String, String>> dataAsListOfMap = data.asMaps(String.class, String.class);
        for (int i = 0; i < dataAsListOfMap.size(); i++) {
            if (!ADCHandler.validateChart(chartName, dataAsListOfMap.get(i))) ;
            ReportsUtils.reportErrors();
        }
    }

    @Then("^UI Validate icon \"([^\"]*)\"(?: with params \"([^\"]*)\")? with status \"([^\"]*)\"$")
    public void uiValidateIconWithParamsWithStatus(String label, String params, String expectedStatus){
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams("");
        List<WebElement> prevIconsDisplayedElementsList = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        List<WebElement> iconsDisplayedElementsList = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        VisionDebugIdsManager.setParams(params);
        boolean needToWait = true;
        while (needToWait)
        {
            if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()) != null)
            {
                needToWait = false;
                break;
            }
            WebUIUtils.scrollIntoView(iconsDisplayedElementsList.get(iconsDisplayedElementsList.size()-1));
            VisionDebugIdsManager.setParams("");
            iconsDisplayedElementsList = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
            if (!prevIconsDisplayedElementsList.retainAll(iconsDisplayedElementsList))
            {
                needToWait = false;
                BaseTestUtils.report("No port with number" + params, Reporter.FAIL);
            }
            prevIconsDisplayedElementsList = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        }
        WebElement iconElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        String actualIconStatus = iconElement.getAttribute("class");
        if (!actualIconStatus.toUpperCase().contains(expectedStatus.toUpperCase()))
        {
            BaseTestUtils.report("The ACTUAL status of " + label + " is " + actualIconStatus + " But the EXPECTED status is " + expectedStatus, Reporter.FAIL);
        }

    }

    @Then("^UI Validate Switch button \"([^\"]*)\"(?: with params \"([^\"]*)\")? isSelected \"(true|false)\"$")
    public void uiValidateSwitchButtonIsSelected(String label, String params, boolean isSelected){
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        if (!(WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).getAttribute("class").contains("seleted-switch-button") && isSelected))
        {
            if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).getAttribute("class").contains("seleted-switch-button") || isSelected)
            {
                BaseTestUtils.report("The ACTUAL isSelected of " + label + params + " is " + WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).getAttribute("class").contains("seleted-switch-button") +  " But EXPECTED isSelect is " + isSelected, Reporter.FAIL);
            }
        }
    }
}
