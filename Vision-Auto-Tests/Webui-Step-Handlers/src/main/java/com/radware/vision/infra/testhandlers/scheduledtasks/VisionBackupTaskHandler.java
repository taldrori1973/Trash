package com.radware.vision.infra.testhandlers.scheduledtasks;

import com.radware.vision.infra.testhandlers.scheduledtasks.enums.BackupDestinations;

import java.util.HashMap;

public class VisionBackupTaskHandler extends BaseTasksHandler {
    public static void deleteTask(String columnName, String taskName) {
        deleteBaseTask(columnName, taskName);
    }

    public static void addTask(HashMap<String, String> taskProperties, BackupDestinations externalLocation) {
        beforeAddTask(taskProperties);
        afterAddTask(taskProperties);
    }

    public static void editTask(HashMap<String, String> taskProperties) {
        beforeEditTask(taskProperties);
        setDestination(taskProperties);
        afterEditTask();
    }
}
