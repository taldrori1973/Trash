package com.radware.vision.automation.AutoUtils.SUT;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Devices;
import lombok.Data;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.lang.String.format;
import static java.util.Objects.isNull;

@Data
public class SUT {

//    SUT.vmOptions.key=-DSUT
//    SUT.path=\\sut
//    SUT.setups.path=\\sut\\setups
//    SUT.devices.path=\\sut\\devices

    private static final String SUT_VM_OPTION_KEY_PROPERTY = "SUT.vmOptions.key";
    private static final String SUT_FILES_PATH_PROPERTY = " SUT.path";
    private static final String SUT_SETUPS_FILES_PATH_PROPERTY = "SUT.setups.path";
    private static final String SUT_DEVICES_FILES_PATH_PROPERTY = "SUT.devices.path";
    private static final String DEVICES_FILE_NAME = "devices.json";


    private static RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
    private static final SUT instance = new SUT();


    private SUT() {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Properties properties = loadApplicationProperties();//load environment/application.properties file from resources


            String sutFileName = getSUTFileName(properties);
            Devices allDevices = objectMapper.readValue(
                    new File(getResourcesPath(format("%s/%s", SUT_DEVICES_FILES_PATH_PROPERTY, DEVICES_FILE_NAME))), Devices.class
            );


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


    private Map<String, String> getSutPaths(String sutArgument) {
        Map<String, String> pathsMap = new HashMap<>();
        return pathsMap;
    }

    private Properties loadApplicationProperties() {
        Properties properties = new Properties();

        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream("environment/application.properties")) {
            properties.load(inputStream);

        } catch (IOException e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
        return properties;
    }

    public static SUT getInstance() {
        return instance;
    }
}
