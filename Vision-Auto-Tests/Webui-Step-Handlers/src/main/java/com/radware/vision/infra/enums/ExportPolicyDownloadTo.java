package com.radware.vision.infra.enums;

/**
 * Created by urig on 10/29/2014.
 */
public enum ExportPolicyDownloadTo {
    Client("Client"),
    Server("Server");

    String downloadTo;

    private ExportPolicyDownloadTo(String downloadTo) {
        this.downloadTo = downloadTo;
    }

    public String getDownloadTo() {
        return this.downloadTo;
    }

    public boolean isDownloadToClient() {
        return this.downloadTo.equals(Client);
    }

    public boolean isDownloadToServer() {
        return this.downloadTo.equals(Server);
    }
}
