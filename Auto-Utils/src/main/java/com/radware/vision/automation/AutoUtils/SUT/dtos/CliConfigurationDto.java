package com.radware.vision.automation.AutoUtils.SUT.dtos;

import lombok.Data;

@Data
public class CliConfigurationDto {
    private String radwareServerCliUserName;
    private String radwareServerCliPassword;
    private String rootServerCliUserName;
    private String rootServerCliPassword;
}
