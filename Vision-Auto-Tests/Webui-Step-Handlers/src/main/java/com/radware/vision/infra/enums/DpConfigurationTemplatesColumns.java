package com.radware.vision.infra.enums;

/**
 * Created by stanislava on 11/11/2014.
 */
public enum DpConfigurationTemplatesColumns {
    SOURCE_DEVICE_NAME("deviceName"),
    FILE_NAME("name"),
    FILE_TYPE("exportedFileType"),
    EXPORT_DATE("exportDate");

    private String columnNameSearch;

    private DpConfigurationTemplatesColumns(String columnNameSearch) {
        this.columnNameSearch = columnNameSearch;
    }

    public String getColumnNameSearch() {
        return this.columnNameSearch;
    }
}
