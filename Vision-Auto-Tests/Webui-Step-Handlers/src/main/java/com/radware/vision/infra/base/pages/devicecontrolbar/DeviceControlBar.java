package com.radware.vision.infra.base.pages.devicecontrolbar;

import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.automation.webui.widgets.impl.WebUIWidget;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

public class DeviceControlBar {
	WebUIWidget deviceControlBar;
	WebUIButton applyButton;
	WebUIButton saveButton;
	WebUIButton revertButton;
	WebUIButton syncButton;
    WebUIButton dumpButton;
    WebUIButton deviceOperationsMenuButton;
    WebUIButton revertMenuButton;

    WebUITextField privateKeysTestField;

	
	public DeviceControlBar() {
			ComponentLocator deviceControlBarLocator = new ComponentLocator(How.ID ,WebUIStrings.getDeviceControlBar());
			deviceControlBar = new WebUIWidget(new WebUIComponent(deviceControlBarLocator));
	}
	
	
	public void applyButtonClick() {
		ComponentLocator applyButtonLocator = new ComponentLocator(How.ID ,WebUIStrings.getApplyButton());
		applyButton = new WebUIButton(deviceControlBar.findInner(applyButtonLocator));
		applyButton.click();
	}
	public void saveButtonClick() {
		ComponentLocator saveButtonLocator = new ComponentLocator(How.ID ,WebUIStrings.getSaveButton());
		saveButton = new WebUIButton(deviceControlBar.findInner(saveButtonLocator));
		saveButton.click();
	}
	public void revertButtonClick() {
		ComponentLocator revertButtonLocator = new ComponentLocator(How.ID ,WebUIStrings.getRevertButton());
		revertButton = new WebUIButton(deviceControlBar.findInner(revertButtonLocator));
		revertButton.click();
	}

    public void revertMenuItemClick(String id) {
        revertButtonClick();
        ComponentLocator locator = new ComponentLocator(How.ID, id);
        revertMenuButton = new WebUIButton(new WebUIComponent(locator));
        revertMenuButton.click();
    }


	public void syncButtonClick() {
		ComponentLocator syncButtonLocator = new ComponentLocator(How.ID ,WebUIStrings.getSyncButton());
		syncButton = new WebUIButton(deviceControlBar.findInner(syncButtonLocator));	
		syncButton.click();
	}

    public void dumpButtonClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getDumpButton());
        dumpButton = new WebUIButton(deviceControlBar.findInner(locator));
        dumpButton.click();
    }

    private void operationsMenuClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getDeviceControlBarOperations());//(How.XPATH, "//*[contains(@class,'" + WebUIStrings.getTriangleMenuOperationsButton() + "')]");
        dumpButton = new WebUIButton(deviceControlBar.findInner(locator));
        dumpButton.click();
    }

    public void operationsMenuItemClick(String id) {
        operationsMenuClick();
        ComponentLocator locator = new ComponentLocator(How.ID, id);
        deviceOperationsMenuButton = new WebUIButton(new WebUIComponent(locator));
        deviceOperationsMenuButton.click();
    }

    public void clickButton(String buttonId) {
        ComponentLocator locator = new ComponentLocator(How.ID, buttonId);
        (new WebUIComponent(locator)).click();
    }

    public void setPrivateKeys(String privateKeys) {
        if (privateKeys != null && !privateKeys.equals("")) {
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getAlteonPassphraseField());
            WebUITextField textField = new WebUITextField(locator);
            textField.setWebElement(new WebUIComponent(locator).getWebElement());
            textField.type(privateKeys);
        }
    }
}
