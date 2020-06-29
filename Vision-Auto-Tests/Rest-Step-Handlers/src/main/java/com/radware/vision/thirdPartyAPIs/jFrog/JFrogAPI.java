package com.radware.vision.thirdPartyAPIs.jFrog;

import com.radware.vision.thirdPartyAPIs.jFrog.models.Artifact;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:33 PM
 */
public class JFrogAPI {

    private static ArtifactService artifactService;
    public static Artifact getArtifact(String artifactName){
        return artifactService.getArtifact(artifactName);
    }
}
