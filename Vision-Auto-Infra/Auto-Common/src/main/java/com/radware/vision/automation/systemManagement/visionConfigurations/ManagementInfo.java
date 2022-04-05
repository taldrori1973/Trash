package com.radware.vision.automation.systemManagement.visionConfigurations;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class ManagementInfo {

    private String macAddress;
    private String activeServerMacAddress;
    private String hostname;
    private String defenseFlowId;
    private String hardwarePlatform;
    private String version;
    private String build;


}
