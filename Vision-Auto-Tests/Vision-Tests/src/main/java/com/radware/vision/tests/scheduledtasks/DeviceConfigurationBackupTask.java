package com.radware.vision.tests.scheduledtasks;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.automation.tools.utils.LinuxServerCredential;
import com.radware.vision.infra.testhandlers.scheduledtasks.DeviceConfigurationBackupTaskHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskRunIntervalType;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.time.LocalTime;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class DeviceConfigurationBackupTask extends TasksDestination {

    TaskType taskType = TaskType.DEVICE_CONFIGURATION_BACKUP;

    String deviceDestinations;
    String groupDestinations;
    String columnName;
    boolean includePrivateKeys = true;


    int runAfterInSeconds;


    @Test
    @TestProperties(name = "add Device configuration Backup Task", paramsInclude = {"qcTestId", "taskEnabled", "taskType", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "deviceDestinations", "groupDestinations",
            "includePrivateKeys", "taskSchedRunTime", "runOnceDate", "taskSchedMinutes", "executeDeltaTime", "backupDestination", "protocol", "directory", "user",
            "ipAddress", "backupFileName", "password"})
    public void addDeviceConfigurationBackupTask() throws Exception {
        try {
            deleteOldDeviceConfigBackupFiles(restTestBase.getLinuxServerCredential(restTestBase.getLinuxFileServer()), deviceDestinations, directory);
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());

            taskPorperties.put("columnName", columnName);
            taskPorperties.put("taskType", String.valueOf(taskType));
            taskPorperties.put("deviceDestinations", deviceDestinations);
            taskPorperties.put("groupDestinations", groupDestinations);
            taskPorperties.put("includePrivateKeys", String.valueOf(includePrivateKeys));
            taskPorperties.put("backupDestination", String.valueOf(backupDestination));
            taskPorperties.put("protocol", String.valueOf(protocol));
            taskPorperties.put("directory", directory);
            taskPorperties.put("user", user);
            taskPorperties.put("ipAddress", ipAddress.getIpAddress());
            taskPorperties.put("backupFileName", backupFileName);
            taskPorperties.put("password", password);

            DeviceConfigurationBackupTaskHandler.addTask(taskPorperties);
        } catch (Exception e) {
            report.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * to use returned param on the next test --> ${taskSchedRunTime}
     *
     * @throws Exception
     */


    @Test
    @TestProperties(name = "add Device configuration Backup Task - runs daily and after a given seconds",
            paramsInclude = {"qcTestId", "taskEnabled", "taskName", "taskDescription", "taskRunAlways", "runAfterInSeconds", "taskSchedStartDate",
                    "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "deviceDestinations", "groupDestinations", "includePrivateKeys",
                    "backupDestination", "protocol", "directory", "user", "ipAddress", "backupFileName", "password"}
            , returnParam = {"taskSchedRunTime"})
    public void addADailyTaskRunsAfterGivenSeconds() throws Exception {
        try {
            if (deviceDestinations != null) {
                deleteOldDeviceConfigBackupFiles(restTestBase.getLinuxServerCredential(restTestBase.getLinuxFileServer()), deviceDestinations, directory);
            }
            taskSchedRunInterval = TaskRunIntervalType.RUN_DAILY;
            LocalTime visionCurrentTime = LocalTime.now();
            LocalTime taskScheduledTime = visionCurrentTime.plusSeconds(runAfterInSeconds);
            taskSchedRunTime = taskScheduledTime.getHour() + ":" + taskScheduledTime.getMinute() + ":" + taskScheduledTime.getSecond();

            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());

            taskPorperties.put("columnName", columnName);
            taskPorperties.put("taskType", String.valueOf(taskType));
            taskPorperties.put("deviceDestinations", deviceDestinations);
            taskPorperties.put("groupDestinations", groupDestinations);
            taskPorperties.put("includePrivateKeys", String.valueOf(includePrivateKeys));
            taskPorperties.put("backupDestination", String.valueOf(backupDestination));
            taskPorperties.put("protocol", String.valueOf(protocol));
            taskPorperties.put("directory", directory);
            taskPorperties.put("user", user);
            taskPorperties.put("ipAddress", ipAddress.getIpAddress());
            taskPorperties.put("backupFileName", backupFileName);
            taskPorperties.put("password", password);

            DeviceConfigurationBackupTaskHandler.addTask(taskPorperties);
        } catch (Exception e) {
            report.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public void deleteOldDeviceConfigBackupFiles(LinuxServerCredential linuxServerCredential, String devicesList, String directoryPath) {
        List<String> deviceNameList = Arrays.asList(devicesList.split(","));
        for (String deviceName : deviceNameList) {
            FileUtils.deleteFileByPartialName(linuxServerCredential, deviceName, directoryPath);
        }
    }

    @Test
    @TestProperties(name = "edit Device configuration Backup Task", paramsInclude = {"qcTestId", "taskEnabled", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "deviceDestinations", "groupDestinations",
            "includePrivateKeys", "taskSchedRunTime", "runOnceDate", "taskSchedMinutes"})
    public void editDeviceConfigurationBackupTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());
            taskPorperties.put("columnName", columnName);
            taskPorperties.put("deviceDestinations", deviceDestinations);
            taskPorperties.put("groupDestinations", groupDestinations);
            taskPorperties.put("includePrivateKeys", String.valueOf(includePrivateKeys));

            DeviceConfigurationBackupTaskHandler.editTask(taskPorperties);
        } catch (Exception e) {
            report.report("Failed to edit task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public TaskType getTaskType() {
        return taskType;
    }

    public void setTaskType(TaskType taskType) {
        this.taskType = taskType;
    }

    public String getDeviceDestinations() {
        return deviceDestinations;
    }

    @ParameterProperties(description = "Specify devices List. Device names must be separated by <,>.")
    public void setDeviceDestinations(String deviceDestinations) {
        this.deviceDestinations = deviceDestinations;
    }

    public String getGroupDestinations() {
        return groupDestinations;
    }

    @ParameterProperties(description = "Specify Group List. Group names must be separated by <,>.")
    public void setGroupDestinations(String groupDestinations) {
        this.groupDestinations = groupDestinations;
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public boolean getIncludePrivateKeys() {
        return includePrivateKeys;
    }

    public void setIncludePrivateKeys(boolean includePrivateKeys) {
        this.includePrivateKeys = includePrivateKeys;
    }


    public int getRunAfterInSeconds() {
        return runAfterInSeconds;
    }

    @ParameterProperties(description = "task scheduled time will be set to time now + runAfterInSeconds")
    public void setRunAfterInSeconds(int runAfterInSeconds) {
        this.runAfterInSeconds = runAfterInSeconds;
    }
}
