package com.radware.vision.tests.dp.accesscontrol.enums;

/**
 * Created by stanislava on 4/13/2015.
 */
public enum DetectorSecurityModules {
    ADMIN("Admin"),
    VISION_REPORTER("Vision Reporter"),
    SERVER_CRACKING("Server Cracking"),
    ANTI_SCAN("Anti-Scan"),
    CONNECTION_LIMIT("Connection Limit"),
    APPLICATION_SECURITY("Application Security"),
    SYN_PROTECTION("Syn Protection"),
    HTTP_FLOOD("HTTP Flood"),
    BEHAVIORAL_DOS("Behavioral DoS"),
    DNS_FLOOD("DNS Flood");

    private String module;

    private DetectorSecurityModules(String module) {
        this.module = module;
    }

    public String getDetectorSecurityModule() {
        return this.module;
    }
}
