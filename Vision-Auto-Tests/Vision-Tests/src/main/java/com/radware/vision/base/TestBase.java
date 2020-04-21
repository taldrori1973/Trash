package com.radware.vision.base;
/*

 */

import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;
import com.radware.vision.systemManagement.VisionConfigurations;
import junit.framework.SystemTestCase4;

public abstract class TestBase extends SystemTestCase4 {

    private SUTManager sutManager;
    private VisionConfigurations visionConfigurations;

    public TestBase() {

        this.sutManager = SUTManagerImpl.getInstance();

        this.visionConfigurations = new VisionConfigurations();
    }

    public VisionConfigurations getVisionConfigurations() {
        return visionConfigurations;
    }

    public SUTManager getSutManager() {
        return sutManager;
    }
}
