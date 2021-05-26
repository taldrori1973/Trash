package com.radware.vision.bddtests.deviceoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.base.pages.VisionServerInfoPane;
import com.radware.vision.infra.enums.*;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.support.How;

import java.util.HashMap;

public class DeviceOperationSteps extends VisionUITestBase {
    DeviceState deviceState = DeviceState.Lock;

    public DeviceOperationSteps() throws Exception {
    }

    @When("^UI Lock Device \"([^\"]*)\" by Tree Tab \"([^\"]*)\"$")
    public void lockDevice(String deviceSetId, String parentTree) throws Exception { ;
        TreeDeviceManagementDto deviceInfo = sutManager.getTreeDeviceManagement(deviceSetId).get();
        DeviceOperationsHandler.lockUnlockDevice(deviceInfo.getDeviceName(), parentTree, DeviceState.Lock.getDeviceState(), false);
    }

    @Given("^UI Unlock Device \"([^\"]*)\" ,Parent Tree \"([^\"]*)\"$")
    public void unlockDevice(String deviceName, String parentTree) {
        DeviceOperationsHandler.lockUnlockDevice(deviceName, parentTree, DeviceState.UnLock.getDeviceState(), false);
    }


    @When("^UI Lock Selected Device$")
    public void uiLockSelectedDevice() {
        DeviceOperationsHandler.atomicLockUnlockDevice(DeviceState.Lock.toString());
    }

    @When("^UI Unlock Selected Device$")
    public void uiUnlockSelectedDevice() {
        DeviceOperationsHandler.atomicLockUnlockDevice(DeviceState.UnLock.toString());
    }

    @Then("^UI Validate InfoPane Property \"(.*)\" with expectedResult \"(.*)\"$")
    public void validateInfoPaneProperty(DeviceInfoPaneProperties deviceInfoPaneProperties, String expectedResult) {
        try {
            VisionServerInfoPane visionServerInfoPane = new VisionServerInfoPane();
            if (visionServerInfoPane.isLabelExists(deviceInfoPaneProperties.getDeviceInfoPaneProperties())) {
                if (!visionServerInfoPane.getInfoPanePropertyVersion(deviceInfoPaneProperties.getDeviceInfoPaneProperties()).equals(expectedResult)) {
                    BaseTestUtils.report("Device Operation validation has failed: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
                }
            } else {
                BaseTestUtils.report("No such property is found: " + deviceInfoPaneProperties.getDeviceInfoPaneProperties() + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Device Property validation has failed : " + "expected is: " + expectedResult + " actual is: " + deviceInfoPaneProperties.getDeviceInfoPaneProperties(), Reporter.FAIL);
        }
    }

    @Then("^UI export Alteon DeviceCfg by type \"(.*)\" with index \"(.*)\" with source to upload from \"(Server|Client)\"$")
    public void exportDeviceCfg(String elementType, String index, String uploadFromSource) throws Exception {
        try {
            SUTDeviceType sutDeviceType = SUTDeviceType.valueOf(elementType);
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(sutDeviceType, Integer.valueOf(index));
            HashMap<String, String> properties = new HashMap<String, String>(10);
            DeviceState state = DeviceState.Lock;
            properties.put("deviceName", deviceInfo.getDeviceName());
            properties.put("deviceState", state.getDeviceState());
            properties.put("parentTree", TopologyTreeTabs.SitesAndClusters.getTopologyTreeTab());
            properties.put("uploadFromSource", uploadFromSource);
            properties.put("privateKeys", "admin");
            properties.put("fileName", "");
            properties.put("scalarNamesList", "");
            properties.put("scalarValuesToVerify", "");

            DeviceOperationsHandler.exportAlteonOperation(properties, restTestBase.getVisionRestClient());
        } catch (Exception e) {
            BaseTestUtils.report("export DeviceCfg operation has been executed incorrectly :", Reporter.FAIL);
        }
    }

    @When("^UI verify Device Status( physical)? \"(.*)\" if Expected device Status \"(.*)\"$")
    public void verifyDeviceStatusSites(String treeTab, String deviceSetId, String expectedDeviceStatus) throws Exception {
        try {
            TreeDeviceManagementDto deviceInfo = sutManager.getTreeDeviceManagement(deviceSetId).get();
            String deviceStatus = (treeTab != null) ? TopologyTreeHandler.getDeviceStatusPhysical(deviceInfo.getDeviceName()) : TopologyTreeHandler.getDeviceStatusSites(deviceInfo.getDeviceName());
            if (DeviceStatusEnum.getDeviceStatusEnum(expectedDeviceStatus) == DeviceStatusEnum.UP_OR_MAINTENANCE) {
                if (!((deviceStatus.equals(DeviceStatusEnum.UP.getStatus())) || (deviceStatus.equals(DeviceStatusEnum.MAINTENANCE.getStatus())))) {
                    BaseTestUtils.report("Device " + deviceInfo.getDeviceName() + " " + "did not reach status: " + expectedDeviceStatus + ". " + "\nCurrent status: " + deviceStatus, Reporter.FAIL);
                }
            } else if (!(deviceStatus.equals(DeviceStatusEnum.getDeviceStatusEnum(expectedDeviceStatus).getStatus()))) {
                BaseTestUtils.report("Device " + deviceInfo.getDeviceName() + " " + "did not reach status: " + expectedDeviceStatus + ". " + "\nCurrent status: " + deviceStatus, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Topology Tree may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI perform Device ResetShutDown Operation( physical)? with deviceType \"(.*)\" with index (\\d+) by operationToPerform \"(Reset|ShutDown)\"$")
    public void performDeviceResetShutDownOperation(String treeTab, SUTDeviceType sutDeviceType, int index,ResetShutDownOperations operationToPerform) {
        try {
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(sutDeviceType, index);
            if(treeTab != null) {
                TopologyTreeHandler.openPhysicalContainers();
            }else {
                TopologyTreeHandler.openSitesAndClusters();
            }
            TopologyTreeHandler.clickTreeNode(deviceInfo.getDeviceName());

            if (!operationToPerform.getOperationType().equals("") && deviceState != null) {
                DeviceOperationsHandler.atomicLockUnlockDevice(DeviceState.Lock.getDeviceState());
                WebUIUtils.fluentWaitClick(new ComponentLocator(How.ID, WebUIStrings.getSelectResetOrShutdownButton()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                WebUIUtils.fluentWaitClick(new ComponentLocator(How.ID, operationToPerform.getOperationType()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                WebUIBasePage.silentPopupclose();

            } else {
                BaseTestUtils.report("Failed to click on the specified button : " + operationToPerform.toString(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the specified button : " + operationToPerform.toString(), Reporter.FAIL);
        }
    }

    @Then("^UI revert Device \"(REVERT|REVERT_APPLY)\"( physical)? with deviceType \"(.*)\" with index (\\d+)$")
    public void revertDevice(RevertApplyMenuItems revertApplyMenuItem, String treeTab, SUTDeviceType sutDeviceType, int index) throws Exception {
        try {
            if(treeTab != null) {
                treeTab = String.valueOf(TopologyTreeTabs.PhysicalContainers);
            }else {
                treeTab = String.valueOf(TopologyTreeTabs.SitesAndClusters);
            }
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(sutDeviceType, index);
            DeviceState state = DeviceState.Lock;
            DeviceOperationsHandler.revertAction(revertApplyMenuItem, deviceInfo.getDeviceName(), treeTab, String.valueOf(state), deviceInfo.getDeviceIp());

        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :", Reporter.FAIL);
        }
    }
}