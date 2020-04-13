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
import java.util.regex.Pattern;

@Data
public class SUT {

    private static RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
    private static final SUT instance = new SUT();


    private SUT() {

        Properties properties = loadApplicationProperties();//load environment/application.properties file from resources

        String sutArgument = properties.getProperty("SUT.vmOptions.key");//returns the "-DSUT" as the key of the sut in vm options

        Map<String, String> sutPaths = getSutPaths(sutArgument);


        List<String> vmOptions = runtimeMXBean.getInputArguments();
    }

    private Map<String, String> getSutPaths(String sutArgument) {
        Map<String, String> pathsMap = new HashMap<>();
        Pattern pattern = Pattern.compile("([^=]*)=([^=]*)");
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
