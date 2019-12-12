package com.radware.vision.bddtests.dp.networkprotection;

import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.utils.DpWebUIUtils;
import testhandlers.Device;

public class DpNTestBase extends BddUITestBase {

    protected DpWebUIUtils dpUtils;


    public DpNTestBase() throws Exception {
        super();
        if (getDeviceName() != null) {
            try {
                updateNavigationParser(Device.getDeviceIp(getVisionRestClient(), getDeviceName()));
            }
            catch (Exception e){

            }
        }
        dpUtils = new DpWebUIUtils();
        dpUtils.setUp();
    }
}
