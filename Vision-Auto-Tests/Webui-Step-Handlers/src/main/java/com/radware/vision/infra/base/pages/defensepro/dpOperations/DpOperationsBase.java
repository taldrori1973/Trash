package com.radware.vision.infra.base.pages.defensepro.dpOperations;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIWidget;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 3/19/2015.
 */
public class DpOperationsBase {
    WebUIWidget dpControlBar;
    WebUIWidget dpOperationsButton;
    WebUIButton importConfigurationFileButton;
    WebUIButton updatePoliciesButton;

    public DpOperationsBase() {
        ComponentLocator dpControlBarLocator = new ComponentLocator(How.ID, WebUIStrings.getDeviceControlBar());
        dpControlBar = new WebUIWidget(new WebUIComponent(dpControlBarLocator));
    }

    public void operationMenuSubItemClick(String operationName) {
        DpOperationsButton();
        ComponentLocator importConfigurationFileButtonLocator = new ComponentLocator(How.ID, operationName);//(How.XPATH, "//*[contains(@title,'" + operationName + "')]")
        importConfigurationFileButton = new WebUIButton(new WebUIComponent(importConfigurationFileButtonLocator));
        importConfigurationFileButton.click();
    }

    private void DpOperationsButton() {
        ComponentLocator dpOperationsLocator = new ComponentLocator(How.ID, "gwt-debug-DeviceControlBar_Operations");
        dpOperationsButton = new WebUIWidget(new WebUIComponent(dpOperationsLocator));
        dpOperationsButton.click();
    }

    public void clickButton(String buttonId) {
        ComponentLocator locator = new ComponentLocator(How.ID, buttonId);
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
    }

    public void updatePoliciesClick() {
        ComponentLocator updatePoliciesLocator = new ComponentLocator(How.ID, WebUIStrings.getUpdatePoliciesButton());
        updatePoliciesButton = new WebUIButton(dpControlBar.findInner(updatePoliciesLocator));
        updatePoliciesButton.click();
    }
}
