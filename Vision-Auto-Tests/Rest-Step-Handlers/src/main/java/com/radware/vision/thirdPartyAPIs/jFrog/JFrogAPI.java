package com.radware.vision.thirdPartyAPIs.jFrog;

import com.radware.vision.thirdPartyAPIs.jFrog.models.Artifact;
import com.radware.vision.thirdPartyAPIs.jFrog.models.Child;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:33 PM
 */
public class JFrogAPI {

    private static ArtifactService artifactService=new ArtifactService();
    public static Artifact getArtifact(String artifactName) throws Exception {
        return artifactService.getArtifact(artifactName);
    }
    public static Child getBuild(FileType fileType,String repoName,String version,String branch,Integer build)P

}
