package com.radware.vision.infra.testhandlers.scheduledtasks;

import com.radware.automation.webui.events.ReportWebDriverEventListener;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.widgets.api.popups.PopupContent;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.scheduledtasks.ScheduledTasks;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import com.radware.vision.infra.utils.WebUIStringsVision;
import java.util.HashMap;
import java.util.List;

public class TORTaskHandler extends BaseTasksHandler {

    private static int intLinkProofs;
    private static int intAlteons;
    public static int intOverallSupportedDevices;

    public static HashMap<String, String> setBaseProperties(String taskName, String taskDescription, boolean taskEnabled) {

        HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
        taskPorperties.put("taskName", taskName);
        taskPorperties.put("taskDescription", taskDescription);
        taskPorperties.put("taskEnabled", String.valueOf(taskEnabled));

        return taskPorperties;
    }


    public static void addTORTask(String taskName, String taskDescription, boolean taskEnabled) {

        String columnName = "Name";

        HashMap<String, String> taskProperties = new HashMap<String, String>(50);
        taskProperties.putAll(setBaseProperties(taskName,taskDescription, taskEnabled));
        taskProperties.put("columnName", columnName);
        taskProperties.put("taskType", String.valueOf(TaskType.TOR_FEED));

        addTask(taskProperties);

        afterAddTask(taskProperties);
    }

    public static void addTORTaskWithoutVerify(String taskName, String taskDescription, boolean taskEnabled) {

        String columnName = "Name";

        HashMap<String, String> taskProperties = new HashMap<String, String>(50);
        taskProperties.putAll(setBaseProperties(taskName,taskDescription, taskEnabled));
        taskProperties.put("columnName", columnName);
        taskProperties.put("taskType", String.valueOf(TaskType.TOR_FEED));

        addTask(taskProperties);

        WebUIVisionBasePage.submit(WebUIStringsVision.getSubmitAddScheduledTasksModule());
        WebUIVisionBasePage.cancel(true);

    }

    public static boolean addingTaskFailed(){
        List<PopupContent> popupErrors = ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).getLastPopupEvent();

        if (popupErrors.size() > 0) {
            for (int i = 0; i < popupErrors.size(); i++) {
                if (popupErrors.get(i).getContent().equals("M_01909: Task of this type already exists.")){
                    return true;
                }
            }
        }
        return false;
    }

    public static boolean fieldsNotExistVerification(List<String> fields){
        ScheduledTasks scheduledTasks = new ScheduledTasks();
        taskEntity = scheduledTasks.addTask();
        taskEntity.setTaskType(TaskType.TOR_FEED);
        return taskEntity.fieldsNotExistVerification(fields);
    }
}
