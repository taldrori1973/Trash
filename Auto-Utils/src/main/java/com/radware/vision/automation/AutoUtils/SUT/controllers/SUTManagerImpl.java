package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.automation.AutoUtils.SUT.dtos.DeviceDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.SutDto;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Devices;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Setup;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.SUTPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
import com.radware.vision.automation.AutoUtils.SUT.utils.ApplicationPropertiesUtils;
import com.radware.vision.automation.AutoUtils.SUT.utils.RuntimeVMOptions;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

import static java.lang.String.format;
import static java.util.Objects.isNull;

/**
 * By Muhamad Igbaria (mohamadi) April 2020
 */

public class SUTManagerImpl implements SUTManager {

    //    Singleton Instance
    private static final SUTManager instance = new SUTManagerImpl();

    //    Constants
    private static final String SUT_VM_OPTION_KEY_PROPERTY = "SUT.vmOptions.key";
    private static final String SUT_FILES_PATH_PROPERTY = "SUT.path";
    private static final String SUT_SETUPS_FILES_PATH_PROPERTY = "SUT.setups.path";
    private static final String SUT_DEVICES_FILES_PATH_PROPERTY = "SUT.devices.path";
    private static final String DEVICES_FILE_NAME = "devices.json";


    private ApplicationPropertiesUtils applicationPropertiesUtils;
    private RuntimeVMOptions runtimeVMOptions;

    private SutDto sutDto;

    private SUTManagerImpl() {

        this.applicationPropertiesUtils = new ApplicationPropertiesUtils("environment/application.properties");
        this.runtimeVMOptions = new RuntimeVMOptions();


        String sutFileName = getSUTFileName();
        Devices allDevices = loadJsonFile(SUT_DEVICES_FILES_PATH_PROPERTY, DEVICES_FILE_NAME, Devices.class);

        SUTPojo sutPojo = loadJsonFile(SUT_FILES_PATH_PROPERTY, sutFileName, SUTPojo.class);

        Setup setup = loadJsonFile(SUT_SETUPS_FILES_PATH_PROPERTY, sutPojo.getSetupFile(), Setup.class);


        this.sutDto = new SutDto(allDevices, sutPojo, setup);

    }

    private <POJO> POJO loadJsonFile(String filePath, String fileName, Class<POJO> type) {
        ObjectMapper objectMapper = new ObjectMapper();
        POJO pojo = null;
        try {
            pojo = objectMapper.readValue(
                    new File(getResourcesPath(format("%s/%s", applicationPropertiesUtils.getProperty(filePath), fileName))), type
            );
        } catch (IOException e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
        return pojo;
    }

    //    Interface Impl
    public String getSetupId() {
        return this.sutDto.getSetupId();
    }

    public VisionConfiguration getVisionConfiguration() {
        return this.sutDto.getVisionConfiguration();
    }

    public List<Site> getVisionSetupSites() {
        return this.sutDto.getSites();
    }

    public List<DeviceDto> getVisionSetupTreeDevices() {
        return this.sutDto.getTreeDevices();
    }

    private String getResourcesPath(String name) {
        return Objects.requireNonNull(getClass().getClassLoader().getResource(name)).getPath();
    }

    private String getSUTFileName() {
        try {
            String sutVmOptionsKey = this.applicationPropertiesUtils.getProperty(SUT_VM_OPTION_KEY_PROPERTY);
            if (isNull(sutVmOptionsKey) || sutVmOptionsKey.isEmpty()) {
                throw new NoSuchFieldException(format("The Property %s not found at environment/application.properties file", SUT_VM_OPTION_KEY_PROPERTY));
            }

            String sutFileName = this.runtimeVMOptions.getSUTFileName(sutVmOptionsKey);

            if (isNull(sutFileName) || sutFileName.isEmpty()) {
                throw new IllegalArgumentException(format("The sut file name is null or empty , validate that the vm option contains \"%s={filename}\" ", sutVmOptionsKey));
            }
            return sutFileName;

        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }

        return null;

    }

    public static SUTManager getInstance() {
        return instance;
    }
}
