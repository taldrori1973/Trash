package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup;


import lombok.Data;

@Data
public class SetupPojo {

    private String simulatorSet;
    private boolean loadSimulators;
    private String setupId;
    private Tree tree;
    private String defenseFlowId;

}
