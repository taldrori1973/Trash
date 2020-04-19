package com.radware.vision.automation.AutoUtils.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * Muhamad Igbaria (MohamadI)
 * Utility Class for getting properties file
 */
public class ApplicationPropertiesUtils {


    private Properties properties;

    /**
     * @param propertiesFilePath the file should be under the runner module resources folder
     */
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
