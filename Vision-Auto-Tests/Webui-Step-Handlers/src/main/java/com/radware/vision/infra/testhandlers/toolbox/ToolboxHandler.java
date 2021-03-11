package com.radware.vision.infra.testhandlers.toolbox;


import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.draganddrop.WebUIDragAndDrop;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.*;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.automation.AutoUtils.utils.SystemProperties;
import com.radware.vision.infra.base.pages.navigation.HomePage;
import com.radware.vision.infra.base.pages.toolbox.advanced.OperatorToolbox;
import com.radware.vision.infra.enums.DualListSides;
import com.radware.vision.infra.enums.ToolboxActionsEnum;
import com.radware.vision.infra.enums.ToolboxGroupsEnum;
import com.radware.vision.infra.enums.WebWidgetType;
import org.openqa.selenium.By;
import org.openqa.selenium.Point;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.How;

import java.awt.*;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.DataFlavor;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by ashrafa on 7/26/2017.
 */
public class ToolboxHandler {

    private static final int DEFAULT_GROUP_WIDTH = 371;
    private static final int DEFAULT_GROUP_HEIGHT = 383;
    private static final int SPACE_BETWEEN_GROUPS = 35;

    public static void dragAndDropActionToGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum groupName, ToolboxGroupsEnum actionParentGroupName) throws Exception {
        navigateToToolbox();

        String actionXpath = ToolboxHandler.generateDragActionItemXpath(actionName, actionParentGroupName);
        String groupXpath = ToolboxHandler.generateDropGroupItemXpath(groupName);

        ComponentLocator actionLocator = new ComponentLocator(How.XPATH, actionXpath);
        ComponentLocator groupLocator = new ComponentLocator(How.XPATH, groupXpath);

        WebUIDragAndDrop.dragAndDrop(actionLocator, groupLocator);
    }

    public static void addActionToGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum groupName) throws Exception {
        navigateToToolbox();
        showGroupMenu(groupName);

        //click the group add script button
        String addScriptXpath = generateGroupItemAddScriptXpath(groupName);
        ComponentLocator addScriptLocator = new ComponentLocator(How.XPATH, addScriptXpath);
        WebUIButton addButton = new WebUIButton(new WebUIComponent(addScriptLocator));
        addButton.click();

        //type script name in suggest box
        String txtInputXpath = generateAddScriptTextFieldXpath();
        ComponentLocator txtInputLocator = new ComponentLocator(How.XPATH, txtInputXpath);
        WebUITextField txtField = new WebUITextField(txtInputLocator);
        txtField.type(actionName.getActionName(), true);

        //select the script
        String actionRowNameXpath = generateScriptRowNameXpath();
        ComponentLocator actionRowLocator = new ComponentLocator(How.XPATH, actionRowNameXpath);
        WebUIButton actionRow = new WebUIButton(new WebUIComponent(actionRowLocator));
        actionRow.click();

        //click select button
        String SelectButtonXpath = generateAddScriptSelectButtonXpath();
        ComponentLocator selectButtonLocator = new ComponentLocator(How.XPATH, SelectButtonXpath);
        WebUIButton selectButton = new WebUIButton(new WebUIComponent(selectButtonLocator));
        selectButton.click();
    }

    public static void deleteActionFromGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName) throws Exception {
//        navigateToToolbox();
        if (!checkIfActionExistsUnderGroup(actionName, actionParentGroupName)) {
            throw new Exception("\"" + actionName.getActionName() + "\" Action does not exist under " + "\"" + actionParentGroupName.toString() + "\" Group");
        }

        //hover on the action
        showActionPanel(actionName, actionParentGroupName);

        String deleteButtonXpath = ToolboxHandler.generateActionItemDeleteXpath(actionName, actionParentGroupName);
        ComponentLocator deleteButtonLocator = new ComponentLocator(How.XPATH, deleteButtonXpath);
        WebUIButton deleteButton = new WebUIButton(new WebUIComponent(deleteButtonLocator));
        deleteButton.click();

        //press Yes
        String xpathLocator = "//button[contains(@id,'Dialog_Box_Yes')]";
        ComponentLocator buttonLocation = new ComponentLocator(How.XPATH, xpathLocator);
        WebElement button = WebUIUtils.fluentWaitDisplayed(buttonLocation.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        if (button != null) {
            button.click();
        }
    }

    public static void runActionFromGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName) throws Exception {
//        navigateToToolbox();
        if (!checkIfActionExistsUnderGroup(actionName, actionParentGroupName)) {
            throw new Exception("\"" + actionName.getActionName() + "\" Action does not exist under " + "\"" + actionParentGroupName.toString() + "\" Group");
        }

        //hover on the action
        showActionPanel(actionName, actionParentGroupName);

        String runButtonXpath = ToolboxHandler.generateActionItemRunXpath(actionName, actionParentGroupName);
        ComponentLocator runButtonLocator = new ComponentLocator(How.XPATH, runButtonXpath);
        WebUIButton runButton = new WebUIButton(new WebUIComponent(runButtonLocator));
        runButton.click();

        closeTap();

        hideActionPanel(actionName, actionParentGroupName);
    }

    public static void runWithParams(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName) throws Exception {
//        navigateToToolbox();
        if (!checkIfActionExistsUnderGroup(actionName, actionParentGroupName)) {
            throw new Exception("\"" + actionName.getActionName() + "\" Action does not exist under " + "\"" + actionParentGroupName.toString() + "\" Group");
        }
        //hover on the action
        showActionPanel(actionName, actionParentGroupName);

        String runButtonXpath = ToolboxHandler.generateActionItemRunWithParamsXpath(actionName, actionParentGroupName);
        WebUIUtils.sleep(1);
        WebUIUtils.waitUntilElementGetAppear(WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, runButtonXpath).getBy()),3);
        ComponentLocator runButtonLocator = new ComponentLocator(How.XPATH, runButtonXpath);
        WebUIButton runButton = new WebUIButton(new WebUIComponent(runButtonLocator));
        runButton.click();
    }

    /*compare the copied output after running the script
    with the output we get by click on "shoe previous result button"*/
    public static void showPreviousResultAndCompare(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName, String result) throws Exception {
//        navigateToToolbox();
        if (!checkIfActionExistsUnderGroup(actionName, actionParentGroupName)) {
            throw new Exception("\"" + actionName.getActionName() + "\" Action does not exist under " + "\"" + actionParentGroupName.toString() + "\" Group");
        }
        //hover on the action
        showActionPanel(actionName, actionParentGroupName);

        String showButtonXpath = ToolboxHandler.generateActionItemResultXpath(actionName, actionParentGroupName);
        ComponentLocator showButtonLocator = new ComponentLocator(How.XPATH, showButtonXpath);
        WebUIButton showButton = new WebUIButton(new WebUIComponent(showButtonLocator));
        showButton.click();

        //copy to clipboard
        String copyBtnXpath = generateCopyToClipboardBtnXpath();
        ComponentLocator copyBtnLocator = new ComponentLocator(How.XPATH, copyBtnXpath);
//        WebUIButton copyBtn = new WebUIButton(new WebUIComponent(copyBtnLocator));
//        copyBtn.click();
        Actions ac = new Actions(WebUIUtils.getDriver());
        WebElement we = WebUIUtils.fluentWaitDisplayed(copyBtnLocator.getBy(), 10, false);
        ac.moveToElement(we, 5, 5).click().perform();

        Toolkit toolkit = Toolkit.getDefaultToolkit();
        Clipboard clipboard = toolkit.getSystemClipboard();
        String runResult = (String) clipboard.getData(DataFlavor.stringFlavor);

        //close output popup
        String closeBtnXpath = generateOutputPopupCloseBtnXpath();
        ComponentLocator closeBtnLocator = new ComponentLocator(How.XPATH, closeBtnXpath);
        WebUIButton closeBtn = new WebUIButton(new WebUIComponent(closeBtnLocator));
        closeBtn.click();

        if (!runResult.equals(result)) {
            throw new Exception("the copied output after running the script not equal to the output we get by click on \"shoe previous result\" button");
        }
    }

    public static void scheduleActionFromGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName) throws Exception {
//        navigateToToolbox();
        if (!checkIfActionExistsUnderGroup(actionName, actionParentGroupName)) {
            throw new Exception("\"" + actionName.getActionName() + "\" Action does not exist under " + "\"" + actionParentGroupName.toString() + "\" Group");
        }

        //hover on the action
        showActionPanel(actionName, actionParentGroupName);

        String scheduleButtonXpath = ToolboxHandler.generateActionItemScheduleXpath(actionName, actionParentGroupName);
        ComponentLocator scheduleButtonLocator = new ComponentLocator(How.XPATH, scheduleButtonXpath);
        WebUIButton scheduleButton = new WebUIButton(new WebUIComponent(scheduleButtonLocator));
        scheduleButton.click();
    }

    public static void moveToolboxDualListItems(DualListSides dualListSide, String dualListItems, String dualListID) throws Exception {
        ComponentLocator dualListLocator = new ComponentLocator(How.ID, dualListID);
        WebUIDualList dualList = new WebUIDualList(new WebUIComponent(dualListLocator));
        if (dualList.getWebElement() == null) {
            throw new Exception("Dual list not found");
        }
        List<String> itemsToMoveList = new ArrayList<String>();
        if (dualListItems != null) {
            itemsToMoveList = Arrays.asList(dualListItems.split(","));
        }
        if (dualListSide.equals(DualListSides.LEFT)) {
            for (String item : itemsToMoveList) {
                dualList.setRawId(dualListID.replace("gwt-debug-", ""));
                dualList.moveRight(item);
            }
        } else if (dualListSide.equals(DualListSides.RIGHT)) {
            for (String item : itemsToMoveList) {
                dualList.setRawId(dualListID.replace("gwt-debug-", ""));
                dualList.moveLeft(item);
            }
        }
    }

    public static void checkAllGroupsExistsAndDisplayed() throws Exception {
        navigateToToolbox();

        boolean isExists;
        for (ToolboxGroupsEnum groupName : ToolboxGroupsEnum.values()) {
            if (!groupName.equals(ToolboxGroupsEnum.UNASSIGNED)) {
                isExists = checkIfGroupExists(groupName);
                if (!isExists) {
                    throw new Exception(groupName + " was not found");
                }
            }
        }
    }

    public static void checkAllGroupsIconsExistsAndDisplayed() throws Exception {
        navigateToToolbox();

        String groupIconXpath;
        ComponentLocator groupIconLocator;
        WebElement groupIcon = null;
        for (ToolboxGroupsEnum groupName : ToolboxGroupsEnum.values()) {
            if (!groupName.equals(ToolboxGroupsEnum.UNASSIGNED)) {
                groupIconXpath = generateGroupItemIconXpath(groupName);
                groupIconLocator = new ComponentLocator(How.XPATH, groupIconXpath);
                groupIcon = WebUIUtils.fluentWaitDisplayed(groupIconLocator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                if (groupIcon == null) {
                    throw new Exception(groupName + " icon was not found");
                }
            }
        }
    }

    public static void deleteAllActionInGroup(ToolboxGroupsEnum groupName) throws Exception {
        navigateToToolbox();

        List<WebElement> actions = getGroupActions(groupName);
        List<String> actionsId = new ArrayList<>();
        for (WebElement action : actions) {
            actionsId.add(action.getAttribute("data-debug-id").replace(getActionItemContainerPrefix(), ""));
        }
        for (int i = 0; i < actionsId.size(); i++) {
            for (ToolboxActionsEnum actionName : ToolboxActionsEnum.values()) {
                if (actionsId.get(i).contains(actionName.getActionID())) {
                    deleteActionFromGroup(actionName, groupName);
                    break;
                }
            }
        }
    }

    public static boolean checkIfActionExistsUnderGroup(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName) throws Exception {
        navigateToToolbox();

        String actionXpath = ToolboxHandler.generateActionItemXpath(actionName, actionParentGroupName);
        ComponentLocator actionLocator = new ComponentLocator(How.XPATH, actionXpath);
        Thread.sleep(300);
        WebElement action = WebUIUtils.fluentWaitDisplayed(actionLocator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (action == null) {
            return false;
        } else {
            return true;
        }
    }

    public static boolean checkIfGroupExists(ToolboxGroupsEnum groupName) throws Exception {

        String groupXpath = ToolboxHandler.generateDropGroupItemXpath(groupName);
        ComponentLocator groupLocator = new ComponentLocator(How.XPATH, groupXpath);
        Thread.sleep(300);
        WebElement group = WebUIUtils.fluentWaitDisplayed(groupLocator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (group == null) {
            return false;
        } else {
            return true;
        }
    }

    public static boolean isScrollable(ToolboxGroupsEnum groupName) {
        navigateToToolbox();

        String xpath = generateDropGroupItemXpath(groupName);
        ComponentLocator locator = new ComponentLocator(How.XPATH, xpath);
        Long scrollHeight = (Long) WebUIUtils.fluentWaitJSExecutor("return $(arguments[0]).get(0).scrollHeight;", false, WebUIUtils.DEFAULT_WAIT_TIME, false, locator);
        Long offsetHeight = (Long) WebUIUtils.fluentWaitJSExecutor("return $(arguments[0]).get(0).offsetHeight;", false, WebUIUtils.DEFAULT_WAIT_TIME, false, locator);

        if (scrollHeight.longValue() != offsetHeight.longValue()) {
            return true;
        }
        return false;
    }

    public static void restoreDashboardDefaultViewAndVerify() throws Exception {
        navigateToToolbox();

        //Click on Restore Default View.
        String restoreBtnXpath = generateRestoreButtonXpath();
        ComponentLocator restoreBtnLocator = new ComponentLocator(How.XPATH, restoreBtnXpath);
        WebUIButton restoreBtn = new WebUIButton(new WebUIComponent(restoreBtnLocator));
        restoreBtn.click();

        checkAllGroupsExistsAndDisplayed();

        //Check groups order.
        String groupXpath;
        ComponentLocator groupLocator;
        Point groupPoint = null;
        int tempX = 0;
        int tempY = 0;
        for (ToolboxGroupsEnum groupName : ToolboxGroupsEnum.values()) {
            if (!groupName.equals(ToolboxGroupsEnum.UNASSIGNED)) {
                groupXpath = generateGroupItemXpath(groupName);
                groupLocator = new ComponentLocator(How.XPATH, groupXpath);
                groupPoint = getElementLocation(groupLocator);
                if (groupPoint.getY() < tempY) {
                    throw new Exception("The groups are not in the right order.");
                }
                if (groupPoint.getY() == tempY) {
                    if (groupPoint.getX() < tempX) {
                        throw new Exception("The groups are not in the right order.");
                    }
                }
                tempX = groupPoint.getX();
                tempY = groupPoint.getY();
            }
        }

    }

    public static void resizeGroupAndVerify(ToolboxGroupsEnum groupName, int xOffset, int yOffset) throws Exception {
        int beforeWidth = 0;
        int beforeHeight = 0;
        int afterWidth = 0;
        int afterHeight = 0;
        int containerEndX = 0;

        navigateToToolbox();
        String groupXpath = generateGroupItemXpath(groupName);
        String containerXpath = generateToolboxContainerWrapperXpath();
        ComponentLocator groupLocator = new ComponentLocator(How.XPATH, groupXpath);
        ComponentLocator containerLocator = new ComponentLocator(How.XPATH, containerXpath);
        beforeWidth = getElementWidth(groupLocator);
        beforeHeight = getElementHeight(groupLocator);
        containerEndX = getElementLocation(containerLocator).getX() + getElementWidth(containerLocator);

        if (xOffset < 0) {
            if (beforeWidth <= DEFAULT_GROUP_WIDTH) {
                throw new Exception("width can not be smaller than: " + DEFAULT_GROUP_WIDTH + "px");
            }
        } else if (xOffset > 0) {
            int newX = getElementLocation(groupLocator).getX() + beforeWidth + xOffset;
            if (newX > containerEndX - SPACE_BETWEEN_GROUPS) {
                throw new Exception("width can not be resize because the group width has reached the right edge of the browser");
            }
        }

        if (yOffset < 0) {
            if (beforeHeight <= DEFAULT_GROUP_HEIGHT) {
                throw new Exception("height can not be smaller than: " + DEFAULT_GROUP_HEIGHT + "px");
            }
        }

        showGroupResizeWidget(groupName);

        String resizeWidgetXpath = generateResizeWidgetXpath(groupName);
        ComponentLocator resizeWidgetLocator = new ComponentLocator(How.XPATH, resizeWidgetXpath);
        WebUIDragAndDrop.dragAndDrop(resizeWidgetLocator, xOffset, yOffset);
        Thread.sleep(500);

        afterWidth = getElementWidth(groupLocator);
        afterHeight = getElementHeight(groupLocator);

        if (xOffset > 0) {
            if ((afterWidth - beforeWidth) <= 0) {
                throw new Exception("Width did not changed");
            }
        } else if (xOffset < 0) {
            if ((afterWidth - beforeWidth) >= 0) {
                throw new Exception("Width did not changed");
            }
        }
        if (yOffset > 0) {
            if ((afterHeight - beforeHeight) <= 0) {
                throw new Exception("Height did not changed");
            }
        } else if (yOffset < 0) {
            if ((afterHeight - beforeHeight) >= 0) {
                throw new Exception("Height did not changed");
            }
        }
    }

    public static void dragAndDropGroupAndVerify(ToolboxGroupsEnum groupName, int xOffset, int yOffset) throws Exception {
        int groupWidth = 0;
        int beforeX = 0;
        int beforeY = 0;
        int afterX = 0;
        int afterY = 0;
        int containerStartX = 0;
        int containerEndX = 0;
        int containerStartY = 0;

        navigateToToolbox();

        String groupXpath = generateGroupItemXpath(groupName);
        ComponentLocator groupLocator = new ComponentLocator(How.XPATH, groupXpath);
        String containerXpath = generateToolboxContainerWrapperXpath();
        ComponentLocator containerLocator = new ComponentLocator(How.XPATH, containerXpath);
        groupWidth = getElementWidth(groupLocator);
        beforeX = getElementLocation(groupLocator).getX();
        beforeY = getElementLocation(groupLocator).getY();
        Point containerXY = getElementLocation(containerLocator);
        containerStartX = containerXY.getX();
        containerEndX = containerXY.getX() + getElementWidth(containerLocator);
        containerStartY = containerXY.getY();

        if (xOffset < 0) {
            int newX = beforeX + xOffset;
            if (newX < containerStartX + SPACE_BETWEEN_GROUPS) {
                throw new Exception("invalid movement to left, group can not go out from the OTB!");
            }
        } else if (xOffset > 0) {
            int newX = beforeX + xOffset;
            if (newX > containerEndX - groupWidth - SPACE_BETWEEN_GROUPS) {
                throw new Exception("invalid movement to right, group can not go out from the OTB!");
            }
        }

        if (yOffset < 0) {
            int newY = beforeY + yOffset;
            if (newY < containerStartY + SPACE_BETWEEN_GROUPS) {
                throw new Exception("invalid movement to top, group can not go out from the OTB!");
            }
        }

        String groupTitleXpath = generateGroupTitleXpath(groupName);
        ComponentLocator groupTitleLocator = new ComponentLocator(How.XPATH, groupTitleXpath);
        WebUIDragAndDrop.dragAndDrop(groupTitleLocator, xOffset, yOffset);
        Thread.sleep(500);

        afterX = getElementLocation(groupLocator).getX();
        afterY = getElementLocation(groupLocator).getY();

        if (xOffset > 0) {
            if ((afterX - beforeX) <= 0) {
                throw new Exception("Move right did not succeed");
            }
        } else if (xOffset < 0) {
            if ((afterX - beforeX) >= 0) {
                throw new Exception("Move left did not succeed");
            }
        }

        if (yOffset > 0) {
            if ((afterY - beforeY) <= 0) {
                throw new Exception("Move down did not succeed");
            }
        } else if (yOffset < 0) {
            if ((afterY - beforeY) >= 0) {
                throw new Exception("Move up did not succeed");
            }
        }
    }

    public static void showOrHideGroup(ToolboxGroupsEnum groupName, boolean show) {
        navigateToToolbox();

        //Click Toolbox toolbar categories repository
        String categoriesRepositoryXpath = generateCategoriesRepositoryXpath();
        ComponentLocator categoriesRepositoryLocator = new ComponentLocator(How.XPATH, categoriesRepositoryXpath);
        new WebUIButton(new WebUIComponent(categoriesRepositoryLocator)).click();

        //select or unSelect
        String repositoryItemXpath = generateCategoriesRepositoryItemXpath(groupName);
        ComponentLocator repositoryItemLocator = new ComponentLocator(How.XPATH, repositoryItemXpath);

        if (show) {
            if (!isSelected(repositoryItemLocator)) {
                new WebUIButton(new WebUIComponent(repositoryItemLocator)).click();
            }
        } else {
            if (isSelected(repositoryItemLocator)) {
                new WebUIButton(new WebUIComponent(repositoryItemLocator)).click();
            }
        }

        //click apply
        String applyXpath = generateCategoriesRepositoryApplyXpath();
        ComponentLocator applyLocator = new ComponentLocator(How.XPATH, applyXpath);
        new WebUIButton(new WebUIComponent(applyLocator)).click();

    }

    public static void copyScriptOutputAndCheckValidity(int timeout) throws Exception {
        String exception = null;
        waitForOutputPopup(timeout);

        //copy to clipboard
        String copyBtnXpath = generateCopyToClipboardBtnXpath();
        ComponentLocator copyBtnLocator = new ComponentLocator(How.XPATH, copyBtnXpath);
//        WebUIButton copyBtn = new WebUIButton(new WebUIComponent(copyBtnLocator));
//        copyBtn.click();
        Actions ac = new Actions(WebUIUtils.getDriver());
        WebElement we = WebUIUtils.fluentWaitDisplayed(copyBtnLocator.getBy(), 10, false);
        ac.moveToElement(we, 5, 5).click().perform();

        Toolkit toolkit = Toolkit.getDefaultToolkit();
        Clipboard clipboard = toolkit.getSystemClipboard();
        String result = (String) clipboard.getData(DataFlavor.stringFlavor);
        try {
            checkCopiedOutputValidity(result);
        } catch (Exception e) {
            exception = e.getMessage();
        }

        //close output popup
        String closeBtnXpath = generateOutputPopupCloseBtnXpath();
        ComponentLocator closeBtnLocator = new ComponentLocator(How.XPATH, closeBtnXpath);
        WebUIButton closeBtn = new WebUIButton(new WebUIComponent(closeBtnLocator));
        closeBtn.click();

        closeTap();

        if (exception != null) {
            throw new Exception(exception);
        }
    }

    public static void copyAndSaveScriptOutput(String varName, int timeout) throws Exception {
        waitForOutputPopup(timeout);

        //copy to clipboard
        String copyBtnXpath = generateCopyToClipboardBtnXpath();
        ComponentLocator copyBtnLocator = new ComponentLocator(How.XPATH, copyBtnXpath);
//        WebUIButton copyBtn = new WebUIButton(new WebUIComponent(copyBtnLocator));
//        copyBtn.click();
        Actions ac = new Actions(WebUIUtils.getDriver());
        WebElement we = WebUIUtils.fluentWaitDisplayed(copyBtnLocator.getBy(), 10, false);
        ac.moveToElement(we, 5, 5).click().perform();

        Toolkit toolkit = Toolkit.getDefaultToolkit();
        Clipboard clipboard = toolkit.getSystemClipboard();
        String result = (String) clipboard.getData(DataFlavor.stringFlavor);
        SystemProperties.get_instance().setRunTimeProperty(varName, result);

        //close output popup
        String closeBtnXpath = generateOutputPopupCloseBtnXpath();
        ComponentLocator closeBtnLocator = new ComponentLocator(How.XPATH, closeBtnXpath);
        WebUIButton closeBtn = new WebUIButton(new WebUIComponent(closeBtnLocator));
        closeBtn.click();

        closeTap();
    }

    private static void checkCopiedOutputValidity(String result) throws Exception {
        boolean isValid = true;
        String exception = "";
        String[] lines = result.split("\n");
        if (!(lines[0].equals("Status:"))) {
            isValid = false;
            exception = exception + "wrong result in line 1" + "\n";
        }
        if (!(lines[2].equals("Operation Completed") || lines[2].equals("Operation Failed"))) {
            isValid = false;
            exception = exception + "wrong result in line 3" + "\n";
        }
        if (!(lines[3].equals("Output:"))) {
            isValid = false;
            exception = exception + "wrong result in line 1" + "\n";
        }
        if (result.contains("Operation Completed")) {
            if (!result.contains("\nCLI Output Text:")) {
                isValid = false;
                exception = exception + "\"CLI Output Text:\" not found in output result" + "\n";
            }
            if (lines.length < 30) {
                isValid = false;
                exception = exception + "the output result may dose not contain CLI output" + "\n";
            }
        }
        if (!isValid) {
            throw new Exception(exception);
        }
    }

    public static void waitForOutputPopupAndClose(int timeout) throws Exception {
        waitForOutputPopup(timeout);

        String closeBtnXpath = generateOutputPopupCloseBtnXpath();
        ComponentLocator closeBtnLocator = new ComponentLocator(How.XPATH, closeBtnXpath);
        WebUIButton closeBtn = new WebUIButton(new WebUIComponent(closeBtnLocator));
        closeBtn.click();
    }

    private static void waitForOutputPopup(int timeout) throws Exception {
        String outputPopupXpath = generateOutputPopupXpath();
        ComponentLocator outputPopupLocator = new ComponentLocator(How.XPATH, outputPopupXpath);
        WebElement outputPopup;
        long startTime = System.currentTimeMillis();
        do {
            outputPopup = WebUIUtils.fluentWaitDisplayed(outputPopupLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        }
        while (System.currentTimeMillis() - startTime < timeout*1000 && outputPopup == null);
        if (outputPopup == null) {
            throw new Exception("Timeout: output popup not displayed");
        }
    }

    public static void setScriptParameter(String elementId, String value, boolean selectCheckbox, WebWidgetType widgetType) throws Exception {
        WebElement element;
        switch (widgetType) {
            case Text:
                WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).clear();
                WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).sendKeys(value);
                break;
            case Dropdown:
                element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                if (element != null) {
                    WebUIDropdown dropdown = new WebUIDropdown();
                    dropdown.setWebElement(element);
                    dropdown.setLocator(new ComponentLocator(How.ID, elementId));
                    dropdown.selectOptionByText(value);
                }
                break;
            case Checkbox:
                WebUICheckbox checkbox = new WebUICheckbox(new ComponentLocator(How.ID, elementId));
                if (checkbox != null) {
                    if (selectCheckbox) {
                        checkbox.check();
                    } else {
                        checkbox.uncheck();
                    }
                }
                break;
            case RadioButton:
                ComponentLocator locator = new ComponentLocator(How.ID, elementId);
                element = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                LinkedList<String> radioGroupOptions = new LinkedList<String>();
                if (element != null) {
                    WebUIRadioGroup radio = new WebUIRadioGroup(locator);

                    radio.setWebElement(element);
                    radioGroupOptions.addAll(Arrays.asList((radio.getInnerText().split(" "))));

                    if (radioGroupOptions.contains(value)) {
                        radio.selectOption(value);
                    } else {
                        throw new Exception("Failed to set Radio button : " + value + " you have provided is out of range " + elementId);
                    }
                }
                break;
        }
    }

    public static boolean isScriptExistUnderOTBAdvancedCategory(String scriptName,ToolboxGroupsEnum group){
        selectCategoryFromAdvanced(group);
        OperatorToolbox operatorToolbox = new OperatorToolbox();
        WebUITable table = operatorToolbox.getOperatorToolboxTable();
        int rowIndex = table.getRowIndex("Action Title",scriptName);
        if(rowIndex != -1){
            return true;
        }
        return false;
    }

    private static void showGroupResizeWidget(ToolboxGroupsEnum groupName) throws Exception {
        String resizeWidgetXpath = generateResizeWidgetXpath(groupName);
        ComponentLocator resizeWidgetLocator = new ComponentLocator(How.XPATH, resizeWidgetXpath);
        String javaScript = "$(arguments[0]).css('visibility','visible');";
        WebUIUtils.fluentWaitJSExecutor(javaScript, WebUIUtils.DEFAULT_WAIT_TIME, false, resizeWidgetLocator);
    }

    private static void showGroupMenu(ToolboxGroupsEnum groupName) throws Exception {
        String panelXpath = generateGroupMenuXpath(groupName);
        ComponentLocator panelLocator = new ComponentLocator(How.XPATH, panelXpath);
        String javaScript = "$(arguments[0]).css('display','block');";
        WebUIUtils.fluentWaitJSExecutor(javaScript, WebUIUtils.DEFAULT_WAIT_TIME, false, panelLocator);
    }

    private static void showActionPanel(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName) throws Exception {
        String panelXpath = generateScriptPanelXpath(actionName, actionParentGroupName);
        ComponentLocator panelLocator = new ComponentLocator(How.XPATH, panelXpath);
        String javaScript = "$(arguments[0]).css('display','inline');";
        WebUIUtils.fluentWaitJSExecutor(javaScript, WebUIUtils.DEFAULT_WAIT_TIME, false, panelLocator);
    }

    private static void hideActionPanel(ToolboxActionsEnum actionName, ToolboxGroupsEnum actionParentGroupName) {
        String panelXpath = generateScriptPanelXpath(actionName, actionParentGroupName);
        ComponentLocator panelLocator = new ComponentLocator(How.XPATH, panelXpath);
        String javaScript = "$(arguments[0]).css('display','none');";
        WebUIUtils.fluentWaitJSExecutor(javaScript, WebUIUtils.DEFAULT_WAIT_TIME, false, panelLocator);
    }

    private static List<WebElement> getGroupActions(ToolboxGroupsEnum groupName) {
        String groupXpath = generateGroupItemXpath(groupName);
        ComponentLocator groupLocator = new ComponentLocator(How.XPATH, groupXpath);
        WebUIWidget group = new WebUIWidget(new WebUIComponent(groupLocator));
        String nodeXpath = ".//div[starts-with(@data-debug-id,'" + getActionItemContainerPrefix() + "')]";
        List<WebElement> nodeList = group.getWebElement().findElements(By.xpath(nodeXpath));
        return nodeList;
    }

    private static void closeTap() {
        String closeXpath = generateTapSmaalCloseXpath();
        ComponentLocator closeLocator = new ComponentLocator(How.XPATH, closeXpath);
        WebUIWidget close = new WebUIWidget(new WebUIComponent(closeLocator));
        close.click();
    }

    private static boolean isSelected(ComponentLocator locator) {
        String attr = WebUIUtils.fluentWaitAttribute(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false, "class", null);
        if (attr == null) {
            return false;
        }
        String classStr = WebUIUtils.fluentWaitAttribute(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false, "class", null).toLowerCase();
        if (classStr.contains("-selected")) {
            return true;
        } else {
            return false;
        }
    }

    private static Point getElementLocation(ComponentLocator elementLocator) throws Exception {
        WebElement element = WebUIUtils.fluentWaitDisplayed(elementLocator.getBy(), 10, false);
        if(element == null){
            throw new Exception("can not find element: " + elementLocator.getLocatorValue());
        }
        return element.getLocation();
    }

    private static int getElementHeight(ComponentLocator elementLocator) {
        WebElement element = WebUIUtils.fluentWaitDisplayed(elementLocator.getBy(), 10, false);
        String height = element.getCssValue("height");
        height = height.replace("px", "");
        return (int) Double.parseDouble(height);
    }

    private static int getElementWidth(ComponentLocator elementLocator) {
        WebElement element = WebUIUtils.fluentWaitDisplayed(elementLocator.getBy(), 10, false);
        String width = element.getCssValue("width");
        width = width.replace("px", "");
        return (int) Double.parseDouble(width);
    }

    private static int getBrowserWidth() {
        return WebUIUtils.getDriver().manage().window().getSize().getWidth();
    }


    public static void navigateToToolbox() {
        try
        {
            HomePage.navigateFromHomePage("AUTOMATION");
        }catch (Exception ignore){}
    }

    public static void selectCategoryFromAdvanced(ToolboxGroupsEnum groupName) {
        navigateToToolbox();

        //Click on advanced
        String advancedBtnXpath = generateAdvancedButtonXpath();
        ComponentLocator advancedBtnLocator = new ComponentLocator(How.XPATH, advancedBtnXpath);
        WebUIButton advancedBtn = new WebUIButton(new WebUIComponent(advancedBtnLocator));
        advancedBtn.click();

        //Select a category from Operator Toolbox menu
        String categoryXpath = generateAdvancedCategoryXpath(groupName);
        ComponentLocator categoryLocator = new ComponentLocator(How.XPATH, categoryXpath);
        WebUIButton categoryBtn = new WebUIButton(new WebUIComponent(categoryLocator));
        categoryBtn.click();
    }

    public static void clickOTBDashboardBtn(){
        String advancedBtnXpath = generateDashboardButtonXpath();
        ComponentLocator dashboardBtnLocator = new ComponentLocator(How.XPATH, advancedBtnXpath);
        WebUIButton dashboardBtn = new WebUIButton(new WebUIComponent(dashboardBtnLocator));
        dashboardBtn.click();
    }

    private static String generateDragActionItemXpath(ToolboxActionsEnum actionItemName, ToolboxGroupsEnum parentGroupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + parentGroupItemName.toString() + "')]" + "//*[starts-with(@data-debug-id,'Dashboard_Widget_" + actionItemName.getActionID() + "')]" + "//*[@class='action-item-content']";
    }

    private static String generateActionItemXpath(ToolboxActionsEnum actionItemName, ToolboxGroupsEnum parentGroupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + parentGroupItemName.toString() + "')]" + "//*[starts-with(@data-debug-id,'Dashboard_Widget_" + actionItemName.getActionID() + "')]";
    }

    private static String generateActionItemDeleteXpath(ToolboxActionsEnum actionItemName, ToolboxGroupsEnum parentGroupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + parentGroupItemName.toString() + "')]" + "//*[starts-with(@data-debug-id,'Dashboard_Widget_" + actionItemName.getActionID() + "')]" + "//*[@class='action-mgmt-button delete']";
    }

    private static String generateActionItemRunXpath(ToolboxActionsEnum actionItemName, ToolboxGroupsEnum parentGroupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + parentGroupItemName.toString() + "')]" + "//*[starts-with(@data-debug-id,'Dashboard_Widget_" + actionItemName.getActionID() + "')]" + "//*[@class='action-mgmt-button run']";
    }

    private static String generateActionItemRunWithParamsXpath(ToolboxActionsEnum actionItemName, ToolboxGroupsEnum parentGroupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + parentGroupItemName.toString() + "')]" + "//*[starts-with(@data-debug-id,'Dashboard_Widget_" + actionItemName.getActionID() + "')]" + "//*[@class='action-mgmt-button config-run']";
    }

    private static String generateActionItemScheduleXpath(ToolboxActionsEnum actionItemName, ToolboxGroupsEnum parentGroupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + parentGroupItemName.toString() + "')]" + "//*[starts-with(@data-debug-id,'Dashboard_Widget_" + actionItemName.getActionID() + "')]" + "//*[@class='action-mgmt-button schedule']";
    }

    private static String generateActionItemResultXpath(ToolboxActionsEnum actionItemName, ToolboxGroupsEnum parentGroupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + parentGroupItemName.toString() + "')]" + "//*[starts-with(@data-debug-id,'Dashboard_Widget_" + actionItemName.getActionID() + "')]" + "//*[@class='action-mgmt-button log']";
    }

    private static String generateDropGroupItemXpath(ToolboxGroupsEnum groupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + groupItemName.toString() + "')]" + "//*[@class='group-item-content']";
    }

    private static String generateGroupItemXpath(ToolboxGroupsEnum groupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + groupItemName.toString() + "')]";
    }

    private static String generateGroupItemIconXpath(ToolboxGroupsEnum groupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + groupItemName.toString() + "')]" + "//*[contains(@style,'/vision-dashboards/public/images/toolbox/" + groupItemName.toString() + "-icon.svg')]";
    }

    private static String generateGroupMenuXpath(ToolboxGroupsEnum groupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + groupItemName.toString() + "')]" + "//*[@class='group-menu-item-buttons-group']";
    }

    private static String generateGroupItemAddScriptXpath(ToolboxGroupsEnum groupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + groupItemName.toString() + "')]" + "//*[contains(@class,'add-script')]";
    }

    private static String generateGroupItemMaximizeXpath(ToolboxGroupsEnum groupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + groupItemName.toString() + "')]" + "//*[contains(@class,'maximize')]";
    }

    private static String generateGroupItemCloseXpath(ToolboxGroupsEnum groupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + groupItemName.toString() + "')]" + "//*[contains(@class,'close')]";
    }

    private static String generateAddScriptTextFieldXpath() {
        return ".//*[contains(@class,'add-script-dialog-wrapper')]" + "//*[@class='add-script-dialog-suggestion-box']";
    }

    private static String generateScriptRowNameXpath() {
        return ".//*[contains(@class,'add-script-dialog-wrapper')]" + "//*[contains(@class,'add-script-dialog-action-item')]";
    }

    private static String generateAddScriptSelectButtonXpath() {
        return ".//*[contains(@class,'add-script-dialog-wrapper')]" + "//*[contains(@class,'add-script-dialog-select')]";
    }

    private static String generateScriptPanelXpath(ToolboxActionsEnum actionItemName, ToolboxGroupsEnum parentGroupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + parentGroupItemName.toString() + "')]" + "//*[starts-with(@data-debug-id,'Dashboard_Widget_" + actionItemName.getActionID() + "')]" + "//*[@class='action-item-control-box']";
    }

    private static String generateTapSmaalCloseXpath() {
        return ".//div[starts-with(@id,'gwt-debug-ConfigTab')]//div[@class='SmallClose']";
    }

    private static String getActionItemContainerPrefix() {
        return "Dashboard_Widget_";
    }

    private static String generateOutputPopupXpath() {
        return ".//*[@id='gwt-debug-script-exec-output-dialog-container']";
    }

    private static String generateOutputPopupCloseBtnXpath() {
        return ".//*[@id='gwt-debug-script-exec-output-dialog-container-header-close-icon']";
    }

    private static String generateCopyToClipboardBtnXpath() {
        return ".//*[@id='gwt-debug-script-exec-output-dialog-content-icons-copy-to-clipboard']";
    }

    private static String generateCategoriesRepositoryXpath() {
        return ".//*[@data-debug-id='toolbox-toolbar-categories-repository']";
    }

    private static String generateCategoriesRepositoryItemXpath(ToolboxGroupsEnum groupItemName) {
        return "//*[contains(@class,'categories-repository-item-" + groupItemName.toString() + "')]";
    }

    private static String generateCategoriesRepositoryApplyXpath() {
        return ".//*[@data-debug-id='categories-repository-apply-changes']";
    }

    private static String generateResizeWidgetXpath(ToolboxGroupsEnum groupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + groupItemName.toString() + "')]" + "//span[@class='react-resizable-handle']";
    }

    private static String generateGroupTitleXpath(ToolboxGroupsEnum groupItemName) {
        return ".//*[starts-with(@data-debug-id,'Dashboard_Widget_toolbox-" + groupItemName.toString() + "')]" + "//div[@class='group-item-title']";
    }

    private static String generateRestoreButtonXpath() {
        return ".//*[@data-debug-id='toolbar-item-wrapper-restore-view']";
    }

    private static String generateAdvancedButtonXpath() {
        return ".//*[@id='gwt-debug-ToolBox_ADVANCED']";
    }

    private static String generateDashboardButtonXpath() {
        return ".//*[@id='gwt-debug-ToolBox_DASHBOARD']";
    }

    private static String generateAdvancedCategoryXpath(ToolboxGroupsEnum groupItemName) {
        return ".//*[@id='gwt-debug-" + groupItemName.getGroupName() + "-content']";
    }

    private static String generateToolboxContainerWrapperXpath() {
        return ".//div[@data-debug-id='toolbox-wrapper']" + "//div[@class='react-grid-layout']";
    }

}