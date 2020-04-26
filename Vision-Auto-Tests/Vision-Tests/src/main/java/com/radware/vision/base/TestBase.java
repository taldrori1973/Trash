package com.radware.vision.base;
/*

 */

import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.systemManagement.ServersManagement;
import com.radware.vision.systemManagement.VisionConfigurations;
import com.radware.vision.systemManagement.models.ManagementInfo;

public abstract class TestBase {

    protected static SUTManager sutManager;
    protected static VisionConfigurations visionConfigurations;
    protected static ServersManagement serversManagement;

    protected static ManagementInfo managementInfo;
    protected static ClientConfigurationDto clientConfigurations;

    static {
        sutManager = SUTManagerImpl.getInstance();
        visionConfigurations = new VisionConfigurations();
        serversManagement = new ServersManagement();

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
