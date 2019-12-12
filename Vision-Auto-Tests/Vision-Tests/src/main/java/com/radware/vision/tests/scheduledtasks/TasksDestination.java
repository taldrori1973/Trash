package com.radware.vision.tests.scheduledtasks;

import com.radware.vision.infra.testhandlers.scheduledtasks.enums.BackupDestinations;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.DestinationIpAddress;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.ProtocolType;
import jsystem.framework.ParameterProperties;

public abstract class TasksDestination extends ScheduledTasksTestBase {
    public ProtocolType protocol = ProtocolType.FTP;
    public String directory = "/root/temp";
    public String user = "root";
    public String backupFileName = "please change";
    public String password = "radware";

    DestinationIpAddress ipAddress = DestinationIpAddress.LINUX_FILE_SERVER_IP;
    BackupDestinations backupDestination = BackupDestinations.VISION_SERVER;


    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getBackupFileName() {
        return backupFileName;
    }

    @ParameterProperties(description = "Select file name")
    public void setBackupFileName(String backupFileName) {
        this.backupFileName = backupFileName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public DestinationIpAddress getIpAddress() {
        return ipAddress;
    }

    public void setIpAddress(DestinationIpAddress ipAddress) {
        this.ipAddress = ipAddress;
    }

    public ProtocolType getProtocol() {
        return protocol;
    }

    public void setProtocol(ProtocolType protocol) {
        this.protocol = protocol;
    }

    public String getDirectory() {
        return directory;
    }

    @ParameterProperties(description = "specify the full path")
    public void setDirectory(String directory) {
        this.directory = directory;
    }

    public BackupDestinations getBackupDestination() {
        return backupDestination;
    }

    public void setBackupDestination(BackupDestinations backupDestination) {
        this.backupDestination = backupDestination;
    }


}
