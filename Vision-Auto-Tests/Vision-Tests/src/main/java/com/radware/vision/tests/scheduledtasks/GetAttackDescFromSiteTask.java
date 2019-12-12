package com.radware.vision.tests.scheduledtasks;

import com.radware.vision.infra.testhandlers.scheduledtasks.GetAttackDescFromSiteTaskHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import jsystem.framework.TestProperties;
import com.radware.automation.tools.basetest.Reporter;;
import org.junit.Test;

import java.util.HashMap;

public class GetAttackDescFromSiteTask extends ScheduledTasksTestBase {
    public TaskType taskType = TaskType.UPDATE_ATTACK_DESCRIPTION_FILE;
    public String columnName;


    @Test
    @TestProperties(name = "add Update Attack Description's File Task", paramsInclude = {"taskEnabled", "taskType", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "taskSchedRunTime",
            "runOnceDate", "taskSchedMinutes", "executeDeltaTime"})
    public void addUpdateAttackDescriptionFileTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());
            taskPorperties.put("columnName", columnName);
            taskPorperties.put("taskType", String.valueOf(taskType));

            GetAttackDescFromSiteTaskHandler.addTask(taskPorperties);
        } catch (Exception e) {
            report.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "edit Update Attack Description's File Task", paramsInclude = {"qcTestId", "taskEnabled", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "taskSchedRunTime", "runOnceDate", "taskSchedMinutes"})
    public void editUpdateAttackDescriptionFileTask() throws Exception {
        try {
            columnName = "Name";
            HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
            taskPorperties.putAll(setBaseProperties());
            taskPorperties.put("columnName", columnName);
            GetAttackDescFromSiteTaskHandler.editTask(taskPorperties);
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
}
