package com.radware.vision.bddtests;

import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.utils.DpWebUIUtils;
import org.junit.Before;
import testhandlers.Device;

public class DpTestBaseBDD extends VisionUITestBase {
    protected DpWebUIUtils dpUtils;
    String defenceProVersion = "Mandatory Parameter";

    public DpTestBaseBDD() throws Exception {
    }

    @Before
    public void uiInit() throws Exception {
        if (getDeviceName() != null) {
            updateNavigationParser(Device.getDeviceIp(getVisionRestClient(), getDeviceName()));
        }
        dpUtils = new DpWebUIUtils();
        dpUtils.setUp();
    }


}
