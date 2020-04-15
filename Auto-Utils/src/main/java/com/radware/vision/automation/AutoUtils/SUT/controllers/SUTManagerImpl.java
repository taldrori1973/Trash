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
import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
    private static final String DEVICES_FILE_NAME = "treeDeviceNodes.json";


    private static RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
    private ApplicationPropertiesUtils applicationPropertiesUtils;
    private RuntimeVMOptions runtimeVMOptions;

    private SutDto sutDto;

    private SUTManagerImpl() {

        this.applicationPropertiesUtils = new ApplicationPropertiesUtils("environment/application.properties");
        this.runtimeVMOptions = new RuntimeVMOptions();

        try {
            ObjectMapper objectMapper = new ObjectMapper();


            String sutFileName = getSUTFileName(properties);
            Devices allDevices = objectMapper.readValue(
                    new File(getResourcesPath(format("%s/%s", applicationPropertiesUtils.getProperty(SUT_DEVICES_FILES_PATH_PROPERTY), DEVICES_FILE_NAME))), Devices.class
            );

            SUTPojo sutPojo = objectMapper.readValue(
                    new File(getResourcesPath(format("%s/%s", applicationPropertiesUtils.getProperty(SUT_FILES_PATH_PROPERTY), sutFileName))), SUTPojo.class
            );

            Setup setup = objectMapper.readValue(
                    new File(getResourcesPath(format("%s/%s", applicationPropertiesUtils.getProperty(SUT_SETUPS_FILES_PATH_PROPERTY), sutPojo.getSetupFile()))), Setup.class
            );


            this.sutDto = new SutDto(allDevices, sutPojo, setup);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private String getResourcesPath(String name) {
        return Objects.requireNonNull(getClass().getClassLoader().getResource(name)).getPath();
    }

    private String getSUTFileName(Properties properties) {
        try {
            String sutVmOption = null;//for example "-DSUT=example_sut.json"

            String sutVmOptionKey = properties.getProperty(SUT_VM_OPTION_KEY_PROPERTY);//get the key of sut file in vm options for example : "-DSUT"

            if (isNull(sutVmOptionKey))
                throw new NoSuchFieldException(format("The Property %s not found at environment/application.properties file", SUT_VM_OPTION_KEY_PROPERTY));

            List<String> vmOptions = runtimeMXBean.getInputArguments();//get vm options

            Optional<String> firstSut = vmOptions.stream().filter(vmOption -> vmOption.startsWith(sutVmOptionKey)).findFirst();//get first option which start with the value of sutVmOptionKey

            if (!firstSut.isPresent())
                throw new NoSuchFieldException(format("No VM Option Was found which start with \"%s\"", sutVmOptionKey));

            else sutVmOption = firstSut.get();

            Pattern pattern = Pattern.compile("([^=]*)=([^=]+)");
            Matcher matcher = pattern.matcher(sutVmOption);
            if (matcher.matches())
                return matcher.group(2);//return sut name

            throw new IllegalArgumentException(format("The sut vm option %s not matches the following pattern \"key=value\"", sutVmOption));
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }

        return null;

    }


    public static SUTManager getInstance() {
        return instance;
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

}
