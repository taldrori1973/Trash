package com.radware.vision.thirdPartyAPIs.jFrog.models;

import lombok.Data;

import java.util.List;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:42 PM
 */
@Data
public class ArtifactVersion extends ArtifactModel{
    private String versionName;

    private List<ArtifactBranch> branches;
}
