package com.radware.vision.bddtests.scheduledtasks;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.infra.testhandlers.scheduledtasks.BaseTasksHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.DDosFeedTaskHandler;
import com.radware.vision.pojomodel.helpers.constants.ImConstants$ScheduledTaskExecutionStatusEnumPojo;
import com.radware.vision.vision_project_cli.RootServerCli;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;


public class ScheduledTaskCommonTests extends BddUITestBase {
    public ScheduledTaskCommonTests() throws Exception {
    }

    /**
     *
     */
    @Given("^UI Open scheduler window$")
    public void openSchedulerWindow() throws Exception {
        BaseTasksHandler.openScheduler(true);
    }

    /**
     *
     */
    @Then("^UI Close scheduler window$")
    public void closeSchedulerWindow() throws Exception {
        BaseTasksHandler.openScheduler(false);
    }


    @When("^UI Delete task with name \"(.*)\"$")
    public void deleteTaskByName(String taskName) throws Exception {
        BaseTasksHandler.deleteBaseTask("Name", taskName);
    }


    @Then("^UI Wait for \"(.*)\" task success$")
    public void waitForTaskSuccess(String taskName) throws Exception {
        try {
            if (!DDosFeedTaskHandler.wait4TaskStatus(taskName, ImConstants$ScheduledTaskExecutionStatusEnumPojo.SUCCESS, restTestBase.getVisionRestClient())) {
                throw new Exception("task did not succeed.");
            }
        } catch (Exception e) {
            BaseTestUtils.report("Task status error: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Validate that task with name \"(.*)\" exists$")
    public void verifyTaskExistence(String taskName) {
        try {
            String columnName = "Name";
            if (!BaseTasksHandler.validateTaskCreation(columnName, taskName)) {
                BaseTestUtils.report("Task not appear in the Scheduler task table", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Select task by name \"(.*)\"$")
    public void selectTaskByName(String taskName) {
        try {
            String columnName = "Name";
            BaseTasksHandler.selectTask(columnName, taskName);
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Run task with name \"(.*)\"$")
    public void runTask(String taskName) throws Exception {

        try {
            BaseTasksHandler.runNowBaseTask("Name", taskName, new ArrayList<>(), getVisionRestClient());
        } catch (RuntimeException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @When("^UI Remove All Tasks with tha Value \"([^\"]*)\" at Column \"([^\"]*)\"$")
    public void uiRemoveAllTasksOfType(String columnValue, String columnName) throws Throwable {
        BaseTasksHandler.deleteAllTasksOfColumnValue(columnName, columnValue);
    }

    @When("^Run command \"(.*)\" and validate task time close to (\\d+)$")
    public void validateTime(String command , int expectedTime)throws Exception{
        RootServerCli rootServerCli = new RootServerCli(clientConfigurations.getHostIp(), restTestBase.getRootServerCli().getUser(), restTestBase.getRootServerCli().getPassword());
        rootServerCli.init();
        CliOperations.runCommand(rootServerCli, command);
        String output = rootServerCli.getCmdOutput().get(1).split("\\.")[0];
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime outputDate = LocalDateTime.parse(output, inputFormatter);
        outputDate =outputDate.plusHours(3);
        LocalDateTime current = LocalDateTime.now();
        double time = Duration.between(current, outputDate).toMinutes()/(60.0);
        if((time < (expectedTime - 0.1) || time > (expectedTime + 0.1)))
            BaseTestUtils.report("the " + time + " is not close to " + expectedTime + " " , Reporter.FAIL);
    }
}
