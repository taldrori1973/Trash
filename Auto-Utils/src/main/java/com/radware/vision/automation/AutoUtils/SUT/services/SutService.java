package com.radware.vision.automation.AutoUtils.SUT.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.automation.AutoUtils.SUT.dtos.*;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.*;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.DeviceConfiguration;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.servers.ServerPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.TreeDeviceNode;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.CliConfiguration;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.ClientConfiguration;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.DeployConfigurations;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeMap;
import org.modelmapper.TypeToken;

import java.lang.reflect.Type;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;


public class SutService {

    private String serverNameDao;
    private ModelMapper modelMapper;
    private ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();
    private DevicesDao devicesDao;
    private SetupDao setupDao;
    private SutDao sutDao;
    private ServersDao externalServersDao;
    private EnvironmentsDao environmentsDao;

    public SutService() {
        this.modelMapper = new ModelMapper();
        this.devicesDao = DevicesDao.get_instance();
        this.sutDao = SutDao.get_instance();
        if (this.sutDao.isLoadSimulators()) {
            this.devicesDao.addSimulatorsBySetID(sutDao.getSimulators());
        }
        this.setupDao = SetupDao.get_instance(sutDao.getSetupFileName());
        serverNameDao = sutDao.getServerName();
        this.externalServersDao = ServersDao.get_instance(applicationPropertiesUtils.getProperty("SUT.servers.externalServers.fileName"));
        this.environmentsDao = EnvironmentsDao.get_instance();
    }


    public String getSetupId() {
        return setupDao.getSetupId();
    }

    public String getVMName() {
        return this.sutDao.getServerName();
    }

    public PairDto getpair() {
        return modelMapper.map(this.sutDao.getPair(), PairDto.class);
    }

    public ClientConfigurationDto getVisionConfigurations() {
        ClientConfiguration clientConfiguration = this.sutDao.findClientConfiguration();
        return modelMapper.map(clientConfiguration, ClientConfigurationDto.class);
    }

    public CliConfigurationDto getVisionCliConfigurations() {
        CliConfiguration cliConfiguration = this.sutDao.findCliConfiguration();
        return modelMapper.map(cliConfiguration, CliConfigurationDto.class);
    }

    public DeployConfigurationsDto getDeployConfigurations() {
        DeployConfigurations deployConfigurations = this.sutDao.findDeployConfigurations();
        return modelMapper.map(deployConfigurations, DeployConfigurationsDto.class);
    }

    public List<String> getVisionSetupTreeSites() {
        List<Site> allSites = this.setupDao.findAllSites();
        return allSites.stream().map(Site::getName).collect(Collectors.toList());
    }

    public List<TreeDeviceManagementDto> getVisionSetupTreeDevices() {
        ModelMapper modelMapper = new ModelMapper();//this is special model mapper
        List<TreeDeviceManagementDto> treeDeviceManagementDtos;
        List<Device> allDevices = this.devicesDao.findAllDevices();
        List<TreeDeviceNode> allSetupDevices = this.setupDao.findAllDevices();

//        find the current setup devices
        List<Device> setupDevices = allDevices.stream().filter(device -> this.setupDao.isDeviceExistById(device.getDeviceId())).collect(Collectors.toList());

        Type listType = new TypeToken<List<TreeDeviceManagementDto>>() {
        }.getType();

        TypeMap<Device, TreeDeviceManagementDto> typeMap = modelMapper.createTypeMap(Device.class, TreeDeviceManagementDto.class)
                .addMapping(device -> device.getConfigurations().getName(), TreeDeviceManagementDto::setDeviceName)
                .addMapping(device -> device.getConfigurations().getType(), TreeDeviceManagementDto::setDeviceType)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getCliPassword(), TreeDeviceManagementDto::setCliPassword)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getCliPort(), TreeDeviceManagementDto::setCliPort)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getCliUsername(), TreeDeviceManagementDto::setCliUsername)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getHttpPassword(), TreeDeviceManagementDto::setHttpPassword)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getHttpUsername(), TreeDeviceManagementDto::setHttpUsername)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getHttpsPassword(), TreeDeviceManagementDto::setHttpsPassword)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getHttpsUsername(), TreeDeviceManagementDto::setHttpsUsername)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getManagementIp(), TreeDeviceManagementDto::setManagementIp)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getSnmpV1ReadCommunity(), TreeDeviceManagementDto::setSnmpV1ReadCommunity)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getSnmpV1WriteCommunity(), TreeDeviceManagementDto::setSnmpV1WriteCommunity)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getSnmpV2ReadCommunity(), TreeDeviceManagementDto::setSnmpV2ReadCommunity)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getSnmpV2WriteCommunity(), TreeDeviceManagementDto::setSnmpV2WriteCommunity)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getSnmpV3AuthenticationProtocol(), TreeDeviceManagementDto::setSnmpV3AuthenticationProtocol)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getSnmpV3PrivacyProtocol(), TreeDeviceManagementDto::setSnmpV3PrivacyProtocol)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getSnmpVersion(), TreeDeviceManagementDto::setSnmpVersion)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getVerifyHttpCredentials(), TreeDeviceManagementDto::setVerifyHttpCredentials)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getVerifyHttpsCredentials(), TreeDeviceManagementDto::setVerifyHttpsCredentials)
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getVisionMgtPort(), TreeDeviceManagementDto::setVisionMgtPort);

        treeDeviceManagementDtos = modelMapper.map(setupDevices, listType);

        return treeDeviceManagementDtos;
    }

    public Optional<TreeDeviceManagementDto> getTreeDeviceManagementBySetId(String setId) {
        List<TreeDeviceManagementDto> visionSetupTreeDevices = getVisionSetupTreeDevices();
        return visionSetupTreeDevices.stream().filter(treeDeviceManagementDto -> treeDeviceManagementDto.getDeviceSetId().equals(setId)).findAny();

    }

    public Optional<ServerDto> getServerById(String serverId) {
        Optional<ServerPojo> serverFromPojo = this.externalServersDao.findServerById(serverId);
        if (!serverFromPojo.isPresent()) return Optional.empty();
        ServerDto serverDto = modelMapper.map(serverFromPojo.get(), ServerDto.class);
        return Optional.of(serverDto);
    }

    public String getDeviceParentSite(String deviceId) {
        Optional<TreeDeviceNode> deviceFromSetupOpt = this.setupDao.findDeviceById(deviceId);
        return deviceFromSetupOpt.map(TreeDeviceNode::getParentSite).orElse(null);
    }

    public Optional<JsonNode> getAddTreeDeviceRequestBodyAsJson(String deviceId) {
        Optional<Device> deviceById = this.devicesDao.findDeviceById(deviceId);
        if (!deviceById.isPresent()) return Optional.empty();
        Device device = deviceById.get();
        DeviceConfiguration configurations = device.getConfigurations();
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.valueToTree(configurations);
        if (Objects.isNull(jsonNode)) return Optional.empty();
        return Optional.of(jsonNode);
    }

    public String getSiteParent(String siteName) {
        Optional<Site> siteByName = this.setupDao.findSiteByName(siteName);
        return siteByName.map(Site::getParentSite).orElse(null);
    }

    public Optional<EnvironmentDto> getEnviorement(String env) {
        ModelMapper modelMapper = new ModelMapper();
//        List<EnvironmentDto> enviorments = environmentsDao.finallEnvironments();
        List<EnvironmentDto> enviorments = modelMapper.map(environmentsDao.findAllEnvironments(), new TypeToken<List<EnvironmentDto>>() {
        }.getType());
        return enviorments.stream().filter(environmentDto -> environmentDto.getName().equals(env)).findAny();

    }

}
