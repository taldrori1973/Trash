package com.radware.vision.restAPI;

import com.radware.vision.thirdPartyAPIs.jFrog.ArtifactService;
import com.radware.vision.thirdPartyAPIs.jFrog.models.Artifact;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:33 PM
 */
public class JFrogRestAPI {

    private static ArtifactService artifactService;
    public static Artifact getArtifact(String artifactName){
        return artifactService.getArtifact(artifactName);
    }
}
