package com.radware.vision.thirdPartyAPIs.jFrog;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.restAPI.JFrogRestAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactChildPojo;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactFolderPojo;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactPojo;
import models.RestResponse;
import models.StatusCode;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

import java.util.List;
import java.util.TreeSet;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:36 PM
 */
public class RepositoryService {

    private ObjectMapper objectMapper;

    private JFrogRestAPI jFrogRestAPI;

    public RepositoryService(String repoName) {
        this.objectMapper = new ObjectMapper();
        this.jFrogRestAPI = new JFrogRestAPI(repoName);
    }


    public void getBuild(FileType fileType, String version, String branch, Integer build) throws Exception {
        ArtifactFolderPojo buildPojo;

        ArtifactPojo artifactPojo = getPojo("", StatusCode.OK, ArtifactPojo.class);

        ArtifactFolderPojo versionPojo = getVersion(artifactPojo, version);

        ArtifactFolderPojo branchPojo = getBranch(versionPojo, branch);

        if (branchPojo == null) buildPojo = getBuild(versionPojo, build, fileType);//build under version
        else buildPojo = getBuild(branchPojo, build, fileType);//build under branch

        if (!version.equals("Latest")) {//go to the specific version folder
            RestResponse restResponse = jFrogRestAPI.sendRequest(version, StatusCode.OK);
            versionPojo = objectMapper.readValue(restResponse.getBody().getBodyAsString(), ArtifactFolderPojo.class);
        }

    }

    private ArtifactFolderPojo getBuild(ArtifactFolderPojo buildParent, Integer build, FileType fileType) throws Exception {
        if (build != 0) {//specific build
            if (isChildExistByUri(buildParent.getChildren(), build.toString())) {
                String path = buildParent.getPath().getPath().substring(1) + "/" + build;
                return getPojo(path, StatusCode.OK, ArtifactFolderPojo.class);
            } else
                throw new Exception(String.format("The Build \"%s\" not found under %s", build, buildParent.getPath().getPath()));
        } else {//latest build

//            Build builds Tree
            TreeSet<Integer> builds = new TreeSet<>();
            buildParent.getChildren().forEach(buildChildPojo -> builds.add(Integer.parseInt(buildChildPojo.getUri().getPath().substring(1))));
            build = getLastSuccessfulBuild(buildParent, fileType);
        }
        return null;
    }

    private Integer getLastSuccessfulBuild(ArtifactFolderPojo buildParent, FileType fileType) {
//            Build builds Tree
        TreeSet<Integer> builds = new TreeSet<>();
        buildParent.getChildren().forEach(buildChildPojo -> builds.add(Integer.parseInt(buildChildPojo.getUri().getPath().substring(1))));
        Integer last;

        while (!builds.isEmpty()) {
            last = builds.pollLast();
            String buildPath = buildParent.getPath().getPath().substring(1) + "/" + last;
            if (containsFileType(fileType, buildPath))
        }
        return null;
    }

    private boolean containsFileType(FileType fileType, String buildPath) throws Exception {
        ArtifactFolderPojo buildPojo = getPojo(buildPath, StatusCode.OK, ArtifactFolderPojo.class);
        return buildPojo.getChildren().stream().anyMatch(artifactChildPojo -> artifactChildPojo.getUri().getPath().endsWith(fileType.getExtension()));
    }

    private ArtifactFolderPojo getBranch(ArtifactFolderPojo branchParent, String branch) throws Exception {
        ArtifactFolderPojo branchPojo;
        if (branch == null) return null;//No branch in the hierarchy

        if (isChildExistByUri(branchParent.getChildren(), branch)) {
            String path = branchParent.getPath().getPath().substring(1) + "/" + branch;

            branchPojo = getPojo(path, StatusCode.OK, ArtifactFolderPojo.class);
        } else
            throw new Exception(String.format("The Branch \"%s\" not found under %s", branch, branchParent.getPath().getPath()));
        return branchPojo;
    }

    private ArtifactFolderPojo getVersion(ArtifactPojo artifactPojo, String version) throws Exception {
        ArtifactFolderPojo versionPojo;
        if (!version.equals("Latest")) {
            if (isChildExistByUri(artifactPojo.getChildren(), version)) {
                String path = artifactPojo.getPath().getPath().substring(1) + "/" + version;
                versionPojo = getPojo(path, StatusCode.OK, ArtifactFolderPojo.class);
            } else throw new Exception(String.format("The Version \"%s\" not found", version));
        } else {
            throw new NotImplementedException();
        }
        return versionPojo;
    }

    private boolean isChildExistByUri(List<ArtifactChildPojo> children, String child) {
        return children.stream().anyMatch(artifactChildPojo -> artifactChildPojo.getUri().getPath().equals("/" + child));
    }


    private <T> T getPojo(String path, StatusCode expectedStatusCode, Class<T> clazz) throws Exception {
        RestResponse restResponse = jFrogRestAPI.sendRequest(path, expectedStatusCode);
        return objectMapper.readValue(restResponse.getBody().getBodyAsString(), clazz);
    }
}
