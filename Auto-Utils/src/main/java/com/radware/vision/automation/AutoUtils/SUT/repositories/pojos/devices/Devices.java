package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Setup;
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
            File file = new File("C:\\GIT\\APSoluteVisionAutomation\\Auto-Utils\\src\\main\\java\\com\\radware\\vision\\automation\\AutoUtils\\SUT\\repositories\\pojos\\devices.json");
            Devices devices = objectMapper.readValue(file, Devices.class);
            File file2 = new File("C:\\GIT\\APSoluteVisionAutomation\\Auto-Utils\\src\\main\\java\\com\\radware\\vision\\automation\\AutoUtils\\SUT\\repositories\\pojos\\fullSetup.json");
            Setup setup = objectMapper.readValue(file2, Setup.class);
            System.out.println(devices);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
