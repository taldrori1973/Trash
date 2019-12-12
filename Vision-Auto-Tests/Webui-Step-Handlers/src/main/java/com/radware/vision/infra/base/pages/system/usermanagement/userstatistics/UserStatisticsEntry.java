package com.radware.vision.infra.base.pages.system.usermanagement.userstatistics;

public class UserStatisticsEntry {
	
	String username;
	String date;
	String numberOfSuccessfulLogins;
	String numberOfFailedLoginAttempts;
	String numberOfPasswordChanges;
	String numberOfLockOuts;

	public UserStatisticsEntry(String username, String date, String numberOfSuccessfulLogins, String numberOfFailedLoginAttempts, String numberOfPasswordChanges, String numberOfLockOuts) {
		setUsername(username);
		setDate(date);
		setNumberOfSuccessfulLogins(numberOfSuccessfulLogins);
		setNumberOfFailedLoginAttempts(numberOfFailedLoginAttempts);
		setNumberOfPasswordChanges(numberOfPasswordChanges);
		setNumberOfLockOuts(numberOfLockOuts);
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getNumberOfSuccessfulLogins() {
		return numberOfSuccessfulLogins;
	}

	public void setNumberOfSuccessfulLogins(String numberOfSuccessfulLogins) {
		this.numberOfSuccessfulLogins = numberOfSuccessfulLogins;
	}

	public String getNumberOfFailedLoginAttempts() {
		return numberOfFailedLoginAttempts;
	}

	public void setNumberOfFailedLoginAttempts(String numberOfFailedLoginAttempts) {
		this.numberOfFailedLoginAttempts = numberOfFailedLoginAttempts;
	}

	public String getNumberOfPasswordChanges() {
		return numberOfPasswordChanges;
	}

	public void setNumberOfPasswordChanges(String numberOfPasswordChanges) {
		this.numberOfPasswordChanges = numberOfPasswordChanges;
	}

	public String getNumberOfLockOuts() {
		return numberOfLockOuts;
	}

	public void setNumberOfLockOuts(String numberOfLockOuts) {
		this.numberOfLockOuts = numberOfLockOuts;
	}
}
