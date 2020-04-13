package com.radware.vision.automation.AutoUtils.SUT;

import lombok.Data;

import java.io.IOException;
import java.io.InputStream;
import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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


    private static RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
    private static final SUT instance = new SUT();


    private SUT() {

        Properties properties = loadApplicationProperties();//load environment/application.properties file from resources


        String sutFileName = getSUTFileName(properties);
        String sutFileName1 = properties.getProperty("SUT.vmOptions.key");//returns the "-DSUT" as the key of the sut in vm options

//        Map<String, String> sutPaths = getSutProperties(sutArgument);


        List<String> vmOptions = runtimeMXBean.getInputArguments();
    }

    private String getSUTFileName(Properties properties) {
        String sutVmOption = properties.get(SUT_VM_OPTION_KEY_PROPERTY).toString();
        Pattern pattern = Pattern.compile("([^=]*)=([^=]*)");
        Matcher matcher = pattern.matcher(sutVmOption);
        if (matcher.matches())
            return matcher.group(2);

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
