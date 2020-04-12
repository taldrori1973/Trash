package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.Data;

import java.io.File;
import java.io.IOException;

@Data
public class Devices {

    private TreeDevices treeDevices;
    private NonTreeDevices nonTreeDevices;

    public static void main(String[] args) {
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            File file = new File("/devices.json");
            Devices devices = objectMapper.readValue(file, Devices.class);
            System.out.println(devices);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
