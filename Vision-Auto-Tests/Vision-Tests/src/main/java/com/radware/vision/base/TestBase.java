package com.radware.vision.base;
/*

 */

import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;
import junit.framework.SystemTestCase4;

public abstract class TestBase extends SystemTestCase4 {

    private SUTManager sutManager;

    public TestBase() {

        this.sutManager = SUTManagerImpl.getInstance();
    }

    public SUTManager getSutManager() {
        return sutManager;
    }
}
