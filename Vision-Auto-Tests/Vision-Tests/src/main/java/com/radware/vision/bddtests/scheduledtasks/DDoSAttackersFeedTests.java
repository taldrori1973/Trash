package com.radware.vision.bddtests.scheduledtasks;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.testhandlers.scheduledtasks.DDosFeedTaskHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskRunIntervalType;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import com.radware.vision.infra.testhandlers.scheduledtasks.validateScheduledTasks.ValidateTasksHandler;
import com.radware.vision.pojomodel.helpers.constants.ImConstants$ScheduledTaskExecutionStatusEnumPojo;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.List;


public class DDoSAttackersFeedTests extends BddUITestBase {

    TaskType taskType = TaskType.ERT_ACTIVE_ATTACKERS_FEED_For_DEFENSEPRO;
    String groupDestinations;
    String taskDescription = "testDesc";

    public DDoSAttackersFeedTests() throws Exception {
    }

    @When("^UI Add Attackers feed task with name \"(.*)\" interval \"(.*)\" destination devices indexes \"(.*)\" with default params$")
    public void addAttackersFeedTask(String taskName, String taskSchedRunInterval, String devicesIndexes) throws Exception {
        try {
            String deviceDestinations = "";
            String[] indexes = devicesIndexes.split(",");

            for (int i = 0; i < indexes.length; i++){
                if(i == (indexes.length -1)){
                    deviceDestinations += devicesManager.getDeviceInfo(SUTDeviceType.DefensePro,Integer.valueOf(indexes[i])).getDeviceName();
                }
                else
                {
                    deviceDestinations += devicesManager.getDeviceInfo(SUTDeviceType.DefensePro,Integer.valueOf(indexes[i])).getDeviceName() + ",";
                }
            }

            DDosFeedTaskHandler.addDDosFeedTask(taskName, taskDescription, TaskRunIntervalType.getTypeByValue(taskSchedRunInterval).toString(), true, true, deviceDestinations, taskType, groupDestinations, true);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @When("^UI Add Attackers feed task with name \"(.*)\" interval \"(.*)\" destination devices indexes \"(.*)\" without verify$")
    public void addAttackersFeedTaskWithoutVerify(String taskName, String taskSchedRunInterval, String devicesIndexes) throws Exception {
        try {
            String deviceDestinations = "";
            String[] indexes = devicesIndexes.split(",");

            for (int i = 0; i < indexes.length; i++){
                if(i == (indexes.length -1)){
                    deviceDestinations += devicesManager.getDeviceInfo(SUTDeviceType.DefensePro,Integer.valueOf(indexes[i])).getDeviceIp();
                }
                else
                {
                    deviceDestinations += devicesManager.getDeviceInfo(SUTDeviceType.DefensePro,Integer.valueOf(indexes[i])).getDeviceIp() + ",";
                }
            }
            DDosFeedTaskHandler.addDDosFeedTaskWithoutVerify(taskName, taskDescription, TaskRunIntervalType.getTypeByValue(taskSchedRunInterval).toString(), true, true, deviceDestinations, taskType, groupDestinations, true);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Validate that adding DDos feed task failed$")
    public void verifyThatAddingTaskFailed() throws Exception {
        try {
            if (!DDosFeedTaskHandler.addingTaskFailed()) {
                throw new Exception("We can create just single DDos feed task.");
            }
        } catch (Exception e) {
            BaseTestUtils.report("Error popup doesn't jumped: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Validate that after \"(.*)\" DDos feed task finished we have alert with message$")
    public void verifyAlertMessageForTask(String taskName, List<String> expectedAlertMessage) throws Exception {
        String message = "";
        if (taskName == null || expectedAlertMessage == null) {
            throw new Exception("Some/all of the test inputs equal to null");
        }

        for (int i = 0; i < expectedAlertMessage.size(); i++) {
            if (i == (expectedAlertMessage.size() - 1)) {
                message += expectedAlertMessage.get(i);
            } else {
                message += expectedAlertMessage.get(i) + " ";
            }
        }

        if (!ValidateTasksHandler.validateERTActiveDDosFeed(taskName, ImConstants$ScheduledTaskExecutionStatusEnumPojo.FAILURE, message, restTestBase.getVisionRestClient())) {
            BaseTestUtils.report("the alerts message was not found ".concat(message), Reporter.FAIL);
        } else {

            BaseTestUtils.report("DDos feed alert Validation Succeeded", Reporter.PASS);
        }
    }
}
