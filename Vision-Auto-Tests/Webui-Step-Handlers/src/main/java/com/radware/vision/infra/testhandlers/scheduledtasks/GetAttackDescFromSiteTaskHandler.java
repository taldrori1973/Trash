package com.radware.vision.infra.testhandlers.scheduledtasks;

import java.util.HashMap;

public class GetAttackDescFromSiteTaskHandler extends BaseTasksHandler {
	public static void deleteTask(String columnName, String taskName) {
		deleteBaseTask(columnName, taskName);
	}

	public static void addTask(HashMap<String, String> taskProperties) {
		beforeAddTask(taskProperties);
		
		afterAddTask(taskProperties);
	}

	public static void editTask(HashMap<String, String> taskProperties) {
		beforeEditTask(taskProperties);

		afterEditTask();
	}
}
