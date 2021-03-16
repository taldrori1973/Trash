package com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums;

/**
 * Created by stanislava on 2/23/2017.
 */
public enum MemoryDbSize {
    DEFAULT_MEMORY_DB_SIZE("16384"),
    OVA_MEMORY_DB_SIZE("16384");

    private String memorySize;

    private MemoryDbSize(String memorySize) {
        this.memorySize = memorySize;
    }

    public String getMemorySize() {
        return this.memorySize;
    }
}
