package com.radware.vision;

import controllers.RestClientsManagement;
import models.config.DevicesConstants;
import restInterface.client.BasicAuthBasedRestClient;
import restInterface.client.SessionBasedRestClient;

import java.util.HashMap;
import java.util.Map;

import static java.util.Objects.isNull;

public class RestClientsFactory {

    private static final String LICENSE_BASED_KEY_TEMPLATE = "%s_%d_%s_%b";//{baseUri}_{connectionPort}_{username}_{isHaveLicense}
    private static final String KEY_TEMPLATE = "%s_%d_%s";//{baseUri}_{connectionPort}_{username}
    private static Map<String, SessionBasedRestClient> visionRestClients;
    private static Map<String, SessionBasedRestClient> onVisionVDirectRestClients;
    private static Map<String, BasicAuthBasedRestClient> alteonRestClients;
    private static Map<String, BasicAuthBasedRestClient> appWallRestClients;
    private static Map<String, SessionBasedRestClient> defenseFlowRestClients;

    static {
        visionRestClients = new HashMap<>();
        onVisionVDirectRestClients = new HashMap<>();
        alteonRestClients = new HashMap<>();
        appWallRestClients = new HashMap<>();
        defenseFlowRestClients = new HashMap<>();
    }

    public static SessionBasedRestClient getVisionConnection(String baseUri, Integer connectionPort, String username, String password, String license) {
        if (isNull(baseUri)) throw new IllegalArgumentException("No baseUri was provided");

        connectionPort = !isNull(connectionPort) ? connectionPort : DevicesConstants.VISION_DEFAULT_PORT;

        String key = String.format(LICENSE_BASED_KEY_TEMPLATE, baseUri, connectionPort, username, !isNull(license));

        if (isNull(license)) {
            if (!visionRestClients.containsKey(key))
                visionRestClients.put(key, (SessionBasedRestClient) RestClientsManagement.getVisionConnection(baseUri, connectionPort, username, password));

        } else {
            if (!visionRestClients.containsKey(key))
                visionRestClients.put(key, (SessionBasedRestClient) RestClientsManagement.getVisionConnection(baseUri, connectionPort, username, password, license));
        }
        return visionRestClients.get(key);
    }


    public static SessionBasedRestClient getOnVisionVDirectConnection(String baseUri, Integer connectionPort, String username, String password) {
        String key = defaultKeyBuilder(baseUri, connectionPort, username);
        if (!onVisionVDirectRestClients.containsKey(key)) {
            onVisionVDirectRestClients.put(key, (SessionBasedRestClient) RestClientsManagement.getOnVisionVDirectConnection(baseUri, connectionPort, username, password));
        }
        return onVisionVDirectRestClients.get(key);
    }

    public static SessionBasedRestClient getDefenseFlowConnection(String baseUri, Integer connectionPort, String username, String password) {
        String key = defaultKeyBuilder(baseUri, connectionPort, username);
        if (!defenseFlowRestClients.containsKey(key)) {
            defenseFlowRestClients.put(key, (SessionBasedRestClient) RestClientsManagement.getDefenseFlowConnection(baseUri, connectionPort, username, password));
        }
        return defenseFlowRestClients.get(key);
    }

    public static BasicAuthBasedRestClient getAlteonConnection(String baseUri, Integer connectionPort, String username, String password) {

        String key = defaultKeyBuilder(baseUri, connectionPort, username);

        if (!alteonRestClients.containsKey(key)) {
            alteonRestClients.put(key, (BasicAuthBasedRestClient) RestClientsManagement.getAlteonConnection(baseUri, connectionPort, username, password));
        }
        return alteonRestClients.get(key);
    }

    public static BasicAuthBasedRestClient getAppWallConnection(String baseUri, Integer connectionPort, String username, String password) {
        String key = defaultKeyBuilder(baseUri, connectionPort, username);

        if (!appWallRestClients.containsKey(key)) {
            appWallRestClients.put(key, (BasicAuthBasedRestClient) RestClientsManagement.getAppWallConnection(baseUri, connectionPort, username, password));
        }
        return appWallRestClients.get(key);
    }

    private static String defaultKeyBuilder(String baseUri, Integer connectionPort, String username) {

        return String.format(KEY_TEMPLATE, baseUri, !isNull(connectionPort) ? connectionPort : 0, username);

    }

}
