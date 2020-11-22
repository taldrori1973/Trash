package com.radware.vision.utils;

public class UriUtils {

    public static String buildUrlFromProtocolAndIp(String protocol, String ip) {
        return String.format("%s://%s", protocol, ip);
    }
}
