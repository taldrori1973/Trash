package com.radware.vision.infra.base.pages.devicecontrolbar;

import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.infra.enums.ExportPolicyDownloadTo;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 4/2/2015.
 */
public class ExportOperation extends DeviceControlBar {

    public ExportOperation() {
        super();
    }

    public void exportFile(String uploadFrom, String fileName, String privateKeys) {
        setExportFrom(uploadFrom);
        if(privateKeys != null && !privateKeys.equals("")) {
            setIncludePrivateKeys(privateKeys);
        }
        if (uploadFrom.equals(ExportPolicyDownloadTo.Server.toString())) {
            exportFromServer(fileName);
        }
        else{
            clickButton(WebUIStrings.getDialogBoxOkButton());
        }
    }

    private void exportFromServer(String fileName) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getAlteonExportFileName());
        WebUITextField textField = new WebUITextField(locator);
        if (fileName != null && !fileName.equals("")) {
            textField.setWebElement(new WebUIComponent(locator).getWebElement());
            textField.type(fileName);
        }
        clickButton(WebUIStrings.getDialogBoxOkButton());
    }

    private void setIncludePrivateKeys(String privateKeys) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getAlteonExportPrivateKeys());
        WebUICheckbox checkbox = new WebUICheckbox(locator);
        checkbox.setWebElement(new WebUIComponent(locator).getWebElement());
        if (!checkbox.isChecked()) {
            checkbox.check();
        }
        setPrivateKeys(privateKeys);
    }

    private void setExportFrom(String uploadFrom) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getAlteonExportSource(uploadFrom));
        (new WebUIComponent(locator)).click();
    }

//    public void setPrivateKeys(String privateKeys) {
//        if (privateKeys != null && !privateKeys.equals("")) {
//            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getAlteonPassphraseField());
//            WebUITextField textField = new WebUITextField(locator);
//            textField.setWebElement(new WebUIComponent(locator).getWebElement());
//            textField.type(privateKeys);
//        }
//    }
}
