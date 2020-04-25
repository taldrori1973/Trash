package com.radware.vision.tests.usermanagement.settings;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.system.usermanagement.UserAuthType;
import com.radware.vision.infra.testhandlers.system.usermanagement.settings.SettingsHandler;
import com.radware.vision.infra.testhandlers.system.usermanagement.settings.UserMgmtSettingsEntryHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class Settings extends WebUITestBase {

	UserAuthType userAuthType;
    String numOfPasswordChallenges;
    String confirmDefaultPasswordForOtherUsers;
    String passwordValidityPeriod;
    String userStatisticsStoragePeriod;
	String numOfLastPasswordSaved;
	boolean usersMustChangePasswordAtFirstLogin;

	@Test
    @TestProperties(name = "Set User Settings", paramsInclude = {"qcTestId", "userAuthType", "numOfPasswordChallenges", "confirmDefaultPasswordForOtherUsers", "passwordValidityPeriod",
            "userStatisticsStoragePeriod", "numOfLastPasswordSaved", "usersMustChangePasswordAtFirstLogin" })
	public void setUserSettings() {
		try {
            UserMgmtSettingsEntryHandler userMgmtSettingsEntry = new UserMgmtSettingsEntryHandler(getUserAuthType(), getNumOfPasswordChallenges(),
                    getConfirmDefaultPasswordForOtherUsers(), getPasswordValidityPeriod(), getUserStatisticsStoragePeriod(), getNumOfLastPasswordSaved(),
                    isUsersMustChangePasswordAtFirstLogin());
			SettingsHandler.fillSettings(userMgmtSettingsEntry);
		} catch (Exception e) {
			BaseTestUtils.report("Failed to update user settings." + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
		}
	}
	
	@Test
    @TestProperties(name = "verify User Settings", paramsInclude = {"qcTestId", "userAuthType", "numOfPasswordChallenges", "confirmDefaultPasswordForOtherUsers", "passwordValidityPeriod",
            "userStatisticsStoragePeriod", "numOfLastPasswordSaved", "usersMustChangePasswordAtFirstLogin" })
	public void verifyUserSettings() {
		try {
            UserMgmtSettingsEntryHandler userMgmtSettingsEntry = new UserMgmtSettingsEntryHandler(getUserAuthType(), getNumOfPasswordChallenges(),
                    getConfirmDefaultPasswordForOtherUsers(), getPasswordValidityPeriod(), getUserStatisticsStoragePeriod(), getNumOfLastPasswordSaved(),
                    isUsersMustChangePasswordAtFirstLogin());
			UserMgmtSettingsEntryHandler retrievedUserMgmtSettings = SettingsHandler.getUserMgmtSettings();
			if(!(retrievedUserMgmtSettings.equals(userMgmtSettingsEntry))) {
				BaseTestUtils.report("User management Settings were not updated correctly.\n" + "Expected: " + userMgmtSettingsEntry.toString() + "\nActual: " + retrievedUserMgmtSettings.toString(), Reporter.FAIL);
			}
			
		} catch (Exception e) {
			BaseTestUtils.report("Verification of User Settings failed." + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
		}
	}
	

	public String getUserAuthType() {
		return userAuthType.getAuthType();
	}

	public void setUserAuthType(UserAuthType userAuthType) {
		this.userAuthType = userAuthType;
	}

    public String getNumOfPasswordChallenges() {
        return numOfPasswordChallenges;
    }

    public void setNumOfPasswordChallenges(String numOfPasswordChallenges) {
        this.numOfPasswordChallenges = numOfPasswordChallenges;
    }

	public String getConfirmDefaultPasswordForOtherUsers() {
		return confirmDefaultPasswordForOtherUsers;
	}

	public void setConfirmDefaultPasswordForOtherUsers(String confirmDefaultPasswordForOtherUsers) {
		this.confirmDefaultPasswordForOtherUsers = confirmDefaultPasswordForOtherUsers;
	}

    public String getPasswordValidityPeriod() {
        return passwordValidityPeriod;
    }

    public void setPasswordValidityPeriod(String passwordValidityPeriod) {
        this.passwordValidityPeriod = passwordValidityPeriod;
    }

	public String getUserStatisticsStoragePeriod() {
		return userStatisticsStoragePeriod;
	}

	public void setUserStatisticsStoragePeriod(String userStatisticsStoragePeriod) {
		this.userStatisticsStoragePeriod = userStatisticsStoragePeriod;
	}

	public String getNumOfLastPasswordSaved() {
		return numOfLastPasswordSaved;
	}

	public void setNumOfLastPasswordSaved(String numOfLastPasswordSaved) {
		this.numOfLastPasswordSaved = numOfLastPasswordSaved;
	}

	public boolean isUsersMustChangePasswordAtFirstLogin() {
		return usersMustChangePasswordAtFirstLogin;
	}

	public void setUsersMustChangePasswordAtFirstLogin(boolean usersMustChangePasswordAtFirstLogin) {
		this.usersMustChangePasswordAtFirstLogin = usersMustChangePasswordAtFirstLogin;
	}

}
