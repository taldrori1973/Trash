package com.radware.vision.restTestHandler;

import com.radware.vision.RestClientsFactory;
import com.radware.vision.RestStepResult;
import controllers.RestClientsManagement;
import models.RestResponse;
import models.StatusCode;
import models.config.DevicesConstants;
import restInterface.client.BasicAuthBasedRestClient;
import restInterface.client.SessionBasedRestClient;

public class RestClientsStepsHandler {

    public static RestStepResult currentVisionLogIn(String baseUri, String username, String password, String licenseKey) {

        return genericVisionLogIn(baseUri, null, username, password, licenseKey);
    }

    public static RestStepResult genericVisionLogIn(String baseUri, Integer port, String username, String password, String licenseKey) {

        RestResponse response;
        SessionBasedRestClient connection = RestClientsFactory.getVisionConnection(baseUri, port, username, password, licenseKey);

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

    public static RestStepResult alteonAppWallLogin(String deviceType, String baseUri, Integer port, String username, String password) {
        RestResponse response;
        StatusCode onSuccessStatusCode;
        BasicAuthBasedRestClient connection;

        switch (deviceType.toLowerCase()) {
            case "alteon":
                connection = RestClientsFactory.getAlteonConnection(baseUri, port, username, password);
                onSuccessStatusCode = DevicesConstants.ALTEON_ON_SUCCESS_STATUS_CODE;
                break;
            case "appwall":
                connection = RestClientsFactory.getAppWallConnection(baseUri, port, username, password);
                onSuccessStatusCode = DevicesConstants.APPWALL_ON_SUCCESS_STATUS_CODE;
                break;
            default:
                throw new IllegalArgumentException("Device type should be Alteon or AppWall");
        }

        response = connection.checkConnection();

        if (!response.getStatusCode().equals(onSuccessStatusCode)) {
            return new RestStepResult(response, onSuccessStatusCode);
        }

        connection.switchTo();
        return new RestStepResult(RestStepResult.Status.SUCCESS, "Ready to use");
    }

    public static RestStepResult onVisionVDirectLogin(String baseUri, Integer port, String username, String password) {
        RestResponse response;
        SessionBasedRestClient connection;

        connection = RestClientsFactory.getOnVisionVDirectConnection(baseUri, port, username, password);

        if (!connection.isLoggedIn()) {//then login

            response = connection.login();//the switch happen in the log in if success

            return new RestStepResult(response, DevicesConstants.V_DIRECT_ON_SUCCESS_STATUS_CODE);

        } else {//already logged in - should make it the current connection
            if (RestClientsManagement.getCurrentConnection().isPresent() &&
                    !RestClientsManagement.getCurrentConnection().get().equals(connection))
                connection.switchTo();//the connection already loggedIn , should make it as current rest connection
            return new RestStepResult(RestStepResult.Status.SUCCESS, "Ready to use");
        }
    }

    public static RestStepResult defenseFlowLogin(String baseUri, Integer port, String username, String password) {
        RestResponse response;
        SessionBasedRestClient connection;

        connection = RestClientsFactory.getDefenseFlowConnection(baseUri, port, username, password);

        if (!connection.isLoggedIn()) {//then login

            response = connection.login();//the switch happen in the log in if success

            return new RestStepResult(response, DevicesConstants.DEFENSE_FLOW_ON_SUCCESS_STATUS_CODE);

        } else {//already logged in - should make it the current connection
            if (RestClientsManagement.getCurrentConnection().isPresent() &&
                    !RestClientsManagement.getCurrentConnection().get().equals(connection))
                connection.switchTo();//the connection already loggedIn , should make it as current rest connection
            return new RestStepResult(RestStepResult.Status.SUCCESS, "Ready to use");
        }
    }
}
