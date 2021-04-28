package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.vision.automation.AutoUtils.SUT.dtos.*;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.Pair;

import java.util.List;
import java.util.Optional;

public interface SUTManager {

    String getServerName();

    Pair getpair();

    String getSetupId();

    String getEnvironmentName();

    ClientConfigurationDto getClientConfigurations();

    CliConfigurationDto getCliConfigurations();

    List<String> getVisionSetupTreeSites();

    String getDeviceParentSite(String deviceId);


    String getSiteParent(String siteName);

    Optional<TreeDeviceManagementDto> getTreeDeviceManagement(String setId);

    Optional<EnvironmentDto> getEnviorement();
    Optional<EnvironmentDto> getPairEnviorement();

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
