package com.radware.vision;

import controllers.RestClientsManagement;
import models.config.DevicesConstants;
import restInterface.client.BasicAuthBasedRestClient;
import restInterface.client.SessionBasedRestClient;

import java.util.HashMap;
import java.util.Map;

import static java.util.Objects.isNull;

public class RestClientsFactory {

    private static final String VISION_KEY_TEMPLATE = "%s_%d_%s_%b";//{baseUri}_{connectionPort}_{username}_{isHaveLicense}
    private static Map<String, SessionBasedRestClient> visionRestClients;
    private static Map<String, SessionBasedRestClient> onVisionVDirectRestClients;
    private static Map<String, BasicAuthBasedRestClient> alteonRestClients;
    private static Map<String, BasicAuthBasedRestClient> appWallRestClients;

    static {
        visionRestClients = new HashMap<>();
        onVisionVDirectRestClients = new HashMap<>();
        alteonRestClients = new HashMap<>();
        appWallRestClients = new HashMap<>();
    }

    public static SessionBasedRestClient getVisionConnection(String baseUri, Integer connectionPort, String username, String password, String license) {
        if (isNull(baseUri)) throw new IllegalArgumentException("No baseUri was provided");

        connectionPort = !isNull(connectionPort) ? connectionPort : DevicesConstants.VISION_DEFAULT_PORT;

        String key = String.format(VISION_KEY_TEMPLATE, baseUri, connectionPort, username, !isNull(license));

        if (isNull(license)) {
            if (!visionRestClients.containsKey(key))
                visionRestClients.put(key, (SessionBasedRestClient) RestClientsManagement.getVisionConnection(baseUri, connectionPort, username, password));

        } else {
            if (!visionRestClients.containsKey(key))
                visionRestClients.put(key, (SessionBasedRestClient) RestClientsManagement.getVisionConnection(baseUri, connectionPort, username, password, license));
        }
        return visionRestClients.get(key);
    }


    public static SessionBasedRestClient getOnVisionVDirectConnection(String baseUri, Integer connectionPort, String username, String password, String license) {
        return onVisionVDirectRestClients.get("");
    }

    public static BasicAuthBasedRestClient getAlteonConnection(String baseUri, Integer connectionPort, String username, String password) {
        return alteonRestClients.get("");
    }

    public static BasicAuthBasedRestClient getAppWallConnection(String baseUri, Integer connectionPort, String username, String password) {
        return appWallRestClients.get("");
    }

}
