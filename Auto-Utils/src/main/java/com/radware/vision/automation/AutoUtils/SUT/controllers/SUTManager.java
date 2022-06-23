package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.vision.automation.AutoUtils.SUT.dtos.*;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.SutDao;

import java.util.List;
import java.util.Optional;

public interface SUTManager {

    String getServerName();

    Optional<TreeDeviceManagementDto> getDefenseFlow();

    Optional<TreeDeviceManagementDto> getFNM();

    PairDto getpair();

    SutDao getPairDao();

    String getSetupId();

    String getLinuxServerID();

    ClientConfigurationDto getClientConfigurations();

    ClientConfigurationDto getPairConfigurations();

    CliConfigurationDto getCliConfigurations();

    CliConfigurationDto getPairCliConfigurations();

    DeployConfigurationsDto getDeployConfigurations();

    DeployConfigurationsDto getPairDeployConfigurations();

    List<String> getVisionSetupTreeSites();

    String getDeviceParentSite(String deviceId);


    String getSiteParent(String siteName);

    Optional<TreeDeviceManagementDto> getTreeDeviceManagement(String setId);

    Optional<TreeDeviceManagementDto> getTreeDeviceManagementFromDevices(String setId);

    List<TreeDeviceManagementDto> getVisionSetupTreeDevices();

    List<TreeDeviceManagementDto> getSimulators();

    List<InterfaceDto> getInterfaces();

    Optional<EnvironmentDto> getEnvironment();

    Optional<EnvironmentDto> getPairEnvironment();

    Optional<EnvironmentDto> getDefenseFlowEnvironment();

    /**
     * @param deviceId deviceId as on devices file
     * @return @{@link JsonNode} Object which contains the tree of the configurations section of the device ,
     * which is the same of the Post Request Body sent when adding new device to topology tree
     * note: all the values was set in the devices json file ,
     * except one value : parentOrmID , which should be set on runtime after getting the ormID of the site which the device should be added under,
     * to get the ormID should send Rest Request to get the topology tree and then get from the response site ormID
     */
    Optional<JsonNode> getAddTreeDeviceRequestBodyAsJson(String deviceId);

    Optional<ServerDto> getServerById(String serverId);
}
