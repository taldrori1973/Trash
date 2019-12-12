package com.radware.vision.bddtests;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.utils.PropertiesFilesUtils;
import com.radware.automation.webui.UIUtils;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.vision.base.WebUITestBase;

import java.io.IOException;

/**
 * Created by AviH on 05-Dec-17.
 */
public abstract class BddUITestBase extends WebUITestBase {
    private static boolean initOnceDateDebugIds = false;

    public BddUITestBase() throws Exception{
        super.uiInit();
        initDataDebugIds();
        WebUIDriver.setListenerScreenshotAfterFind(false);
        WebUIDriver.setListenerScreenshotAfterClick(false);
        UIUtils.reportErrorPopup = true;
    }

    public static void initDataDebugIds() {
        try {
            if (!initOnceDateDebugIds) {
                VisionDebugIdsManager.DEBUG_IDS = PropertiesFilesUtils.mapAllPropertyFiles("debugIds");
                initOnceDateDebugIds = true;
            }
        } catch (IOException e) {
            BaseTestUtils.report("Failed to uiInit data debug id's", e);
        }
    }
}
