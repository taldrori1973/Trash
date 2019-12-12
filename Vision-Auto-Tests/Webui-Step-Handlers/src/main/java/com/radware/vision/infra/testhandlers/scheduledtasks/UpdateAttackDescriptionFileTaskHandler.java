package com.radware.vision.infra.testhandlers.scheduledtasks;

import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskRunIntervalType;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import com.radware.vision.infra.utils.WebUIStringsVision;

import java.util.HashMap;

public class UpdateAttackDescriptionFileTaskHandler extends BaseTasksHandler {

    public static HashMap<String, String> setBaseProperties(String taskName, String taskDescription, boolean taskEnabled) {

        HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
        taskPorperties.put("taskName", taskName);
        taskPorperties.put("taskDescription", taskDescription);
        taskPorperties.put("taskEnabled", String.valueOf(taskEnabled));

        return taskPorperties;
    }


    public static void addUpdateAttackDescriptionFileTask(String taskName, String taskDescription, boolean taskEnabled) {

        String columnName = "Name";

        HashMap<String, String> taskProperties = new HashMap<String, String>(50);
        taskProperties.putAll(setBaseProperties(taskName, taskDescription, taskEnabled));
        taskProperties.put("columnName", columnName);
        taskProperties.put("taskRunAlways", "true");
        taskProperties.put("taskSchedRunInterval", TaskRunIntervalType.RUN_DAILY.name());
        taskProperties.put("taskSchedRunTime", "00:00:00");
        taskProperties.put("taskType", String.valueOf(TaskType.UPDATE_ATTACK_DESCRIPTION_FILE));

        addTask(taskProperties);

        afterAddTask(taskProperties);
    }

    public static void addTaskWithoutVerify(String taskName, String taskDescription, boolean taskEnabled) {

        String columnName = "Name";

        HashMap<String, String> taskProperties = new HashMap<String, String>(50);
        taskProperties.putAll(setBaseProperties(taskName, taskDescription, taskEnabled));
        taskProperties.put("columnName", columnName);
        taskProperties.put("taskType", String.valueOf(TaskType.UPDATE_ATTACK_DESCRIPTION_FILE));

        addTask(taskProperties);

        WebUIVisionBasePage.submit(WebUIStringsVision.getSubmitAddScheduledTasksModule());
        WebUIVisionBasePage.cancel(true);

    }

}
