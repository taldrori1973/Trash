package com.radware.vision.infra.base.pages.system.usermanagement;

import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.testhandlers.system.usermanagement.settings.UserMgmtSettingsEntryHandler;
import org.openqa.selenium.support.How;

public class UserSettings extends WebUIVisionBasePage {

    final String defaultPasswordForOtherUsers = "gwt-debug-defaultPasswordRegularUsers_Widget";
    final String confirmDefaultPasswordForOtherUsers = "gwt-debug-defaultPasswordRegularUsers_DuplicatePasswordField";

	public UserSettings() {
		super("User Settings", "UserManagement.GlobalAAAParameters.xml", false);
		setPageLocatorHow(How.ID);
		setPageLocatorContent(WebUIStrings.getUserMgmtUserSettings());
	}

	public void setAuthenticationMode(String authType) {
		WebUIDropdown authMode = (WebUIDropdown) container.getDropdown("Authentication Mode");
		authMode.selectOptionByText(authType);
	}

    public void setNumOfPasswordChallenges(String challengesNumber) {
        WebUITextField textField = (WebUITextField) container.getTextField("Maximum Password Challenges");
        textField.type(challengesNumber);
    }

	public void setConfirmDefaultPassword(String password) {
        ComponentLocator locator = new ComponentLocator(How.ID, confirmDefaultPasswordForOtherUsers);
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement((new WebUIComponent(locator)).getWebElement());
        textField.type(password);
    }

	public void setDefaultPasswordForOtherUsers(String confirmDefaultPassword) {
		ComponentLocator locator = new ComponentLocator(How.ID, defaultPasswordForOtherUsers);
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement((new WebUIComponent(locator)).getWebElement());
		textField.type(confirmDefaultPassword);
	}

	public void setPasswordValidityPeriod(String passwordValidityPeriod) {
		WebUITextField textField = (WebUITextField) container.getTextField("Password Validity Period");
		textField.type(passwordValidityPeriod);
	}

	public void setUserStatisticStoragePeriod(String passwordValidityPeriod) {
        WebUITextField textField = (WebUITextField) container.getTextField("User Statistics Storage Period");
        textField.type(passwordValidityPeriod);
	}

	public void setNumberOfLastPasswordsSaved(String numOflastPassSaved) {
        WebUITextField textField = (WebUITextField) container.getTextField("Last Passwords Saved");
        textField.type(numOflastPassSaved);
	}

	public void setUsersMustChangePasswordAtFirstLogin(boolean mustChangePassword) {
		WebUICheckbox combo = (WebUICheckbox) container.getCheckbox("Users Must Change Password at First Login");
		if (mustChangePassword)
			combo.check();
		else
			combo.uncheck();
	}

	// Getters
	public String getAuthenticationMode() {
		WebUIDropdown authMode = (WebUIDropdown) container.getDropdown("Authentication Mode");
		return authMode.getValue();
	}

	public String getNumOfPasswordChallenges() {
		WebUITextField textField = (WebUITextField) container.getTextField("Number of Password Challenges");
		return textField.getValue();
	}

	public String getConfirmDefaultPassword() {
		WebUITextField textField = (WebUITextField) container.getTextField("Default Password for Other Users");
		return textField.getValue();
	}

	public String getDefaultPasswordForOtherUsers() {
		ComponentLocator locator = new ComponentLocator(How.ID, defaultPasswordForOtherUsers);
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement((new WebUIComponent(locator)).getWebElement());
		return textField.getValue();
	}

	public String getPasswordValidityPeriod() {
		WebUITextField textField = (WebUITextField) container.getTextField("Password Validity Period");
		return textField.getValue();
	}

	public String getUserStatisticStoragePeriod() {
		WebUITextField textField = (WebUITextField) container.getTextField("User Statistic Storage Period");
		return textField.getValue();
	}

	public String getNumberOfLastPasswordsSaved() {
		WebUITextField textField = (WebUITextField) container.getTextField("Number of Last Passwords Saved");
		return textField.getValue();
	}

	public boolean getUsersMustChangePasswordAtFirstLogin() {
		WebUICheckbox combo = (WebUICheckbox) container.getCheckbox("Users Must Change Password at First Login");
		return combo.isChecked();
	}

	public UserMgmtSettingsEntryHandler getUserSettings() {
		return new UserMgmtSettingsEntryHandler(getAuthenticationMode(), getNumOfPasswordChallenges(), getConfirmDefaultPassword(), getConfirmDefaultPassword(), getUserStatisticStoragePeriod(),
				getNumberOfLastPasswordsSaved(), getUsersMustChangePasswordAtFirstLogin());
	}
}
