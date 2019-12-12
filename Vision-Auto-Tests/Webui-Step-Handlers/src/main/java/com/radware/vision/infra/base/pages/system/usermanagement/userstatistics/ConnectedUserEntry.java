package com.radware.vision.infra.base.pages.system.usermanagement.userstatistics;

public class ConnectedUserEntry {

	String userName;
	String userFullName;
	String loginDateAndTime;
	
	public ConnectedUserEntry(String username, String userFullName, String loginDateAndTime) {
		setUserName(username);
		setUserFullName(userFullName);
		setLoginDateAndTime(loginDateAndTime);
	}

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserFullName() {
		return userFullName;
	}
	public void setUserFullName(String userFullName) {
		this.userFullName = userFullName;
	}
	public String getLoginDateAndTime() {
		return loginDateAndTime;
	}
	public void setLoginDateAndTime(String loginDateAndTime) {
		this.loginDateAndTime = loginDateAndTime;
	}
}
