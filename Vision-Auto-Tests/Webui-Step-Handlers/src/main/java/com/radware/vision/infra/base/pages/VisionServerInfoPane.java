package com.radware.vision.infra.base.pages;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIWidget;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

public class VisionServerInfoPane {

    WebUIButton topologyTreeOpenCloseBtn;

    public VisionServerInfoPane() {
    }

    public static String getDeviceTypeFromName() {
        ComponentLocator locator = new ComponentLocator(How.CLASS_NAME, "device_name");
        WebUIWidget infoElement = new WebUIWidget(new WebUIComponent(locator));
        return infoElement == null ? "" : infoElement.getInnerText().substring(0, infoElement.getInnerText().indexOf(" "));

    }

    public String getDeviceStatus() {
        if (!isLabelExists(WebUIStrings.getInfoPaneDeviceStatus())) {
            return "";
        } else {
            return getInfoElementValue(getInfoElement(WebUIStrings.getInfoPaneDeviceStatus()));
        }
    }

    public String getDeviceLockedBy() {
        return getInfoElementValue(getInfoElement(WebUIStrings.getInfoPaneDeviceLockedBy()));
    }

    public String getDeviceType() {
        return getInfoElementValue(getInfoElement(WebUIStrings.getInfoPaneDeviceType()));
    }

    public String getDeviceHost() {
        return getInfoElementValue(getInfoElement(WebUIStrings.getInfoPaneDevicehoHost()));
    }

    public String getDeviceNameWithOutType() {
        ComponentLocator locator = new ComponentLocator(How.CLASS_NAME, "device_name");
        WebUIWidget infoElement = new WebUIWidget(new WebUIComponent(locator));
        return infoElement == null ? "" : infoElement.getInnerText().substring(infoElement.getInnerText().lastIndexOf(" ") + 1);
    }

    public String getDeviceName() {
        ComponentLocator locator = new ComponentLocator(How.CLASS_NAME, "device_name");
        WebUIWidget infoElement = new WebUIWidget(new WebUIComponent(locator));
        return infoElement == null ? "" : infoElement.getInnerText();
    }

    public String getInfoPanePropertyVersion(String propertyID) {
        return getInfoElementValue(getInfoElement(propertyID));
    }

    public String getDeviceVersion() {
        return getInfoElementValue(getInfoElement(WebUIStrings.getInfoPaneDeviceVersion()));
    }

    public boolean waitForDeviceStatusUp(long timeout) {
        if (getDeviceStatus() == null) {
            return true;
        }

        long startTime = System.currentTimeMillis();
        do {
            try {
                if (getDeviceStatus().equals("Up")) {
                    return true;
                }
            } catch (Exception e) {
//				Ignore
            }
        }
        while (System.currentTimeMillis() - startTime < timeout);
        return false;
    }

    public boolean isLabelExists(String locatorIdText) {
        ComponentLocator locator = new ComponentLocator(How.ID, locatorIdText);
        WebElement element = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        return element != null;
    }

    private WebUIWidget getInfoElement(String locatorIdText) {
        ComponentLocator locator = new ComponentLocator(How.ID, locatorIdText);
        WebUIWidget infoElement = new WebUIWidget(new WebUIComponent(locator));
        return infoElement;
    }

    private String getInfoElementValue(WebUIWidget infoElement) {
        return infoElement == null ? "" : infoElement.getInnerText();
    }
}
