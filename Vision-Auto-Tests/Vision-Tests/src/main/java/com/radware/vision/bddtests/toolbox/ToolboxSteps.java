package com.radware.vision.bddtests.toolbox;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.utils.SystemProperties;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.base.pages.navigation.WebUIUpperBar;
import com.radware.vision.infra.enums.*;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.testhandlers.toolbox.ToolboxHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class ToolboxSteps extends BddUITestBase {

    public ToolboxSteps() throws Exception {
    }

    @Then("^UI Validate that \"(.*)\" script not exist under \"(.*)\" group$")
    public void checkIfActionExistUnderGroup(String actionName, String actionParentGroupName) {
        try {
            ToolboxActionsEnum action = ToolboxActionsEnum.getActionByName(actionName);
            ToolboxGroupsEnum group = ToolboxGroupsEnum.getGroupByName(actionParentGroupName);

            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(action, group);
            if (isExist) {
                BaseTestUtils.report("\"" + actionName + "\" Script exists under " + "\"" + actionParentGroupName + "\" Group", Reporter.FAIL);
            } else {
                BaseTestUtils.report("\"" + actionName + "\" Script not exist under " + " \"" + actionParentGroupName + "\" Group", Reporter.PASS);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI Validate that \"(.*)\" script not exist under \"(.*)\" OTB advanced category")
    public void selectCategoryFromAdvanced(String scriptName, String groupName) {
        try {
            ToolboxGroupsEnum group = ToolboxGroupsEnum.getGroupByName(groupName);
            if (ToolboxHandler.isScriptExistUnderOTBAdvancedCategory(scriptName, group)) {
                BaseTestUtils.report("\"" + scriptName + "\" Script exists under " + "\"" + groupName + "\" category.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^UI Click on \"(.*)\" OTB script Run With Params from \"(.*)\" OTB category$")
    public void runScriptWithParams(String scriptName, String groupName) {
        try {
            ToolboxActionsEnum action = ToolboxActionsEnum.getActionByName(scriptName);
            ToolboxGroupsEnum group = ToolboxGroupsEnum.getGroupByName(groupName);
            ToolboxHandler.runWithParams(action, group);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^UI Click OTB script run submit$")
    public void scriptRunSubmit() {
        ClickOperationsHandler.clickWebElement(WebElementType.Id, "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Submit", 0);
    }

    @When("^UI Open OTB Dashboard")
    public void openDashboard() {
        WebUIUpperBar.select(UpperBarItems.ToolBox_Dashboard);
    }

    @When("^UI Open OTB Advanced")
    public void OpenAdvanced() {
        WebUIUpperBar.select(UpperBarItems.ToolBox_Advanced);
    }

    @When("^UI Click OTB script run cancel$")
    public void scriptRunClose() {
        ClickOperationsHandler.clickWebElement(WebElementType.Id, "gwt-debug-ConfigTab_NEW_AdminScriptsDeployment_Close", 0);
    }

    @When("^UI Wait for OTB running script output popup (\\d+) seconds( negative)?$")
    public void waitForOutputPopup(int timeout, String negative) {
        try {
            ToolboxHandler.waitForOutputPopupAndClose(timeout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * check if the toolbox dashboard or advanced are visible or not
     *
     * @param item
     * @param visibleOrNot
     */

    @Then("^UI Toolbox \"([^\"]*)\" Tab Visible \"([^\"]*)\"$")
    public void toolboxTabVisibility(String item, String visibleOrNot) {
        RBACHandlerBase.expectedResultRBAC = Boolean.valueOf(visibleOrNot);
        if (!RBACHandler.IsUpperBarItemExist(UpperBarItems.getEnumValue(item))) {
            if (RBACHandlerBase.expectedResultRBAC) {
                ReportsUtils.reportAndTakeScreenShot("Toolbox Tab -->" + item + " Does Not Exists", Reporter.FAIL);
            } else {

                ReportsUtils.reportAndTakeScreenShot("Toolbox -->" + item + " Does Exists", Reporter.FAIL);
            }
        }
    }

    @Then("^UI ToolboxTest - Run Action from Group by ActionName \"([^\"]*)\" by groupName \"([^\"]*)\"$")
    public void runActionFromGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum groupName) {
        try {
            ToolboxHandler.runActionFromGroup(actionName, groupName);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Check If Action Exist Under Group by actionName \"([^\"]*)\" by groupName \"([^\"]*)\"( negative)?$")
    public void checkIfActionExistUnderGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum groupName, String negativeStr) {
        try {
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName, groupName);
            if (isExist) {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action exist under " + "\"" + groupName.toString() + "\" Group", Reporter.PASS);
            } else {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action not exist under " + " \"" + groupName.toString() + "\" Group", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Delete All Action In Group by groupName \"([^\"]*)\"$")
    public void deleteAllActionInGroup(ToolboxGroupsEnum groupName) {
        try {
            ToolboxHandler.deleteAllActionInGroup(groupName);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Drag And Drop Group And Verify by groupName \"([^\"]*)\" by xOffset \"([^\"]*)\" by yOffset \"([^\"]*)\"$")
    public void dragAndDropGroupAndVerify(ToolboxGroupsEnum groupName, String xOffset, String yOffset) {
        try {
            ToolboxHandler.dragAndDropGroupAndVerify(groupName, Integer.parseInt(xOffset), Integer.parseInt(yOffset));
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Resize Group And Verify by groupName \"([^\"]*)\" by xOffset \"([^\"]*)\" by yOffset \"([^\"]*)\"$")
    public void resizeGroupAndVerify(ToolboxGroupsEnum groupName, String xOffset, String yOffset) {
        try {
            ToolboxHandler.resizeGroupAndVerify(groupName, Integer.parseInt(xOffset), Integer.parseInt(yOffset));
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Restore Dashboard Default View And Verify$")
    public void restoreDashboardDefaultViewAndVerify() {
        try {
            ToolboxHandler.restoreDashboardDefaultViewAndVerify();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Check that all groups are exist and displayed$")
    public void checkAllGroupsDisplayed() {
        try {
            ToolboxHandler.checkAllGroupsExistsAndDisplayed();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Check that all groups icons are exist and displayed$")
    public void checkAllGroupsIconsDisplayed() {
        try {
            ToolboxHandler.checkAllGroupsIconsExistsAndDisplayed();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Delete Action from Group by actionName \"([^\"]*)\" with actionParentGroupName \"([^\"]*)\"$")
    public void deleteActionFromGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName) {
        try {
            ToolboxHandler.deleteActionFromGroup(actionName, actionParentGroupName);
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName, actionParentGroupName);
            if (isExist) {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action exist under " + "\"" + actionParentGroupName.toString() + "\" Group", Reporter.FAIL);
            } else {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action not exist under " + " \"" + actionParentGroupName.toString() + "\" Group", Reporter.PASS);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Add Action To Group by actionName \"([^\"]*)\" with groupName \"([^\"]*)\"$")
    public void addActionToGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum groupName) {
        try {
            ToolboxHandler.addActionToGroup(actionName, groupName);
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName, groupName);
            if (isExist) {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action exist under " + "\"" + groupName.toString() + "\" Group", Reporter.PASS);
            } else {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action not exist under " + " \"" + groupName.toString() + "\" Group", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - dragAndDropActionToGroup by actionName \"([^\"]*)\" with groupName \"([^\"]*)\" with actionParentGroupName \"([^\"]*)\"$")
    public void dragAndDropActionToGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum groupName, ToolboxGroupsEnum actionParentGroupName) {
        try {
            ToolboxHandler.dragAndDropActionToGroup(actionName, groupName, actionParentGroupName);
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName, groupName);
            if (isExist) {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action exist under " + "\"" + groupName.toString() + "\" Group", Reporter.PASS);
            } else {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action not exist under " + " \"" + groupName.toString() + "\" Group", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Drag And Drop Action From Favorites To Group by actionName \"([^\"]*)\" with groupName \"([^\"]*)\"$")
    public void dragAndDropActionFromFavoritesToGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum groupName) {
        try {
            ToolboxHandler.dragAndDropActionToGroup(actionName, groupName, ToolboxGroupsEnum.FAVORITES);
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName, groupName);
            if (isExist) {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action was copied from Favorites to " + "\"" + groupName.toString() + "\" Group", Reporter.FAIL);
            } else {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action was not copied from Favorites to " + " \"" + groupName.toString() + "\" Group", Reporter.PASS);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Drag And Drop Action From Group To Recently Used by actionName \"([^\"]*)\" with actionParentGroupName \"([^\"]*)\"$")
    public void dragAndDropActionFromGroupToRecentlyUsed(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName) {
        try {
            ToolboxHandler.dragAndDropActionToGroup(actionName, ToolboxGroupsEnum.RECENTLY_USED, actionParentGroupName);
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName, ToolboxGroupsEnum.RECENTLY_USED);
            if (isExist) {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action was copied from group to " + "\"" + ToolboxGroupsEnum.RECENTLY_USED + "\" Group", Reporter.FAIL);
            } else {
                BaseTestUtils.report("\"" + actionName.getActionName() + "\" Action was not copied from group to " + " \"" + ToolboxGroupsEnum.RECENTLY_USED + "\" Group", Reporter.PASS);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Verify That Group Is Scrollable by groupName \"([^\"]*)\"( negative)?$")
    public void verifyThatGroupIsScrollable(ToolboxGroupsEnum groupName, String negativeStr) {
        try {
            if (ToolboxHandler.isScrollable(groupName)) {
                BaseTestUtils.report(groupName.toString() + " group is scrollable", Reporter.PASS);
            } else {
                BaseTestUtils.report(groupName.toString() + " group is not scrollable", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Show Or Hide Group by groupName \"([^\"]*)\" show \"(true|false)\"$")
    public void showOrHideGroup(ToolboxGroupsEnum groupName, boolean show) {
        try {
            ToolboxHandler.showOrHideGroup(groupName, show);
            boolean isExists = ToolboxHandler.checkIfGroupExists(groupName);
            if (show && !isExists) {
                BaseTestUtils.report(groupName.toString() + " group not shown", Reporter.FAIL);
            } else if (!show && isExists) {
                BaseTestUtils.report(groupName.toString() + " group shown", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Schedule Action from Group by actionName \"([^\"]*)\" with actionParentGroupName \"([^\"]*)\"$")
    public void scheduleActionFromGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName) {
        try {
            ToolboxHandler.scheduleActionFromGroup(actionName, actionParentGroupName);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Move Toolbox DualList Items to Side \"(LEFT|RIGHT)\" with dualListItems \"([^\"]*)\" with dualListItems \"([^\"]*)\"$")
    public void moveToolboxDualListItems(DualListSides dualListSide, String dualListItems, String dualListID) {
        try {
            ToolboxHandler.moveToolboxDualListItems(dualListSide, dualListItems, dualListID);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Run With Params by actionName \"([^\"]*)\" with actionParentGroupName \"([^\"]*)\"$")
    public void runWithParams(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName) {
        try {
            ToolboxHandler.runWithParams(actionName, actionParentGroupName);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Copy Script Output And Check Validity with timeOut (\\d+)$")
    public void copyScriptOutputAndCheckValidity(int timeout) {
        try {
            ToolboxHandler.copyScriptOutputAndCheckValidity(timeout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Select Category From Advanced by groupName \"([^\"]*)\"$")
    public void selectCategoryFromAdvanced(ToolboxGroupsEnum groupName) {
        try {
            ToolboxHandler.selectCategoryFromAdvanced(groupName);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Check If Group Exists \"([^\"]*)\"( negative)?$")
    public void checkIfGroupExists(ToolboxGroupsEnum groupName, String negativeStr) {
        try {
            boolean isExists = ToolboxHandler.checkIfGroupExists(groupName);
            if (!isExists) {
                BaseTestUtils.report(groupName.toString() + " group not shown in the OTB", Reporter.FAIL);
            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Copy And Save Script Output \"([^\"]*)\" with timeout (\\d+)$")
    public void copyAndSaveScriptOutput(String runPropertyName, int timeout) {
        try {
            ToolboxHandler.copyAndSaveScriptOutput(runPropertyName, timeout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI ToolboxTest - Show Previous Result And Compare by actionName \"([^\"]*)\" with groupName \"([^\"]*)\" with property \"([^\"]*)\"$")
    public void showPreviousResultAndCompare(ToolboxActionsEnum actionName, ToolboxGroupsEnum groupName, String property) {
        try {
            SystemProperties systemProperties = new SystemProperties();
            String result = systemProperties.getValueByKey(property);
            ToolboxHandler.showPreviousResultAndCompare(actionName, groupName, result);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

}
