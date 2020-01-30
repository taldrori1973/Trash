package com.radware.vision.restBddTests.utils;

public class UriUtils {

    public static String buildUrlFromProtocolAndIp(String protocol, String ip) {
        return String.format("%s://%s", protocol, ip);
    }
}
