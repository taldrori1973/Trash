package com.radware.vision.automation.AutoUtils.SUT.services;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.automation.AutoUtils.SUT.dtos.CliConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ServerDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.DevicesDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.ServersDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.SetupDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.SutDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.DeviceConfiguration;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.servers.ServerPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.TreeDeviceNode;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.CliConfiguration;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.ClientConfiguration;
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

    private  String serverNameDao;
    private  String pairIpDao;
//    private  String pairEnvDao;
    private ModelMapper modelMapper;
    private ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();
    private DevicesDao devicesDao;
    private SetupDao setupDao;
    private SutDao sutDao;
    private ServersDao externalServersDao;

    public SutService() {
        this.modelMapper = new ModelMapper();
        this.devicesDao = DevicesDao.get_instance();
        this.sutDao = SutDao.get_instance();
        this.setupDao = SetupDao.get_instance(sutDao.getSetupFileName());
        serverNameDao = sutDao.getServerName();
        pairIpDao = sutDao.getpairIp();
//        pairEnvDao = sutDao.getpairEnv();
        this.externalServersDao = ServersDao.get_instance(applicationPropertiesUtils.getProperty("SUT.servers.externalServers.fileName"));
    }


    public String getSetupId() {
        return setupDao.getSetupId();
    }

    public String  getVMName() {
        return this.sutDao.getServerName();
    }
    public String getpairIp() {
        return this.sutDao.getpairIp();
    }
//    public String getPairEnv() {
//        return this.sutDao.getpairEnv();
//    }


    public ClientConfigurationDto getVisionConfigurations() {
        ClientConfiguration clientConfiguration = this.sutDao.findClientConfiguration();
        return modelMapper.map(clientConfiguration, ClientConfigurationDto.class);
    }
    public CliConfigurationDto getVisionCliConfigurations() {
        CliConfiguration cliConfiguration = this.sutDao.findCliConfiguration();
        return modelMapper.map(cliConfiguration, CliConfigurationDto.class);
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
                .addMapping(device -> device.getConfigurations().getDeviceSetup().getDeviceAccess().getManagementIp(), TreeDeviceManagementDto::setManagementIp);

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
}
