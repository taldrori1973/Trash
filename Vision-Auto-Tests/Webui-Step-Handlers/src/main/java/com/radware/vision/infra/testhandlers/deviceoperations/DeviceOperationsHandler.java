package com.radware.vision.infra.testhandlers.deviceoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.restcore.VisionRestClient;
import com.radware.utils.DeviceUtils;
import com.radware.utils.device.DeviceScalarUtils;
import com.radware.vision.infra.base.pages.devicecontrolbar.DeviceControlBar;
import com.radware.vision.infra.base.pages.devicecontrolbar.DumpDialog;
import com.radware.vision.infra.base.pages.devicecontrolbar.ExportOperation;
import com.radware.vision.infra.base.pages.devicecontrolbar.ImportOperation;
import com.radware.vision.infra.base.pages.deviceoperations.DeviceOperations;
import com.radware.vision.infra.base.pages.topologytree.DeviceProperties;
import com.radware.vision.infra.base.pages.topologytree.StandardDeviceProperties;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.RevertApplyMenuItems;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.infra.utils.TimeUtils;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

public class DeviceOperationsHandler extends BaseHandler {

    public static void applyAction(String deviceName, String parentTree, String deviceState) {
        initLockDevice(deviceName, parentTree, deviceState);
        DeviceControlBar deviceControlBar = new DeviceControlBar();
        deviceControlBar.applyButtonClick();
    }

    public static void saveAction(String deviceName, String parentTree, String deviceState) {
        lockUnlockDevice(deviceName, parentTree, deviceState, true);
        DeviceControlBar deviceControlBar = new DeviceControlBar();
        deviceControlBar.saveButtonClick();
    }

    public static void revertAction(RevertApplyMenuItems revertApplyMenuItem, String deviceName, String parentTree, String deviceState, String deviceIp) {
        if (revertApplyMenuItem != null && !revertApplyMenuItem.getRevertApplyMenuItem().equals("")) {
            lockUnlockDevice(deviceName, parentTree, deviceState, true, deviceIp);
            DeviceControlBar deviceControlBar = new DeviceControlBar();
            if (revertApplyMenuItem.equals(RevertApplyMenuItems.REVERT)) {
                deviceControlBar.revertMenuItemClick(WebUIStrings.getRevertAlteonRevertButton());
            } else if (revertApplyMenuItem.equals(RevertApplyMenuItems.REVERT_APPLY)) {
                deviceControlBar.revertMenuItemClick(WebUIStrings.getRevertAlteonApplyButton());
            }
        }
    }

    public static void syncAction(String deviceName, String parentTree, String deviceState) {
        initLockDevice(deviceName, parentTree, deviceState);
        DeviceControlBar deviceControlBar = new DeviceControlBar();
        deviceControlBar.syncButtonClick();
    }

    public static void importAlteonOperation(HashMap<String, String> properties, VisionRestClient visionRestClient) {
        initLockDevice(properties);
        ImportOperation importOperation = new ImportOperation();
        importOperation.operationsMenuItemClick(WebUIStrings.getImportConfigurationFileToDevice());
        importOperation.importFile(properties.get("uploadFromSource"), properties.get("fileName"), properties.get("privateKeys"), properties.get("fileDownloadPath"));
        BasicOperationsHandler.delay(10);
        if (properties.get("scalarNamesList") != null && !properties.get("scalarNamesList").equals("") && properties.get("scalarValuesToVerify") != null && !properties.get("scalarValuesToVerify").equals("")) {
            DeviceScalarUtils.getScalar(visionRestClient, DeviceUtils.getDeviceIp(visionRestClient, properties.get("deviceName")), properties.get("scalarNamesList"), properties.get("scalarValuesToVerify"), false);
        }
    }

    public static void exportAlteonOperation(HashMap<String, String> properties, VisionRestClient visionRestClient) {
        DeviceOperationsHandler.viewDevice(properties.get("deviceName"));
        ExportOperation exportOperation = new ExportOperation();
        exportOperation.operationsMenuItemClick(WebUIStrings.getExportConfigurationFileToDevice());
        exportOperation.exportFile(properties.get("uploadFromSource"), properties.get("fileName"), properties.get("privateKeys"));
        BasicOperationsHandler.delay(5);
        if (properties.get("scalarNamesList") != null && !properties.get("scalarNamesList").equals("") && properties.get("scalarValuesToVerify") != null && !properties.get("scalarValuesToVerify").equals("")) {
            DeviceScalarUtils.getScalar(visionRestClient, DeviceUtils.getDeviceIp(visionRestClient, properties.get("deviceName")), properties.get("scalarNamesList"), properties.get("scalarValuesToVerify"), false);
        }
    }

    public static boolean alteonSaveDump(String deviceName, String filePath, String messageToValidate, String privateKeys) throws NoSuchFieldException, Exception {
        viewDevice(deviceName);

        DeviceControlBar deviceControlBar = new DeviceControlBar();
        deviceControlBar.dumpButtonClick();
        BasicOperationsHandler.delay(2);
        DumpDialog dumpDialog = new DumpDialog();
        long currentTime = TimeUtils.getCurrentDate();
        Date date = new Date(currentTime);
        dumpDialog.includePrivateKeys(privateKeys);
        dumpDialog.saveDumpButtonClick();
        BasicOperationsHandler.delay(2);
        dumpDialog.closeDumpDialogBox();
        return validateDumpFile(filePath, messageToValidate, date);
    }

    public static void viewDevice(String deviceName) {
        TopologyTreeHandler.openSitesAndClusters();
        TopologyTreeHandler.expandAllSitesClusters();
        TopologyTreeHandler.clickTreeNode(deviceName);
        TopologyTreeHandler.openDeviceInfoPane();
    }

    public static boolean validateDumpFile(String filePath, String messageToValidate, Date date) throws Exception {
        String dumpFileName = findFileByPartialName(filePath, date);
        if (dumpFileName.contains("txt")) {
            String dumpContent = FileUtils.getFileContent(dumpFileName);
            if (dumpContent.contains(messageToValidate)) {
                return true;
            }
            return false;
        } else {
            return FileUtils.ifContainsInArchive(new File(dumpFileName), messageToValidate);
        }
    }


    public static String findFileByPartialName(String filePath, Date date) throws NoSuchFieldException {
        File dir = new File(filePath);
        String[] files = dir.list();
        SimpleDateFormat simpleDateFormatPrefix = new SimpleDateFormat("HH");
        SimpleDateFormat simpleDateFormatSuffix = new SimpleDateFormat("_EEE-MMM-d-yyyy");

        String fileNameFirstPartCurrentMin = "Configuration_".concat(simpleDateFormatPrefix.format(date));
        String fileNameSecondPart = simpleDateFormatSuffix.format(date);
        try {
            for (int i = 0; i < files.length; i++) {
                if (files[i].toString().contains(fileNameFirstPartCurrentMin) && files[i].toString().contains(fileNameSecondPart)) {
                    return filePath.concat("\\").concat(files[i].toString());
                }
            }
        } catch (Exception e) {
            throw new NoSuchFieldException(e.getMessage() + "\n" + e.getStackTrace());
        }
        return "";
    }

    public static void lockUnlockMultipleDevices(String deviceNamesGroup, String parentTree, DeviceState deviceState) {
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        DeviceOperations deviceOperations = new DeviceOperations();
        List<String> deviceNames = parseDeviceNamesArr(deviceNamesGroup);

        try {
            if (TopologyTreeTabs.getEnum(parentTree).equals(TopologyTreeTabs.SitesAndClusters)) {
                TopologyTreeHandler.openSitesAndClusters();
            } else if (TopologyTreeTabs.getEnum(parentTree).equals(TopologyTreeTabs.PhysicalContainers)) {
                TopologyTreeHandler.openPhysicalContainers();
            } else {
                throw new IllegalStateException("Incorrect Topology Tree tab name is provided: " + TopologyTreeTabs.getEnum(parentTree));
            }
            TopologyTreeHandler.multiSelection(deviceNames);
            deviceProperties.viewDevice();
            BaseHandler.atomicLockUnlockDevice(deviceState.getDeviceState());// As soon as IDs for multiple devices are implemented, change/add this accordingly
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void applyMultipleAction(String deviceName, String parentTree) {
        lockUnlockMultipleDevices(deviceName, parentTree, DeviceState.Lock);
        DeviceControlBar deviceControlBar = new DeviceControlBar();
        deviceControlBar.applyButtonClick();
    }

    public static void saveMultipleAction(String deviceName, String parentTree) {
        lockUnlockMultipleDevices(deviceName, parentTree, DeviceState.Lock);
        DeviceControlBar deviceControlBar = new DeviceControlBar();
        deviceControlBar.saveButtonClick();
    }

    public static void revertMultipleAction(String deviceName, String parentTree) {
        lockUnlockMultipleDevices(deviceName, parentTree, DeviceState.Lock);
        DeviceControlBar deviceControlBar = new DeviceControlBar();
        deviceControlBar.revertButtonClick();
    }

    public static void syncMultipleAction(String deviceName, String parentTree) {
        lockUnlockMultipleDevices(deviceName, parentTree, DeviceState.Lock);
        DeviceControlBar deviceControlBar = new DeviceControlBar();
        deviceControlBar.syncButtonClick();
    }


    public static List<String> parseDeviceNamesArr(String deviceNamesGroup) {
        String[] deviceNamesArr = deviceNamesGroup.split(",");
        List<String> deviceNames = new ArrayList<String>();
        deviceNames = new ArrayList<String>(Arrays.asList(deviceNamesArr));

        return deviceNames;
    }
}
