package com.radware.vision.tests.toolbox;

import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.DualListSides;
import com.radware.vision.infra.enums.ToolboxActionsEnum;
import com.radware.vision.infra.enums.ToolboxGroupsEnum;
import com.radware.vision.infra.enums.WebWidgetType;
import com.radware.vision.infra.testhandlers.toolbox.ToolboxHandler;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import com.radware.automation.tools.basetest.Reporter;
import org.junit.Test;

/**
 * Created by ashrafa on 7/27/2017.
 */
public class ToolboxTests extends WebUITestBase {

    ToolboxActionsEnum actionName;
    ToolboxGroupsEnum actionParentGroupName;
    ToolboxGroupsEnum groupName;
    DualListSides dualListSide = DualListSides.SELECT_SIDE_TO_SELECT_FROM;
    String dualListItems;
    String dualListID;
    int timeout = 0;
    String elementId = "";
    String value = "";
    boolean selectCheckbox = false;
    boolean show = false;
    WebWidgetType widgetType;
    int xOffset = 0;
    int yOffset = 0;
    String runPropertyName = "";
    String runResult = "";

    @Test
    @TestProperties(name = "ToolboxTest - Resize Group And Verify", paramsInclude = {"groupName","xOffset","yOffset","targetTestId"})
    public void resizeGroupAndVerify() {
        try {
            ToolboxHandler.resizeGroupAndVerify(groupName,xOffset,yOffset);
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Drag And Drop Group And Verify", paramsInclude = {"groupName","xOffset","yOffset","targetTestId"})
    public void dragAndDropGroupAndVerify() {
        try {
            ToolboxHandler.dragAndDropGroupAndVerify(groupName,xOffset,yOffset);
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Restore Dashboard Default View And Verify", paramsInclude = {"targetTestId"})
    public void restoreDashboardDefaultViewAndVerify() {
        try {
            ToolboxHandler.restoreDashboardDefaultViewAndVerify();
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }
    /**
     * this test drag an Action and drag it into a Group.
     * parameters:-
     * actionName: select the action name you want to drag - the source for drag and drop.
     * actionParentGroupName: select the group name that contain the source action.
     * groupName: select the group name you want to drop the action into - the target for drag and drop.
     */
    @Test
    @TestProperties(name = "ToolboxTest - dragAndDropActionToGroup", paramsInclude = {"actionName","groupName","actionParentGroupName","targetTestId"})
    public void dragAndDropActionToGroup() {
        try {
            ToolboxHandler.dragAndDropActionToGroup(actionName,groupName,actionParentGroupName);
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName,groupName);
            if(isExist){
                report.report("\"" + actionName.getActionName() + "\" Action exist under " + "\"" + groupName.toString() + "\" Group",Reporter.PASS);
            }
            else {
                report.report("\"" + actionName.getActionName() + "\" Action not exist under " + " \"" + groupName.toString() + "\" Group",Reporter.FAIL);
            }
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Drag And Drop Action From Favorites To Group", paramsInclude = {"actionName","groupName","targetTestId"})
    public void dragAndDropActionFromFavoritesToGroup() {
        try {
            ToolboxHandler.dragAndDropActionToGroup(actionName,groupName,ToolboxGroupsEnum.FAVORITES);
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName,groupName);
            if(isExist){
                report.report("\"" + actionName.getActionName() + "\" Action was copied from Favorites to " + "\"" + groupName.toString() + "\" Group",Reporter.FAIL);
            }
            else {
                report.report("\"" + actionName.getActionName() + "\" Action was not copied from Favorites to " + " \"" + groupName.toString() + "\" Group",Reporter.PASS);
            }
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Drag And Drop Action From Group To Recently Used", paramsInclude = {"actionName","actionParentGroupName","targetTestId"})
    public void dragAndDropActionFromGroupToRecentlyUsed() {
        try {
            ToolboxHandler.dragAndDropActionToGroup(actionName,ToolboxGroupsEnum.RECENTLY_USED,actionParentGroupName);
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName,ToolboxGroupsEnum.RECENTLY_USED);
            if(isExist){
                report.report("\"" + actionName.getActionName() + "\" Action was copied from group to " + "\"" + ToolboxGroupsEnum.RECENTLY_USED + "\" Group",Reporter.FAIL);
            }
            else {
                report.report("\"" + actionName.getActionName() + "\" Action was not copied from group to " + " \"" + ToolboxGroupsEnum.RECENTLY_USED + "\" Group",Reporter.PASS);
            }
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Add Action To Group", paramsInclude = {"actionName","groupName","targetTestId"})
    public void addActionToGroup() {
        try {
            ToolboxHandler.addActionToGroup(actionName,groupName);
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName,groupName);
            if(isExist){
                report.report("\"" + actionName.getActionName() + "\" Action exist under " + "\"" + groupName.toString() + "\" Group",Reporter.PASS);
            }
            else {
                report.report("\"" + actionName.getActionName() + "\" Action not exist under " + " \"" + groupName.toString() + "\" Group",Reporter.FAIL);
            }
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Delete Action from Group", paramsInclude = {"actionName","actionParentGroupName","targetTestId"})
    public void deleteActionFromGroup() {
        try {
            ToolboxHandler.deleteActionFromGroup(actionName, actionParentGroupName);
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName,actionParentGroupName);
            if(isExist){
                report.report("\"" + actionName.getActionName() + "\" Action exist under " + "\"" + actionParentGroupName.toString() + "\" Group",Reporter.FAIL);
            }
            else {
                report.report("\"" + actionName.getActionName() + "\" Action not exist under " + " \"" + actionParentGroupName.toString() + "\" Group",Reporter.PASS);
            }
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - schedule Action from Group", paramsInclude = {"actionName","actionParentGroupName","targetTestId"})
    public void scheduleActionFromGroup() {
        try {
            ToolboxHandler.scheduleActionFromGroup(actionName, actionParentGroupName);

        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Move Toolbox DualList Items", paramsInclude = {"dualListSide","dualListItems","dualListID","targetTestId"})
    public void moveToolboxDualListItems(){
        try {
            ToolboxHandler.moveToolboxDualListItems(dualListSide,dualListItems,dualListID);

        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "ToolboxTest - Run Action from Group", paramsInclude = {"actionName","actionParentGroupName","targetTestId"})
    public void runActionFromGroup() {
        try {
            ToolboxHandler.runActionFromGroup(actionName, actionParentGroupName);
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Run With Params", paramsInclude = {"actionName","actionParentGroupName","targetTestId"})
    public void runWithParams() {
        try {
            ToolboxHandler.runWithParams(actionName, actionParentGroupName);
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Check that all groups are exist and displayed", paramsInclude = {"targetTestId"})
    public void checkAllGroupsDisplayed() {
        try {
            ToolboxHandler.checkAllGroupsExistsAndDisplayed();
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Check that all groups icons are exist and displayed", paramsInclude = {"targetTestId"})
    public void checkAllGroupsIconsDisplayed() {
        try {
            ToolboxHandler.checkAllGroupsIconsExistsAndDisplayed();
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "ToolboxTest - Delete All Action In Group", paramsInclude = {"groupName","targetTestId"})
    public void deleteAllActionInGroup() {
        try {
            ToolboxHandler.deleteAllActionInGroup(groupName);
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * compare the copied output after running the script
     * with the output we get by click on "shoe previous result button"
     */
    @Test
    @TestProperties(name = "ToolboxTest - Show Previous Result And Compare", paramsInclude = {"actionName","groupName","runResult","targetTestId"})
    public void showPreviousResultAndCompare() {
        try {
            ToolboxHandler.showPreviousResultAndCompare(actionName,groupName,runResult);
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Check If Action Exist Under Group", paramsInclude = {"actionName","actionParentGroupName","targetTestId"})
    public void checkIfActionExistUnderGroup() {
        try {
            boolean isExist = ToolboxHandler.checkIfActionExistsUnderGroup(actionName,actionParentGroupName);
            if(isExist){
                report.report("\"" + actionName.getActionName() + "\" Action exist under " + "\"" + actionParentGroupName.toString() + "\" Group",Reporter.PASS);
            }
            else {
                report.report("\"" + actionName.getActionName() + "\" Action not exist under " + " \"" + actionParentGroupName.toString() + "\" Group",Reporter.FAIL);
            }
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Verify That Group Is Scrollable", paramsInclude = {"groupName","targetTestId"})
    public void verifyThatGroupIsScrollable() {
        try {
            if(ToolboxHandler.isScrollable(groupName)){
                report.report(groupName.toString() + " group is scrollable",Reporter.PASS);
            }
            else{
                report.report(groupName.toString() + " group is not scrollable",Reporter.FAIL);
            }
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Wait For Output Popup", paramsInclude = {"timeout","targetTestId"})
    public void waitForOutputPopup() {
        try {
            ToolboxHandler.waitForOutputPopupAndClose(timeout);
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Copy Script Output And Check Validity", paramsInclude = {"timeout","targetTestId"})
    public void copyScriptOutputAndCheckValidity() {
        try {
            ToolboxHandler.copyScriptOutputAndCheckValidity(timeout);
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Copy And Save Script Output", paramsInclude = {"runPropertyName","timeout","targetTestId"})
    public void copyAndSaveScriptOutput() {
        try {
            ToolboxHandler.copyAndSaveScriptOutput(runPropertyName,timeout);
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Set Script Parameter", paramsInclude = {"elementId","value","selectCheckbox","widgetType","targetTestId"})
    public void setScriptParameter() {
        try {
            ToolboxHandler.setScriptParameter(elementId,value,selectCheckbox,widgetType);
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Show Or Hide Group", paramsInclude = {"groupName","show","targetTestId"})
    public void showOrHideGroup() {
        try {
            ToolboxHandler.showOrHideGroup(groupName,show);
            boolean isExists = ToolboxHandler.checkIfGroupExists(groupName);
            if(show && !isExists){
                report.report(groupName.toString() + " group not shown", Reporter.FAIL);
            }
            else if(!show && isExists){
                report.report(groupName.toString() + " group shown", Reporter.FAIL);
            }
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Check If Group Exists", paramsInclude = {"groupName","targetTestId"})
    public void checkIfGroupExists() {
        try {
            boolean isExists = ToolboxHandler.checkIfGroupExists(groupName);
            if(!isExists){
                report.report(groupName.toString() + " group not shown in the OTB", Reporter.FAIL);
            }

        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ToolboxTest - Select Category From Advanced", paramsInclude = {"groupName","targetTestId"})
    public void selectCategoryFromAdvanced() {
        try {
            ToolboxHandler.selectCategoryFromAdvanced(groupName);
        }catch (Exception e){
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public ToolboxActionsEnum getActionName(){return this.actionName;}
    @ParameterProperties(description = "Please, select the Action to work with.")
    public void setActionName(ToolboxActionsEnum actionName){this.actionName = actionName;}

    public ToolboxGroupsEnum getGroupName(){return this.groupName;}
    @ParameterProperties(description = "Please, select the Group to work with.")
    public  void setGroupName(ToolboxGroupsEnum groupName){this.groupName = groupName;}

    public ToolboxGroupsEnum getActionParentGroupName() {return actionParentGroupName;}
    @ParameterProperties(description = "Please, select the parent Group of the Action you want work with.")
    public void setActionParentGroupName(ToolboxGroupsEnum actionParentGroupName) {this.actionParentGroupName = actionParentGroupName;}

    public DualListSides getDualListSide() {
        return dualListSide;
    }
    @ParameterProperties(description = "Please select a side to move FROM!")
    public void setDualListSide(DualListSides dualListSide) {
        this.dualListSide = dualListSide;
    }

    public String getDualListItems() {
        return dualListItems;
    }
    @ParameterProperties(description = "Please provide Item Names to move. Names must be separated by <,>!")
    public void setDualListItems(String dualListItems) {
        this.dualListItems = dualListItems;
    }

    public String getDualListID(){return this.dualListID;}
    public void setDualListID(String dualListID){this.dualListID = dualListID;}

    public int getTimeout(){return this.timeout;}
    @ParameterProperties(description = "Please enter the time to wait (in Sec).")
    public void setTimeout(int timeout){this.timeout = timeout*1000;}

    public String getElementId() {
        return elementId;
    }
    @ParameterProperties(description = "Please, provide the ID of the WebElement you want to use!")
    public void setElementId(String elementId) {
        this.elementId = elementId;
    }

    public String getValue() {
        return this.value;
    }
    @ParameterProperties(description = "Please, provide the value you want to set!")
    public void setValue(String value) {
        this.value = value;
    }

    public boolean getSelectCheckbox() {
        return selectCheckbox;
    }
    @ParameterProperties(description = "Please, provide the value for the checkbox!")
    public void setSelectCheckbox(boolean selectCheckbox) {
        this.selectCheckbox = selectCheckbox;
    }

    public WebWidgetType getWidgetType(){return this.widgetType;}
    @ParameterProperties(description = "Please, provide the widget type")
    public void setWidgetType(WebWidgetType widgetType){this.widgetType = widgetType;}

    public boolean getShow(){return this.show;}
    @ParameterProperties(description = "Please, select true to show Group or false to hide")
    public void setShow(boolean show){this.show = show;}

    public int getXOffset(){return this.xOffset;}
    public void setXOffset(int xOffset){this.xOffset = xOffset;}

    public int getYOffset(){return this.yOffset;}
    public void setYOffset(int yOffset){this.yOffset = yOffset;}

    public String getRunPropertyName(){return this.runPropertyName;}
    @ParameterProperties(description = "Please, set a name for the run property you want to save the output in it")
    public void setRunPropertyName(String runPropertyName){this.runPropertyName = runPropertyName;}

    public String getRunResult(){return this.runResult;}
    public void setRunResult(String runResult){this.runResult = runResult;}

}
