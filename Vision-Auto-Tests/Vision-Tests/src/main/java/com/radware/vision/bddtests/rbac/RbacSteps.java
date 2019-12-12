package com.radware.vision.bddtests.rbac;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandler;
import cucumber.api.java.After;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.List;

import static com.radware.vision.infra.utils.GeneralUtils.lineSeparator;

public class RbacSteps {


    @When("^UI Validate user rbac$")
    public void uiValidateUserRbac(List<RbacEntry> entries) {


        String failuresOutput = "";
        String operation;
        String access;
        for (RbacEntry entry : entries) {

            operation = entry.operations;
            access = entry.accesses;

            StringBuilder currentValidation = new StringBuilder()
                    .append(" Operation : ")
                    .append(operation)
                    .append(" Access : ")
                    .append(access)
                    .append("--->");
            try {
                String returnedTValue = RBACHandler.validateRbacOperation(operation, access);

                if (!returnedTValue.isEmpty())
                    failuresOutput = failuresOutput.join("", (currentValidation.toString()), returnedTValue, lineSeparator);
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }

            if (!failuresOutput.isEmpty())
                BaseTestUtils.report(failuresOutput, Reporter.FAIL);
        }

    }

    @After("@Logout")
    public void logout() {
        BasicOperationsHandler.logout();
    }

    @Then("^UI Validate user rbac with \"([^\"]*)\" and \"([^\"]*)\"$")
    public void uiValidateUserRbac(String operation, String access) {
        String failuresOutput = "";
        StringBuilder currentValidation = new StringBuilder()
                .append(" Operation : ")
                .append(operation)
                .append(" Access : ")
                .append(access)
                .append("--->");
        try {
            String returnedTValue = RBACHandler.validateRbacOperation(operation, access);

            if (!returnedTValue.isEmpty())
                failuresOutput = failuresOutput.join("", (currentValidation.toString()), returnedTValue, lineSeparator);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

        if (!failuresOutput.isEmpty())
            BaseTestUtils.report(failuresOutput, Reporter.FAIL);
    }


    public class RbacEntry {
        public String operations;
        public String accesses;
    }

}
