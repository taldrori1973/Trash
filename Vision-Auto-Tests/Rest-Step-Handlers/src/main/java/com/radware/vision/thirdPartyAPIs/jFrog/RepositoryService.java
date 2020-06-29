package com.radware.vision.thirdPartyAPIs.jFrog;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.restAPI.JFrogRestAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.pojos.ArtifactFolderPojo;
import models.RestResponse;
import models.StatusCode;

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
        ArtifactFolderPojo versionPojo;
        ArtifactFolderPojo branchPojo;
        ArtifactFolderPojo buildPojo;

        JFrogRestAPI jFrogRestAPI = new JFrogRestAPI(repoName);
        if (!version.equals("Latest")) {//go to the specific version folder
            RestResponse restResponse = jFrogRestAPI.sendRequest(version, StatusCode.OK);
            versionPojo = objectMapper.readValue(restResponse.getBody().getBodyAsString(), ArtifactFolderPojo.class);
        }

    }


    private <T> T sendRequestAndGetPojo(String path, StatusCode expectedStatusCode, Class<T> clazz) throws Exception {
        RestResponse restResponse = jFrogRestAPI.sendRequest(path, StatusCode.OK);
        return objectMapper.readValue(restResponse.getBody().getBodyAsString(), clazz);
    }
}
