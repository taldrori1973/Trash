package com.radware.vision.infra.testhandlers.scheduledtasks.enums;

/**
 * Created by stanislava on 9/21/2016.
 */
public enum BackupDestinations {
    VISION_SERVER("APSolute Vision Server"),
    EXTERNAL_LOCATION("External Location");

    private String backupDestination;

    private BackupDestinations(String backupDestination) {
        this.backupDestination = backupDestination;
    }

    public String getBackupDestination() {
        return this.backupDestination;
    }
}
