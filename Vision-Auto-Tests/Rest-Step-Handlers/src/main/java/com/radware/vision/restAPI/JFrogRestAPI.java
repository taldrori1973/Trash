package com.radware.vision.restAPI;

import com.radware.vision.RestClientsFactory;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
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
    private String artifactName;

    public JFrogRestAPI(String artifactName) {
        this.baseUri = String.format(
                "%s://%s",
                applicationPropertiesUtils.getProperty("JFrog.artifactory.protocol"),
                applicationPropertiesUtils.getProperty("JFrog.artifactory.host")
        );

        this.connectionPort = Integer.parseInt(applicationPropertiesUtils.getProperty("JFrog.artifactory.port"));

        this.artifactName = artifactName;

    }

    public RestResponse sendRequest() {
        NoAuthRestClient connection = RestClientsFactory.getNoAuthConnection(this.baseUri, this.connectionPort);
        connection.switchTo();

    }
}
