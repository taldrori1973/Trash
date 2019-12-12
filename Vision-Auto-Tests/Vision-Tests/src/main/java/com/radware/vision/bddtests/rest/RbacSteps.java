package com.radware.vision.bddtests.rest;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testresthandlers.RestRbacHandler;
import cucumber.api.java.en.When;

import java.util.List;

import static com.radware.vision.infra.utils.GeneralUtils.lineSeparator;

public class RbacSteps {


    @When("^REST Validate user rbac$")
    public void RestValidateUserRbac(List<com.radware.vision.bddtests.rbac.RbacSteps.RbacEntry> entries) {

        String failuresOutput = "";
        String operation = "";
        String access = "";
        for (int i = 0; i < entries.size(); i++) {

            operation = entries.get(i).operations;
            access = entries.get(i).accesses;

            StringBuilder currentValidation = new StringBuilder()
                    .append(" Operation : ")
                    .append(operation)
                    .append(" Access : ")
                    .append(access)
                    .append("--->");
            try {
                String returnedTValue = RestRbacHandler.validateRbacOperation(operation, access);

                if (!returnedTValue.isEmpty())
                    failuresOutput = failuresOutput.join("", (currentValidation.toString()), returnedTValue, lineSeparator);
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }

            if (!failuresOutput.isEmpty())
                BaseTestUtils.report(failuresOutput, Reporter.FAIL);
        }
    }

}
