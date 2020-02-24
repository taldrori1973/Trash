package com.radware.vision.infra.testhandlers.rbac;


import com.radware.automation.tools.utils.PropertiesFilesUtils;
import com.radware.automation.tools.utils.ReflectionUtils;
import com.radware.automation.tools.utils.ValidationUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.base.pages.dptemplates.DpTemplates;
import com.radware.vision.infra.base.pages.navigation.HomePage;
import com.radware.vision.infra.base.pages.navigation.WebUIUpperBar;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.system.usermanagement.localusers.User;
import com.radware.vision.infra.base.pages.toolbox.advanced.OperatorToolbox;
import com.radware.vision.infra.base.pages.toolbox.advanced.appshapes.AppShapes;
import com.radware.vision.infra.base.pages.topologytree.DeviceProperties;
import com.radware.vision.infra.base.pages.topologytree.StandardDeviceProperties;
import com.radware.vision.infra.base.pages.topologytree.TreeSelection;
import com.radware.vision.infra.enums.*;
import com.radware.vision.infra.enums.controlbaritems.AlteonAndLinkProofNG;
import com.radware.vision.infra.enums.controlbaritems.Utils;
import com.radware.vision.infra.enums.enumsutils.Element;
import com.radware.vision.infra.enums.enumsutils.EnumsUtils;
import com.radware.vision.infra.testhandlers.alerts.AlertsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.UserRoles;
import com.radware.vision.infra.testhandlers.rbac.enums.VisionDashboardsSubMenu;
import com.radware.vision.infra.testhandlers.rbac.enums.VisionSettingsSubMenu;
import com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums.SystemSubMenuItems;
import com.radware.vision.infra.testhandlers.scheduledtasks.BaseTasksHandler;
import com.radware.vision.infra.testhandlers.system.generalsettings.devicedriver.DeviceDriverHandler;
import com.radware.vision.infra.testhandlers.system.usermanagement.localusers.LocalUsersHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.Keys;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class RBACHandler extends RBACHandlerBase {


    public static boolean defenceProConfigurationTemplatesAndSubChildsVisibility(boolean visibleOrNot) {
        WebUIUpperBar.select(UpperBarItems.ToolBox);
        WebUIUpperBar.select(UpperBarItems.ToolBox_Advanced);

        //get the ids and build the locators
        List<DpTemplates.DefenceConfigurationTemplatesTree> list = Arrays.asList(DpTemplates.DefenceConfigurationTemplatesTree.values());
        List<ComponentLocator> locators = new ArrayList<>();
        for (DpTemplates.DefenceConfigurationTemplatesTree elements : list) {

            locators.add(new ComponentLocator(How.XPATH, elements.getId()));
        }
        //check if matches the expected result

        for (ComponentLocator locator : locators) {

            if (!WebUIUtils.findExpectedResult(locator, visibleOrNot)) {
                return false;
            }
        }
        return true;

    }

    public static boolean appShapeAndSubChildsVisibility(boolean visibleOrNot) {

        WebUIUpperBar.select(UpperBarItems.ToolBox);
        WebUIUpperBar.select(UpperBarItems.ToolBox_Advanced);

        //get the ids and build the locators
        List<AppShapes.AppShapesTree> list = Arrays.asList(AppShapes.AppShapesTree.values());
        List<ComponentLocator> locators = new ArrayList<>();
        for (AppShapes.AppShapesTree elements : list) {

            locators.add(new ComponentLocator(How.XPATH, elements.getElementId()));
        }
        //check if matches the expected result

        for (ComponentLocator locator : locators) {

            if (!WebUIUtils.findExpectedResult(locator, visibleOrNot)) {
                return false;
            }
        }
        return true;

    }

    public static boolean operatorToolboxAndSubChildsVisibility(boolean visibleOrNot) {

        WebUIUpperBar.select(UpperBarItems.ToolBox);
        WebUIUpperBar.select(UpperBarItems.ToolBox_Advanced);

        //get the ids and build the locators
        List<OperatorToolbox.OperatorToolboxTree> list = Arrays.asList(OperatorToolbox.OperatorToolboxTree.values());
        List<ComponentLocator> locators = new ArrayList<>();
        for (OperatorToolbox.OperatorToolboxTree elements : list) {

            locators.add(new ComponentLocator(How.XPATH, elements.getId()));
        }
        //check if matches the expected result

        for (ComponentLocator locator : locators) {

            if (!WebUIUtils.findExpectedResult(locator, visibleOrNot)) {
                return false;
            }
        }
        return true;
    }

    public static boolean verifyTreeNodeInvisible(String treeNode) {
        ComponentLocator nodeLocator = new ComponentLocator(How.ID, WebUIStrings.getDeviceTreeNode(treeNode));
        return WebUIUtils.findExpectedResult(nodeLocator, expectedResultRBAC);
    }

    public static boolean IsUpperBarItemExist(UpperBarItems item) {
        boolean result = false;
        ComponentLocator itemLocator = new ComponentLocator(How.ID, item.getMenuIds());
        result = WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);

        return result;
    }

    public static boolean verifyDeviceDriverLinkInvisible(DeviceDriverActions item) {
        DeviceDriverHandler.openDeviceDriverMenu();
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getDeviceDriverLink(String.valueOf(item)));
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }

    //============= exist/not exist check ==================
    public static boolean verifyDeviceControlBarItemExistence(DeviceControlBarItems item) {
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getDeviceControlBarItem(String.valueOf(item)));
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }

    //============= enabled/disabled check==================
    public static boolean verifyDeviceControlBarItemEnabled(DeviceControlBarItems item, String
            deviceName, TopologyTreeTabs parentTree) {
        DeviceOperationsHandler.lockUnlockDevice(deviceName, parentTree.getTopologyTreeTab(), DeviceState.Lock.getDeviceState(), true);
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getDeviceControlBarItem(String.valueOf(item)));
        WebUIComponent component = new WebUIComponent(itemLocator);
        return component.isItemEnabled(expectedResultRBAC, itemLocator);
    }

    /**
     * @param deviceType
     * @return in case there is operation not supported returns the error message ,
     * if the behavior as expected return empty String
     * @throws Exception
     */
    public static String supportsDeviceOperations(DeviceType4Group deviceType) throws Exception {

        Class<? extends Enum<? extends Element>> device = Utils.getDeviceClass(deviceType);

        for (Enum<? extends Element> operation : device.getEnumConstants()) {
            String elementName = (String) ReflectionUtils.getField(operation.getClass(), "elementName").get(operation);
            String elementId = (String) ReflectionUtils.getField(operation.getClass(), "elementId").get(operation);

            if (deviceType.equals(DeviceType4Group.Alteon) || deviceType.equals(DeviceType4Group.LinkProof))
                if (elementName.equalsIgnoreCase(AlteonAndLinkProofNG.SYNC.getElementName()))
                    continue;

            //if the item have father click on it first to see the child element
            if (elementName.contains("->")) {
                String elementParentId = Utils.getEnumInstanceForDeviceControlBarItem(deviceType, elementName.split("->")[0]).getElementId();
                if (!WebUIUtils.isItemSelected(new ComponentLocator(How.ID, elementParentId))) {
                    //to avoid the case another child is open
                    Actions actions = new Actions(WebUIUtils.getDriver());
                    actions.sendKeys(Keys.ESCAPE);
                    actions.perform();
                    WebUIUtils.pressEsc();
                    ClickOperationsHandler.clickWebElement(WebElementType.Id, elementParentId, 0);
                }
            }
            if (!checkIfItemEnabled(new ComponentLocator(How.ID, elementId)))
                return "Operation " + elementName + " does not exist or enabled";
        }

        return "";
    }


    public static boolean verifyTaskRowInvisible(String columnName, String columnValue) throws Exception {
        boolean valid = BaseTasksHandler.validateTaskCreation(columnName, columnValue);
        return valid;
    }

    public static boolean verifyAlertRow(String columnName, String columnValue) {
        boolean valid = AlertsHandler.validateAlert(columnName, columnValue);
        if (valid == expectedResultRBAC) {
            return true;
        } else {
            return false;
        }
    }

    public static boolean verifyDisabledTopologyTreeOperation(TopologyTreeOperations operation) {
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getTopologyTreeOperation(String.valueOf(operation)));
        WebUIComponent treeOperation = new WebUIComponent(itemLocator);

        if (treeOperation.isItemEnabled(expectedResultRBAC, itemLocator)) {
            return true;
        } else return false;
    }

    public static boolean verifyExistingTopologyTreeOperation(TopologyTreeOperations operation, boolean existing) {
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getTopologyTreeOperation(String.valueOf(operation)));
        WebElement treeOperation = WebUIUtils.fluentWaitDisplayed(itemLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        return existing ? treeOperation != null : treeOperation == null;
    }

    public static boolean verifyDeviceStateOperation(String deviceName, String parentTree) {
        if (!deviceName.equals("") || !parentTree.equals("")) {
            DeviceProperties deviceProperties = new StandardDeviceProperties();
            if (TopologyTreeTabs.getEnum(parentTree).equals(TopologyTreeTabs.SitesAndClusters)) {
                TopologyTreeHandler.openSitesAndClusters();
            } else if (TopologyTreeTabs.getEnum(parentTree).equals(TopologyTreeTabs.PhysicalContainers)) {
                TopologyTreeHandler.openPhysicalContainers();
            } else {
                throw new IllegalStateException("Incorrect Topology Tree tab name is provided: " + TopologyTreeTabs.getEnum(parentTree));
            }
            deviceProperties.selectTreeNode(deviceName);
        }
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStrings.getLockUnlockDevice());
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }

    public static boolean verifyRoleScope(UserRoles role) {
        LocalUsersHandler.NavigateHereIfNeedTo();
        User newUser = LocalUsersHandler.getLocalUsers().newUser();
        newUser.addPermission().setRole(role.getUserRole());

        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getScopeMenu());
        WebElement scope = new WebUIComponent(itemLocator).getWebElement();
        String isDisabled = scope.getAttribute("disabled");

        WebUIVisionBasePage.cancel(false);
        WebUIVisionBasePage.cancel(false);

        if ((isDisabled != null && expectedResultRBAC == false) || (isDisabled == null && expectedResultRBAC == true)) {
            return true;
        } else return false;
    }

    public static boolean verifyPhysicalTabExistence() {
        TopologyTreeHandler.openTreeSelectionMenu();
        ComponentLocator itemLocator = new ComponentLocator(How.ID, TreeSelection.getPhysicalContainers());
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }

    public static boolean verifyDeviceSettingsSubMenuExistence(String item, String deviceName) {
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        TopologyTreeHandler.openSitesAndClusters();
        TopologyTreeHandler.expandAllSitesClusters();
        deviceProperties.selectTreeNode(deviceName);
//        deviceProperties.viewDevice();
//        VisionServerMenuPane menuPane = new VisionServerMenuPane();
//        menuPane.openSystemGeneralSettings();


        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getDeviceSettingsMenuItem(item));
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }


    public static boolean verifyVisionSettingsSubMenuExistence(String item) {
        BasicOperationsHandler.settings();
//        BasicOperationsHandler.delay(1);
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getDeviceSettingsMenuItem(item));
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }


    public static boolean deviceResourcesIsVisible(boolean visible) {
        WebUIVisionBasePage.navigateToPage("System");
        WebElement deviceResources = WebUIUtils.fluentWait(new ComponentLocator(How.ID, "gwt-debug-TopicsStack_am.system.tree.additional").getBy(), WebUIUtils.SHORT_WAIT_TIME, false);

        if (visible && deviceResources == null || !visible && deviceResources != null) return false;

        return true;
    }

    public static String validateRbacOperation(String operation, String access) throws Exception {
        boolean existsAndEnabled = true;
        String errorMessage = "";
        ComponentLocator locator;
        String operationWithoutUpperCase = operation;
        operation = operation.toUpperCase();


        switch (operation) {
            case "ADD/EDIT DEVICE":
                //if the tree does not exists there is no need to check others
                if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, TreeSelection.TreeSelectionMenu.TREE_SELECTION_MENU.getId()))) {

                    locator = new ComponentLocator(How.ID, WebUIStrings.getAddNewDeviceCommand());
                    if (existsAndEnabled = checkIfItemEnabled(locator)) {
                        errorMessage = "Add device icon exists and enabled";
                    } else {
                        errorMessage = "Add device icon does not exist or enabled";
                    }

                    //Click on device first to check if the edit is enabled
                    TopologyTreeHandler.clickTreeNode(DeviceType4Group.NOT_DEFAULT);

                    locator = new ComponentLocator(How.ID, WebUIStrings.getEditElementCommand());
                    if (existsAndEnabled = checkIfItemEnabled(locator)) {
                        errorMessage += " - Edit device icon exists and enabled";
                    } else {
                        errorMessage += " - Edit device icon does not exist or enabled";
                    }
                } else errorMessage = "Devices Tree does not exists";

                break;

            case "LOCK DEVICE":
                //if the tree does not exists there is no need to check others
                if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, TreeSelection.TreeSelectionMenu.TREE_SELECTION_MENU.getId()))) {
                    TopologyTreeHandler.clickRandomDevice();
                    locator = new ComponentLocator(How.ID, WebUIStrings.getLockUnlockDevice());
                    if (existsAndEnabled = checkIfItemEnabled(locator))
                        errorMessage = "lock device icon exists and enabled";
                    else
                        errorMessage = "lock device icon does not exist or enabled";
                    break;

                } else errorMessage = "Devices Tree does not exists";

            case "SUPPORTS ALTEON":
            case "SUPPORTS LINKPROOF":
            case "SUPPORTS DEFENSEPRO":
            case "SUPPORTS APPWALL":
                //if the tree does not exists there is no need to check others
                if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, TreeSelection.TreeSelectionMenu.TREE_SELECTION_MENU.getId()))) {
                    DeviceType4Group device = getDeviceType(operation);
                    if (existsAndEnabled = TopologyTreeHandler.clickTreeNode(device))
                        errorMessage = "device exists in the tree";
                    else
                        errorMessage = "device does not exist in the tree";
                    break;
                } else errorMessage = "Devices Tree does not exists";


            case "SECURITY MONITORING PERSPECTIVE":
                //if the tree does not exists there is no need to check others
                if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, TreeSelection.TreeSelectionMenu.TREE_SELECTION_MENU.getId()))) {
                    TopologyTreeHandler.clickTreeNode(DeviceType4Group.NOT_DEFAULT);
                    locator = new ComponentLocator(How.ID, WebUIStringsVision.getLeftMenuPaneSecurityMonitoring());

                    if (existsAndEnabled = checkIfItemEnabled(locator)) {
                        errorMessage = "Exists And enabled";

                    } else errorMessage = "does not exist or enabled";
                } else errorMessage = "Devices Tree does not exists";

                break;

            case "VISION SETTINGS DEVICE RESOURCES":
                BasicOperationsHandler.settings();

                String deviceResourcesId = EnumsUtils.getEnumByElementName(SystemSubMenuItems.class, "Device Resources").getElementId();
                locator = new ComponentLocator(How.ID, deviceResourcesId);
                if (existsAndEnabled = checkIfItemEnabled(locator))
                    errorMessage = "vision settings device resources exists and enabled";
                else
                    errorMessage = "vision settings device resources does not exist or enabled";
                break;

            case "SCHEDULER":
            case "APM":
            case "VISION SETTINGS":
            case "DEVICES CONFIGURATION":
            case "GEL DASHBOARD":
            case"SECURITY CONTROL CENTER":
            case "AMS ALERTS":
            case "AMS FORENSICS":
            case "AMS REPORTS":
            case "APPWALL DASHBOARD":
            case "DEFENSEFLOW ANALYTICS DASHBOARD":
            case "DEFENSEPRO MONITORING DASHBOARD":
            case "DEFENSEPRO ANALYTICS DASHBOARD":
            case "HTTPS FLOOD DASHBOARD":
            case "DEFENSEPRO BEHAVIORAL PROTECTIONS DASHBOARD":
            case "ANALYTICS AMS":
            case "ANALYTICS ADC":
            case "EAAF DASHBOARD":
                errorMessage = HomePage.validateExistNavigator(PropertiesFilesUtils.mapAllPropertyFiles("Navigations").get(operationWithoutUpperCase));
                existsAndEnabled = errorMessage.equals("");
                if (existsAndEnabled)
                    errorMessage="The Navigator " + operation + " shouldn't be exist, But it exists";
                break;

            case "TOOLBOX":
                errorMessage = HomePage.validateExistNavigator(PropertiesFilesUtils.mapAllPropertyFiles("Navigations").get("AUTOMATION"));
                existsAndEnabled = errorMessage.equals("");
                if (existsAndEnabled)
                    errorMessage="The Navigator " + operation + " shouldn't be exist, But it exists";
                break;

            case "AVR":
            case "DPM":
            case "VDIRECT":
                errorMessage = HomePage.validateExistNavigator(PropertiesFilesUtils.mapAllPropertyFiles("Navigations").get(operationWithoutUpperCase));
                existsAndEnabled = errorMessage.equals("");
                if (access.equalsIgnoreCase("yes"))
                {
                    try
                    {
                        WebUIUtils.getDriver().switchTo().window(new ArrayList<String>(WebUIUtils.getDriver().getWindowHandles()).get(1)).close();
                    }catch (Exception ignore){}
                    WebUIUtils.getDriver().switchTo().window(new ArrayList<String>(WebUIUtils.getDriver().getWindowHandles()).get(0));
                }
                if (existsAndEnabled)
                    errorMessage="The Navigator " + operation + " shouldn't be exist, But it exists";
                break;

            case "ALERT BROWSER":
                locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsMaximizeButton());
                if (existsAndEnabled = checkIfItemEnabled(locator))
                    errorMessage = "Alerts icon exists and enabled";
                else
                    errorMessage = "Alerts icon does not exist or enabled";
                break;

            case "OPERATOR TOOLBOX":
//                locator = new ComponentLocator(How.ID, UpperBarItems.ToolBox.getMenuIds());
//                if (existsAndEnabled = checkIfItemEnabled(locator)) {
//                    WebUIUpperBar.selectNoVerify(UpperBarItems.ToolBox);
                try
                {
                    HomePage.navigateFromHomePage(PropertiesFilesUtils.mapAllPropertyFiles("Navigations").get("AUTOMATION"));
                }catch (Exception e )
                {
                    errorMessage = e.getMessage();
                }
                if (errorMessage.equals("")){
                    locator = new ComponentLocator(How.ID, UpperBarItems.ToolBox_Advanced.getMenuIds());
                    if (existsAndEnabled = checkIfItemEnabled(locator)) {
                        ClickOperationsHandler.clickWebElement(locator);
                        if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, AppShapes.AppShapesTree.APPSHAPES.getElementId()))) {
                            errorMessage = "Appshapes exist and enabled";
                        } else errorMessage = "Appshape does not exist or enabled";
                    } else errorMessage = "Toolbox advanced does not exist or enabled";

                } else
                    errorMessage = "Toolbox icon does not exist or enabled";
                break;

            case "APPSHAPE IS VISIBLE":
//                locator = new ComponentLocator(How.ID, UpperBarItems.ToolBox.getMenuIds());
//
//                if (existsAndEnabled = checkIfItemEnabled(locator)) {
//                    WebUIUpperBar.selectNoVerify(UpperBarItems.ToolBox);
                try
                {
                    HomePage.navigateFromHomePage(PropertiesFilesUtils.mapAllPropertyFiles("Navigations").get("AUTOMATION"));
                }catch (Exception e )
                {
                    errorMessage = e.getMessage();
                }
                if (errorMessage.equals("")){
                    locator = new ComponentLocator(How.ID, UpperBarItems.ToolBox_Advanced.getMenuIds());
                    if (existsAndEnabled = checkIfItemEnabled(locator)) {
                        WebUIUpperBar.selectNoVerify(UpperBarItems.ToolBox_Advanced);
                        if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, AppShapes.AppShapesTree.APPSHAPES.getElementId())))
                            errorMessage = "Appshape exists and enabled";
                        else
                            errorMessage = "Appshape does not exist or enabled";

                    } else errorMessage = "Toolbox advanced tab is not visible or enabled";
                } else errorMessage = "Toolbox is icon is not visible or enabled";

                break;

            case "LOAD NEW APPSHAPE":
//                locator = new ComponentLocator(How.ID, UpperBarItems.ToolBox.getMenuIds());
//
//                if (existsAndEnabled = checkIfItemEnabled(locator)) {
//                    WebUIUpperBar.selectNoVerify(UpperBarItems.ToolBox);
                try
                {
                    HomePage.navigateFromHomePage(PropertiesFilesUtils.mapAllPropertyFiles("Navigations").get("AUTOMATION"));
                }catch (Exception e )
                {
                    errorMessage = e.getMessage();
                }
                if (errorMessage.equals("")){
                    locator = new ComponentLocator(How.ID, UpperBarItems.ToolBox_Advanced.getMenuIds());
                    if (existsAndEnabled = checkIfItemEnabled(locator)) {
                        WebUIUpperBar.selectNoVerify(UpperBarItems.ToolBox_Advanced);
                        if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, AppShapes.AppShapesTree.APPSHAPES.getElementId()))) {
                            new AppShapes().clickOnAppShapes();
                            if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, AppShapes.TABLE_ADD)))
                                errorMessage = "Loading new appshape icon exists and enabled";
                            else
                                errorMessage = "Loading new appshape icon does not exists or enabled";
                        } else
                            errorMessage = "Appshape does not exist or enabled";

                    } else errorMessage = "Toolbox advanced tab is not visible or enabled";
                } else errorMessage = "Toolbox is icon is not visible or enabled";

                break;
            case "DP TEMPLATES":
//                locator = new ComponentLocator(How.ID, UpperBarItems.ToolBox.getMenuIds());
//
//                if (existsAndEnabled = checkIfItemEnabled(locator)) {
//                    WebUIUpperBar.selectNoVerify(UpperBarItems.ToolBox);
                try
                {
                    HomePage.navigateFromHomePage(PropertiesFilesUtils.mapAllPropertyFiles("Navigations").get("AUTOMATION"));
                }catch (Exception e )
                {
                    errorMessage = e.getMessage();
                }
                if (errorMessage.equals("")){
                    locator = new ComponentLocator(How.ID, UpperBarItems.ToolBox_Advanced.getMenuIds());
                    if (existsAndEnabled = checkIfItemEnabled(locator)) {
                        WebUIUpperBar.selectNoVerify(UpperBarItems.ToolBox_Advanced);
                        if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, AppShapes.AppShapesTree.APPSHAPES.getElementId()))) {
                            if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, DpTemplates.DefenceConfigurationTemplatesTree.DEFENCE_CONFIGURATION_TEMPLATES.getId())))
                                errorMessage = "DefensePro Configuration Templates exists and enabled";
                            else
                                errorMessage = "DefensePro Configuration Templates does not exist or enabled";

                        } else
                            errorMessage = "Appshape does not exist or enabled";

                    } else errorMessage = "Toolbox advanced tab is not visible or enabled";
                } else errorMessage = "Toolbox is icon is not visible or enabled";

                break;


            case "PHYSICAL TAB":
                //if the tree does not exists there is no need to check others
                HomePage.navigateFromHomePage("HOME");
                if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, TreeSelection.TreeSelectionMenu.TREE_SELECTION_MENU.getId()))) {
                    new TreeSelection().openTreeSelectionMenu();
                    if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, TreeSelection.TreeSelectionMenu.PHYSICAL_CONTAINERS.getId())))
                        errorMessage = "exists and enabled";
                    else errorMessage = "does not exist or enabled";
                } else errorMessage = "Devices Tree does not exists";
                break;

            case "DP OPERATIONS":
            case "ALTEON OPERATIONS":
            case "APPWALL OPERATIONS":
            case "LINKPROOF NG OPERATIONS":

                //if the tree does not exists there is no need to check others
                if (existsAndEnabled = checkIfItemEnabled(new ComponentLocator(How.ID, TreeSelection.TreeSelectionMenu.TREE_SELECTION_MENU.getId()))) {
                    DeviceType4Group device = getDeviceType(operation);
                    if (existsAndEnabled = TopologyTreeHandler.clickTreeNode(device)) {
                        locator = new ComponentLocator(How.ID, WebUIStrings.getLockUnlockDevice());
                        if (existsAndEnabled = checkIfItemEnabled(locator)) {
                            ClickOperationsHandler.clickWebElement(locator);
                            errorMessage = supportsDeviceOperations(device);
                            if (existsAndEnabled = errorMessage.isEmpty() ? true : false) {
                                errorMessage = "all operations supported";
                            }
                        } else errorMessage = "Lock device icon does not exist or enabled";

                    } else
                        errorMessage = "There is no device to select from the sites and devices tree";
                    //unlock device after finish working with it
                    DeviceOperationsHandler.atomicLockUnlockDevice(DeviceState.UnLock.getDeviceState());

                } else errorMessage = "Devices Tree does not exists";
                break;

            case "APP SLA DASHBOARD":
//                WebUIUpperBar.selectNoVerify(UpperBarItems.VisionSettings);
                HomePage.navigateFromHomePage(PropertiesFilesUtils.mapAllPropertyFiles("Navigations").get("VISION SETTINGS"));
                locator = new ComponentLocator(How.ID, VisionSettingsSubMenu.DASHBOARDS.getElementId());
                if (existsAndEnabled = checkIfItemEnabled(locator)) {
                    ClickOperationsHandler.clickWebElement(locator);
                    locator = new ComponentLocator(How.ID, VisionDashboardsSubMenu.DASHBOARDS_SUB_MENU.getElementId());
                    if (existsAndEnabled = checkIfItemEnabled(locator)) {
                        ClickOperationsHandler.clickWebElement(locator);
                        locator = new ComponentLocator(How.ID, VisionDashboardsSubMenu.APPLICATION_SLA_DASHBOARD.getElementId());
                        if (existsAndEnabled = checkIfItemEnabled(locator)) {
                            ClickOperationsHandler.clickWebElement(locator);
                        } else errorMessage = "Application SLA Dashboard tab does not exist or enabled";

                    } else errorMessage = "Dashboards sub menu tab does not exist or enabled";

                } else errorMessage = "Dashboards tab does not exist or enabled";
                break;

            default:
                return "";

        }

        if (!ValidationUtils.checkIfMatches(existsAndEnabled, access)) {
            return errorMessage;
        }

        return "";
    }

    private static DeviceType4Group getDeviceType(String operation) {
        operation = operation.toUpperCase();

        if (operation.contains("ALTEON"))
            return DeviceType4Group.Alteon;
        if (operation.contains("LINKPROOF NG") || operation.contains("LINKPROOF"))
            return DeviceType4Group.LinkProof;
        if (operation.contains("DEFENSEPRO") || operation.contains("DP"))
            return DeviceType4Group.DefensePro;
        if (operation.contains("APPWALL"))
            return DeviceType4Group.AppWall;
        return null;
    }


    /**
     * calls the checkIfItemEnabled(locator); to check if item enabled or not.
     * if it throws exception will return false;
     *
     * @param locator
     * @return
     */
    private static boolean checkIfItemEnabled(ComponentLocator locator) {

        boolean result;
        try {
            result = WebUIUtils.isItemEnabled(locator);
        } catch (NoSuchElementException e) {
            return false;
        }

        return result;
    }
}


