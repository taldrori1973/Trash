package com.radware.vision.base;
/*

 */

import com.radware.automation.bdd.reporter.JSystemReporter4Bdd;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.systemManagement.VisionConfigurations;
import com.radware.vision.systemManagement.models.ManagementInfo;

public abstract class TestBase extends JSystemReporter4Bdd {

    protected static SUTManager sutManager;
    protected static VisionConfigurations visionConfigurations;

    protected static ManagementInfo managementInfo;
    protected static ClientConfigurationDto clientConfigurations;

    static {
        sutManager = SUTManagerImpl.getInstance();
        visionConfigurations = new VisionConfigurations();
        managementInfo = getVisionConfigurations().getManagementInfo();
        clientConfigurations = getSutManager().getClientConfigurations();
    }

    public static VisionConfigurations getVisionConfigurations() {
        return visionConfigurations;
    }

    public static SUTManager getSutManager() {
        return sutManager;
    }


}