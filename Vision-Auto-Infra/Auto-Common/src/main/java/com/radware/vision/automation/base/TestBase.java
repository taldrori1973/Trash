package com.radware.vision.automation.base;
/*

 */

import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;
import com.radware.vision.automation.AutoUtils.SUT.dtos.CliConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.systemManagement.licenseManagement.LicenseGenerator;
import com.radware.vision.automation.systemManagement.serversManagement.ServersManagement;
import com.radware.vision.automation.systemManagement.visionConfigurations.ManagementInfo;
import com.radware.vision.automation.systemManagement.visionConfigurations.VisionConfigurations;

import java.time.LocalDateTime;


public abstract class TestBase {

    protected static SUTManager sutManager;
    protected static VisionConfigurations visionConfigurations;
    protected static ServersManagement serversManagement;

    protected static ManagementInfo managementInfo;
    protected static ClientConfigurationDto clientConfigurations;
    protected static CliConfigurationDto cliConfigurations;
    protected static LocalDateTime testStartTime;

    static {
        sutManager = SUTManagerImpl.getInstance();
        visionConfigurations = new VisionConfigurations();
        LicenseGenerator.MAC_ADDRESS = visionConfigurations.getManagementInfo().getMacAddress();
        serversManagement = new ServersManagement();

        managementInfo = getVisionConfigurations().getManagementInfo();
        clientConfigurations = getSutManager().getClientConfigurations();
        cliConfigurations = getSutManager().getCliConfigurations();
        testStartTime =LocalDateTime.now();
    }

    public  static ServersManagement getServersManagement() {return serversManagement; }

    public static VisionConfigurations getVisionConfigurations() {
        return visionConfigurations;
    }

    public static SUTManager getSutManager() {
        return sutManager;
    }

    public static LocalDateTime getTestStartTime(){return testStartTime;}
}
