package com.radware.vision.tests.dp.accesscontrol.enums;

/**
 * Created by stanislava on 4/13/2015.
 */
public enum ProtocolType {
    ANY("Any"),
    TCP("TCP"),
    UDP("UDP"),
    ICMP("ICMP"),
    IGMP("IGMP"),
    SCTP("SCTP"),
    GRE("GRE"),
    ICMPv6("ICMPv6"),
    L2TP("L2TP"),
    GTP("GTP"),
    IP_in_IP("IP in IP");

    private String type;

    private ProtocolType(String type) {
        this.type = type;
    }

    public String getProtocolType() {
        return this.type;
    }
}
