package com.radware.vision.tests.scheduledtasks;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.scheduledtasks.VisionReporterBackupTaskHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.BackupDestinations;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.util.HashMap;

public class VisionReporterBackupTask extends TasksDestination {
    public TaskType taskType = TaskType.APSOLUTE_VISION_REPORTER_BACKUP;
    public String columnName;

    @Test
    @TestProperties(name = "add APsolute Vision Reporter Backup Task", paramsInclude = {"qcTestId", "taskEnabled", "taskType", "taskName", "taskDescription", "taskSchedRunInterval", "backupDestination",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime",
            "protocol", "directory", "user", "ipAddress", "backupFileName", "password", "taskSchedRunTime", "runOnceDate", "taskSchedMinutes", "executeDeltaTime"})
    public void addAPsoluteVisionReporterBackupTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());
            taskPorperties.put("columnName", columnName);
            taskPorperties.put("taskType", String.valueOf(taskType));
            taskPorperties.put("backupDestination", backupDestination == null ? null : String.valueOf(backupDestination));
            if (backupDestination.equals(BackupDestinations.EXTERNAL_LOCATION)) {
                taskPorperties.put("protocol", String.valueOf(protocol));
                taskPorperties.put("directory", directory);
                taskPorperties.put("user", user);
                taskPorperties.put("ipAddress", ipAddress.getIpAddress());
                taskPorperties.put("backupFileName", backupFileName);
                taskPorperties.put("password", password);
            }

            VisionReporterBackupTaskHandler.addTask(taskPorperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "edit APsolute Vision Reporter Backup Task", paramsInclude = {"qcTestId", "taskEnabled", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime",
            "protocol", "directory", "user", "ipAddress", "backupFileName", "password", "taskSchedRunTime", "runOnceDate", "taskSchedMinutes"})
    public void editAPsoluteVisionReporterBackupTask() throws Exception {
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

            VisionReporterBackupTaskHandler.editTask(taskPorperties);
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
}
