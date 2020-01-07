package com.radware.vision.restTestHandler.Auth;

import com.radware.vision.RestClientsFactory;
import com.radware.vision.RestStepResult;
import controllers.RestClientsManagement;
import models.RestResponse;
import models.config.DevicesConstants;
import restInterface.client.SessionBasedRestClient;

public class RestClientsStepsHandler {

    public static RestStepResult currentVisionLogIn(String baseUri, String username, String password, String licenseKey) {
        RestResponse response;

        SessionBasedRestClient connection = RestClientsFactory.getVisionConnection(baseUri, null, username, password, licenseKey);

        if (!connection.isLoggedIn()) {//then login

            response = connection.login();//the switch happen in the log in if success

            return new RestStepResult(response, DevicesConstants.VISION_ON_SUCCESS_STATUS_CODE);

        } else {//already logged in - should make it the current connection
            if (RestClientsManagement.getCurrentConnection().isPresent() &&
                    !RestClientsManagement.getCurrentConnection().get().equals(connection))
                connection.switchTo();//the connection already loggedIn , should make it as current rest connection
            return new RestStepResult(RestStepResult.Status.SUCCESS, "Ready to use");
        }

    }

    public static RestStepResult genericVisionLogIn(String baseUri, Integer port, String username, String password, String licenseKey) {
        return null;
    }
}
