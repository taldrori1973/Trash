package com.radware.vision.base;
/*

 */

import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.systemManagement.licenseManagement.LicenseGenerator;
import com.radware.vision.systemManagement.serversManagement.ServersManagement;
import com.radware.vision.systemManagement.visionConfigurations.ManagementInfo;
import com.radware.vision.systemManagement.visionConfigurations.VisionConfigurations;


public abstract class TestBase {

    protected static SUTManager sutManager;
    protected static VisionConfigurations visionConfigurations;
    protected static ServersManagement serversManagement;

    protected static ManagementInfo managementInfo;
    protected static ClientConfigurationDto clientConfigurations;

    static {
        sutManager = SUTManagerImpl.getInstance();
        visionConfigurations = new VisionConfigurations();
        LicenseGenerator.MAC_ADDRESS = visionConfigurations.getManagementInfo().getMacAddress();
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
