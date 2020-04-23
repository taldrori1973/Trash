package com.radware.vision.tests.usermanagement.userstaticstics;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.system.usermanagement.userstatistics.UsersStatisticsHandler;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.awt.*;
import java.util.Date;

public class UsersStatistics extends WebUITestBase {
	public String userName;
	public String userFullName;
	public Date loginDateAndTime;
	
	public String statisticsDate;
	public Integer numSuccessfulLogins;
	public Integer numFailedLogins;
	public Integer numPasswordChanges;
	public Integer numLockOuts;
	
	
	@Test
	@TestProperties(name = "filter Currently Connected Users", paramsInclude = {"qcTestId", "userName", "statisticsDate", "numSuccessfulLogins",
			"numFailedLogins", "numPasswordChanges", "numLockOuts", "loginDateAndTime"})
	public void filterCurrentlyConnectedUsers() throws AWTException {
		try{
			UsersStatisticsHandler.filterUserStatistics(userName, statisticsDate, numSuccessfulLogins, numFailedLogins, numPasswordChanges, numLockOuts, loginDateAndTime);
		}
		catch(Exception e){
			BaseTestUtils.report("Device Driver related operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
		}
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


	public Date getLoginDateAndTime() {
		return loginDateAndTime;
	}


	public void setLoginDateAndTime(Date loginDateAndTime) {
		this.loginDateAndTime = loginDateAndTime;
	}


	public String getStatisticsDate() {
		return statisticsDate;
	}

	@ParameterProperties(description = "Accepted format is: yyyy-mm-dd")
	public void setStatisticsDate(String statisticsDate) {
		this.statisticsDate = statisticsDate;
	}

	public String getNumSuccessfulLogins() {
		return String.valueOf(numSuccessfulLogins);
	}


	public void setNumSuccessfulLogins(int numSuccessfulLogins) {
		this.numSuccessfulLogins = numSuccessfulLogins;
	}


	public int getNumFailedLogins() {
		return numFailedLogins;
	}


	public void setNumFailedLogins(int numFailedLogins) {
		this.numFailedLogins = numFailedLogins;
	}


	public int getNumPasswordChanges() {
		return numPasswordChanges;
	}


	public void setNumPasswordChanges(int numPasswordChanges) {
		this.numPasswordChanges = numPasswordChanges;
	}


	public String getNumLockOuts() {
		return String.valueOf(numLockOuts);
	}


	public void setNumLockOuts(int numLockOuts) {
		this.numLockOuts = numLockOuts;
	}
}
