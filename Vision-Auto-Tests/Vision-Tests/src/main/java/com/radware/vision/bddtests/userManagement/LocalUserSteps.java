package com.radware.vision.bddtests.userManagement;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.testhandlers.system.usermanagement.localusers.LocalUsersHandler;
import cucumber.api.java.en.Then;

import java.util.Map;

public class LocalUserSteps extends VisionUITestBase {

    @Then("^UI Add Local user with userName \"([^\"]*)\"$")
    public void createUser(String userName, Map<String,String> userProperties) {
        try {
            String fullName = userProperties.get("fullName");
            String address = userProperties.get("address");
            String organisation = userProperties.get("organisation");
            String phoneNumber = userProperties.get("phoneNumber");
            String permissions = userProperties.get("permissions");
            String newNetworkPolicies = userProperties.get("newNetworkPolicies");
            String password = userProperties.get("password");

            LocalUsersHandler.addUser(userName, fullName, address, organisation, phoneNumber, permissions, newNetworkPolicies, password);
        } catch (Exception e) {
            BaseTestUtils.report("Adding user:" + userName + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Then("^UI Delete Local user with userName \"([^\"]*)\"$")
    public void deleteUser(String userName) {
        try {
            LocalUsersHandler.deleteUser(userName);
        } catch (Exception e) {
            BaseTestUtils.report("Deleting user:" + userName + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }
}
