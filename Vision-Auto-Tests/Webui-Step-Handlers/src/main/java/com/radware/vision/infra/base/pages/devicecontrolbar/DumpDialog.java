package com.radware.vision.infra.base.pages.devicecontrolbar;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.*;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 3/23/2015.
 */
public class DumpDialog {
    WebUIWidget dumpDialog;
    WebUIButton saveDumpButton;
    WebUIButton closeDumpButton;

    public DumpDialog() {
        ComponentLocator locator = new ComponentLocator(How.XPATH, "//*[contains(@class,'" + "SlidingAreaFrame" + "')]");//"SlidingAreaFrame");
        dumpDialog = new WebUIWidget(new WebUIComponent(locator));
    }

    public void saveDumpButtonClick() {
        ComponentLocator applyButtonLocator = new ComponentLocator(How.XPATH, "//*[contains(@title,'" + "Save to File" + "')]");
        saveDumpButton = new WebUIButton(dumpDialog.findInner(applyButtonLocator));
        saveDumpButton.click();
    }

    public void includePrivateKeys(String privateKeys) {
        if (privateKeys != null && !privateKeys.equals("")) {
            setIncludePrivateKeys();
            setPrivateKeys(privateKeys);
        }
    }

    private void setPrivateKeys(String privateKeys) {
        ComponentLocator txtBoxLocator = new ComponentLocator(How.XPATH, "//*[contains(@class,'" + "gwt-PasswordTextBox gwt-PasswordTextBox-error" + "')]");
        WebUITextField textField = new WebUITextField(txtBoxLocator);
        textField.setWebElement(dumpDialog.findInner(txtBoxLocator).getWebElement());
        textField.type(privateKeys);
    }

    private void setIncludePrivateKeys() {
        ComponentLocator locator = new ComponentLocator(How.XPATH, "//input[contains(@id,'" + "gwt-uid-" + "')]");
        WebUICheckbox includePrivateKeysCheckbox = new WebUICheckbox(locator);
        includePrivateKeysCheckbox.setWebElement(dumpDialog.findInner(locator).getWebElement());
        includePrivateKeysCheckbox.check();
    }

    public void closeDumpDialogBox() {
        ComponentLocator applyButtonLocator = new ComponentLocator(How.XPATH, "//*[contains(@class,'" + "DefaultItemSmall DefaultItemSmall-Right CancelButton" + "')]");
        closeDumpButton = new WebUIButton(dumpDialog.findInner(applyButtonLocator));
        closeDumpButton.click();
    }

}
