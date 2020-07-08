package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ServerDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.AutoUtils.SUT.services.SutService;

import java.util.List;
import java.util.Optional;

/**
 * By Muhamad Igbaria (mohamadi) April 2020
 */

public class SUTManagerImpl implements SUTManager {

    //    Singleton Instance
    private static final SUTManager instance = new SUTManagerImpl();


    private SutService sutService;


    private SUTManagerImpl() {
        this.sutService = new SutService();
    }

    public static SUTManager getInstance() {
        return instance;
    }

    @Override
    public String getSetupId() {
        return this.sutService.getSetupId();
    }

    @Override
    public ClientConfigurationDto getClientConfigurations() {
        return this.sutService.getVisionConfigurations();
    }

    @Override
    public List<String> getVisionSetupTreeSites() {
        return this.sutService.getVisionSetupTreeSites();
    }

    @Override
    public String getDeviceParentSite(String deviceId) {
        return this.sutService.getDeviceParentSite(deviceId);
    }

    @Override
    public String getSiteParent(String siteName) {
        return this.sutService.getSiteParent(siteName);
    }

    @Override
    public Optional<TreeDeviceManagementDto> getTreeDeviceManagement(String setId) {
        return this.sutService.getTreeDeviceManagementBySetId(setId);
    }


    @Override
    public Optional<ServerDto> getServerById(String serverId) {
        return this.sutService.getServerById(serverId);
    }

    public Optional<JsonNode> getAddTreeDeviceRequestBodyAsJson(String deviceId) {
        return this.sutService.getAddTreeDeviceRequestBodyAsJson(deviceId);
    }
}
