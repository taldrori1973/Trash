package com.radware.vision.restTestHandler.Auth;

import com.radware.vision.RestClientsFactory;
import restInterface.client.SessionBasedRestClient;

public class RestClientsStepsHandler {

    public static boolean currentVisionLogIn(String baseUri, String username, String password, String licenseKey) {
        SessionBasedRestClient connection = RestClientsFactory.getVisionConnection(baseUri, null, username, password, licenseKey);
        connection.switchTo();
        if (!connection.isLoggedIn()) {
            connection.login();
        }
        return connection.isLoggedIn();
    }
}
