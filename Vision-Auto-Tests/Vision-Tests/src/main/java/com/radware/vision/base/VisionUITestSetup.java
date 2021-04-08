package com.radware.vision.base;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.UIUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.connection.VisionConnectionAuthentication;
import com.radware.automation.webui.utils.VisionUtils;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;
import com.radware.vision.infra.utils.VisionWebUIUtils;
import org.openqa.selenium.Cookie;

public class VisionUITestSetup extends VisionUITestBase {
    public VisionUITestSetup() {

    }

    public void setup() throws Exception {
        webUtils = new VisionWebUIUtils();
        UIUtils.setConnection(new VisionConnectionAuthentication());
        webUtils.setUp();
//      "automationFlag" reveals session storage elements and time filter
        String debugFlag = "/?automationFlag=true";
//        if (BaseTestUtils.isDebugMode())
////          add source logs
//            debugFlag = debugFlag.concat("&ed");
        String visionServerIp = getVisionServerIp();
        WebUIUtils.getDriver().get("https://" + visionServerIp + debugFlag);
//        webUtils.logIn(visionServerIp + debugFlag);

        try {
            BaseTestUtils.report("WebUI setUp", Reporter.PASS_NOR_FAIL);
        } catch (NullPointerException ignored) {
        }

        WebUIUtils.visionUtils = new VisionUtils();
        WebUIUtils.visionUtils.setUpVisionWeb(getVisionServerIp());

        //report.stopLevel();

        Cookie jsessionId = WebUIUtils.getDriver().manage().getCookieNamed("JSESSIONID");
        if (jsessionId != null) {
            browserSessionId = jsessionId.getValue();
            BaseTestUtils.report("Browser Session Id = " + browserSessionId, Reporter.PASS_NOR_FAIL);
        }

        //====================== initialize alteon and defensePro Products
        DeviceVisionWebUIUtils.init();
        //=====================================
    }

}
