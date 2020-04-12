package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos;

import lombok.Data;

import java.util.List;

@Data
public class TreeDevices {
    private List<Device> alteons;
    private List<Device> linkProofs;
    private List<Device> defensePros;
    private List<Device> appWalls;
}