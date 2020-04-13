package com.radware.vision.automation.AutoUtils.SUT;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
import lombok.Data;

@Data
public class SUT {
    private String setup;
    private VisionConfiguration visionConfiguration;

}
