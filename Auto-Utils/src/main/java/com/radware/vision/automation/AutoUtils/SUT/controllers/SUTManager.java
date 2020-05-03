package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ServerDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;

import java.util.List;
import java.util.Optional;

public interface SUTManager {

    String getSetupId();

    ClientConfigurationDto getClientConfigurations();

    List<String> getVisionSetupTreeSites();

    String getDeviceParentSite(String deviceId);

    Optional<TreeDeviceManagementDto> getTreeDeviceManagement(String setId);

    Optional<JsonNode> getAddTreeDeviceRequestBodyAsJson(String deviceId);

    Optional<ServerDto> getServerById(String serverId);
}
