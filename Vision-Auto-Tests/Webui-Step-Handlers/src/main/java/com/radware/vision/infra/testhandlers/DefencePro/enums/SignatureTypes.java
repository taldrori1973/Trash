package com.radware.vision.infra.testhandlers.DefencePro.enums;

/**
 * Created by stanislava on 3/24/2015.
 */
public enum SignatureTypes {

    RADWARE_SIGNATURES("RadwareSignatures"),
    RSA_SIGNATURES("RSASignatures");

    private String type;

    private SignatureTypes(String type) {
        this.type = type;
    }

    public String getType() {
        return this.type;
    }
}
