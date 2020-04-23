package com.radware.vision.tests.scheduledtasks;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.scheduledtasks.BaseTasksHandler;
import com.radware.vision.infra.testhandlers.system.deviceResources.devicebackups.DeviceBackupsHandler;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class SchedulerCommonTests extends ScheduledTasksTestBase {
    String taskName;
    String columnName;
    String taskRowsToDelete;

    @Test
    @TestProperties(name = "Verify Task Existence", paramsInclude = {"qcTestId", "taskName"})
    public void verifyTaskExistence() {
        try {
            columnName = "Name";
            if (BaseTasksHandler.validateTaskCreation(columnName, taskName)) {
                BaseTestUtils.report("Task appear in the Scheduler task table", Reporter.PASS);
            } else {
                BaseTestUtils.report("Task not appear in the Scheduler task table", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "delete Task", paramsInclude = {"qcTestId", "taskName"})
    public void deleteTask() throws Exception {
        try {
            columnName = "Name";
            BaseTasksHandler.deleteBaseTask(columnName, taskName);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "delete All Tasks", paramsInclude = {"qcTestId", "taskRowsToDelete"})
    public void deleteAllTasks() throws Exception {
        try {
            BaseTasksHandler.deleteAllTasks(taskRowsToDelete);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "delete All Devices Backups", paramsInclude = {"qcTestId"})
    public void deleteDevicesBackups() throws Exception {
        try {
            DeviceBackupsHandler.deleteDeviceBackups();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to delete all devices backups: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public String getTaskRowsToDelete() {
        return taskRowsToDelete;
    }

    @ParameterProperties(description = "Specify rows numbers you want to be deleted. Must be separated by <,>. To delete All, leave empty!")
    public void setTaskRowsToDelete(String taskRowsToDelete) {
        this.taskRowsToDelete = taskRowsToDelete;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }
}
