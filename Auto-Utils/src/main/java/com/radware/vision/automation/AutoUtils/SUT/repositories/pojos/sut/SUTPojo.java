package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut;

import lombok.Data;

@Data
public class SUTPojo {
    private String setupFile;
    private ClientConfiguration clientConfiguration;
    private CliConfiguration cliConfiguration;
}
