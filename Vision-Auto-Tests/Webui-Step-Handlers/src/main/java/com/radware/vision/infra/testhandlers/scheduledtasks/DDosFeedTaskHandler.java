package com.radware.vision.infra.testhandlers.scheduledtasks;

import basejunit.RestTestBase;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.UIUtils;
import com.radware.automation.webui.events.ReportWebDriverEventListener;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.widgets.api.popups.PopupContent;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.DualListTypeEnum;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.DestinationType;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import com.radware.vision.infra.utils.WebUIStringsVision;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class DDosFeedTaskHandler extends BaseTasksHandler {

    public static void addDDosFeedTask(String taskName, String taskDescription, String taskSchedRunInterval, boolean taskRunAlways, boolean taskEnabled, String deviceDestinations, TaskType taskType, String groupDestinations, boolean updateDuringAttack) throws Exception {

        String columnName = "Name";

        HashMap<String, String> taskProperties = new HashMap<String, String>(50);
        taskProperties.putAll(BaseTasksHandler.setBaseProperties(taskName, taskDescription, taskSchedRunInterval, null, null, null, null, null, null, null, null, null, taskRunAlways, taskEnabled));
        taskProperties.put("columnName", columnName);
        taskProperties.put("taskType", String.valueOf(taskType));
        taskProperties.put("deviceDestinations", deviceDestinations);
        taskProperties.put("groupDestinations", groupDestinations);

        addTask(taskProperties);
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

        // set Allow update during attack
//        taskEntity.setAllowUpdateDuringAttack(updateDuringAttack);

        afterAddTask(taskProperties);
    }

    public static void addDDosFeedTaskWithoutVerify(String taskName, String taskDescription, String taskSchedRunInterval, boolean taskRunAlways, boolean taskEnabled, String deviceDestinations, TaskType taskType, String groupDestinations, boolean updateDuringAttack) throws Exception {

        String columnName = "Name";

        HashMap<String, String> taskProperties = new HashMap<String, String>(50);
        taskProperties.putAll(BaseTasksHandler.setBaseProperties(taskName, taskDescription, taskSchedRunInterval, null, null, null, null, null, null, null, null, null, taskRunAlways, taskEnabled));
        taskProperties.put("columnName", columnName);
        taskProperties.put("taskType", String.valueOf(taskType));
        taskProperties.put("deviceDestinations", deviceDestinations);
        taskProperties.put("groupDestinations", groupDestinations);

        UIUtils.reportErrorPopup = false;
        addTask(taskProperties);
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
        WebUIVisionBasePage.submit(WebUIStringsVision.getSubmitAddScheduledTasksModule());
        WebUIVisionBasePage.cancel(true);

    }

    public static boolean addingTaskFailed() {
        List<PopupContent> popupErrors = ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).getLastPopupEvent();

        if (popupErrors.size() > 0) {
            for (int i = 0; i < popupErrors.size(); i++) {
                if (popupErrors.get(i).getContent().equals("M_01909: Task of this type already exists.")) {
                    return true;
                }
            }
        }
        return false;
    }

    public static void verifyValidatingFeedForDefenseProInVisionLog(String dpMacAddress, RestTestBase restTestBase) {
        String lastOutputItems;
        CliOperations.runCommand(restTestBase.getRootServerCli(), "logs");
        CliOperations.runCommand(restTestBase.getRootServerCli(), "grep \"validated the folowing ip adresses:\" vision.log");
        lastOutputItems = CliOperations.lastOutput;
        if (!lastOutputItems.contains(dpMacAddress.replace(":", ""))) {
            BaseTestUtils.report("Mac address not found.", Reporter.FAIL);
        }
    }

    public static void verifyRequestingFeedForDefenseProInVisionLog(String dpMacAddress, RestTestBase restTestBase) {
        String lastOutputItems;
        CliOperations.runCommand(restTestBase.getRootServerCli(), "logs");
        CliOperations.runCommand(restTestBase.getRootServerCli(), "grep \"Requesting feed for the following mac adresses:\" vision.log");
        lastOutputItems = CliOperations.lastOutput;
        if (!lastOutputItems.contains(dpMacAddress.replace(":", ""))) {
            BaseTestUtils.report("Mac address not found.", Reporter.FAIL);
        }
    }

    public static void verifyThatNoFeedRequestForDefenseProInVisionLog(String dpMacAddress, RestTestBase restTestBase) {
        String lastOutputItems;
        CliOperations.runCommand(restTestBase.getRootServerCli(), "logs");
        CliOperations.runCommand(restTestBase.getRootServerCli(), "grep \"Requesting feed for the following mac adresses:\" vision.log");
        lastOutputItems = CliOperations.lastOutput;
        if (lastOutputItems.contains(dpMacAddress.replace(":", ""))) {
            BaseTestUtils.report("Feed request for this DefensePro was found", Reporter.FAIL);
        }
    }
}
