package com.radware.vision.infra.testhandlers.rbac.enums.dataVerifyEnums;

/**
 * Created by stanislava on 1/7/2015.
 */
public enum CertificateSubjectDefaultsFieldActions {
    COUNTRY_NAME("CountryName"),
    STATE_OR_PROVINCE_NAME("ProvinceName"),
    LOCALITY_NAME("LocallyName"),
    ORGANIZATION_NAME("OrganizationName"),
    ORGANIZATIONAL_UNIT_NAME("OrganizationUnitName"),
    EMAIL_ADDRESS("EMail");

    private String textValue;

    private CertificateSubjectDefaultsFieldActions(String textValue) {
        this.textValue = textValue;
    }

    public String getTextValue() {
        return this.textValue;
    }
}
