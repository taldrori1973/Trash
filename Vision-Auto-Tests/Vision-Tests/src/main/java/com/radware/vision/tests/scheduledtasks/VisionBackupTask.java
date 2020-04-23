package com.radware.vision.tests.scheduledtasks;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.scheduledtasks.VisionBackupTaskHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.BackupDestinations;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskRunIntervalType;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.time.LocalTime;
import java.util.HashMap;

public class VisionBackupTask extends TasksDestination {
    public TaskType taskType = TaskType.APSOLUTE_VISION_CONFIGURATION_BACKUP;


    public String columnName;
    //public String ipAddress = "must be a real file server";

    private int runAfterInSeconds;


    @Test
    @TestProperties(name = "add APsolute Vision configuration Backup Task", paramsInclude = {"taskEnabled", "taskType", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "backupDestination",
            "protocol", "directory", "user", "ipAddress", "backupFileName", "password", "taskSchedRunTime", "runOnceDate", "taskSchedMinutes", "executeDeltaTime"})
    public void addAPsoluteVisionConfigurationBackupTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());
            taskPorperties.put("columnName", columnName);
            taskPorperties.put("taskType", String.valueOf(taskType));
            taskPorperties.put("backupDestination", backupDestination == null ? null : String.valueOf(backupDestination));
            if (backupDestination == BackupDestinations.EXTERNAL_LOCATION) {
                taskPorperties.put("protocol", String.valueOf(protocol));
                taskPorperties.put("directory", directory);
                taskPorperties.put("user", user);
                taskPorperties.put("ipAddress", ipAddress.getIpAddress());
                taskPorperties.put("backupFileName", backupFileName);
                taskPorperties.put("password", password);
            }

            VisionBackupTaskHandler.addTask(taskPorperties, backupDestination);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * to use returned param on the next test --> ${taskSchedRunTime}
     *
     * @throws Exception
     */

    @Test
    @TestProperties(name = "add APsolute Vision configuration Backup Task - runs daily and after a given seconds", paramsInclude = {"taskEnabled", "taskName", "taskDescription",
            "runAfterInSeconds", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "taskRunAlways", "backupDestination",
            "protocol", "directory", "user", "ipAddress", "backupFileName", "password"}
            , returnParam = {"taskSchedRunTime"})
    public void addADailyTaskRunsAfterGivenSeconds() throws Exception {
        try {

            taskSchedRunInterval = TaskRunIntervalType.RUN_DAILY;
            LocalTime visionCurrentTime = LocalTime.now();
            LocalTime taskScheduledTime = visionCurrentTime.plusSeconds(runAfterInSeconds);
            taskSchedRunTime = taskScheduledTime.getHour() + ":" + taskScheduledTime.getMinute() + ":" + taskScheduledTime.getSecond();

            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());
            taskPorperties.put("columnName", columnName);
            taskPorperties.put("taskType", String.valueOf(taskType));
            taskPorperties.put("backupDestination", backupDestination == null ? null : String.valueOf(backupDestination));
            if (backupDestination == BackupDestinations.EXTERNAL_LOCATION) {
                taskPorperties.put("protocol", String.valueOf(protocol));
                taskPorperties.put("directory", directory);
                taskPorperties.put("user", user);
                taskPorperties.put("ipAddress", ipAddress.getIpAddress());
                taskPorperties.put("backupFileName", backupFileName);
                taskPorperties.put("password", password);
            }

            VisionBackupTaskHandler.addTask(taskPorperties, backupDestination);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "edit APsolute Vision configuration Backup Task", paramsInclude = {"qcTestId", "taskEnabled", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime",
            "protocol", "directory", "user", "ipAddress", "backupFileName", "password", "taskSchedRunTime", "runOnceDate", "taskSchedMinutes"})
    public void editAPsoluteVisionConfigurationBackupTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());
            taskPorperties.put("columnName", columnName);
            taskPorperties.put("protocol", String.valueOf(protocol));
            taskPorperties.put("directory", directory);
            taskPorperties.put("user", user);
            taskPorperties.put("ipAddress", ipAddress.getIpAddress());
            taskPorperties.put("backupFileName", backupFileName);
            taskPorperties.put("password", password);

            VisionBackupTaskHandler.editTask(taskPorperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to edit task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    public TaskType getTaskType() {
        return taskType;
    }

    public void setTaskType(TaskType taskType) {
        this.taskType = taskType;
    }


    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public int getRunAfterInSeconds() {
        return runAfterInSeconds;
    }

    @ParameterProperties(description = "task scheduled time will be set to time now + runAfterInSeconds")
    public void setRunAfterInSeconds(int runAfterInSeconds) {
        this.runAfterInSeconds = runAfterInSeconds;
    }


}
