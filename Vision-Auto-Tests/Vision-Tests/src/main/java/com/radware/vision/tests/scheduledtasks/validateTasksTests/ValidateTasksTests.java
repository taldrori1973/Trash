package com.radware.vision.tests.scheduledtasks.validateTasksTests;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.scheduledtasks.ScheduledTasks;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.Users.LocalUsersHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.BaseTasksHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.BackupDestinations;
import com.radware.vision.infra.testhandlers.scheduledtasks.validateScheduledTasks.ValidateTasksHandler;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.vision_handlers.system.ConfBackup;
import com.radware.vision.vision_handlers.system.ReporterBackup;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import testhandlers.Device;

import java.time.LocalTime;
import java.util.HashMap;

/**
 * Created by stanislava on 11/19/2014.
 */
public class ValidateTasksTests extends WebUITestBase {

    String taskName;
    String taskColumnName = "Name";
    String timePeriodToVerify = "60";
    String timePeriodToVerifyLastSignatureUpdate = "180";
    TopologyTreeTabs parentTree = TopologyTreeTabs.SitesAndClusters;
    String fileName;
    String filePath;
    String deviceIp;
    String defaultFileName = "/cm:/db_f.bin";
    String networkProtectionPolicyList;
    String serverProtectionPolicyList;
    String taskSchedRunTime;

    int timeout = 30;

    String username;
    String password;


    String filePathToDelete;

    BackupDestinations destination = BackupDestinations.VISION_SERVER;
    String visionBackupFilePath = "/opt/radware/storage/backup/";
    String visionBackupFilePrefix = "ConfBackup__";
    String visionReporterBackupPrefix = "ReporterBackup__";

    String expectedAlertMessage;


    int userId;

    @Before
    public void uiInit() throws Exception {
        updateNavigationParser(this.deviceIp);
    }

    @After
    public void cleanup() throws Exception {
        BasicOperationsHandler.scheduler(false);
    }


    @Test
    @TestProperties(name = "check if task ran in the scheduled time", paramsInclude = {"taskName", "taskSchedRunTime", "timeout"})
    public void checkIfTaskRanInScheduledTime() {
        try {
            if (taskName == null || taskSchedRunTime == null) {
                BaseTestUtils.report("please insert values for the test parameters", Reporter.FAIL);
            }


            BasicOperationsHandler.scheduler(true);
            ScheduledTasks scheduledTasks = new ScheduledTasks();
            WebUITable tasksTable;


            LocalTime taskScheduledRunTime = TimeUtils.addMissingDigits(taskSchedRunTime);
            do {
                tasksTable = scheduledTasks.getTaskTable();
                int rowNumber = tasksTable.getRowIndex("Name", taskName, true);
                if (rowNumber == -1) {
                    BasicOperationsHandler.takeScreenShot();
                    BaseTestUtils.report("Task with name " + taskName + " does not exist", Reporter.FAIL);
                } else {
                    int colIndex = tasksTable.getColIndex("Last Execution Date");
                    String lastExecDateTimeAsString = tasksTable.getCellValue(rowNumber, colIndex);
                    if (lastExecDateTimeAsString != null && !lastExecDateTimeAsString.isEmpty()) {
                        String lastExecTimeAsString = lastExecDateTimeAsString.split(" ")[1];
                        LocalTime lastExecutionTime = LocalTime.parse(lastExecTimeAsString);

                        if (lastExecutionTime.isAfter(taskScheduledRunTime) || !lastExecutionTime.isBefore(taskScheduledRunTime) && !lastExecutionTime.isAfter(taskScheduledRunTime)) {
                            BaseTestUtils.report("Task scheduled time is : " + taskScheduledRunTime + " --- Last execution date is : " + lastExecutionTime, Reporter.PASS);
                            return;
                        } else {
                            BasicOperationsHandler.takeScreenShot();
                            BaseTestUtils.report("something wrong with task execution", Reporter.FAIL);

                        }


                    }


                }


                Thread.sleep(10000);
                timeout -= 10000;
            } while (timeout > 0);
            BasicOperationsHandler.takeScreenShot();
            BaseTestUtils.report("time ended and task still not executed yet", Reporter.FAIL);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);

        }

    }

    @Test
    @TestProperties(name = "Remove Security Signature File", paramsInclude = {"qcTestId", "deviceIp", "username", "password", "filePathToDelete"})
    public void removeSecuritySignatureFile() {
        try {
            if (filePathToDelete == null || filePathToDelete.isEmpty()) {
                ValidateTasksHandler.removeDpSecurityFileRepeater(deviceIp, getRestTestBase().getRootServerCli(), username, password, defaultFileName, 5);
            } else {
                ValidateTasksHandler.removeDpSecurityFileRepeater(deviceIp, getRestTestBase().getRootServerCli(), username, password, filePathToDelete, 5);

            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to remove Security Signature files for device: " + deviceIp + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify DPConfiguration Templates per Device", paramsInclude = {"qcTestId", "taskName", "deviceName", "networkProtectionPolicyList", "serverProtectionPolicyList"})
    public void verifyDPConfigurationTemplatesTest() {
        try {
            HashMap<String, String> testProperties = new HashMap<String, String>();
            testProperties.put("taskName", taskName);
            testProperties.put("taskColumnName", taskColumnName);
            testProperties.put("deviceName", getDeviceName());
            testProperties.put("networkProtectionPolicyList", networkProtectionPolicyList);
            testProperties.put("serverProtectionPolicyList", serverProtectionPolicyList);
            testProperties.put("policyColumnName", "Policy Name");
            testProperties.put("serverColumnName", "Server Name");
            if (!ValidateTasksHandler.validateDPConfigurationTemplatesTask(testProperties, getVisionRestClient())) {
                BaseTestUtils.report("Verify DeviceConfiguration Backup failed: " + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify DeviceConfiguration Backup failed: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * wait for task execution to finish
     * in case the destination is server , will do the below steps:
     * navigate to System->Device Resources -> Device Backups
     * check if the device config exists
     * verify file name convention dependent on the device type
     * check if export date is after the task scheduled task time
     * <p>
     * in case its external :
     * verify if the file name exists under the file path and matches the naming convention as specified in the test case
     */
    @Test
    @TestProperties(name = "Verify DeviceConfiguration Backup", paramsInclude = {"qcTestId", "taskName", "deviceName", "timePeriodToVerify", "filePath", "fileName"})
    public void verifyDeviceConfigurationBackupTest() {
        try {
            if (!ValidateTasksHandler.validateDeviceConfigurationBackupTask(taskName, getDeviceName(), timePeriodToVerify, filePath, fileName, getVisionRestClient(), restTestBase.getLinuxServerCredential(getRestTestBase().getLinuxFileServer()))) {
                BaseTestUtils.report("Verify DeviceConfiguration Backup failed: " + "\n." + ValidateTasksHandler.errorMessages.toString(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify DeviceConfiguration Backup failed: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        } finally {
            ValidateTasksHandler.errorMessages.clear();
        }
    }

    @Test
    @TestProperties(name = "Verify Device reboot", paramsInclude = {"qcTestId", "taskColumnName", "taskName", "deviceName", "maxTimePeriodToVerifyStatus", "parentTree"})
    public void verifyDeviceRebootTest() {
        try {
            HashMap<String, String> testProperties = new HashMap<String, String>();
            testProperties.put("taskName", taskName);
            testProperties.put("taskColumnName", taskColumnName);
            testProperties.put("deviceName", getDeviceName());
            testProperties.put("timePeriodToVerify", timePeriodToVerify);
            testProperties.put("parentTree", parentTree.getTopologyTreeTab());

            if (!ValidateTasksHandler.validateDeviceRebootTask(testProperties, getVisionRestClient())) {
                BaseTestUtils.report("Verify DeviceConfiguration Backup failed: " + "\n." + ValidateTasksHandler.errorMessages.toString(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify Device reboot failed: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        } finally {
            ValidateTasksHandler.errorMessages.clear();
        }
    }

    @Test
    @TestProperties(name = "Verify APsoluteVisionConfigurationBackup Task", paramsInclude = {"taskName", "fileName", "filePath", "destination"})
    public void verifyAPsoluteVisionConfigurationBackupTest() {
        try {
            BaseTasksHandler.wait4TaskFinished(taskName, getVisionRestClient());
            BasicOperationsHandler.delay(10);
            if (destination.equals(BackupDestinations.EXTERNAL_LOCATION)) {
                if (!ValidateTasksHandler.executeFileExistenceVerifyScript(getRestTestBase().getLinuxFileServer(), filePath, fileName)) {
                    BaseTestUtils.report("the file : ".concat(fileName).concat("does not exist ") + "\n.", Reporter.FAIL);
                }
            } else if (destination.equals(BackupDestinations.VISION_SERVER)) {
                //in the cli it shows only the first 6 letters of the task name
                if (taskName.length() > 6) {
                    taskName = taskName.substring(0, 6);
                }
                ConfBackup.confBackupList(getRestTestBase().getRadwareServerCli(), taskName.split(" "));
                if (!ValidateTasksHandler.executeFileExistenceVerifyScript(getRestTestBase().getRootServerCli(), visionBackupFilePath, visionBackupFilePrefix.concat(taskName))) {
                    BaseTestUtils.reporter.report("The config file does not exist in the vision file system");
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify APsoluteVisionConfigurationBackup failed: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify APsoluteVisionReportBackup Task", paramsInclude = {"taskName", "fileName", "filePath", "destination"})
    public void verifyAPsoluteVisionReportBackupTest() {
        try {
            BaseTasksHandler.wait4TaskFinished(taskName, getVisionRestClient());
            BasicOperationsHandler.delay(10);
            if (destination.equals(BackupDestinations.EXTERNAL_LOCATION)) {
                if (!ValidateTasksHandler.executeFileExistenceVerifyScript(getRestTestBase().getLinuxFileServer(), filePath, fileName)) {
                    BaseTestUtils.report("the file : ".concat(fileName).concat("does not exist ") + "\n.", Reporter.FAIL);
                }
            } else if (destination.equals(BackupDestinations.VISION_SERVER)) {
                //in the cli it shows only the first 6 letters of the task name
                if (taskName.length() > 6) {
                    taskName = taskName.substring(0, 6);
                }
                ReporterBackup.VerifyBackupInListAsRegex(taskName, getRestTestBase().getRadwareServerCli());
                if (!ValidateTasksHandler.executeFileExistenceVerifyScript(getRestTestBase().getRootServerCli(), visionBackupFilePath, visionReporterBackupPrefix.concat(taskName))) {
                    BaseTestUtils.report("The config file does not exist in the vision file system");
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify APsoluteVisionConfigurationBackup failed: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "Verify UpdateRSASecuritySignature Task", paramsInclude = {"qcTestId", "taskColumnName", "taskName", "deviceName", "deviceIp", "parentTree", "timePeriodToVerifyLastSignatureUpdate"})
    public void verifyUpdateRSASecuritySignatureTest() {
        try {
            HashMap<String, String> testProperties = new HashMap<String, String>();
            updateNavigationParser(Device.getDeviceIp(getVisionRestClient(), getDeviceName()));
            testProperties.put("deviceName", getDeviceName());
            testProperties.put("parentTree", parentTree.getTopologyTreeTab().toString());
            testProperties.put("taskColumnName", taskColumnName);
            testProperties.put("taskName", taskName);
            testProperties.put("deviceIp", deviceIp);
            testProperties.put("timePeriodToVerifyLastSignatureUpdate", timePeriodToVerifyLastSignatureUpdate);

            if (!ValidateTasksHandler.validateUpdateRSASecuritySignatureTask(testProperties, getVisionRestClient())) {
                BaseTestUtils.report("Verify UpdateRSASecuritySignature failed: " + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify UpdateRSASecuritySignature failed: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * this test will wait for task run and looks for the expected alert message in the alerts table
     */
    @Test
    @TestProperties(name = "Verify Update Fraud Security Signatures ", paramsInclude = {"taskName", "expectedAlertMessage"})
    public void verifyUpdateFraudSecuritySignatures() throws Exception {
        if (taskName == null || expectedAlertMessage == null) {
            throw new Exception("Some/all of the test inputs equal to null");
        }

        if (!ValidateTasksHandler.validateUpdateFraudSecuritySignatures(taskName, expectedAlertMessage, restTestBase.getVisionRestClient())) {

            BaseTestUtils.report("the alerts message was not found ".concat(expectedAlertMessage), Reporter.FAIL);
        } else {

            BaseTestUtils.report("Update Fraud Security Signatures Validation Succeeded", Reporter.PASS);
        }

    }


    @Test
    @TestProperties(name = "Verify UpdateSecuritySignatureFile Task", paramsInclude = {"taskName", "deviceName", "deviceIp", "parentTree", "defaultFileName"})
    public void verifyUpdateSecuritySignatureFileTest() {
        try {
            HashMap<String, String> testProperties = new HashMap<String, String>();
            updateNavigationParser(Device.getDeviceIp(getVisionRestClient(), getDeviceName()));
            testProperties.put("deviceName", getDeviceName());
            testProperties.put("parentTree", parentTree.getTopologyTreeTab().toString());
            testProperties.put("taskColumnName", taskColumnName);
            testProperties.put("taskName", taskName);
            testProperties.put("defaultFileName", defaultFileName);

            if (!ValidateTasksHandler.validateUpdateSecuritySignatureFileTask(testProperties, getVisionRestClient())) {
                BaseTestUtils.report("Verify UpdateSecuritySignatureFile failed: " + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify UpdateSecuritySignatureFile failed: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify Update Attack Description File Task", paramsInclude = {"taskColumnName", "taskName", "parentTree", "expectedAlertMessage"})
    public void verifyUpdateAttackDescriptionFileTest() {
        try {
            HashMap<String, String> testProperties = new HashMap<String, String>();
            testProperties.put("parentTree", parentTree.getTopologyTreeTab().toString());
            testProperties.put("taskColumnName", taskColumnName);
            testProperties.put("taskName", taskName);
            // testProperties.put("deviceIp", deviceIp);

            if (!ValidateTasksHandler.validateUpdateAttackDescriptionFileTask(testProperties, getVisionRestClient(), expectedAlertMessage)) {
                BaseTestUtils.report("Verify Update Attack Description File failed: ".concat(ValidateTasksHandler.errorMessages.toString()) + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify UpdateAttachDescriptionFile failed: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        } finally {
            ValidateTasksHandler.errorMessages.clear();
        }
    }


    @Test
    @TestProperties(name = "Verify ADC Create User Task", paramsInclude = {"taskName", "userId", "deviceName", "deviceIp"})
    public void verifyAdcCreateUser() throws Exception {
        ValidateTasksHandler.wait4TaskFinished(taskName, restTestBase.getVisionRestClient());
        try {
            if (!LocalUsersHandler.checkIfUserExist(userId, getDeviceName())) {
                webUtils.generateAndReportScreeshort();
                throw new Exception("use with id " + userId + " does not exists");
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "Verify ADC Create User Task", paramsInclude = {"taskName", "userId", "deviceName", "deviceIp"})
    public void verifyAdcDeleteUser() throws Exception {
        ValidateTasksHandler.wait4TaskFinished(taskName, restTestBase.getVisionRestClient());
        try {
            if (LocalUsersHandler.checkIfUserExist(userId, getDeviceName())) {
                webUtils.generateAndReportScreeshort();
                throw new Exception("use with id " + userId + " does exists");
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @After
    public void deleteOutputFiles() {
        String baseCommand = "rm -rf ";
        try {
            String command = baseCommand.concat(filePath).concat("/").concat(fileName).concat("*");
            InvokeUtils.invokeCommand(command, WebUITestBase.getRestTestBase().getLinuxFileServer());
            BasicOperationsHandler.delay(5);
        } catch (Exception e) {
//            Ignore
        }
    }

    public String getFilePathToDelete() {
        return filePathToDelete;
    }

    @ParameterProperties(description = "insert the file path include the file name to delete.")
    public void setFilePathToDelete(String filePathToDelete) {
        this.filePathToDelete = filePathToDelete;
    }

    public String getTimePeriodToVerifyLastSignatureUpdate() {
        return timePeriodToVerifyLastSignatureUpdate;
    }

    @ParameterProperties(description = "Specify time Period to verify last RSA signature update (in seconds): ")
    public void setTimePeriodToVerifyLastSignatureUpdate(String timePeriodToVerifyLastSignatureUpdate) {
        this.timePeriodToVerifyLastSignatureUpdate = timePeriodToVerifyLastSignatureUpdate;
    }

    public String getDeviceIp() {
        return deviceIp;
    }

    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getTimePeriodToVerify() {
        return timePeriodToVerify;
    }

    @ParameterProperties(description = "Specify time Period to verify backup creation (in seconds): ")
    public void setTimePeriodToVerify(String timePeriodToVerify) {
        this.timePeriodToVerify = timePeriodToVerify;
    }

    public String getTaskName() {
        return taskName;
    }

    @ParameterProperties(description = "Specify the taskName to look for: ")
    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getTaskColumnName() {
        return taskColumnName;
    }

    @ParameterProperties(description = "Specify columnName to look for a task in: ")
    public void setTaskColumnName(String taskColumnName) {
        this.taskColumnName = taskColumnName;
    }

    public TopologyTreeTabs getParentTree() {
        return parentTree;
    }

    public void setParentTree(TopologyTreeTabs parentTree) {
        this.parentTree = parentTree;
    }

    public String getDefaultFileName() {
        return defaultFileName;
    }

    public void setDefaultFileName(String defaultFileName) {
        this.defaultFileName = defaultFileName;
    }

    public String getNetworkProtectionPolicyList() {
        return networkProtectionPolicyList;
    }

    @ParameterProperties(description = "Specify Network Policies. Must be separated by <,>!")
    public void setNetworkProtectionPolicyList(String networkProtectionPolicyList) {
        this.networkProtectionPolicyList = networkProtectionPolicyList;
    }

    public String getServerProtectionPolicyList() {
        return serverProtectionPolicyList;
    }

    @ParameterProperties(description = "Specify Server Policies. Must be separated by <,>!")
    public void setServerProtectionPolicyList(String serverProtectionPolicyList) {
        this.serverProtectionPolicyList = serverProtectionPolicyList;
    }

    public String getTaskSchedRunTime() {
        return taskSchedRunTime;
    }

    public void setTaskSchedRunTime(String taskSchedRunTime) {
        this.taskSchedRunTime = taskSchedRunTime;
    }

    public int getTimeout() {
        return timeout;
    }

    @ParameterProperties(description = "time to wait in seconds")
    public void setTimeout(int timeout) {
        this.timeout = timeout * 1000;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public BackupDestinations getDestination() {
        return destination;
    }

    public void setDestination(BackupDestinations destination) {
        this.destination = destination;
    }

    public String getExpectedAlertMessage() {
        return expectedAlertMessage;
    }

    @ParameterProperties(description = "Using '|' between alerts will verify if one of them exists." +
            "use',' to split messages ")
    public void setExpectedAlertMessage(String expectedAlertMessage) {
        this.expectedAlertMessage = expectedAlertMessage;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

}

