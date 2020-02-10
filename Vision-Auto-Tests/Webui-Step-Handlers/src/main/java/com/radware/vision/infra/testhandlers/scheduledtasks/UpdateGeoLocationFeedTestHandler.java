package com.radware.vision.infra.testhandlers.scheduledtasks;


import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.DualListTypeEnum;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.DestinationType;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskRunIntervalType;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import com.radware.vision.infra.utils.WebUIStringsVision;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class UpdateGeoLocationFeedTestHandler extends BaseTasksHandler {

    public static void addNewTask(String taskName, String run_time, List<String> devices) throws Exception {
        String columnName = "Name";
        String taskDisc = "Update Geo Location Feed Test";
        String deviceDestinations=String.join(",",devices);

        HashMap<String, String> taskProperties = new HashMap<String, String>(50);
        taskProperties.putAll(
                BaseTasksHandler.setBaseProperties(taskName, taskDisc, TaskRunIntervalType.RUN_DAILY.getRunType(), run_time,
                        null, null, null, null, null,
                        null, null, null, true, true));

        taskProperties.put("columnName", columnName);
        taskProperties.put("taskType", String.valueOf(TaskType.Update_GEO_Location_Feed));
        taskProperties.put("deviceDestinations", deviceDestinations);
        taskProperties.put("groupDestinations", null);

        BasicOperationsHandler.scheduler(true);
        addTask(taskProperties);
        taskEntity.getSchedule().setTime(run_time,"Daily");
        List<String> deviceDestinationsList;
        if (taskProperties.get("deviceDestinations") != null) {
            deviceDestinationsList = Arrays.asList(taskProperties.get("deviceDestinations").split(","));
            taskEntity.getDestination(DestinationType.DeviceList);
            taskEntity.addSelectedDevices(DualListTypeEnum.SCHEDULE_TASKS_DEVICES, deviceDestinationsList);
        }
        if (taskProperties.get("groupDestinations") != null) {
            deviceDestinationsList = Arrays.asList(taskProperties.get("groupDestinations").split(","));
            taskEntity.getDestination(DestinationType.DeviceList);
            taskEntity.addSelectedDevices(DualListTypeEnum.SCHEDULE_TASKS_GROUPS, deviceDestinationsList);
        }


        taskEntity.setName(taskProperties.get("taskName"));
        taskEntity.setDecription(taskDisc);
        WebUIVisionBasePage.submit(WebUIStringsVision.getSubmitAddScheduledTasksModule());
        WebUIVisionBasePage.cancel(true);
    }
}
