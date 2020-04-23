package com.radware.vision.tests.usermanagement.cliaccesslist;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.system.usermanagement.cliaccesslist.CliAccessListHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class CliAccessListTests extends WebUITestBase{
	String userName;
	
	@Test
	@TestProperties(name = "add User", paramsInclude = {"qcTestId", "userName"} )
	public void addUser() {
		try {
			CliAccessListHandler.addUser(userName);
		}
		catch(Exception e) {
			BaseTestUtils.report("Add user:" + userName + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
		}
	}
	
	@Test
	@TestProperties(name = "view User", paramsInclude = {"qcTestId", "userName"} )
	public void viewUser() {
		try {
			CliAccessListHandler.viewUser(userName);
		}
		catch(Exception e) {
			BaseTestUtils.report("View user:" + userName + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
		}
	}
	
	@Test
	@TestProperties(name = "delete User", paramsInclude = {"qcTestId", "userName"} )
	public void deleteUser() {
		try {
			CliAccessListHandler.deleteUser(userName);
		}
		catch(Exception e) {
			BaseTestUtils.report("Delete user:" + userName + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
		}
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
}
