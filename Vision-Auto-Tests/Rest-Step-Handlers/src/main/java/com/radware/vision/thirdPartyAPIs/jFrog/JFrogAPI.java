package com.radware.vision.thirdPartyAPIs.jFrog;

import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.thirdPartyAPIs.jFrog.models.Child;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:33 PM
 */
public class JFrogAPI {
    private static ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();


    /**
     * This method search for a build when the hierarchy is Version--> Branch--> Build
     *
     * @param fileType file type to search for
     * @param repoName in which repository to search for a build i.e. local, release
     * @param version  desired version , if version is null will search in the latest version
     * @param branch   in which branch to search , if branch is null , will search on the default branch
     * @param build    desired build number , if null or 0 will search for last successful build under version and branch
     * @return The requested build file info
     */
    public static Child getBuild(FileType fileType, String repoName, String version, String branch, Integer build) throws Exception {
        if (version == null) version = "Latest";
        if (branch == null) branch = applicationPropertiesUtils.getProperty("default.branch");
        if (build == null) build = 0;
        RepositoryService repositoryService=new RepositoryService(repoName);
        repositoryService.getBuild(fileType, version, branch, build);

        return null;
    }

    /**
     * This method search for a build when the hierarchy is Version--> Build
     *
     * @param fileType file type to search for
     * @param repoName in which repository to search for a build i.e. local, release
     * @param version  desired version , if version is null will search in the latest version
     * @param build    desired build number , if null will search for last successful build under version and branch
     * @return The requested build file info
     */
    public static Child getBuild(FileType fileType, String repoName, String version, Integer build) {
        if (version == null) version = "Latest";
        if (build == null) build = 0;
        repositoryService.getBuild(fileType, repoName, version, null, build);

        return null;
    }

}
