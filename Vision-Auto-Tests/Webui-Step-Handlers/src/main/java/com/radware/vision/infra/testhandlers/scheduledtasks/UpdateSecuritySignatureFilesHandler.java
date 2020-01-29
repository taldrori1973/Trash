package com.radware.vision.infra.testhandlers.scheduledtasks;

import com.radware.vision.infra.enums.DualListTypeEnum;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.DestinationType;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class UpdateSecuritySignatureFilesHandler extends BaseTasksHandler {
	public static void deleteTask(String columnName, String taskName) throws Exception {
		deleteBaseTask(columnName, taskName);
	}
	
	public static void addTask(HashMap<String, String> taskProperties) throws Exception {
		beforeAddTask(taskProperties);
		List<String> deviceDestinationsList = new ArrayList<String>();
		if(taskProperties.get("deviceDestinations") != null){
			deviceDestinationsList = Arrays.asList(taskProperties.get("deviceDestinations").split(","));
			taskEntity.getDestination(DestinationType.DeviceList);
			taskEntity.addSelectedDevices(DualListTypeEnum.SCHEDULE_TASKS_DEVICES, deviceDestinationsList);
		}
		if(taskProperties.get("groupDestinations") != null){
			deviceDestinationsList = Arrays.asList(taskProperties.get("groupDestinations").split(","));
			taskEntity.getDestination(DestinationType.DeviceList);
			taskEntity.addSelectedDevices(DualListTypeEnum.SCHEDULE_TASKS_GROUPS, deviceDestinationsList);
		}
		afterAddTask(taskProperties);
	}
	
	public static void editTask(HashMap<String, String> taskProperties) throws Exception {
		beforeEditTask(taskProperties);
		List<String> deviceDestinationsList = new ArrayList<String>();
		if(taskProperties.get("deviceDestinations") != null){
			deviceDestinationsList = Arrays.asList(taskProperties.get("deviceDestinations").split(","));
			taskEntity.getDestination(DestinationType.DeviceList);
			taskEntity.addSelectedDevices(DualListTypeEnum.SCHEDULE_TASKS_DEVICES, deviceDestinationsList);
		}
		if(taskProperties.get("groupDestinations") != null){
			deviceDestinationsList = Arrays.asList(taskProperties.get("groupDestinations").split(","));
			taskEntity.getDestination(DestinationType.DeviceList);
			taskEntity.addSelectedDevices(DualListTypeEnum.SCHEDULE_TASKS_GROUPS, deviceDestinationsList);
		}
		afterEditTask();
	}
}

