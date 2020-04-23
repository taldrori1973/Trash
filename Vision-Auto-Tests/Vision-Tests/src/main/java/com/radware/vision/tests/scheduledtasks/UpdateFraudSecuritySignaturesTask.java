package com.radware.vision.tests.scheduledtasks;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.scheduledtasks.UpdateFraudSecuritySignaturesTaskHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskRunIntervalType;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.util.HashMap;

public class UpdateFraudSecuritySignaturesTask extends ScheduledTasksTestBase {
    TaskType taskType = TaskType.UPDATE_FRAUD_SECURITY_SIGNATURE;
    String deviceDestinations;
    String groupDestinations;
    String columnName;


    @Test
    @TestProperties(name = "Add Update Fraud Security Signatures Task", paramsInclude = {"qcTestId", "taskEnabled", "taskType", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "deviceDestinations", "groupDestinations",
            "taskSchedRunTime", "runOnceDate", "taskSchedMinutes", "executeDeltaTime"}, returnParam = {"taskSchedRunTime"})
    public void addUpdateRSASecuritySignatureTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());
            taskPorperties.put("columnName", columnName);
            taskPorperties.put("taskType", String.valueOf(taskType));
            taskPorperties.put("deviceDestinations", deviceDestinations);
            taskPorperties.put("groupDestinations", groupDestinations);
            UpdateFraudSecuritySignaturesTaskHandler.addTask(taskPorperties);
            if (taskSchedRunInterval != TaskRunIntervalType.RUN_MINUTES) {
                taskSchedRunTime = UpdateFraudSecuritySignaturesTaskHandler.taskEntity.getSchedule().getTime();
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Edit Update Fraud Security Signatures Task", paramsInclude = {"qcTestId", "taskEnabled", "taskName", "taskDescription",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "deviceDestinations", "groupDestinations",
            "taskSchedRunTime", "runOnceDate", "taskSchedMinutes"})
    public void editUpdateRSASecuritySignatureTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());
            taskPorperties.put("columnName", columnName);
            taskPorperties.put("deviceDestinations", deviceDestinations);
            taskPorperties.put("groupDestinations", groupDestinations);

            UpdateFraudSecuritySignaturesTaskHandler.editTask(taskPorperties);
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
}
