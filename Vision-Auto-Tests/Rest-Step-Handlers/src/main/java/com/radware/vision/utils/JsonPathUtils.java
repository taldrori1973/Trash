package com.radware.vision.utils;

import com.jayway.jsonpath.DocumentContext;

public class JsonPathUtils {
    public static boolean isPathExist(String path, DocumentContext documentContext) {
        try {
            documentContext.read(path);
        } catch (Exception e) {
            return false;
        }
        return true;
    }
}
