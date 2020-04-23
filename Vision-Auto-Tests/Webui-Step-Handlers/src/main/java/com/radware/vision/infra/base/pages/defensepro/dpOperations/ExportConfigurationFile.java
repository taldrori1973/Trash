package com.radware.vision.infra.base.pages.defensepro.dpOperations;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.system.deviceresources.DeviceResources;
import com.radware.vision.infra.base.pages.system.deviceresources.devicebackups.DeviceBackups;
import com.radware.vision.infra.enums.ExportPolicyDownloadTo;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import org.openqa.selenium.support.How;

import java.nio.file.NoSuchFileException;

/**
 * Created by stanislava on 3/19/2015.
 */
public class ExportConfigurationFile extends DpOperationsBase {

    static final long exportConfigToServerTimeout = 1 * 60 * 1000;

    public ExportConfigurationFile() {
        super();
    }

    public void setUploadFrom(String uploadFrom) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getExportConfigurationUploadFrom(uploadFrom));
        (new WebUIComponent(locator)).click();
    }

    private void exportToClient(String includePrivateKeys) {
        setIncludePrivateKeys(includePrivateKeys);
        clickButton(WebUIStrings.getDialogBoxOkButton());
    }

    private String exportToServer(String fileName, String includePrivateKeys) {
        setIncludePrivateKeys(includePrivateKeys);
        String fileNameToValidate = "";
        if (fileName != null && !fileName.equals("")) {
            setExportFileName(fileName);
        }
        fileNameToValidate = getExportFileName();
        clickButton(WebUIStrings.getDialogBoxOkButton());
        return fileNameToValidate;
    }

    private void setExportFileName(String fileName) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getExportConfigurationFileName());
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement(new WebUIComponent(locator).getWebElement());
        textField.type(fileName);
    }

    private String getExportFileName() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getExportConfigurationFileName());
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement(new WebUIComponent(locator).getWebElement());
        return textField.getValue();
    }


    private void setIncludePrivateKeys(String includePrivateKeys) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getExportIncludePrivateKeys());
        WebUICheckbox checkbox = new WebUICheckbox(locator);
        checkbox.setWebElement(new WebUIComponent(locator).getWebElement());
        if (includePrivateKeys.equals("true")) {
            checkbox.check();
        } else if (includePrivateKeys.equals("false")) {
            checkbox.uncheck();
        }
    }

    public String exportFileTo(String filePath, String uploadFrom, String fileName, String includePrivateKeys, String deviceName) {
        setUploadFrom(uploadFrom);
        String fileNameToValidate = "";
        if (uploadFrom.equals(ExportPolicyDownloadTo.Client.toString())) {
            try {
                FileUtils.deleteFile(filePath, deviceName.trim().concat("_config"));
            } catch (NoSuchFileException e) {
                e.printStackTrace();
            }
            exportToClient(includePrivateKeys);
            fileNameToValidate = fileNameToValidate.concat(deviceName).trim().concat("_config.txt");
        } else if (uploadFrom.equals(ExportPolicyDownloadTo.Server.toString())) {
            fileNameToValidate = (exportToServer(fileName, includePrivateKeys)).concat(".txt");
        }
        BaseTestUtils.report("Export file: " + fileNameToValidate, Reporter.PASS);
        return fileNameToValidate;
    }

    public boolean validateExportDpConfigurationFileToServer(String fileName) {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        DeviceResources deviceResources = menuPane.openSystemDeviceResources();
        DeviceBackups deviceBackups = deviceResources.deviceBackupsMenu();
        WebUITable table = deviceBackups.getDeviceBackupsTable();
        if (fileName != null && !fileName.equals("")) {
            return verifyConfigFileName(table, fileName);
        }
        return false;
    }

    public boolean verifyConfigFileName(WebUITable table, String fileName) {
        int fileNameColumn = 1;
        long startTime = System.currentTimeMillis();
        while (System.currentTimeMillis() - startTime < exportConfigToServerTimeout) {
            BasicOperationsHandler.refresh();
            table.analyzeTable("div");
            for (int i = 0; i < table.getRowCount(); i++) {
                if (table.getCellValue(i, fileNameColumn).equals(fileName)) {
                    return true;
                }
            }
        }
        return false;
    }

}
