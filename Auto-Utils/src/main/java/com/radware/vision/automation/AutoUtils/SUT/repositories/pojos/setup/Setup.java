package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup;


import lombok.Data;

import java.util.List;

@Data
public class Setup {

    private String setupId;
    private Tree tree;
    private List<Site> sites;
    private List<Device> devices;

}
