package com.radware.vision.tests.usermanagement.roles;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.system.usermanagement.roles.RolesHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.util.Arrays;

public class Roles extends WebUITestBase {
	
	public String rolesToFind;

	@Test
	@TestProperties(name = "Get All Roles", paramsInclude = {"qcTestId", "rolesToFind"} )
	public void testVerifyExistingRoles() {
		try {
			if(!RolesHandler.verifyExistingRoles(Arrays.asList(getRolesToFind().split(",")))) {
				BaseTestUtils.report("Expected roles were not found in general roles list: " + rolesToFind + "\n", Reporter.FAIL);
			}
		}
		catch(Exception e) {
			BaseTestUtils.report("Failed to retrieve current roles." + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
		}
	}
	
	public String getRolesToFind() {
		return rolesToFind;
	}

	public void setRolesToFind(String rolesToFind) {
		this.rolesToFind = rolesToFind;
	}

}
