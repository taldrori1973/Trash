package com.radware.vision.infra.enums;

/**
 * Created by moaada on 8/1/2017.
 */
public enum IpVersion {

    IPV4("IPv4"),
    IPV6("IPv6");

    private String ipVer;

    IpVersion(String ipVer) {

        this.ipVer = ipVer;
    }

    public String getIpVer() {
        return ipVer;
    }
}
