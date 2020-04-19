package com.radware.vision.automation.AutoUtils.SUT.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ApplicationPropertiesUtils {


    private Properties properties;

    public ApplicationPropertiesUtils(String propertiesFilePath) {
        this.properties = new Properties();
        try (InputStream inputStream = getClass().getClassLoader().getResourceAsStream(propertiesFilePath)) {
            this.properties.load(inputStream);

        } catch (IOException e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
    }

    public String getProperty(String name) {
        return this.properties.getProperty(name);
    }

}
