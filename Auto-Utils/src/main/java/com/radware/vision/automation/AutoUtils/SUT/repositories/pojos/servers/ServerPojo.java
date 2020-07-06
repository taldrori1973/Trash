package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.servers;

import lombok.Data;

@Data
public class ServerPojo {

    private String serverId;
    private String host;
    private String user;
    private String password;
    private boolean connectOnInit;

}
