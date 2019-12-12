package com.radware.vision.tests.rbac;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.rbac.RBACManager;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.infra.enums.*;
import com.radware.vision.infra.testhandlers.multipleUseHandlers.MultipleUseHandlers;
import com.radware.vision.infra.testhandlers.rbac.RBACHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.testhandlers.rbac.enums.DeviceSettingsSubMenus;
import com.radware.vision.infra.testhandlers.rbac.enums.UserRoles;
import com.radware.vision.infra.testhandlers.rbac.enums.VisionSettingsSubMenu;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

public class RBACTests extends RBACTestBase {

    String treeElement;
    UpperBarItems upperBarItem;
    DeviceDriverActions deviceDriverAction;
    DeviceControlBarItems deviceControlBarItem;
    DeviceState deviceState;
    UserRoles userRole = UserRoles.ADC_ADMINISTRATOR;
    DeviceSettingsSubMenus deviceSettingsSubMenu = DeviceSettingsSubMenus.CONFIGURATION;
    VisionSettingsSubMenu visionSettingsSubMenu = VisionSettingsSubMenu.SYSTEM;
    String columnName;
    String taskName;
    String deviceType;
    String deviceIp;
    String columnValue;
    TopologyTreeTabs parentTree = TopologyTreeTabs.SitesAndClusters;
    TopologyTreeOperations topologyTreeOperation;
    VisionTableIDs visionTableID = VisionTableIDs.SELECT_TABLE_TO_WORK_WITH;


    @Test
    @TestProperties(name = "Verify existing topology tree element", paramsInclude = {"qcTestId", "treeElement", "expectedResult"})
    public void verifyNonExistingTreeNode() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if (!(RBACHandler.verifyTreeNodeInvisible(treeElement))) {
                report.report("Topology tree element is in an incorrect state (exist/not exist): " + treeElement + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verify existing topology tree element failed: " + treeElement + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify existing Upper Bar Items", paramsInclude = {"qcTestId", "upperBarItem", "expectedResult"})
    public void verifyNonExistingUpperBarItems() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if (!(RBACHandler.IsUpperBarItemExist(upperBarItem))) {
                report.report("Upper Bar Item is in an incorrect state (exist/not exist): " + String.valueOf(upperBarItem) + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verify existing Upper Bar Item failed: " + String.valueOf(upperBarItem) + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify existing Device Driver Link", paramsInclude = {"qcTestId", "deviceDriverAction", "expectedResult"})
    public void verifyNonExistingDeviceDriverLink() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if (!(RBACHandler.verifyDeviceDriverLinkInvisible(deviceDriverAction))) {
                report.report("Device Driver Link: " + String.valueOf(deviceDriverAction) + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Device Driver operation failed: " + String.valueOf(deviceDriverAction) + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Device Control Bar Item Existence", paramsInclude = {"qcTestId", "deviceControlBarItem", "expectedResult"})
    public void verifyNonExistingDeviceControlBarItem() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if (!(RBACHandler.verifyDeviceControlBarItemExistence(deviceControlBarItem))) {
                report.report("Device Control Bar Item Existence test has failed: " + String.valueOf(deviceControlBarItem) + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Device Control Bar Item Existence test has failed: " + String.valueOf(deviceControlBarItem) + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    //policyProperties.get("deviceName"), policyProperties.get("parentTree"), policyProperties.get("deviceState")
    @Test
    @TestProperties(name = "Device Control Bar Item Enabled", paramsInclude = {"qcTestId", "deviceControlBarItem", "expectedResult", "deviceName", "parentTree"})
    public void verifyEnabledDeviceControlBarItem() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if (!(RBACHandler.verifyDeviceControlBarItemEnabled(deviceControlBarItem, getDeviceName(), parentTree))) {
                report.report("Device Control Bar Item Enabled test has Failed: " + String.valueOf(deviceControlBarItem) + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Device Control Bar Item Enabled test has Failed: " + String.valueOf(deviceControlBarItem) + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Task Existance", paramsInclude = {"qcTestId", "taskName", "expectedResult"})
    public void verifyNonExistingTask() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            columnName = "Name";
            if ((RBACHandler.verifyTaskRowInvisible(columnName, taskName))) {
                report.report("Task: " + taskName + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verify non existing Task: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Existing Alert", paramsInclude = {"qcTestId", "columnName", "columnValue", "expectedResult"})
    public void verifyNonExistingAlert() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if (!(RBACHandler.verifyAlertRow(columnName, columnValue))) {
                report.report("The specified : " + deviceType + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verify non existing Task: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public String normalizeExpectedAlertResult(String alertContent) {
        String normalizedContent = "";
        if (alertContent.contains("(ID: R_")) {
            normalizedContent = alertContent.substring(0, alertContent.indexOf("(ID: R_")).concat(alertContent.substring(alertContent.indexOf("(ID: R_") + 13, alertContent.length() - 1));
        } else {
            normalizedContent = alertContent;
        }

        return normalizedContent;
    }


    @Test
    @TestProperties(name = "Verify Disabled Tree Operations", paramsInclude = {"qcTestId", "topologyTreeOperation", "expectedResult"})
    public void verifyDisabledTreeOperation() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if ((!RBACHandler.verifyDisabledTopologyTreeOperation(topologyTreeOperation))) {
                report.report("Tree Operation: " + String.valueOf(topologyTreeOperation) + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verify Disabled Tree Operations: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify Existing Tree Operations", paramsInclude = {"qcTestId", "topologyTreeOperation", "expectedResult"})
    public void verifyExistingTreeOperation() {
        try {
            if ((!RBACHandler.verifyExistingTopologyTreeOperation(topologyTreeOperation, expectedResult))) {
                report.report("Tree Operation: " + String.valueOf(topologyTreeOperation) + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verify Existing Tree Operations: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify Device Lock-Unlock Operations", paramsInclude = {"qcTestId", "expectedResult", "deviceName", "parentTree"})
    public void verifyLockUnlockOperation() {
        try {
            if ((!MultipleUseHandlers.verifyLockUnlockOperation(expectedResult, getDeviceName(), parentTree.getTopologyTreeTab()))) {
                report.report("Device Operation: " + String.valueOf(deviceState) + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verify Device Lock-Unlock Operations: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify Scope All Required", paramsInclude = {"qcTestId", "expectedResult", "userRole"})
    public void verifyScopeAllRequired() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if ((!RBACHandler.verifyRoleScope(userRole))) {
                report.report("Verify Scope: " + String.valueOf(userRole) + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verify Scope All Required: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify PhysicalTab Existence", paramsInclude = {"qcTestId", "expectedResult"})
    public void verifyPhysicalTabExistence() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if ((!RBACHandler.verifyPhysicalTabExistence())) {
                report.report("Verify PhysicalTab: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verify PhysicalTab Existence: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify DeviceSettingsSubMenu Existence", paramsInclude = {"qcTestId", "expectedResult", "deviceSettingsSubMenu", "deviceName"})
    public void verifyDeviceSettingsSubMenuExistence() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if ((!RBACHandler.verifyDeviceSettingsSubMenuExistence(deviceSettingsSubMenu.getSubMenu(), getDeviceName()))) {
                report.report("Verify DeviceSettingsSubMenu: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verify DeviceSettingsSubMenu Existence: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify VisionSettingsSubMenu Existence", paramsInclude = {"qcTestId", "expectedResult", "visionSettingsSubMenu"})
    public void verifyVisionSettingsSubMenuExistence() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if ((!RBACHandler.verifyVisionSettingsSubMenuExistence(visionSettingsSubMenu.getElementName()))) {
                report.report("Verify VisionSettingsSubMenu: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verify VisionSettingsSubMenu Existence: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Vision Table Existence", paramsInclude = {"visionTableID", "expectedResult"})
    public void verifyVisionTableExistence() {
        try {
            if (!visionTableID.getVisionTableID().equals("") && visionTableID != null) {
                WebUIUtils.isTriggerPopupSearchEvent4FreeTest = false;
                RBACManager.isRBACMode = true;
                ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-".concat(visionTableID.getVisionTableID()));
                WebElement element = WebUIUtils.fluentWaitPresence(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                if ((element == null) && expectedResult || (element != null && !expectedResult)) {
                    report.report("Existance Validation has Failed : " + "gwt-debug-".concat(visionTableID.getVisionTableID()), Reporter.FAIL);
                }

            } else {
                report.report("Existance Validation has Failed : " + "gwt-debug-".concat(visionTableID.getVisionTableID()), Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Existance Validation has Failed : " + "gwt-debug-".concat(visionTableID.getVisionTableID()), Reporter.FAIL);
        } finally {
            WebUIUtils.isTriggerPopupSearchEvent4FreeTest = true;
        }
    }

    public VisionSettingsSubMenu getVisionSettingsSubMenu() {
        return visionSettingsSubMenu;
    }

    public void setVisionSettingsSubMenu(VisionSettingsSubMenu visionSettingsSubMenu) {
        this.visionSettingsSubMenu = visionSettingsSubMenu;
    }

    public TopologyTreeTabs getParentTree() {
        return parentTree;
    }

    public void setParentTree(TopologyTreeTabs parentTree) {
        this.parentTree = parentTree;
    }

    public DeviceSettingsSubMenus getDeviceSettingsSubMenu() {
        return deviceSettingsSubMenu;
    }

    public void setDeviceSettingsSubMenu(DeviceSettingsSubMenus deviceSettingsSubMenu) {
        this.deviceSettingsSubMenu = deviceSettingsSubMenu;
    }

    public UserRoles getUserRole() {
        return userRole;
    }

    public void setUserRole(UserRoles userRole) {
        this.userRole = userRole;
    }

    public DeviceState getDeviceState() {
        return deviceState;
    }

    public void setDeviceState(DeviceState deviceState) {
        this.deviceState = deviceState;
    }

    public String getTreeElement() {
        return treeElement;
    }

    public void setTreeElement(String treeElement) {
        this.treeElement = treeElement;
    }

    public UpperBarItems getUpperBarItem() {
        return upperBarItem;
    }

    @ParameterProperties(description = "Please provide the Item's name as it uppears in the Vision client.")
    public void setUpperBarItem(UpperBarItems upperBarItem) {
        this.upperBarItem = upperBarItem;
    }

    public DeviceDriverActions getDeviceDriverAction() {
        return deviceDriverAction;
    }

    public void setDeviceDriverAction(DeviceDriverActions deviceDriverAction) {
        this.deviceDriverAction = deviceDriverAction;
    }

    public DeviceControlBarItems getDeviceControlBarItem() {
        return deviceControlBarItem;
    }

    public void setDeviceControlBarItem(DeviceControlBarItems deviceControlBarItem) {
        this.deviceControlBarItem = deviceControlBarItem;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(String deviceType) {
        this.deviceType = deviceType;
    }

    public String getDeviceIp() {
        return deviceIp;
    }

    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public String getColumnValue() {
        return columnValue;
    }

    @ParameterProperties(description = "Please provide the part/whole Cell content to match!")
    public void setColumnValue(String columnValue) {
        this.columnValue = columnValue;
    }

    public TopologyTreeOperations getTopologyTreeOperation() {
        return topologyTreeOperation;
    }

    public void setTopologyTreeOperation(TopologyTreeOperations topologyTreeOperation) {
        this.topologyTreeOperation = topologyTreeOperation;
    }

    public VisionTableIDs getVisionTableID() {
        return visionTableID;
    }

    public void setVisionTableID(VisionTableIDs visionTableID) {
        this.visionTableID = visionTableID;
    }
}
