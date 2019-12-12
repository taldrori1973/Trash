package com.radware.vision.tests.scheduledtasks;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.scheduledtasks.UpdateFraudSecuritySignaturesTaskHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.UpdateSecuritySignatureFilesHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskRunIntervalType;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.util.HashMap;

public class UpdateSecuritySignatureFilesTask extends ScheduledTasksTestBase {
    public TaskType taskType = TaskType.UPDATE_SECURITY_SIGNATURE_FILES;

    String columnName;
    String deviceDestinations;
    String groupDestinations;


    @Test
    @TestProperties(name = "add Update Security Signature Files Task", paramsInclude = {"taskEnabled", "taskType", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "deviceDestinations", "taskSchedRunTime",
            "runOnceDate", "taskSchedMinutes", "executeDeltaTime"}, returnParam = {"taskSchedRunTime"})
    public void addNewTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());
            taskPorperties.put("columnName", columnName);
            taskPorperties.put("taskType", String.valueOf(taskType));
            taskPorperties.put("deviceDestinations", deviceDestinations);
            UpdateSecuritySignatureFilesHandler.addTask(taskPorperties);
            if (taskSchedRunInterval != TaskRunIntervalType.RUN_MINUTES) {
                taskSchedRunTime = UpdateFraudSecuritySignaturesTaskHandler.taskEntity.getSchedule().getTime();
            }
        } catch (Exception e) {
            report.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "edit Update Security Signature Files Task", paramsInclude = {"qcTestId", "taskEnabled", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "taskSchedRunTime", "runOnceDate", "taskSchedMinutes",
            "deviceDestinations", "groupDestinations"})
    public void editTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());
            taskPorperties.put("columnName", columnName);
            taskPorperties.put("deviceDestinations", deviceDestinations);
            taskPorperties.put("groupDestinations", groupDestinations);
            UpdateSecuritySignatureFilesHandler.editTask(taskPorperties);
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

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getDeviceDestinations() {
        return deviceDestinations;
    }

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
}
