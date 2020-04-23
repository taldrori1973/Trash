package com.radware.vision.infra.base.pages.defensepro.dpOperations;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.automation.webui.widgets.impl.WebUIRadioGroup;
import com.radware.vision.infra.base.pages.devicecontrolbar.ImportOperation;
import com.radware.vision.infra.enums.ExportPolicyDownloadTo;
import com.radware.vision.infra.testhandlers.DefencePro.dpOperations.DPOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 3/18/2015.
 */
public class ImportConfigurationFile extends DpOperationsBase {

    public ImportConfigurationFile() {
        super();
    }

    public void setUploadFrom(String uploadFrom) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getImportConfigurationUploadFrom(uploadFrom));
        WebUIRadioGroup radio = new WebUIRadioGroup(locator);
        radio.selectOption(uploadFrom);
    }

    public void uploadFile(String uploadFrom, String fileName, String filePath, String deviceName) throws Exception {
        setUploadFrom(uploadFrom);
        ImportOperation importOperation = new ImportOperation();
        String fileNameToUse = filePath;
        if (uploadFrom.equals(ExportPolicyDownloadTo.Client.toString())) {
            if (fileName == null || fileName.equals("")) {
                fileNameToUse = fileNameToUse.concat(setDefaultFileName(deviceName));
            } else {
                fileNameToUse = fileNameToUse.concat(fileName);
            }
            if (!FileUtils.isFileExist(fileNameToUse)) {
                BaseTestUtils.report("No such file: " + fileNameToUse, Reporter.FAIL);
                throw new RuntimeException("No such file: " + fileNameToUse);
            } else {
                BaseTestUtils.report("Upload file: " + fileNameToUse, Reporter.PASS);
            }
            importOperation.importFromClient(fileNameToUse, true);//uploadFromClient(fileNameToUse);
            BasicOperationsHandler.delay(30);
            FileUtils.deleteFile(filePath, deviceName.concat("_config"));
        } else if (uploadFrom.equals(ExportPolicyDownloadTo.Server.toString())) {
            BaseTestUtils.report("Upload file: " + fileName, Reporter.PASS);
            uploadFromServer(fileName);
        }
        clickButton(WebUIStringsVision.getDialogBoxClose());
        DPOperationsHandler.handleYellowMessage();
    }

    private void uploadFromClient(String fileName) {
        String id = WebUIStrings.getBrowseToFileForDownloadWidget();
        WebElement element = WebUIUtils.fluentWaitDisplayed(By.id(id), WebUIUtils.SHORT_WAIT_TIME, false);
        element.sendKeys(fileName);
        clickButton(WebUIStrings.getFileForDownloadFromClientSubmit());
    }

    private void uploadFromServer(String fileName) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getDpFileSelectorWidget());
        WebUIDropdown dropdown = new WebUIDropdown();
        dropdown.setWebElement(new WebUIComponent(locator).getWebElement());
        if (fileName == null || fileName.equals("")) {
            dropdown.selectOptionByIndex(dropdown.getElementsCount(WebUIStrings.getDropdownListView()) - 2);
        } else {
            dropdown.selectOptionByText(fileName, WebUIStrings.getDropdownListView());
        }
        clickButton(WebUIStrings.getFileForDownloadFromServerSubmit());
    }

    private String setDefaultFileName(String deviceName) {
        String fileName = "";
        fileName = fileName.concat(deviceName).concat("_config.txt");
        return fileName;
    }
}
