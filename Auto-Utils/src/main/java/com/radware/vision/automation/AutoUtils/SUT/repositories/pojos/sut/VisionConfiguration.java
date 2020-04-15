package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut;

import lombok.Data;

@Data
public class VisionConfiguration {

    private String hostIp;
    private String userName;
    private String password;
    private RestConnection restConnection;

}
