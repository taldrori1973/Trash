package com.radware.vision.thirdPartyAPIs.jenkins.models;

import lombok.Data;

import java.util.List;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:42 PM
 */
@Data
public class Artifact extends ArtifactModel {
    private String name;
    private List<ArtifactVersion> versions;
}
