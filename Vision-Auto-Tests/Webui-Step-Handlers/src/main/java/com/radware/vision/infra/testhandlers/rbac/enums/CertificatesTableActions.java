package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/29/2014.
 */
public enum CertificatesTableActions {
    NEW("NEW"),
    EDIT("EDIT"),
    DELETE("DELETE"),
    SEND_CERTIFICATE_FILE_TO_DEVICE("Send Certificate File To Device"),
    GET_CERTIFICATE_FILE_FROM_DEVICE("Get Certificate File From Device"),
    SHOW_CERTIFICATE_FILE_FROM_DEVICE("Show Certificate File From Device");

    private String tableAction;

    private CertificatesTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
