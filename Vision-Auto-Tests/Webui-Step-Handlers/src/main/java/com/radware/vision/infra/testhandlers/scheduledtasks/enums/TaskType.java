package com.radware.vision.infra.testhandlers.scheduledtasks.enums;

public enum TaskType {

    APSOLUTE_VISION_CONFIGURATION_BACKUP("APSolute Vision Configuration Backup"),
    APSOLUTE_VISION_REPORTER_BACKUP("APSolute Vision Reporter Backup"),
    DEVICE_REBOOT("Device Reboot"),
    UPDATE_SECURITY_SIGNATURE_FILES("Update Security Signature Files"),
    UPDATE_FRAUD_SECURITY_SIGNATURE("Update Fraud Security Signatures"),
    UPDATE_ATTACK_DESCRIPTION_FILE("Update Attack Description File"),
    DEVICE_CONFIGURATION_BACKUP("Device Configuration Backup"),
    OPERATOR_TOOLBOX("Operator Toolbox"),
    DP_CONFIGURATION_TEMPLATES("DefensePro Configuration Templates"),
    ERT_ACTIVE_ATTACKERS_FEED_For_DEFENSEPRO("ERT Active Attackers Feed for DefensePro"),
    TOR_FEED("ERT IP Reputation Feed for Alteon"),
    Update_GEO_Location_Feed("Geolocation Feed");


    String taskType;

    private TaskType(String taskType) {
        this.taskType = taskType;
    }

    public String getType() {
        return this.taskType;
    }

}
