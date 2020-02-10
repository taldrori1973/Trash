package com.radware.vision.infra.testhandlers.scheduledtasks;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.jsonparsers.impl.JsonArrayUtils;
import com.radware.jsonparsers.impl.JsonUtils;
import com.radware.jsonparsers.impl.ScheduledTaskJsonImpl;
import com.radware.restcore.VisionRestClient;
import com.radware.vision.infra.base.pages.navigation.HomePage;
import com.radware.vision.pojomodel.helpers.constants.ImConstants$CurrentTaskStatusPojo;
import com.radware.vision.pojomodel.helpers.constants.ImConstants$DeviceStatusEnumPojo;
import com.radware.vision.pojomodel.helpers.constants.ImConstants$ScheduledTaskExecutionStatusEnumPojo;
import com.radware.vision.infra.base.pages.alerts.Alerts;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.scheduledtasks.ScheduledTasks;
import com.radware.vision.infra.base.pages.scheduledtasks.TaskEntity;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.*;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;
import testhandlers.Device;

import java.text.SimpleDateFormat;
import java.util.*;

public class BaseTasksHandler {
    public static TaskEntity taskEntity;
    static ScheduledTaskJsonImpl scheduledTaskJson = new ScheduledTaskJsonImpl();
    static List<String> executeTasks = new LinkedList<String>();

    public static void setBaseTask(HashMap<String, String> taskProperties) {
        List<String> weekDays = new ArrayList<String>();
        if (taskProperties.get("taskSchedWeekdays") != null) {
            weekDays = Arrays.asList(taskProperties.get("taskSchedWeekdays").split(","));
        }

        taskEntity.setName(taskProperties.get("taskName"));
        taskEntity.setDecription(taskProperties.get("taskDescription"));

        if (!TaskType.valueOf(taskProperties.get("taskType")).equals(TaskType.TOR_FEED)) {
            TaskRunIntervalType interval = null;
            if (taskProperties.get("taskSchedRunInterval") != null) {
                interval = TaskRunIntervalType.valueOf(taskProperties.get("taskSchedRunInterval"));
                taskEntity.getSchedule().setRunInterval(interval.getRunType());
            }
            taskEntity.setTaskStatus(Boolean.valueOf(taskProperties.get("taskEnabled")));

            if (!StringUtils.isEmpty(taskProperties.get("executeDeltaTime")) && interval != null) {
                executeTasks.add(taskProperties.get("taskName"));
                Date radwareDate = addDeltaTime(taskProperties.get("executeDeltaTime"));
                SimpleDateFormat format = new SimpleDateFormat();
                switch (interval) {
                    case RUN_ONCE:
                        format = new SimpleDateFormat("HH:mm:ss");
                        taskEntity.getSchedule().setTime(format.format(radwareDate), interval.getRunType());
                        format = new SimpleDateFormat("dd.MM.yyyy");
                        taskEntity.getSchedule().setRunOnceDate(format.format(radwareDate));
                        break;
                    case RUN_DAILY:
                        format = new SimpleDateFormat("HH:mm:ss");
                        taskEntity.getSchedule().setTime(format.format(radwareDate), interval.getRunType());
                        break;
                    case RUN_MINUTES:
                        taskEntity.getSchedule().setRunMinutesMinutes(taskProperties.get("taskSchedMinutes"));
                        //executeTasks.remove(taskPorperties.get("taskName"));
                        break;
                    case RUN_WEEKLY:
                        format = new SimpleDateFormat("HH:mm:ss");
                        taskEntity.getSchedule().setTime(format.format(radwareDate), interval.getRunType());
                        taskEntity.getSchedule().checkWeekDays(getWeekdays(radwareDate));
                        break;
                }
            } else if (interval != null) {
                switch (interval) {
                    case RUN_ONCE:
                        taskEntity.getSchedule().setTime(taskProperties.get("taskSchedRunTime"), interval.getRunType());
                        taskEntity.getSchedule().setRunOnceDate(taskProperties.get("runOnceDate"));
                        break;
                    case RUN_DAILY:
                        taskEntity.getSchedule().setTime(taskProperties.get("taskSchedRunTime"), interval.getRunType());
                        break;
                    case RUN_MINUTES:
                        taskEntity.getSchedule().setRunMinutesMinutes(taskProperties.get("taskSchedMinutes"));
                        break;
                    case RUN_WEEKLY:
                        taskEntity.getSchedule().setTime(taskProperties.get("taskSchedRunTime"), interval.getRunType());
                        taskEntity.getSchedule().checkWeekDays(weekDays);
                        break;
                }
            }
            taskEntity.getSchedule().setRunAlways(Boolean.valueOf(taskProperties.get("taskRunAlways")));
            if (!Boolean.valueOf(taskProperties.get("taskRunAlways"))) {
                taskEntity.getSchedule().setRunStartDate(taskProperties.get("taskSchedStartDate"));
                taskEntity.getSchedule().setRunEndDate(taskProperties.get("taskSchedEndDate"));
                taskEntity.getSchedule().setStartTime(taskProperties.get("taskSchedStartTime"));
                taskEntity.getSchedule().setEndTime(taskProperties.get("taskSchedEndTime"));
            }

            if (taskProperties.get("backupDestination") != null) {
                taskEntity.getSchedule().setBackupDestination(BackupDestinations.valueOf(taskProperties.get("backupDestination")));
                if (BackupDestinations.valueOf(taskProperties.get("backupDestination")).getBackupDestination().equals(BackupDestinations.EXTERNAL_LOCATION.getBackupDestination())) {
                    setDestination(taskProperties);
                }
            }
        }
    }

    public static void deleteBaseTask(String columnName, String taskName) throws Exception {
        openScheduler(true);
        ScheduledTasks scheduledTasks = new ScheduledTasks();
        scheduledTasks.deleteTask(columnName, taskName);
//		AreYouSureDialogBox dialogBox = new AreYouSureDialogBox();
//		dialogBox.yesButtonClick();
        WebUIVisionBasePage.cancel(false);
    }

    public static void deleteAllTasks(String taskRowsToDelete) throws Exception {
        openScheduler(true);
        ScheduledTasks scheduledTasks = new ScheduledTasks();
        List<String> rowsToDeleteTemp = new ArrayList<String>();
        List<Integer> rowsToDelete = new ArrayList<Integer>();
        if (taskRowsToDelete == null) {
            scheduledTasks.getTaskTable().deleteAll();
        } else {
            rowsToDeleteTemp = Arrays.asList(taskRowsToDelete.split(","));
            for (String row : rowsToDeleteTemp) {
                rowsToDelete.add(Integer.parseInt(row) - 1);
            }
            scheduledTasks.deleteAllTasksInner(rowsToDelete);
        }
    }

    public static void deleteAllTasksOfColumnValue(String columnName, String columnValue) throws Exception {
        openScheduler(true);
        ScheduledTasks scheduledTasks = new ScheduledTasks();
        WebUITable taskTable = scheduledTasks.getTaskTable();

        int row;
        while((row=taskTable.findRowByKeyValue(columnName,columnValue,false))!=-1){
            taskTable.deleteRow(row);
        }

    }

    public static void selectTask(String columnName, String taskName) throws Exception {
        openScheduler(true);
        ScheduledTasks scheduledTasks = new ScheduledTasks();
        scheduledTasks.selectTaskByName(columnName, taskName);
    }

    public static boolean runNowBaseTask(String columnName, String taskName, List<String> deviceNameList, VisionRestClient visionRestClient) throws Exception {
        if (executeTasks.contains(taskName)) {
            return wait4TaskFinished(taskName, visionRestClient);
        } else {
            // Wait for devices
            long waitTimeout = 120 * 1000;
            for (String deviceName : deviceNameList) {
                try {
                    Device.waitForDeviceStatus(visionRestClient, deviceName, ImConstants$DeviceStatusEnumPojo.OK, waitTimeout);
                } catch (Exception e) {
                }
            }
            openScheduler(true);
            ScheduledTasks scheduledTasks = new ScheduledTasks();
            scheduledTasks.runNowTask(columnName, taskName);
            WebUIVisionBasePage.cancel(false);
//			return ValidateTasksHandler.validateTaskRunByServer(60 * 1000);
            return wait4TaskFinished(taskName, visionRestClient);
        }
    }

    public static boolean validateTaskCreationMain(String columnName, String taskName) throws Exception {
        boolean result = validateTaskCreation(columnName, taskName);
        WebUIVisionBasePage.cancel(false);
        return result;
    }

    public static boolean validateTaskCreation(String columnName, String taskName) throws Exception {
        openScheduler(true);
        ScheduledTasks scheduledTasks = new ScheduledTasks();
        WebUITable table = scheduledTasks.getTaskTable();
        table.analyzeTable("div");
        int rowIndex = table.getRowIndex(columnName, taskName);

        if (rowIndex == (-1)) {
            return false;
        }
        return true;
    }

    public static String getLastExecutionDateString(String taskName, VisionRestClient visionRestClient) {
        long time = getLastExecutionDate(taskName, visionRestClient);
        return TimeUtils.getHumanReadableDate(time);
    }

    protected static void validateTaskCreation(HashMap<String, String> taskProperties) throws Exception {
        if (!validateTaskCreation(taskProperties.get("columnName"), taskProperties.get("taskName").trim())) {
            BaseTestUtils.report("Task was not found: " + taskProperties.get("taskName") + "\n.", Reporter.FAIL);
        }
        WebUIVisionBasePage.cancel(false);
    }

    protected static void beforeAddTask(HashMap<String, String> taskProperties) throws Exception {
        openScheduler(true);
        ScheduledTasks scheduledTasks = new ScheduledTasks();
        taskEntity = scheduledTasks.addTask();
        taskEntity.setTaskType(TaskType.valueOf(taskProperties.get("taskType")));
    }

    protected static void addTask(HashMap<String, String> taskProperties) throws Exception {
        ScheduledTasks scheduledTasks = new ScheduledTasks();
        taskEntity = scheduledTasks.addTask();
        taskEntity.setTaskType(TaskType.valueOf(taskProperties.get("taskType")));
    }

    public static void openScheduler(boolean clickToOpen) throws Exception {
//        BasicOperationsHandler.scheduler(clickToOpen);
        HomePage.navigateFromHomePage("SCHEDULER");
    }

    protected static void beforeEditTask(HashMap<String, String> taskProperties) throws Exception {
        openScheduler(true);
        ScheduledTasks scheduledTasks = new ScheduledTasks();
        taskEntity = scheduledTasks.editTask(taskProperties.get("columnName"), taskProperties.get("taskName"));
        setBaseTask(taskProperties);
    }

    protected static void afterAddTask(HashMap<String, String> taskProperties) throws Exception {
        setBaseTask(taskProperties);
        WebUIVisionBasePage.submit(WebUIStringsVision.getSubmitAddScheduledTasksModule());
        closeSchedulerIfOpen();

        // task creation validation
        BasicOperationsHandler.delay(10);
        BasicOperationsHandler.refresh();
        validateTaskCreation(taskProperties);
        openScheduler(false);
    }

    public static void closeSchedulerIfOpen() {
        ComponentLocator cancelButtonLocator = new ComponentLocator(How.XPATH, "//*[contains(@id, '" + "scheduledTasks_Close" + "')]");
        try {
            WebElement webElement = WebUIUtils.fluentWait(cancelButtonLocator.getBy());
            if (webElement != null) {
                WebUIVisionBasePage.cancel(false);
            }
        } catch (Exception e) {
            BaseTestUtils.report("no cancel button found: ", e);
        }

    }

    protected static void afterEditTask() {
        WebUIVisionBasePage.submit(WebUIStringsVision.getSubmitEditScheduledTasksModule());
        WebUIVisionBasePage.cancel(false);
    }

    private static Date addDeltaTime(String deltaTime) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.SECOND, Integer.parseInt(deltaTime));
        return cal.getTime();
    }

    public static boolean wait4TaskFinished(String taskName, VisionRestClient visionRestClient) throws Exception {
        JSONObject scheduledTask;
        BasicOperationsHandler.delay(2);
        waitForTaskProperty(Arrays.asList(ImConstants$CurrentTaskStatusPojo.WAITING.toString(), ""), taskName, "status", visionRestClient);
        waitForTaskProperty(Arrays.asList(ImConstants$ScheduledTaskExecutionStatusEnumPojo.SUCCESS.toString(),
                ImConstants$ScheduledTaskExecutionStatusEnumPojo.FAILURE.toString(),
                ImConstants$ScheduledTaskExecutionStatusEnumPojo.WARNING.toString()), taskName, "lastExecutionStatus", visionRestClient);

        scheduledTask = getScheduledTask(taskName, visionRestClient, 10 * 1000);
        String taskLastExecutionStatus = (String) JsonArrayUtils.getJsonValueByKey(scheduledTask.toString(), "lastExecutionStatus");
        if (ImConstants$ScheduledTaskExecutionStatusEnumPojo.SUCCESS.toString().equals(taskLastExecutionStatus)) {
            return true;
        } else {
            openScheduler(true);
            //to understand later why its failed
            WebUIUtils.generateAndReportScreeshort();
            openScheduler(false);
            Alerts alerts = new Alerts();
            alerts.openPage();
            alerts.alertsMaximize();
            BasicOperationsHandler.refresh();
            WebUIUtils.generateAndReportScreeshort();
            alerts.alertsMaximize();
            throw new RuntimeException("Failed to execute task: " + taskName + "\n" + "Task Last Execution Status: " + taskLastExecutionStatus);
        }
    }

    public static boolean wait4TaskStatus(String taskName, ImConstants$ScheduledTaskExecutionStatusEnumPojo status, VisionRestClient visionRestClient) throws Exception {
        JSONObject scheduledTask;
        BasicOperationsHandler.delay(2);
        waitForTaskProperty(Arrays.asList(ImConstants$CurrentTaskStatusPojo.WAITING.toString(), ""), taskName, "status", visionRestClient);
        waitForTaskProperty(Arrays.asList(ImConstants$ScheduledTaskExecutionStatusEnumPojo.SUCCESS.toString(),
                ImConstants$ScheduledTaskExecutionStatusEnumPojo.FAILURE.toString(),
                ImConstants$ScheduledTaskExecutionStatusEnumPojo.WARNING.toString()), taskName, "lastExecutionStatus", visionRestClient);

        scheduledTask = getScheduledTask(taskName, visionRestClient, 10 * 1000);
        String taskLastExecutionStatus = (String) JsonArrayUtils.getJsonValueByKey(scheduledTask.toString(), "lastExecutionStatus");
        if (status.toString().equals(taskLastExecutionStatus)) {
            return true;
        } else {
            openScheduler(true);
            //to understand later why its failed
            WebUIUtils.generateAndReportScreeshort();
            openScheduler(false);
            Alerts alerts = new Alerts();
            alerts.openPage();
            alerts.alertsMaximize();
            BasicOperationsHandler.refresh();
            WebUIUtils.generateAndReportScreeshort();
            alerts.closeViewAlertsTab();
            throw new RuntimeException("Failed to execute task: " + taskName + "\n" + "Task Last Execution Status: " + taskLastExecutionStatus);
        }
    }

    public static JSONObject getScheduledTask(String taskName, VisionRestClient visionRestClient, long millisTimeout) {
        String scheduledTasksJson = visionRestClient.mgmtCommands.schedulerCommands.getScheduledTask();
        scheduledTasksJson = "{'tasksTableArray': ".concat(scheduledTasksJson).concat("}");
        JSONArray tasksArray = JsonUtils.getJsonArray(scheduledTasksJson, "tasksTableArray");
        long startTime = System.currentTimeMillis();
        do {
            for (int i = 0; i < tasksArray.length(); i++) {
                JSONObject currTask = (tasksArray.getJSONObject(i));
                if (currTask.get("name").equals(taskName)) {
                    return currTask;
                }
            }
        }
        while (System.currentTimeMillis() - startTime < millisTimeout);
        return null;
    }

    private static List<String> getWeekdays(Date date) {
        String[] weekDays = new String[]{"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        String day = weekDays[(cal.get(Calendar.DAY_OF_WEEK) - 1)];
        List<String> days = new LinkedList();
        days.add(day);
        return days;
    }

    private static boolean waitForTaskProperty(List<String> comparedValues, String taskName, String keyName, VisionRestClient visionRestClient) {
        JSONObject scheduledTask;
        int loopCount = 0;
        do {
            scheduledTask = getScheduledTask(taskName, visionRestClient, 1 * 1000);
            if (scheduledTask == null) {
                BaseTestUtils.report("Task does not exist in tasks table , it may not been created ", Reporter.FAIL);
                return false;

            }
            if (comparedValues.contains(JsonArrayUtils.getJsonValueByKey(scheduledTask.toString(), keyName))) {
                return true;
            } else {
                BasicOperationsHandler.delay(3);
                loopCount += 3;
            }
        } while (loopCount < 300);
        return false;
    }

    public static void setDestination(HashMap<String, String> taskProperties) {
        taskEntity.getDestination(DestinationType.Destination).setProtocol(ProtocolType.valueOf(taskProperties.get("protocol")));
        taskEntity.getDestination(DestinationType.Destination).setDirectory(taskProperties.get("directory"));
        taskEntity.getDestination(DestinationType.Destination).setUser(taskProperties.get("user"));
        taskEntity.getDestination(DestinationType.Destination).setPassword(taskProperties.get("password"));
        taskEntity.getDestination(DestinationType.Destination).setConfirmPassword(taskProperties.get("password"));
        taskEntity.getDestination(DestinationType.Destination).setIpAddress(taskProperties.get("ipAddress"));
        taskEntity.getDestination(DestinationType.Destination).setBackupFileName(taskProperties.get("backupFileName"));
    }

    public static HashMap<String, String> setBaseProperties(String taskName, String taskDescription, String taskSchedRunInterval, String taskSchedRunTime, String runOnceDate, String taskSchedMinutes
            , String taskSchedWeekdays, String taskSchedStartDate, String taskSchedStartTime, String taskSchedEndDate, String taskSchedEndTime, String executeDeltaTime
            , boolean taskRunAlways, boolean taskEnabled) {

        HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
        taskPorperties.put("taskName", taskName);
        taskPorperties.put("taskDescription", taskDescription);
        taskPorperties.put("taskSchedRunInterval", taskSchedRunInterval == null ? null : taskSchedRunInterval);
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

    public static long getLastExecutionDate(String taskName, VisionRestClient visionRestClient) {
        JSONObject scheduledTask;
        scheduledTask = getScheduledTask(taskName, visionRestClient, 10 * 1000);
        return Long.parseLong((String) JsonArrayUtils.getJsonValueByKey(scheduledTask.toString(), "lastExecutionDate"));
    }
}
