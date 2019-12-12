package com.radware.vision.infra.base.pages;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.automation.webui.widgets.impl.WebUIWidget;
import org.openqa.selenium.Keys;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

public class VisionWebUILogin {
	
	WebUIWidget loginDialog;
	WebUIButton loginBtn;
	WebUITextField usernameTextBox;
	WebUITextField passwordTextBox;
	
	public VisionWebUILogin() {
		ComponentLocator loginDialogLocator = new ComponentLocator(How.ID ,WebUIStrings.getLoginPopupDialog());
		loginDialog = new WebUIWidget(new WebUIComponent(loginDialogLocator));
	}
	
	public void login() {
		WebUIDriver.getListenerManager().unregisterEventListener();
		ComponentLocator loginBtnLocator = new ComponentLocator(How.ID ,"gwt-debug-Dialog_Box_undefined");
		WebUIComponent loginButton = new WebUIComponent(loginBtnLocator);
		try {
			loginButton.click();
		}
		catch(StaleElementReferenceException sere) {
			//	Ignore
		}
		WebUIUtils.registerEventListener();
	}
	
	private void staleElementClick(WebElement element) {
		try {
			element.sendKeys(Keys.ENTER);
		}
		catch(StaleElementReferenceException sere) {
			staleElementClick(element);
		}
	}
	
	public void setUsername(String username) {
        ComponentLocator usernameLocator = new ComponentLocator(How.ID ,WebUIStrings.getLoginUsernameTextbox());
        usernameTextBox = new WebUITextField(usernameLocator);
        usernameTextBox.setWebElement(loginDialog.findInner(usernameLocator).getWebElement());
		usernameTextBox.type(username);
	}
	
	public void setUPassword(String password) {
        ComponentLocator passwordLocator = new ComponentLocator(How.ID ,WebUIStrings.getLoginPasswordTextbox());
        passwordTextBox = new WebUITextField(passwordLocator);
        passwordTextBox.setWebElement(loginDialog.findInner(passwordLocator).getWebElement());
		passwordTextBox.type(password);
	}
}
