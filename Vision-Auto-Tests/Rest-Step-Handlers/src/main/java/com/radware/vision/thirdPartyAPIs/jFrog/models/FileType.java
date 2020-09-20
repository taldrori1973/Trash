package com.radware.vision.thirdPartyAPIs.jFrog.models;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 2:58 PM
 */
public enum FileType {
    OVA("ova");

    private String extension;

    FileType(String extension) {
        this.extension = extension;
    }

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }
}
