package com.radware.vision.infra.testhandlers.system.usermanagement.userstatistics;

public class LoggedInUserEntry {
	
	String username;
	String fullname;
	String loginDateTime;
	
	private LoggedInUserEntry() {
		
	}
	
	public static void filterLoggedInUsers(String userName, String userFullName, String loginDateAndTime) {
		
	}
	
	public LoggedInUserEntry(String username, String fullname, String loginDateTime) {
		setUsername(username);
		setFullname(fullname);
		setLoginDateTime(loginDateTime);
	}
	
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public String getLoginDateTime() {
		return loginDateTime;
	}

	public void setLoginDateTime(String loginDateTime) {
		this.loginDateTime = loginDateTime;
	}

}
