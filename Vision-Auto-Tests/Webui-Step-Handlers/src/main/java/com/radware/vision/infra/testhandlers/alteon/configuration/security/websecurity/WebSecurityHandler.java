package com.radware.vision.infra.testhandlers.alteon.configuration.security.websecurity;

import com.radware.automation.webui.webpages.configuration.security.webSecurity.WebSecurity;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by alexeys on 6/15/2015.
 */
public class WebSecurityHandler {

    private static WebSecurity webSecurity = DeviceVisionWebUIUtils.alteonUtils.alteonProduct
            .mConfiguration().mSecurity().mWebSecurity();
    public static void editWebSecuritySettings(HashMap<String, String> testProperties) {
        webSecurity.openPage();

    }
}
