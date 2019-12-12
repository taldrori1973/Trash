package com.radware.vision.infra.enums;

/**
 * Created by stanislava on 9/8/2015.
 */
public enum VisionTableIDs {

    SELECT_TABLE_TO_WORK_WITH("",""),
    Server_Alarm("Server Alarm", "WarningThresholdsEntry"),
    Device_Drivers("Device Drivers", "DsvDriverVersionsEntry"),
    License("License", "VisionLicense"),
    Current_Utilization("Current Utilization", "Current.Utilization"),
    APM_Settings("APM Settings", "SharePath.SharePathConfig.Table"),
    APM_Enabled_Services("APM Enabled Services", "apmenabledservices"),
    APM_Enabled_Devices("APM Enabled Devices", "apmserversbydevices"),
    Maintenance_Files("Maintenance Files", "maintenance"),
    Upgrade_Log_Files("Upgrade Log Files", "upgrade"),
    Local_Users("Local Users", "User"),
    Permissions("Permissions", "roleGroupPairList"),
    Roles("Roles", "Role"),
    Currently_Connected_Users("Currently Connected Users", "CurrentlyUsersTable"),
    User_Statistics("User Statistics", "UserStatistics"),
    Device_Backups("Device Backups", "DeviceFile"),
    Task_List("Task List", "scheduledTasks"),
    DefensePro_Configuration_Templates("DefensePro Configuration Templates", "DPConfigurationTemplatesTable"),
    adminScriptTable("Script", "adminScriptTable"),
    ldapobjectpermission("ldapobjectpermission", "ldapobjectpermission"),
    roleGroupPairList("Role", "roleGroupPairList"),
    Alerts_Table("Alerts Table", "alerts");

    private String tableID;
    private String label;

    private VisionTableIDs(String labelName, String tableID) {
        this.tableID = tableID;
        this.label = labelName;
    }

    public String getVisionTableID() {
        return this.tableID;
    }
    public String getLabel() {
        return this.label;
    }
    public static VisionTableIDs getByLabel(String label) {
        for (VisionTableIDs e : VisionTableIDs.values())  {
            if (e.label.equals(label)) return e;
        }
        return null;
    }
}
