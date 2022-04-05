package com.radware.vision.infra.base.pages.system.usermanagement;

import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.api.Dropdown;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import org.openqa.selenium.support.How;

public class BasicParameters extends WebUIVisionBasePage {
	
	String authTypeComboName = "Basic Parameters"; 
	
	public BasicParameters() {
		super("Basic Paramaters", "UserManagement.BasicParam.xml");
		setPageLocatorHow(How.ID);
		setPageLocatorContent(WebUIStrings.getUserMgmtBasicParams());
	}
	
	public void setAuthenticationMethod(UserAuthType authType) {
		Dropdown authTypeCombo = container.getDropdown(authTypeComboName);
		authTypeCombo.selectOptionByText(authType.getAuthType());
	}
}
