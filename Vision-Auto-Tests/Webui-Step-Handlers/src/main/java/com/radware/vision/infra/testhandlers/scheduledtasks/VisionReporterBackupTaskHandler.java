package com.radware.vision.infra.testhandlers.scheduledtasks;

import java.util.HashMap;

public class VisionReporterBackupTaskHandler extends BaseTasksHandler {
    public static void deleteTask(String columnName, String taskName) throws Exception {
        deleteBaseTask(columnName, taskName);
    }

    public static void addTask(HashMap<String, String> taskProperties) throws Exception {
        beforeAddTask(taskProperties);
        afterAddTask(taskProperties);
    }

    public static void editTask(HashMap<String, String> taskProperties) throws Exception {
        beforeEditTask(taskProperties);
        setDestination(taskProperties);
        afterEditTask();
    }
}
