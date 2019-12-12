package com.radware.vision.infra.enums;

/**
 * Created by moaada on 7/30/2017.
 */
public enum ServerType {

    LOCAL("Local"),
    REMOTE("Remote"),
    WAN_LINK("WAN Link");

    private String serverType;

    ServerType(String serverType) {
        this.serverType = serverType;
    }

    public String getServerType() {
        return serverType;
    }
}
