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

    /**
     *  This method search for a build when the hierarchy is Version--> Branch--> Build
     * @param fileType  file type to search for
     * @param repoName  in which repository to search for a build i.e. local, release
     * @param version   desired version , if version is null will search in the latest version
     * @param branch    in which branch to search , if branch is null , will search on the default branch
     * @param build     desired build number , if null will search for last successful build under version and branch
     * @return
     */
    public static Child getBuild(FileType fileType,String repoName,String version,String branch,Integer build){
        return null;
    }

    public static Child getBuild(FileType fileType,String repoName,String version,Integer build){
        return null;
    }

}
