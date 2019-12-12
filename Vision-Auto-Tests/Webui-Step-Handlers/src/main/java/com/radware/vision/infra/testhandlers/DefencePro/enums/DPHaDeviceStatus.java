package com.radware.vision.infra.testhandlers.DefencePro.enums;

/**
 * Created by UriG on 1/19/2015.
 */
public enum DPHaDeviceStatus {

    PrimaryActive("dpOKHAACTIVE"),
    SecondaryInActive("dpOK"),
    SecondaryActive("dpOKACTIVE"),
    PrimaryInactive("dpOKHA");

    private String status;

    private DPHaDeviceStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }
}
