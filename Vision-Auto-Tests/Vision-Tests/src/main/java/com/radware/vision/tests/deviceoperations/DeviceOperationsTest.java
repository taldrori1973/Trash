package com.radware.vision.tests.deviceoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.WebUIScreen;
import com.radware.utils.DeviceUtils;
import com.radware.utils.device.DeviceScalarUtils;
import com.radware.vision.pojomodel.helpers.constants.ImConstants$DeviceStatusEnumPojo;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.VisionServerInfoPane;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.ExportPolicyDownloadTo;
import com.radware.vision.infra.enums.RevertApplyMenuItems;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;
import testhandlers.Device;

import java.util.HashMap;

public class DeviceOperationsTest extends WebUITestBase {
    TopologyTreeTabs parentTree;
    boolean verifyDeviceLockState = false;
    String fileDownloadPath = System.getProperty("user.home").concat("\\Downloads\\");
    String messageToValidate;
    String privateKeys;
    ExportPolicyDownloadTo uploadFromSource = ExportPolicyDownloadTo.Client;
    String fileName;
    String scalarNamesList;
    String scalarValuesToVerify;
    String deviceIp;
    String scalarPropsValues;
    String scalarProps;
    String expectedValues;

    boolean useRestForLockUnlock = false;
    RevertApplyMenuItems revertApplyMenuItem = RevertApplyMenuItems.SELECT_DESIRED_MENU_ITEM;
    ImConstants$DeviceStatusEnumPojo requestedDeviceStatus;


    int timeouToWaitInSeconds = 300;


    @Before
    public void setDeviceDriver() {
        WebUIScreen webScreen = new WebUIScreen();
        webScreen.setCurrentContainer(WebUIUtils.VISION_DEVICE_DRIVER_ID, true);
    }

    @Test
    @TestProperties(name = "Lock Device", paramsInclude = {"qcTestId", "deviceName", "parentTree", "verifyDeviceLockState", "useRestForLockUnlock", "targetTestId"})
    public void lockDevice() throws Exception {
        try {
            DeviceState state = DeviceState.Lock;
            DeviceOperationsHandler.lockUnlockDevice(getDeviceName(), String.valueOf(parentTree), String.valueOf(state), useRestForLockUnlock);
            if (verifyDeviceLockState) {
                BasicOperationsHandler.delay(2);
                VisionServerInfoPane infopane = new VisionServerInfoPane();
                String currentyLockedBy = infopane.getDeviceLockedBy();
                if (!(currentyLockedBy.equals(WebUITestBase.webUtils.loggedinUser))) {
                    report.report("Device: " + getDeviceName() + " is locked by: " + currentyLockedBy + ", and not by " + WebUITestBase.getConnectionUsername(), Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            report.report("Topology Element may not have been found :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Unlock Device", paramsInclude = {"qcTestId", "deviceName", "parentTree", "verifyDeviceLockState", "useRestForLockUnlock"})
    public void unlockDevice() throws Exception {
        try {
            DeviceState state = DeviceState.UnLock;
            DeviceOperationsHandler.lockUnlockDevice(getDeviceName(), String.valueOf(parentTree), String.valueOf(state), useRestForLockUnlock);
            if (verifyDeviceLockState) {
                VisionServerInfoPane infopane = new VisionServerInfoPane();
                String currentlyLockedBy = infopane.getDeviceLockedBy();
                if (!(currentlyLockedBy.equals(""))) {
                    report.report("Device: " + getDeviceName() + " is locked by: " + currentlyLockedBy + ", instead of 'unlocked' state.", Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            report.report("Topology Element may not have been found :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "apply Device", paramsInclude = {"qcTestId", "deviceName", "parentTree"})
    public void applyDevice() throws Exception {
        try {
            DeviceState state = DeviceState.Lock;
            DeviceOperationsHandler.applyAction(getDeviceName(), String.valueOf(parentTree), String.valueOf(state));

        } catch (Exception e) {
            report.report("Topology Element may not have been found :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "save Device", paramsInclude = {"qcTestId", "deviceName", "parentTree"})
    public void saveDevice() throws Exception {
        try {
            DeviceState state = DeviceState.Lock;
            DeviceOperationsHandler.saveAction(getDeviceName(), String.valueOf(parentTree), String.valueOf(state));

        } catch (Exception e) {
            report.report("Topology Element may not have been found :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "revert Device", paramsInclude = {"qcTestId", "revertApplyMenuItem", "deviceName", "parentTree", "targetTestId"})
    public void revertDevice() throws Exception {
        try {
            DeviceState state = DeviceState.Lock;
            DeviceOperationsHandler.revertAction(revertApplyMenuItem, getDeviceName(), String.valueOf(parentTree), String.valueOf(state), getDeviceName());

        } catch (Exception e) {
            report.report("Topology Element may not have been found :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "sync Device", paramsInclude = {"qcTestId", "deviceName", "parentTree"})
    public void syncDevice() throws Exception {
        try {
            DeviceState state = DeviceState.Lock;
            DeviceOperationsHandler.syncAction(getDeviceName(), String.valueOf(parentTree), String.valueOf(state));
        } catch (Exception e) {
            report.report("Topology Element may not have been found :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "alteon Save Dump", paramsInclude = {"qcTestId", "deviceName", "fileDownloadPath", "messageToValidate", "privateKeys"})
    public void alteonSaveDump() throws Exception {
        try {
            if (!DeviceOperationsHandler.alteonSaveDump(getDeviceName(), fileDownloadPath, messageToValidate, privateKeys)) {
                report.report("The following message : " + messageToValidate + " is not found in the dump file!", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("alteon Save Dump may not have been executed correctly :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "import DeviceCfg", paramsInclude = {"qcTestId", "deviceName", "fileName", "fileDownloadPath", "parentTree", "uploadFromSource", "privateKeys",
            "scalarNamesList", "scalarValuesToVerify"})
    public void importDeviceCfg() throws Exception {
        try {
            HashMap<String, String> properties = new HashMap<String, String>(40);
            DeviceState state = DeviceState.Lock;
            properties.put("deviceName", getDeviceName());
            properties.put("deviceState", state.getDeviceState());
            properties.put("parentTree", parentTree.getTopologyTreeTab());
            properties.put("uploadFromSource", uploadFromSource.getDownloadTo());
            properties.put("privateKeys", privateKeys);
            properties.put("fileName", fileName);
            properties.put("fileDownloadPath", fileDownloadPath);
            properties.put("scalarNamesList", scalarNamesList);
            properties.put("scalarValuesToVerify", scalarValuesToVerify);

            DeviceOperationsHandler.importAlteonOperation(properties, getVisionRestClient());
        } catch (Exception e) {
            report.report("import DeviceCfg operation has been executed incorrectly :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "export DeviceCfg", paramsInclude = {"qcTestId", "deviceName", "fileName", "fileDownloadPath", "parentTree", "uploadFromSource", "privateKeys",
            "scalarNamesList", "scalarValuesToVerify"})
    public void exportDeviceCfg() throws Exception {
        try {
            HashMap<String, String> properties = new HashMap<String, String>(40);
            DeviceState state = DeviceState.Lock;
            properties.put("deviceName", getDeviceName());
            properties.put("deviceState", state.getDeviceState());
            properties.put("parentTree", parentTree.getTopologyTreeTab());
            properties.put("uploadFromSource", uploadFromSource.getDownloadTo());
            properties.put("privateKeys", privateKeys);
            properties.put("fileName", fileName);
            properties.put("fileDownloadPath", fileDownloadPath);
            properties.put("scalarNamesList", scalarNamesList);
            properties.put("scalarValuesToVerify", scalarValuesToVerify);

            DeviceOperationsHandler.exportAlteonOperation(properties, getVisionRestClient());

        } catch (Exception e) {
            report.report("export DeviceCfg operation has been executed incorrectly :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Set Scalar", paramsInclude = {"qcTestId", "deviceName", "scalarPropsValues"})
    public void setScalar() {
        try {
            DeviceOperationsHandler.lockUnlockDevice(getDeviceName(), TopologyTreeTabs.SitesAndClusters.getTopologyTreeTab(), DeviceState.Lock.getDeviceState(), true);
            DeviceScalarUtils.putScalar(getVisionRestClient(), DeviceUtils.getDeviceIp(getVisionRestClient(), getDeviceName()), scalarPropsValues);
        } catch (Exception e) {
            report.report("Set Scalar failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Get Scalar", paramsInclude = {"qcTestId", "deviceIp", "scalarProps", "expectedValues"})
    public void getScalar() {
        try {
            DeviceScalarUtils.getScalar(getVisionRestClient(), deviceIp, scalarProps, expectedValues, false);
        } catch (Exception e) {
            report.report("Get Scalar failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Wait For Device Status", paramsInclude = {"qcTestId", "deviceName", "requestedDeviceStatus", "timeouToWaitInSeconds"})
    public void waitForDeviceStatus() {
        try {
            for (String deviceName : getDeviceName().split(",")) {
                if (!Device.waitForDeviceStatus(getVisionRestClient(), deviceName, requestedDeviceStatus, timeouToWaitInSeconds * 1000)) {
                    BaseTestUtils.report("Device Name :" + deviceName + " Device Status is equal to " + DeviceUtils.getDeviceState(getVisionRestClient(), deviceName), Reporter.FAIL);
                    return;
                }
            }

        } catch (Exception e) {
            report.report("Wait For Device Status Failed " + getDeviceName(), Reporter.FAIL);
        }
    }

    public RevertApplyMenuItems getRevertApplyMenuItem() {
        return revertApplyMenuItem;
    }

    public void setRevertApplyMenuItem(RevertApplyMenuItems revertApplyMenuItem) {
        this.revertApplyMenuItem = revertApplyMenuItem;
    }

    public String getScalarProps() {
        return scalarProps;
    }

    @ParameterProperties(description = "Specify list of Scalars You want to Pull. Fields must be separated by <,>.")
    public void setScalarProps(String scalarProps) {
        this.scalarProps = scalarProps;
    }

    public String getExpectedValues() {
        return expectedValues;
    }

    @ParameterProperties(description = "Specify list of Expected Values according to Scalars order. Fields must be separated by <,>.")
    public void setExpectedValues(String expectedValues) {
        this.expectedValues = expectedValues;
    }

    public String getDeviceIp() {
        return deviceIp;
    }

    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public String getScalarPropsValues() {
        return scalarPropsValues;
    }

    @ParameterProperties(description = "Specify list of Scalars and their Values to be SET. Fields must be separated by <,>.(f.e. '<scalar>=<value>')")
    public void setScalarPropsValues(String scalarPropsValues) {
        this.scalarPropsValues = scalarPropsValues;
    }

    public String getScalarNamesList() {
        return scalarNamesList;
    }

    @ParameterProperties(description = "Specify list of Scalars You want to validate. Fields must be separated by <,>.")
    public void setScalarNamesList(String scalarNamesList) {
        this.scalarNamesList = scalarNamesList;
    }

    public String getScalarValuesToVerify() {
        return scalarValuesToVerify;
    }

    @ParameterProperties(description = "Specify list of Expected Values according to Scalars order. Fields must be separated by <,>.")
    public void setScalarValuesToVerify(String scalarValuesToVerify) {
        this.scalarValuesToVerify = scalarValuesToVerify;
    }

    public ExportPolicyDownloadTo getUploadFromSource() {
        return uploadFromSource;
    }

    public void setUploadFromSource(ExportPolicyDownloadTo uploadFromSource) {
        this.uploadFromSource = uploadFromSource;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getPrivateKeys() {
        return privateKeys;
    }

    @ParameterProperties(description = "Please, provide <private Keys> between 4 to 40 characters.")
    public void setPrivateKeys(String privateKeys) {
        this.privateKeys = privateKeys;
    }

    public String getMessageToValidate() {
        return messageToValidate;
    }

    @ParameterProperties(description = "Please, provide the <message> You want to look for in the dumpFile.")
    public void setMessageToValidate(String messageToValidate) {
        this.messageToValidate = messageToValidate;
    }

    public String getFileDownloadPath() {
        return fileDownloadPath;
    }

    @ParameterProperties(description = "Please, provide a path if different from the default one.")
    public void setFileDownloadPath(String fileDownloadPath) {
        this.fileDownloadPath = fileDownloadPath;
    }

    public TopologyTreeTabs getParentTree() {
        return parentTree;
    }

    public void setParentTree(TopologyTreeTabs parentTree) {
        this.parentTree = parentTree;
    }

    public boolean getVerifyDeviceLockState() {
        return verifyDeviceLockState;
    }

    public void setVerifyDeviceLockState(boolean verifyDeviceLockState) {
        this.verifyDeviceLockState = verifyDeviceLockState;
    }

    public boolean getUseRestForLockUnlock() {
        return useRestForLockUnlock;
    }

    public void setUseRestForLockUnlock(boolean useRestForLockUnlock) {
        this.useRestForLockUnlock = useRestForLockUnlock;
    }

    public ImConstants$DeviceStatusEnumPojo getRequestedDeviceStatus() {
        return requestedDeviceStatus;
    }

    public void setRequestedDeviceStatus(ImConstants$DeviceStatusEnumPojo requestedDeviceStatus) {
        this.requestedDeviceStatus = requestedDeviceStatus;
    }


    public int getTimeouToWaitInSeconds() {
        return timeouToWaitInSeconds;
    }

    public void setTimeouToWaitInSeconds(int timeouToWaitInSeconds) {
        this.timeouToWaitInSeconds = timeouToWaitInSeconds;
    }
}
