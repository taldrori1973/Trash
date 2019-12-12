package com.radware.vision.infra.base.pages.dptemplates;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.DpTemplateFileType;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.awt.*;
import java.awt.datatransfer.StringSelection;

public class DpUploadFileToServer extends WebUIVisionBasePage {
    public DpUploadFileToServer() {
        super("Upload File to Server", "DPConfigTemplates.UploadFileFromClientToDB.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getAlertsTab());
    }

    public void setFileType(DpTemplateFileType fileType) {
        WebUIDropdown combo = (WebUIDropdown) container.getDropdown("File Type");
        combo.selectOptionByText(fileType.getFileType());

    }

    public void browseNetwork(String fileType) {
        ComponentLocator locator;
        if (fileType.equals(DpTemplateFileType.NETWORK_PROTECTION.getFileType())) {
            locator = new ComponentLocator(How.ID, WebUIStringsVision.getDpBrowseNetworkButton());
        } else {
            locator = new ComponentLocator(How.ID, WebUIStringsVision.getDpBrowseServerButton());
        }
        (new WebUIComponent(locator)).click();

    }

    public void importSelectedFIle(String fileType) {
        try {
            WebUIUtils.setIsTriggerPopupSearchEvent(false);
            ComponentLocator locator;
            if (fileType.equals(DpTemplateFileType.NETWORK_PROTECTION.getFileType())) {
                locator = new ComponentLocator(How.ID, WebUIStringsVision.getNetworkDpTemplatesFileUploadButton());
            } else {
                locator = new ComponentLocator(How.ID, WebUIStringsVision.getServerDpTemplatesFileUploadButton());
            }
            (new WebUIComponent(locator)).click();
        }
        finally {
            WebUIUtils.setIsTriggerPopupSearchEvent(true);
        }
    }

    public void setClipboardData(String fileName) {
        StringSelection stringSelection = new StringSelection(fileName);
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
    }

    public void setFileNameToUpload(String fileName, String fileType) {
        String id;
        if (fileType.equals(DpTemplateFileType.NETWORK_PROTECTION.getFileType())) {
            id = WebUIStringsVision.getDpBrowseNetworkButton();
        } else {
            id = WebUIStringsVision.getDpBrowseServerButton();
        }

        WebElement El = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, id).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        El.sendKeys(fileName);
    }
}
