package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup;


import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.servers.ServerPojo;
import lombok.Data;

import java.util.List;

@Data
public class SetupPojo {

    private String setupId;
    private Tree tree;
    private String defenseFlowId;
    private List<ServerPojo> servers;

}
