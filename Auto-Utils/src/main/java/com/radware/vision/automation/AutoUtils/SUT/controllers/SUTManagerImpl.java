package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.vision.automation.AutoUtils.SUT.dtos.*;
import com.radware.vision.automation.AutoUtils.SUT.services.SutService;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.SutDao;

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
    public String getServerName() {
        return this.sutService.getVMName();
    }

    @Override
    public Optional<TreeDeviceManagementDto> getDefenseFlow() {
        return this.sutService.getDefenseFlow();
    }

    @Override
    public Optional<TreeDeviceManagementDto> getFNM() {
        return this.sutService.getFNM();
    }

    public PairDto getpair() {
        return this.sutService.getPair();
    }

    @Override
    public SutDao getPairDao() {
        return this.sutService.getPairSutDao();
    }

    @Override
    public String getSetupId() {
        return this.sutService.getSetupId();
    }

    @Override
    public String getLinuxServerID() {
        return this.sutService.getLinuxServerID();
    }

    @Override
    public ClientConfigurationDto getClientConfigurations() {
        return this.sutService.getVisionConfigurations();
    }

    @Override
    public ClientConfigurationDto getPairConfigurations() {
        return this.sutService.getPairConfigurations();
    }

    @Override
    public CliConfigurationDto getCliConfigurations() {
        return this.sutService.getVisionCliConfigurations();
    }

    @Override
    public CliConfigurationDto getPairCliConfigurations() {
        return this.sutService.getPairCliConfigurations();
    }

    public DeployConfigurationsDto getDeployConfigurations() {

        return this.sutService.getDeployConfigurations();
    }

    @Override
    public DeployConfigurationsDto getPairDeployConfigurations() {
        return this.sutService.getPairDeployConfigurations();
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
    public Optional<TreeDeviceManagementDto> getTreeDeviceManagementFromDevices(String setId) {
        return this.sutService.getTreeDeviceManagementBySetIdFromDevices(setId);
    }

    public Optional<EnvironmentDto> getEnvironment() {
        return this.sutService.getEnviorement(getDeployConfigurations().getEnvironment());
    }


    @Override
    public Optional<ServerDto> getServerById(String serverId) {
        return this.sutService.getServerById(serverId);
    }

    public Optional<JsonNode> getAddTreeDeviceRequestBodyAsJson(String deviceId) {
        return this.sutService.getAddTreeDeviceRequestBodyAsJson(deviceId);
    }

    public Optional<EnvironmentDto> getPairEnvironment() {
        return this.sutService.getEnviorement(getPairDeployConfigurations().getEnvironment());
    }

    public Optional<EnvironmentDto> getDefenseFlowEnvironment() {
        return this.sutService.getEnviorement(getDefenseFlow().get().getEnvironment());
    }

    public List<TreeDeviceManagementDto> getVisionSetupTreeDevices() {
        return sutService.getVisionSetupTreeDevices();
    }

    @Override
    public List<TreeDeviceManagementDto> getSimulators() {
        return sutService.getSimulators();
    }

    @Override
    public List<InterfaceDto> getInterfaces() {
        return this.sutService.getInterfaces();
    }
}
