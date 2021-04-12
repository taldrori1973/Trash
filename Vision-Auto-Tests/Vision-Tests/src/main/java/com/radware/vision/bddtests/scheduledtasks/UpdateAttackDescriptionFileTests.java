package com.radware.vision.bddtests.scheduledtasks;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.exceptions.misc.NoSuchOperationException;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.bddtests.basicoperations.BasicOperationsSteps;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.UpdateAttackDescriptionFileTaskHandler;
import cucumber.api.java.en.When;
import testhandlers.vision.system.generalSettings.BasicParametersHandler;
import testhandlers.vision.system.generalSettings.enums.BasicParametersKeys;

import java.time.LocalDateTime;

public class UpdateAttackDescriptionFileTests extends VisionUITestBase {

    public UpdateAttackDescriptionFileTests() throws Exception {
    }

    @When("^UI Add Update Attack Description File Task with name \"(.*)\" description \"(.*)\" with default params( negative)?$")
    public void addUpdateAttackDescriptionFileTask(String taskName, String taskDescription, String isNegativeArg) {
        try {
            UpdateAttackDescriptionFileTaskHandler.addUpdateAttackDescriptionFileTask(taskName, taskDescription, true);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
        BaseTestUtils.report("Operation was executed successfully : " + taskName, BaseTestUtils.PASS_NOR_FAIL);
    }

    /**
     * Disable Proxy amd Upload Attack Description File" from Radware.com
     */
    @When("^UI Update Attack Description File$")
    public void updateAttackDescriptionFile() {
        BasicOperationsSteps basicOperationsSteps = null;
        try {
            basicOperationsSteps = new BasicOperationsSteps();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(),Reporter.FAIL);
            e.printStackTrace();
        }

        try {
            basicOperationsSteps.goToVision();
            disableProxy();
            //get previous update
            String lastUpdate = BasicParametersHandler.getBasicParameterByKey(getVisionRestClient(), BasicParametersKeys.getBasicParametersKeysEnum("attackDescLastUpdate"));
            //click update
            basicOperationsSteps.clickWebElementWithId("gwt-debug-attackDescLastUpdate_ActionButton", null);
            // choose from radware
            basicOperationsSteps.clickWebElementWithId("gwt-debug-MgtServer.UpdateAttackDescFromClient.UpdateFrom_MgtServer.UpdateAttackDescFromClient.UpdateFrom.Radware-input", null);
            basicOperationsSteps.clickWebElementWithId("gwt-debug-MgtServer.UpdateAttackDescFromClient.UpdateFromSite_Widget", null);
            Thread.sleep(5000);
            basicOperationsSteps.clickWebElementWithId("gwt-debug-Dialog_Box_Close", null);
            int timeoutMin = 7;
            LocalDateTime timeout = LocalDateTime.now().plusMinutes(timeoutMin);
            do {
                String upToDate = BasicParametersHandler.getBasicParameterByKey(getVisionRestClient(), BasicParametersKeys.getBasicParametersKeysEnum("attackDescLastUpdate"));
                if (!lastUpdate.equals(upToDate))
                    return;
                Thread.sleep(5000);
            } while (timeout.isAfter(LocalDateTime.now()));
            BaseTestUtils.report("Failed to Update Description File", Reporter.FAIL);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Disable server Proxy
     */
    private void disableProxy() throws TargetWebElementNotFoundException {
        try {
            WebUIVisionBasePage.navigateToPage("System->General Settings->Connectivity");
            BasicOperationsHandler.doOperation("select", "Proxy Server Parameters", null);
            BasicOperationsHandler.setCheckbox("Enable Proxy Server", null, false);
            BasicOperationsHandler.clickButton("Submit", null);
            WebUIVisionBasePage.navigateToPage("System->General Settings->Basic Parameters");
            BasicOperationsHandler.doOperation("select", "Attack Descriptions File", null);
        } catch (NoSuchOperationException e) {
            BaseTestUtils.report("Failed to Disable Proxy", Reporter.FAIL);
        }
    }
}
