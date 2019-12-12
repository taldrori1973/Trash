package com.radware.vision.infra.testhandlers.DefencePro.dpOperations;

import basejunit.RestTestBase;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.automation.webui.DpWebUIUtils;
import com.radware.automation.webui.WebUIMessages;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.events.ReportWebDriverEventListener;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.restcore.VisionRestClient;
import com.radware.utils.DeviceUtils;
import com.radware.utils.device.DeviceScalarUtils;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.infra.base.pages.defensepro.dpOperations.DpOperationsBase;
import com.radware.vision.infra.base.pages.defensepro.dpOperations.ExportConfigurationFile;
import com.radware.vision.infra.base.pages.defensepro.dpOperations.ImportConfigurationFile;
import com.radware.vision.infra.base.pages.defensepro.dpOperations.UpdateSecuritySignatures;
import com.radware.vision.infra.enums.ExportPolicyDownloadTo;
import com.radware.vision.infra.testhandlers.DefencePro.enums.SignatureTypes;
import com.radware.vision.infra.testhandlers.DefencePro.enums.UpdateFromSource;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.testhandlers.scheduledtasks.validateScheduledTasks.ValidateTasksHandler;
import com.radware.vision.infra.testhandlers.system.deviceResources.devicebackups.DeviceBackupsHandler;

import java.nio.file.NoSuchFileException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * Created by stanislava on 3/18/2015.
 */
public class DPOperationsHandler extends RBACHandlerBase {

    public static void importConfigurationFile(VisionRestClient visionRestClient, HashMap<String, String> properties) throws Exception {
        ImportConfigurationFile importConfigurationFile = new ImportConfigurationFile();
        try {
            initLockDevice(properties);
            importConfigurationFile.operationMenuSubItemClick(WebUIStrings.getImportConfigurationFileToDevice());
            importConfigurationFile.uploadFile(properties.get("uploadFrom"), properties.get("fileName"), properties.get("fileDownloadPath"), properties.get("deviceName"));
            waitForDeviceRestart(visionRestClient, properties);
            if (properties.get("scalarNamesList") != null && !properties.get("scalarNamesList").equals("") && properties.get("scalarValuesToVerify") != null && !properties.get("scalarValuesToVerify").equals("")) {
                DeviceScalarUtils.getScalar(visionRestClient, DeviceUtils.getDeviceIp(visionRestClient, properties.get("deviceName")), properties.get("scalarNamesList"), properties.get("scalarValuesToVerify"), false);
            }
        } finally {
            importConfigurationFile.clickButton("gwt-debug-Dialog_Box_Close");
        }
    }

    public static boolean exportConfigurationFile(HashMap<String, String> properties) {
        ExportConfigurationFile exportConfigurationFile = new ExportConfigurationFile();
        DeviceOperationsHandler.viewDevice(properties.get("deviceName"));
        exportConfigurationFile.operationMenuSubItemClick(WebUIStrings.getExportConfigurationFileToDevice());
        String fileNameToValidate = exportConfigurationFile.exportFileTo(properties.get("fileDownloadPath"), properties.get("uploadFrom"), properties.get("saveAsFileName"), properties.get("includePrivateKeys"), properties.get("deviceName"));
        BasicOperationsHandler.delay(10);
        return validateExportConfigurationFile(properties.get("uploadFrom"), fileNameToValidate, properties.get("fileDownloadPath"), properties.get("includePrivateKeys"));

    }

    public static boolean exportLogSupportFile(HashMap<String, String> properties, RadwareServerCli cli) throws NoSuchFileException {
        String fileContent = "";
        try {
            DpOperationsBase exportLogSupportFile = new ExportConfigurationFile();
            String partialFileName = properties.get("deviceName").concat("_").concat("Log_");
            try {
                FileUtils.deleteFile(properties.get("fileDownloadPath"), partialFileName);
            } catch (NoSuchFileException e) {
            }
            DeviceOperationsHandler.viewDevice(properties.get("deviceName"));
            exportLogSupportFile.operationMenuSubItemClick(WebUIStrings.getExportLogSupportFile());
            String exportedFileName = FileUtils.findFileByPartialName(properties.get("fileDownloadPath"), partialFileName);
            if (exportedFileName != null && exportedFileName.isEmpty()) {
                return false;
            }
            fileContent = FileUtils.getFileContent(exportedFileName);
            if (exportedFileName != null && !exportedFileName.equals("")) {
                fileContent = FileUtils.getFileContent(exportedFileName);
            }
        } catch (Exception e) {

        }
        if (properties.get("messageToVerify") != null && fileContent.contains(properties.get("messageToVerify"))) {
            return true;
        } else if (properties.get("messageToVerify") == null) {
            return true;
        }
        return false;

    }

    public static boolean exportTechnicalSupportFile(HashMap<String, String> properties, RadwareServerCli cli) throws NoSuchFileException {
        String exportedFileName = "";
        try {
            DpOperationsBase exportTechnicalSupportFile = new ExportConfigurationFile();
            String partialFileName = properties.get("deviceName").concat("_").concat("Support_");
            try {
                FileUtils.deleteFile(properties.get("fileDownloadPath"), partialFileName);
            } catch (NoSuchFileException e) {
            }
            DeviceOperationsHandler.viewDevice(properties.get("deviceName"));
            exportTechnicalSupportFile.operationMenuSubItemClick(WebUIStrings.getExportTechnicalSupportFile());
            exportedFileName = FileUtils.findFileByPartialName(properties.get("fileDownloadPath"), partialFileName);
        } catch (Exception e) {
        }
        if (exportedFileName != null && !exportedFileName.equals("")) {
            return true;
        }
        return false;
    }

    public static boolean updateSecuritySignatures(VisionRestClient visionRestClient, HashMap<String, String> properties) throws Exception {
        UpdateSecuritySignatures updateSecuritySignatures = new UpdateSecuritySignatures();
        String ssVersion = "";
        String fileName = properties.get("fileDownloadPath");
        if (properties.get("fileName") != null && !properties.get("fileName").equals("")) {
            fileName = fileName.concat(properties.get("fileName"));
        } else {
            if (properties.get("signatureType").equals(SignatureTypes.RADWARE_SIGNATURES.getType()) &&
                    properties.get("updateFromSource").equals(UpdateFromSource.UPDATE_FROM_CLIENT.getSource())) {
                String deviceMACAddress = getServerMACAddress(visionRestClient, properties.get("deviceName"), "rsWSDSysBaseMACAddress");
                fileName = FileUtils.getAbsoluteClassesPath() + FileUtils.getFileSeparator() + "Signatures";
                fileName = FileUtils.findFileByPartialName(fileName, deviceMACAddress.replace(":", ""));
            }
        }

        initLockDevice(properties);
        updateSecuritySignatures.operationMenuSubItemClick(WebUIStrings.getUpdateSecuritySignatures());
        updateSecuritySignatures.setSignatureType(properties.get("signatureType"));
        if (properties.get("signatureType").equals(SignatureTypes.RADWARE_SIGNATURES.getType())) {
            updateSecuritySignatures.setUpdateSource(properties.get("updateFromSource"));
            if (properties.get("updateFromSource").equals(UpdateFromSource.UPDATE_FROM_CLIENT.getSource())) {
                ssVersion = getSSVersion(fileName);
                String ssFileVersion = fileName.split("-")[1];
                if (ssVersion.equals(ssFileVersion)) return true;
                updateSecuritySignatures.updateFromClient(fileName);
            } else if (properties.get("updateFromSource").equals(UpdateFromSource.UPDATE_FROM_RADWARE.getSource())) {
                ssVersion = ValidateTasksHandler.getSignatureFileVersionFromSite();
                updateSecuritySignatures.clickButton(WebUIStrings.getSignaturesFromRadwareUpdate());
            }
            updateSecuritySignatures.clickButton(WebUIStrings.getDialogBoxCloseButton());
            waitForDeviceRestart(visionRestClient, properties);
            return ValidateTasksHandler.validateUpdateSecuritySignatureFiles(properties.get("deviceName"), ssVersion, properties.get("updateFromSource"));
        } else if (properties.get("signatureType").equals(SignatureTypes.RSA_SIGNATURES.getType())) {
            updateSecuritySignatures.clickButton(WebUIStrings.getUpdateRSAWidget());
            updateSecuritySignatures.clickButton(WebUIStrings.getDialogBoxCloseButton());
            waitForDeviceRestart(visionRestClient, properties);
            return ValidateTasksHandler.validateUpdateRSASecuritySignature(properties.get("deviceName"));
        }
        return false;
    }

    public static String getServerMACAddress(VisionRestClient visionRestClient, String deviceName, String scalar) {
        String scalarValue = DeviceScalarUtils.getScalarValueByKey(visionRestClient, DeviceUtils.getDeviceIp(visionRestClient, deviceName), scalar);
        return scalarValue;
    }


    public static boolean validateExportConfigurationFile(String clientServerVerify, String fileName, String filePath, String privateKey) {
        boolean result = false;
        ExportConfigurationFile exportConfigurationFile = new ExportConfigurationFile();
        if (clientServerVerify.equals(ExportPolicyDownloadTo.Client.getDownloadTo())) {
            result = FileUtils.validateFileDownload(fileName, filePath, false);
            if (result) {
                BasicOperationsHandler.delay(4); // Allow time for the file to get filled with content.
                result = privateKeyValidation(filePath, fileName, privateKey);
            }
        } else if (clientServerVerify.equals(ExportPolicyDownloadTo.Server.getDownloadTo())) {
            BasicOperationsHandler.delay(4);
            result = exportConfigurationFile.validateExportDpConfigurationFileToServer(fileName);
            DeviceBackupsHandler.downloadSelectedFile(fileName, "File Name");
            if (result) {
                BasicOperationsHandler.delay(2); // Allow time for the file to get filled with content.
                return privateKeyValidation(filePath, fileName, privateKey);

            }
        }

        return result;
    }

    public static String setExportSupportPartialFileName(Date date, String fileNameInitialPrefix) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd.MM.yyyy HH");

        String fileNamePart = fileNameInitialPrefix.concat(simpleDateFormat.format(date));//"Configuration_"
        return fileNamePart;
    }

    public static boolean privateKeyValidation(String filePath, String fileName, String privateKey) {
        String startKey = "BEGIN RSA PRIVATE KEY";
        String endKey = "END RSA PRIVATE KEY";
        String fileContent = FileUtils.getFileContent(filePath.concat(fileName));
        if (fileContent == null) {
            throw new IllegalStateException("File: " + filePath.concat(fileName) + " could not be found.");
        }
        if ("true".equals(privateKey)) {
            return fileContent.contains(startKey) && fileContent.contains(endKey);
        } else if ("false".equals(privateKey)) {
            return !fileContent.contains(startKey) && !fileContent.contains(endKey);
        } else {
            RestTestBase.report.report("private Key is not as expected! ", Reporter.FAIL);
            return false;
        }
    }

    public static String getSSVersion(String fileName) {
        String version = "";
        if (fileName != null && !fileName.equals("")) {
            int pos = fileName.lastIndexOf("-");
            version = fileName.substring(pos - 12, pos);
            version = version.replace("_", ".");
        }
        return version;
    }

    private static void waitForDeviceRestart(VisionRestClient visionRestClient, HashMap<String, String> properties) throws Exception {
        try {
            WebUIUtils.setIsTriggerPopupSearchEvent(false);
            BasicOperationsHandler.delay(120);
            handleYellowMessage();
            printYellowMessage();
            BasicOperationsHandler.delay(120);  // Make sure that the device is down
            DpWebUIUtils.waitForDeviceUp();
        } finally {
            WebUIUtils.setIsTriggerPopupSearchEvent(true);
            // Clear Popup message
            ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).getPopupHandler().handle();
        }
    }

    public static void handleYellowMessage() {
        String message = WebUIBasePage.waitForLastYellowMessage(10 * 1000);
        if (message != null && !message.contains("succeeded") && !message.contains("started")) {
            WebUIMessages.addMessage(message);
        }
    }

    public static void printYellowMessage() {
        String message = WebUIMessages.getLastMessage();
        if (!message.isEmpty()) {
            BaseTestUtils.report(message, Reporter.FAIL);
        }
        WebUIMessages.clear();
    }
}
