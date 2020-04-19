package com.radware.vision.automation.AutoUtils.utils;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.io.IOException;


public class JsonUtilities {


    public static <POJO> POJO loadJsonFile(String filePath, Class<POJO> type) {
        ObjectMapper objectMapper = new ObjectMapper();
        POJO pojo = null;
        try {
            pojo = objectMapper.readValue(new File(filePath), type);
        } catch (IOException e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }
        return pojo;
    }

}
