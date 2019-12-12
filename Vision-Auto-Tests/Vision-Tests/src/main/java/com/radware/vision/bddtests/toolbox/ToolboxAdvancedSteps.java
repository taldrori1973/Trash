package com.radware.vision.bddtests.toolbox;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.enums.ToolboxGroupsEnum;
import com.radware.vision.infra.testhandlers.rbac.RBACHandler;
import com.radware.vision.infra.testhandlers.toolbox.ToolboxAdvancedHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.List;
import java.util.Map;

public class ToolboxAdvancedSteps {


    @Then("^UI Operator Toolbox, Visible : \"([^\"]*)\"$")
    public void uiOperatorToolboxVisible(String visibleOrNot) {
        String message;
        if (!RBACHandler.operatorToolboxAndSubChildsVisibility(Boolean.valueOf(visibleOrNot))) {
            if (visibleOrNot.equals("true")) {
                message = "Operator Toolbox or its sub child does not exist";
            } else {
                message = "Operator Toolbox or its sub child does exists";
            }
            ReportsUtils.reportAndTakeScreenShot(message, Reporter.FAIL);
        }
    }

    @Then("^UI AppShapes, Visible : \"([^\"]*)\"$")
    public void uiAppShapesVisible(String visibleOrNot) {
        String message;
        if (!RBACHandler.appShapeAndSubChildsVisibility(Boolean.valueOf(visibleOrNot))) {
            if (visibleOrNot.equals("true")) {
                message = "AppShapes or its sub child does not exist";
            } else {
                message = "AppShapes or its sub child does exists";
            }
            ReportsUtils.reportAndTakeScreenShot(message, Reporter.FAIL);
        }
    }


    @Then("^UI DefensePro Configuration Templates, Visible : \"([^\"]*)\"$")
    public void uiDefenseProConfigurationTemplatesVisible(String visibleOrNot) {
        String message;
        if (!RBACHandler.defenceProConfigurationTemplatesAndSubChildsVisibility(Boolean.valueOf(visibleOrNot))) {
            if (visibleOrNot.equals("true")) {
                message = "DefensePro Configuration Templates or its sub child does not exist";
            } else {
                message = "DefensePro Configuration Templates or its sub child does exists";
            }
            ReportsUtils.reportAndTakeScreenShot(message, Reporter.FAIL);
        }
    }

    /**
     * @param paramsAndValues a table with keys and values, in case there is multi fields with same name for exmaple in citrix appshape type
     *                        StoreFront->SLB Metric
     *                        Citrix StoreFront Servers->Address
     */

    @When("^UI Add AppShapes Service$")
    public void uiAddAppShapesService(List<Map<String, String>> paramsAndValues) {
        try {
            ToolboxAdvancedHandler.addAppShapes(paramsAndValues);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

    @Then("^UI Delete AppShapes, AppShape Type:\"([^\"]*)\" ,Device Name: \"([^\"]*)\"$")
    public void uiDeleteAppShapesAppShapeTypeDeviceName(String appShapeType, String deviceName) {

        ToolboxAdvancedHandler.deleteAppShape(appShapeType, deviceName);
    }

    @Then("^UI Verify AppShapes Existence \"([^\"]*)\", AppShape Type:\"([^\"]*)\" ,Device Name:\"([^\"]*)\"$")
    public void uiVerifyAppShapesExistenceAppShapeTypeDeviceName(String existOrNot, String appShapeType, String deviceName) {
        int rowNumber = ToolboxAdvancedHandler.AppShapeExist(appShapeType, deviceName);
        if (rowNumber == -1 && existOrNot.equals("true")) {
            ReportsUtils.reportAndTakeScreenShot("The expected app shape does not exist", Reporter.FAIL);
        } else if (rowNumber != -1 && existOrNot.equals("false")) {
            ReportsUtils.reportAndTakeScreenShot("The expected app shape does exist", Reporter.FAIL);
        }
    }
    @Then("^UI select Category From Advanced \"(.*)\"$")
    public void selectCategoryFromAdvanced(String groupName) {
        try {
            ToolboxAdvancedHandler.selectAdvancedOperatorToolbox(ToolboxGroupsEnum.getGroupByName(groupName));
        }catch (Exception e){
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
