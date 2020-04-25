package com.radware.vision.tests.dp;

import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.utils.DpWebUIUtils;
import org.junit.Before;
import testhandlers.Device;


public class DpTestBase extends WebUITestBase {

    protected DpWebUIUtils dpUtils;
    String defenceProVersion = "Mandatory Parameter";

    @Before
    public void uiInit() throws Exception {
        if (getDeviceName() != null) {
            updateNavigationParser(Device.getDeviceIp(getVisionRestClient(), getDeviceName()));
        }
        dpUtils = new DpWebUIUtils();
        dpUtils.setUp();
    }


}


