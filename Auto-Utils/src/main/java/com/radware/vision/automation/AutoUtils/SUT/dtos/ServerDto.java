package com.radware.vision.automation.AutoUtils.SUT.dtos;

import lombok.Data;

@Data
public class ServerDto {

    private String host;
    private String user;
    private String password;
    private boolean connectOnInit;

}
