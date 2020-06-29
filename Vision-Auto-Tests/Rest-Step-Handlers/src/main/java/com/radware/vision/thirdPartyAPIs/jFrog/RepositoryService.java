package com.radware.vision.thirdPartyAPIs.jFrog;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.restAPI.JFrogRestAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.models.Artifact;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactFolderPojo;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactPojo;
import models.RestResponse;
import models.StatusCode;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:36 PM
 */
public class RepositoryService {

    private ObjectMapper objectMapper;

    private JFrogRestAPI jFrogRestAPI ;

    public RepositoryService(String repoName) {
        this.objectMapper = new ObjectMapper();
        this.jFrogRestAPI=new JFrogRestAPI(repoName);
    }

    public Artifact getArtifact(String repoName) throws Exception {

        JFrogRestAPI jFrogRestAPI = new JFrogRestAPI(repoName);
        RestResponse repoResponse = jFrogRestAPI.sendRequest("", StatusCode.OK);

        if (!repoResponse.getStatusCode().equals(StatusCode.OK))
            throw new Exception(repoResponse.getBody().getBodyAsString());

        ArtifactPojo artifactPojo = this.objectMapper.readValue(repoResponse.getBody().getBodyAsString(), ArtifactPojo.class);

        Artifact artifact = mapPojoToModel(artifactPojo);
        return null;
    }

    private Artifact mapPojoToModel(ArtifactPojo artifactPojo) {
        return null;
    }

    public void getBuild(FileType fileType, String version, String branch, Integer build) throws Exception {
        ArtifactFolderPojo versionPojo;
        ArtifactFolderPojo branchPojo;
        ArtifactFolderPojo buildPojo;

        JFrogRestAPI jFrogRestAPI = new JFrogRestAPI(repoName);
        if (!version.equals("Latest")) {//go to the specific version folder
            RestResponse restResponse = jFrogRestAPI.sendRequest(version, StatusCode.OK);
            versionPojo = objectMapper.readValue(restResponse.getBody().getBodyAsString(), ArtifactFolderPojo.class);
        }

    }


    private <T> T sendRequestAndGetPojo(String path,StatusCode expectedStatusCode,Class<T> type){

    }
}
