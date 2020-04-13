package com.radware.vision.automation.AutoUtils.SUT;

import lombok.Data;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.util.Properties;

@Data
public class SUT {

    private static RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
    private static final SUT instance = new SUT();


    private SUT() throws FileNotFoundException {
        Properties properties = loadApplicationProperties();

        properties.
                List<String> vmOptions = runtimeMXBean.getInputArguments();
    }

    private Properties loadApplicationProperties() throws FileNotFoundException {
        Properties properties = new Properties();
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream("environment/application.properties")) {
            properties.load(inputStream);
        } catch (IOException e) {
            throw new FileNotFoundException(e.getMessage());
        }
        return properties;
    }

    public static SUT getInstance() {
        return instance;
    }
}
