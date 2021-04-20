package com.radware.vision.bddtests.dp.networkprotection;

import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.utils.DpWebUIUtils;
import testhandlers.Device;

public class DpNTestBase extends VisionUITestBase {

    protected DpWebUIUtils dpUtils;


    public DpNTestBase() throws Exception {
        super();
        if (getDeviceName() != null) {
            try {
                updateNavigationParser(Device.getDeviceIp(restTestBase.getVisionRestClient(), getDeviceName()));
            }
            catch (Exception e){

            }
        }
        dpUtils = new DpWebUIUtils();
        dpUtils.setUp();
    }
}
