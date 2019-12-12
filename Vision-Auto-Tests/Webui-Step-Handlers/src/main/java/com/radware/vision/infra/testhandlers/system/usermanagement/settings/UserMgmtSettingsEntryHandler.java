package com.radware.vision.infra.testhandlers.system.usermanagement.settings;

public class UserMgmtSettingsEntryHandler {

	String userAuth;
	String numOfPassChallanges;
	String confirmPassOtherUsers;
	String passValidityPeriod;
	String userStatisticsStoragePeriod;
	String numLastPassSaved;
	boolean mustChangePasswordFirstLogin;

	public UserMgmtSettingsEntryHandler() {

	}

	public UserMgmtSettingsEntryHandler(String userAuth, String numOfPassChallanges, String confirmPassOtherUsers, String passValidityPeriod,
			String userStatisticsStoragePeriod, String numLastPassSaved, boolean mustChangePasswordFirstLogin) {
		setUserAuth(userAuth);
		setNumOfPassChallanges(numOfPassChallanges);
		setConfirmPassOtherUsers(confirmPassOtherUsers);
		setPassValidityPeriod(passValidityPeriod);
		setUserStatisticsStoragePeriod(userStatisticsStoragePeriod);
		setNumLastPassSaved(numLastPassSaved);
		setMustChangePasswordFirstLogin(mustChangePasswordFirstLogin);
	}

	@Override
	public boolean equals(Object otherUserSettings) {
		if (otherUserSettings == null)
			return false;
		if (!(otherUserSettings instanceof UserMgmtSettingsEntryHandler))
			return false;
		UserMgmtSettingsEntryHandler comparedUsermgmtSettings = (UserMgmtSettingsEntryHandler) otherUserSettings;
		if ((this.getUserAuth().equals(comparedUsermgmtSettings.getUserAuth()))
				&& (this.getNumOfPassChallanges().equals(comparedUsermgmtSettings.getNumOfPassChallanges()))
				&& (this.getConfirmPassOtherUsers().equals(comparedUsermgmtSettings.getConfirmPassOtherUsers()))
				&& (this.getPassValidityPeriod().equals(comparedUsermgmtSettings.getPassValidityPeriod()))
				&& (this.getUserStatisticsStoragePeriod().equals(comparedUsermgmtSettings.getUserStatisticsStoragePeriod()))
				&& (this.getNumLastPassSaved().equals(comparedUsermgmtSettings.getNumLastPassSaved()))
				&& (this.getMustChangePasswordFirstLogin() == (comparedUsermgmtSettings.getMustChangePasswordFirstLogin())))
			return true;

		return false;
	}
	
	@Override
	public String toString() {
		StringBuffer settings = new StringBuffer();
		settings.
		append("Authentication Mode: ").append(getUserAuth()).
		append("Number of Password Challenges").append(getNumOfPassChallanges()).append("\n").
		append("Confirm Default password for Other Users: ").append(getConfirmPassOtherUsers()).append("\n").
		append("Password Validity Period: ").append(getPassValidityPeriod()).append("\n").
		append("User Statistics Storage Period: ").append(getUserStatisticsStoragePeriod()).append("\n").
		append("Number of Last Password Saved: ").append(getNumLastPassSaved()).append("\n").
		append("Users Must Change Password at First Login: ").append(getMustChangePasswordFirstLogin()).append("\n");
		return settings.toString();
		
	}

	public String getUserAuth() {
		return userAuth;
	}

	public void setUserAuth(String userAuth) {
		this.userAuth = userAuth;
	}

	public String getNumOfPassChallanges() {
		return numOfPassChallanges;
	}

	public void setNumOfPassChallanges(String numOfPassChallanges) {
		this.numOfPassChallanges = numOfPassChallanges;
	}

	public String getConfirmPassOtherUsers() {
		return confirmPassOtherUsers;
	}

	public void setConfirmPassOtherUsers(String confirmPassOtherUsers) {
		this.confirmPassOtherUsers = confirmPassOtherUsers;
	}

	public String getPassValidityPeriod() {
		return passValidityPeriod;
	}

	public void setPassValidityPeriod(String passValidityPeriod) {
		this.passValidityPeriod = passValidityPeriod;
	}

	public String getUserStatisticsStoragePeriod() {
		return userStatisticsStoragePeriod;
	}

	public void setUserStatisticsStoragePeriod(String userStatisticsStoragePeriod) {
		this.userStatisticsStoragePeriod = userStatisticsStoragePeriod;
	}

	public String getNumLastPassSaved() {
		return numLastPassSaved;
	}

	public void setNumLastPassSaved(String numLastPassSaved) {
		this.numLastPassSaved = numLastPassSaved;
	}

	public boolean getMustChangePasswordFirstLogin() {
		return mustChangePasswordFirstLogin;
	}

	public void setMustChangePasswordFirstLogin(boolean mustChangePasswordFirstLogin) {
		this.mustChangePasswordFirstLogin = mustChangePasswordFirstLogin;
	}
}
