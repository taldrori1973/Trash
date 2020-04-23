package com.radware.vision.tests.generalsettings.authenticationprotocols;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.WidgetsContainer;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.navigation.WebUIUpperBar;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.UpperBarItems;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.By;

public class RadiusSettingsTests extends WebUITestBase {

    String ipAddress;
    String port;
    String sharedSecret;
    String confirmSharedSecret;


    @Test
    @TestProperties(name = "update Radius settings", paramsInclude = {"ipAddress", "port", "sharedSecret", "confirmSharedSecret"})
    public void updateRadiusSettings() {

        if (ipAddress == null || sharedSecret == null || confirmSharedSecret == null) {
            BaseTestUtils.report("one or more of the following fields equal to null : ip address , shared secret , confirm shared secret");
        }

        try {
            WebUIUpperBar.select(UpperBarItems.VisionSettings);
            WidgetsContainer pageContainer = WebUIVisionBasePage.navigateToPage("System->General Settings->Authentication Protocols->RADIUS Settings").getContainer();
            if (!pageContainer.getIpv4TextFieldById("primaryRadiusIP").getValue().equals(ipAddress)) {
                pageContainer.getIpv4TextFieldById("primaryRadiusIP").type(ipAddress, true);
                if (port != null) {
                    pageContainer.getDropdown("Port").selectOptionByText(port);
                }

                pageContainer.getPasswordTextField("Shared Secret", "primarySharedSecret").type(sharedSecret);
                WebUIUtils.fluentWaitSendText(confirmSharedSecret, By.id("gwt-debug-primarySharedSecret_DuplicatePasswordField"), WebUIUtils.SHORT_WAIT_TIME, false);

                WebUIBasePage.submit();


                if (ipAddress.equals(pageContainer.getIpv4TextFieldById("primaryRadiusIP").getValue()) &&
                        port != null ? port.equals(pageContainer.getDropdown("Port").getValue()) : true) {
                    BasicOperationsHandler.takeScreenShot();
                    BaseTestUtils.report("Test succeeded", Reporter.PASS);
                } else {
                    BasicOperationsHandler.takeScreenShot();
                    BaseTestUtils.report("Failed to set some /all values", Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage());
        }
    }


    public String getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public String getSharedSecret() {
        return sharedSecret;
    }

    public void setSharedSecret(String sharedSecret) {
        this.sharedSecret = sharedSecret;
    }

    public String getConfirmSharedSecret() {
        return confirmSharedSecret;
    }

    public void setConfirmSharedSecret(String confirmSharedSecret) {
        this.confirmSharedSecret = confirmSharedSecret;
    }


}
