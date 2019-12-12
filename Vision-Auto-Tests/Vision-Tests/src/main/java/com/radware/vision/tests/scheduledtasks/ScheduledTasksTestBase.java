package com.radware.vision.tests.scheduledtasks;

import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskRunIntervalType;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import jsystem.framework.ParameterProperties;
import org.junit.After;

import java.util.HashMap;

public abstract class ScheduledTasksTestBase extends WebUITestBase {

    String taskName;
    String taskDescription;

    boolean taskEnabled = true;
    boolean taskRunAlways = true;

    TaskRunIntervalType taskSchedRunInterval;

    String taskSchedRunTime = "00:01:00";
    String runOnceDate;
    String taskSchedMinutes;

    String taskSchedWeekdays;
    String taskSchedStartDate;
    String taskSchedStartTime = "00:01:00";
    String taskSchedEndDate;
    String taskSchedEndTime = "00:01:00";
    String executeDeltaTime;

    @After
    public void afterSched() {
        WebUIVisionBasePage.cancel(false);
        WebUIBasePage.cancel(false);
    }

    public HashMap<String, String> setBaseProperties() {
        TopologyTreeHandler.clickTreeNodeDefault();

        HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
        taskPorperties.put("taskName", taskName);
        taskPorperties.put("taskDescription", taskDescription);
        taskPorperties.put("taskSchedRunInterval", taskSchedRunInterval == null ? null : String.valueOf(taskSchedRunInterval));
        taskPorperties.put("taskSchedRunTime", taskSchedRunTime);
        taskPorperties.put("runOnceDate", runOnceDate);
        taskPorperties.put("taskSchedMinutes", taskSchedMinutes);
        taskPorperties.put("taskSchedWeekdays", taskSchedWeekdays);
        taskPorperties.put("taskRunAlways", String.valueOf(taskRunAlways));
        taskPorperties.put("taskSchedStartDate", taskSchedStartDate);
        taskPorperties.put("taskSchedStartTime", taskSchedStartTime);
        taskPorperties.put("taskSchedEndDate", taskSchedEndDate);
        taskPorperties.put("taskSchedEndTime", taskSchedEndTime);
        taskPorperties.put("taskEnabled", String.valueOf(taskEnabled));
        taskPorperties.put("executeDeltaTime", executeDeltaTime);

        return taskPorperties;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTaskDescription() {
        return taskDescription;
    }

    public void setTaskDescription(String taskDescription) {
        this.taskDescription = taskDescription;
    }

    public boolean getTaskEnabled() {
        return taskEnabled;
    }

    public void setTaskEnabled(boolean taskEnabled) {
        this.taskEnabled = taskEnabled;
    }

    public boolean getTaskRunAlways() {
        return taskRunAlways;
    }

    public void setTaskRunAlways(boolean taskRunAlways) {
        this.taskRunAlways = taskRunAlways;
    }

    public TaskRunIntervalType getTaskSchedRunInterval() {
        return taskSchedRunInterval;
    }

    public void setTaskSchedRunInterval(TaskRunIntervalType taskSchedRunInterval) {
        this.taskSchedRunInterval = taskSchedRunInterval;
    }

    public String getTaskSchedRunTime() {
        return taskSchedRunTime;
    }

    @ParameterProperties(description = "Accepted format is: HH:mm")
    public void setTaskSchedRunTime(String taskSchedRunTime) {
        this.taskSchedRunTime = taskSchedRunTime;
    }

    public String getRunOnceDate() {
        return runOnceDate;
    }

    @ParameterProperties(description = "Accepted format: DD.MM.YYYY")
    public void setRunOnceDate(String runOnceDate) {
        this.runOnceDate = runOnceDate;
    }

    public String getTaskSchedMinutes() {
        return taskSchedMinutes;
    }

    public void setTaskSchedMinutes(String taskSchedMinutes) {
        this.taskSchedMinutes = taskSchedMinutes;
    }

    public String getTaskSchedWeekdays() {
        return taskSchedWeekdays;
    }

    @ParameterProperties(description = "Specify days of the week to run the task. Must start with capital latter and be separated by <,>.")
    public void setTaskSchedWeekdays(String taskSchedWeekdays) {
        this.taskSchedWeekdays = taskSchedWeekdays;
    }

    public String getTaskSchedStartDate() {
        return taskSchedStartDate;
    }

    @ParameterProperties(description = "Accepted format is: dd.mm.yyyy")
    public void setTaskSchedStartDate(String taskSchedStartDate) {
        this.taskSchedStartDate = taskSchedStartDate;
    }

    public String getTaskSchedStartTime() {
        return taskSchedStartTime;
    }

    @ParameterProperties(description = "Accepted format is: HH:mm")
    public void setTaskSchedStartTime(String taskSchedStartTime) {
        this.taskSchedStartTime = taskSchedStartTime;
    }

    public String getTaskSchedEndDate() {
        return taskSchedEndDate;
    }

    @ParameterProperties(description = "Accepted format is: dd.mm.yyyy")
    public void setTaskSchedEndDate(String taskSchedEndDate) {
        this.taskSchedEndDate = taskSchedEndDate;
    }

    public String getTaskSchedEndTime() {
        return taskSchedEndTime;
    }

    @ParameterProperties(description = "Accepted format is: HH:mm")
    public void setTaskSchedEndTime(String taskSchedEndTime) {
        this.taskSchedEndTime = taskSchedEndTime;
    }

    public String getExecuteDeltaTime() {
        return executeDeltaTime;
    }

    @ParameterProperties(description = "Execute task (in seconds): ")
    public void setExecuteDeltaTime(String executeDeltaTime) {
        this.executeDeltaTime = executeDeltaTime;
    }
}
