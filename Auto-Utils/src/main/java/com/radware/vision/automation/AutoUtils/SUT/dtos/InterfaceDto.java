package com.radware.vision.automation.AutoUtils.SUT.dtos;

import lombok.Data;

@Data
public class InterfaceDto {
    private String name;
    private String network;
    private String ip;

    public InterfaceDto() {}

    public InterfaceDto(String name, String network, String ip)
    {
        this.name = name;
        this.network = network;
        this.ip = ip;
    }
}
