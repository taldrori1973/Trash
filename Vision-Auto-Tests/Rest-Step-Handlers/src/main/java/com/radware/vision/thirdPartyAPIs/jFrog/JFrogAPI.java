package com.radware.vision.thirdPartyAPIs.jFrog;

import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.models.JFrogFileModel;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:33 PM
 */
public class JFrogAPI {



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
    public static JFrogFileModel getBuild(FileType fileType, String repoName, String version, String branch, Integer build) throws Exception {
        if (version == null) version = "Latest";
        if (branch == null) branch = "master";
        if (build == null) build = 0;
        RepositoryService repositoryService=new RepositoryService(repoName);
        return repositoryService.getFile(fileType, version, branch, build);

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
    public static JFrogFileModel getBuild(FileType fileType, String repoName, String version, Integer build) throws Exception {
        if (version == null) version = "Latest";
        if (build == null) build = 0;
        RepositoryService repositoryService=new RepositoryService(repoName);

        return repositoryService.getFile(fileType, version, null, build);

    }

    /**
     * This method search for a build when the hierarchy is Repository--> Branch--> Build
      * @param fileType  file type to search for
     * @param build      desired build number
     * @param repoName  in which repository to search for a build i.e. local, release
     * @param branch    in which branch to search , if branch is null , will search on the default branch (master)
     * @return         The requested build file info
     */
    public static JFrogFileModel getBuild(FileType fileType,  Integer build, String repoName, String branch) throws Exception {
        if (branch == null || branch=="") branch = "master";
        if (build == null) build = 0;
        RepositoryService repositoryService=new RepositoryService(repoName);
        return repositoryService.getFile(fileType,build,branch);
    }
    /**
     * This method return the last extended build  from a given branch when the hierarchy is Repository--> Branch--> Build
     * @param fileType  file type to search for
     * @param repoName  in which repository to search for a build i.e. local, release
     * @param branch    in which branch to search , if branch is null , will search on the default branch (master)
     * @return          The Last extended build file info under a given branch
     */
    public static JFrogFileModel getLastExtendedBuildFromFeatureBranch(FileType fileType,String repoName, String branch) throws Exception {
        if (branch == null || branch=="") branch = "master";
        RepositoryService repositoryService=new RepositoryService(repoName);
        return repositoryService.getFileFromLastExtendedBuild(fileType,branch);
    }




}
