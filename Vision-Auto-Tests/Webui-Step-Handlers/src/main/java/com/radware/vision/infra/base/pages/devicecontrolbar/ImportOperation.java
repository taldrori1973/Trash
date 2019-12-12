package com.radware.vision.infra.base.pages.devicecontrolbar;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.infra.enums.ExportPolicyDownloadTo;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.How;

import java.awt.*;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;

/**
 * Created by stanislava on 3/26/2015.
 */
public class ImportOperation extends DeviceControlBar {
    public ImportOperation() {
        super();
    }

    public void importFile(String uploadFrom, String fileName, String privateKeys, String fileDownloadPath) {
        setImportFrom(uploadFrom);
        setIncludePrivateKeys(privateKeys);
        if (uploadFrom.equals(ExportPolicyDownloadTo.Client.toString())) {
            //importFromClient(fileDownloadPath.concat(fileName));
            try {
                importFromClient(fileDownloadPath.concat(fileName), true);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (uploadFrom.equals(ExportPolicyDownloadTo.Server.toString())) {
            importFromServer(fileName);
        }
        clickButton(WebUIStringsVision.getDialogBoxClose());
    }

    private void setImportFrom(String uploadFrom) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getAlteonImportSource(uploadFrom));
        (new WebUIComponent(locator)).click();
    }

    public void importFromClient(String filepath, boolean ifClickImport) throws Exception {
        ComponentLocator buttonLocator = null;
        try {
            WebUIUtils.isTriggerPopupSearchEvent4FreeTest = false;
            ComponentLocator locator2 = new ComponentLocator(How.ID, "gwt-debug-Upload-Custom");

            WebElement elementFinalUpload = WebUIUtils.fluentWait(locator2.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
            ((JavascriptExecutor) WebUIUtils.getDriver()).executeScript("arguments[0].setAttribute('style', 'display:block;')", elementFinalUpload);
            buttonLocator = new ComponentLocator(How.ID, "gwt-debug-FileUploadSubmit");
            boolean isLinux = System.getProperty("os.name").toLowerCase().contains("linux") || System.getProperty("os.name").toLowerCase().contains("unix");
            String fileLocation = filepath;
            if(!isLinux) {
                fileLocation = fileLocation.replace("/", "\\");
                fileLocation = fileLocation.replace("\\\\", "\\");
            }
            else {
                fileLocation = fileLocation.replace("\\", "/");
            }
            WebUIUtils.fluentWaitSendText(fileLocation, locator2.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        } catch (Exception e) {
            throw new IllegalStateException("Failed during setting file for upload.", e);
        } finally {
            if(ifClickImport) {
                Actions actions = new Actions(WebUIUtils.getDriver());
                WebUIComponent uploadElement = (new WebUIComponent(buttonLocator));
                actions.moveToElement(uploadElement.getWebElement());
                actions.click();
                actions.perform();
                WebUIUtils.isTriggerPopupSearchEvent4FreeTest = true;
            }
        }
    }

    private static void setFileNameToUpload(String fileName) throws Exception {
        setClipboardData(fileName);
        //native key strokes for CTRL, V and ENTER keys
        try {
            Robot robot = new Robot();
            robot.delay(1000);
            robot.keyPress(KeyEvent.VK_CONTROL);
            robot.keyPress(KeyEvent.VK_V);
            robot.keyRelease(KeyEvent.VK_V);
            robot.keyRelease(KeyEvent.VK_CONTROL);
            robot.delay(500);
            robot.keyPress(KeyEvent.VK_ENTER);
            robot.keyRelease(KeyEvent.VK_ENTER);
        } catch (AWTException e) {
            throw new Exception("Could NOT select " + fileName, e);
        }
    }

    public static void setClipboardData(String fileName) {
        StringSelection stringSelection = new StringSelection(fileName);
        Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
    }

    private void importFromServer(String fileName) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getAlteonFileSelectorWidget());
        WebUIDropdown dropdown = new WebUIDropdown();
        dropdown.setWebElement(new WebUIComponent(locator).getWebElement());
        if (fileName == null || fileName.equals("")) {
            dropdown.selectOptionByIndex(dropdown.getElementsCount(WebUIStrings.getDropdownListView()) - 1);
        } else {
            dropdown.selectOptionByText(fileName, WebUIStrings.getDropdownListView());
        }
        clickButton(WebUIStrings.getAlteonImportFromServerSubmit());
    }

    private void setIncludePrivateKeys(String privateKeys) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getAlteonImportIncludePrivateKeys());
        WebUICheckbox checkbox = new WebUICheckbox(locator);
        checkbox.setWebElement(new WebUIComponent(locator).getWebElement());
        if (privateKeys != null && !checkbox.isChecked()) {
            checkbox.check();
        }
        setPrivateKeys(privateKeys);

    }
    public void setPrivateKeys(String privateKeys) {
        if (privateKeys != null && !privateKeys.equals("")) {
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getAlteonImportPrivateKeysPassphrase());
            WebUITextField textField = new WebUITextField(locator);
            textField.setWebElement(new WebUIComponent(locator).getWebElement());
            textField.type(privateKeys);
        }
    }

    /*
     public void importFromClient(String fileName) throws Exception {
        ComponentLocator buttonLocator = null;
        try {
            ComponentLocator locator2 = new ComponentLocator(How.CLASS_NAME, "gwt-FileUpload");
            WebUIUtils.fluentWaitJSExecutor("arguments[0].setAttribute('style', 'display:\"\"')", WebUIUtils.SHORT_WAIT_TIME, false, locator2);

//WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//input[contains(@class,'gwt-FileUpload')]").getBy(), WebUIUtils.SHORT_WAIT_TIME, false).sendKeys(Keys.ENTER);
            WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//input[contains(@class,'gwt-FileUpload')]").getBy(), WebUIUtils.SHORT_WAIT_TIME, false).click();
            RobotUtils robotUtils = new RobotUtils();
            robotUtils.type(fileName);
            robotUtils.type(KeyEvent.VK_TAB);
            robotUtils.type(KeyEvent.VK_TAB);
            robotUtils.type(KeyEvent.VK_SPACE);

//            Robot robot = new Robot();
//            robot.keyPress(KeyEvent.VK_E);\\10.205.191.200\SHARED\JSYSTEM\DOWNLOADS\172.16.22.31
//            robot.keyPress(KeyEvent.VK_R);
//            robot.delay(500);
//            robot.keyPress(KeyEvent.VK_TAB);
//            robot.keyPress(KeyEvent.VK_TAB);
//            robot.keyPress(KeyEvent.VK_ENTER);

//            WebUIUtils.isTriggerPopupS\\10.205.191.200\Shared\JSystem\Downloads\172.16.22.31_config.txt       earchEvent4FreeTest = false;
//            ComponentLocator locator2 = new ComponentLocator(How.ID, "gwt-debug-Upload-Custom");
//
////            WebElement elementFinalUpload = WebUIUtils.fluentWait(locator2.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
//            WebUIUtils.fluentWaitJSExecutor("arguments[0].setAttribute('style', 'display:block')", WebUIUtils.SHORT_WAIT_TIME, false, locator2);
////            ((JavascriptExecutor) WebUIUtils.getDriver()).executeScript("arguments[0].setAttribute('style', 'display:block')", elementFinalUpload);
//            buttonLocator = new ComponentLocator(How.ID, "gwt-debug-FileUploadSubmit");
////            WebUIUtils.fluentWait(locator2.getBy(), WebUIUtils.SHORT_WAIT_TIME, false).sendKeys(fileName);
            WebUIUtils.fluentWaitSendText(fileName, locator2.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        } catch (Exception e) {
            throw new IllegalStateException("Failed during setting file for upload.", e);
        } finally {
            Actions actions = new Actions(WebUIUtils.getDriver());
            WebUIComponent uploadElement = (new WebUIComponent(buttonLocator));
            actions.moveToElement(uploadElement.getWebElement());
            actions.click();
            actions.perform();
            WebUIUtils.isTriggerPopupSearchEvent4FreeTest = true;
        }
    }
    * */
}
