package com.radware.vision.systemManagement.models;

import com.radware.vision.RestClientsFactory;
import com.radware.vision.RestStepResult;
import com.radware.vision.restBddTests.utils.SutUtils;
import com.radware.vision.restBddTests.utils.UriUtils;
import com.radware.vision.systemManagement.controllers.VisionConfigurationsController;
import models.RestResponse;
import models.StatusCode;
import restInterface.client.SessionBasedRestClient;

import static com.radware.vision.restBddTests.utils.SutUtils.*;
import static com.radware.vision.restBddTests.utils.UriUtils.*;

public class VisionConfigurations {

    private VisionConfigurationsController visionConfigurationsController = new VisionConfigurationsController();

    private String macAddress;
    private String activeServerMacAddress;
    private String hostname;
    private String defenseFlowId;
    private String hardwarePlatform;
    private String version;
    private String build;

    public VisionConfigurations() {
        enableConnection();
    }

    private void enableConnection() {
//        send Login Request
        RestResponse response;
        String baseUri = null;
        try {
            String visionMac = null;
            baseUri = buildUrlFromProtocolAndIp(getCurrentVisionRestProtocol(), getCurrentVisionIp());
            String username = getCurrentVisionRestUserName();
            String password = getCurrentVisionRestUserPassword();
            String licenseKey = null;

            SessionBasedRestClient connection = RestClientsFactory.getVisionConnection(baseUri, null, username, password, licenseKey);
            RestResponse loginResult = connection.login();

//        if fail : check if it's because the license
//                  if because the license : get the MAC from response header and send another login request with the license activation
            if (loginResult.getStatusCode().equals(StatusCode.PAYMENT_REQUIRED)) {
                visionMac = loginResult.getHeaders().getOrDefault("Vision-MAC", null);


                if (visionMac == null)
                    throw new NoSuchFieldException("The Login returns 402 Payment Required and no \"Vision-MAC\" key was found in the response header.");
                else {//send new login request with activation Key

                }
            } else if (!loginResult.getStatusCode().equals(StatusCode.OK)) {
                throw new RuntimeException(String.format("the Login Fails because of the following error: %s", loginResult.getBody().getBodyAsString()));
            }
//                    else throw exception
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
    }

}
