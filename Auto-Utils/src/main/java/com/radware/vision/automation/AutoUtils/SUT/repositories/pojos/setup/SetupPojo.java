package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup;


import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class SetupPojo {
    @JsonInclude(JsonInclude.Include.NON_NULL)
    private String simulatorSet;
    private String setupId;
    private Tree tree;
    private String defenseFlowId;
    private String fnmId;

}
