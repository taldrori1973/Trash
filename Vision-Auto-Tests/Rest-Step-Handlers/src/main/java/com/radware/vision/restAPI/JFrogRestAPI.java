package com.radware.vision.restAPI;

import com.radware.vision.RestClientsFactory;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.restTestHandler.GenericStepsHandler;
import models.RestRequestSpecification;
import models.RestResponse;
import restInterface.client.NoAuthRestClient;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:33 PM
 */
public class JFrogRestAPI {

    private static ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();
    private String baseUri;
    private Integer connectionPort;
    private String repoName;
    private RestRequestSpecification restRequestSpecification;

    public JFrogRestAPI(String repoName) {
        this.baseUri = String.format(
                "%s://%s",
                applicationPropertiesUtils.getProperty("JFrog.artifactory.protocol"),
                applicationPropertiesUtils.getProperty("JFrog.artifactory.host")
        );

        this.connectionPort = Integer.parseInt(applicationPropertiesUtils.getProperty("JFrog.artifactory.port"));

        this.repoName = repoName;


    }

    public RestResponse sendRequest(String path) {
        NoAuthRestClient connection = RestClientsFactory.getNoAuthConnection(this.baseUri, this.connectionPort);
        connection.switchTo();
        this.restRequestSpecification = GenericStepsHandler.createNewRestRequestSpecification("/ThirdPartyAPIs/jfrog.json", "Get Artifact API");
        return null;

    }
}
