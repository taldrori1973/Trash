package com.radware.vision.infra.enums;

public enum DpTemplateFileType {
    SERVER_PROTECTION("Server Protection", "server"),
    NETWORK_PROTECTION("Network Protection", "network");

    private String fileType;
    private String resourceFolderName;

    private DpTemplateFileType(String fileType, String resourceFolderName) {
        this.fileType = fileType;
        this.resourceFolderName = resourceFolderName;
    }

    public String getFileType() {
        return this.fileType;
    }

    public String getResourceFolderName() {
        return this.resourceFolderName;
    }
}
