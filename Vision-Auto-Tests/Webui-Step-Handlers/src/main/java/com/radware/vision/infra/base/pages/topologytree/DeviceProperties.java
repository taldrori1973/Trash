package com.radware.vision.infra.base.pages.topologytree;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.automation.webui.widgets.impl.WebUIWidget;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.topologytree.devicecfg.EventNotification;
import com.radware.vision.infra.base.pages.topologytree.devicecfg.Snmp;
import com.radware.vision.infra.base.pages.topologytree.devicecfg.SshAccess;
import com.radware.vision.infra.base.pages.topologytree.devicecfg.WebAccess;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.utils.MouseUtils;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

public class DeviceProperties extends WebUIVisionBasePage {

    public WebUIWidget addElementCommand;
    public WebUIWidget editElementCommand;
    public WebUIWidget deleteElementCommand;
    public WebUIWidget viewElementCommand;

    String locationComboName = "Location";
    String typeComboName = "Type";
    String nameTextBoxName = "Name";
    String mgmtIpName = "Management IP";

    protected DeviceProperties() {

    }

    public DeviceProperties(String deviceDriverFilename) {
        super("Device Properties", deviceDriverFilename, false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getFloatDeviceMngPanel());
    }

    public static void submit() {
        WebUIBasePage.submit(WebUIStrings.getDevicePropertiesSubmit());
        BasicOperationsHandler.delay(0.5);
    }

    public static void cancelDialog() {
        try {
            WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, WebUIStrings.getDevicePropertiesCancel()).getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
            if (element != null) {
                element.click();
            }
        } catch (Exception e) {
            //	Ignore
        } finally {
        }
    }

    public DeviceProperties openPage() {
        return (DeviceProperties) super.openPage();
    }

    public boolean waitForDialogClose(long timeout) {
        long startTimeout = System.currentTimeMillis();
        ComponentLocator deviceDialogLocator = new ComponentLocator(How.ID, "gwt-debug-FloatDeviceMngPanel");
        while (java.lang.System.currentTimeMillis() - startTimeout < timeout) {
            if (WebUIUtils.fluentWaitDisplayed(deviceDialogLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false) == null) {
                return true;
            } else {
                continue;
            }
        }
        return false;
    }

    public void setType(SUTDeviceType elementType) {
        WebUIDropdown deviceTypeCombo = (WebUIDropdown) container.getDropdown(typeComboName);
        deviceTypeCombo.selectOptionByText(elementType.getDeviceType());
    }

    public void setSiteType() {
        WebUIDropdown deviceTypeCombo = (WebUIDropdown) container.getDropdown(typeComboName);
        deviceTypeCombo.selectOptionByText("Site");
    }

    public void openAddNewElementDialog() {
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getAddNewDeviceCommand());
        openPage();
        BasicOperationsHandler.delay(0.5);
    }

    public void openManageVADCDialog() {
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getManageVADC());
        openPage();
//		BasicOperationsHandler.delay(1);
    }

    public void openEditElementDialog() {
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getEditElementCommand());
        openPage();
//		BasicOperationsHandler.delay(1);
    }

    public void deleteElement(String elementName) {
        WebUIButton deleteButton = new WebUIButton();
        deleteButton.setLocator(new ComponentLocator(How.ID, WebUIStrings.getDeleteElementCommand()));
        deleteButton.find(true, true);
        deleteButton.click();
    }

    public void selectTreeNode(String treeNodeName) {
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getDeviceTreeNode(treeNodeName));
        openPage();

        //to get rid of the device info when hovering on it
        MouseUtils.hover(new ComponentLocator(How.ID, WebUIStringsVision.getAlertsMaximizeButton()));

    }

    public void pinDevicesTree() {
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getPinDevicesTree());
        openPage();
    }

    public void setElementName(String elementName) {
        WebUITextField nameTextBox = (WebUITextField) container.getTextField(nameTextBoxName);
        nameTextBox.type(elementName);
    }

    public void viewDevice() {
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getViewDevice());
        openPage();
    }

    public Snmp mSnmp() {
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getSnmpGroup());
        super.openPage();
//        BasicOperationsHandler.delay(0.5);
        return new Snmp(getXmlFile());
    }

    public SshAccess mSsh() {
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getSshGroup());
        super.openPage();
//        BasicOperationsHandler.delay(0.5);
        return new SshAccess(getXmlFile());
    }

    public WebAccess mWebAccess() {
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getWebAccessGroup());
        super.openPage();
//        BasicOperationsHandler.delay(0.5);
        return new WebAccess(getXmlFile());
    }

    public EventNotification mEventNotification() {
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getEventNotificationGroup());
        super.openPage();
//        BasicOperationsHandler.delay(0.5);
        return new EventNotification(getXmlFile());
    }
}
