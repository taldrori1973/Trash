package com.radware.vision.infra.testhandlers.scheduledtasks.validateScheduledTasks;

import com.aqua.sysobj.conn.CliConnectionImpl;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.ExecuteShellCommands;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.automation.tools.utils.LinuxServerCredential;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.networkprotectionrules.NetworkProtectionPolicies;
import com.radware.automation.webui.webpages.dp.configuration.serverprotection.serverprotectionpolicy.ServerProtectionPolicy;
import com.radware.automation.webui.webpages.dp.configuration.setup.globalParameters.GlobalParameters;
import com.radware.automation.webui.webpages.dp.monitoring.operationalstatus.overview.Overview;
import com.radware.automation.webui.widgets.impl.table.WebUIRow;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.restcore.VisionRestClient;
import com.radware.utils.DeviceUtils;
import com.radware.utils.scheduler.ScheduledTasksUtils;
import com.radware.utils.scheduler.Utils;
import com.radware.vision.infra.base.pages.VisionServerInfoPane;
import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.system.deviceresources.devicebackups.DeviceBackups;
import com.radware.vision.infra.base.pages.system.generalsettings.basicparameters.BasicParameters;
import com.radware.vision.infra.testhandlers.DefencePro.enums.UpdateFromSource;
import com.radware.vision.infra.testhandlers.alerts.AlertsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.dptemplates.TemplatesHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.BaseTasksHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.BackupDestinations;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.pojomodel.helpers.constants.ImConstants$ScheduledTaskExecutionStatusEnumPojo;
import com.radware.vision.vision_project_cli.RootServerCli;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import testhandlers.vision.config.itemlist.scheduler.tasks.enums.ScheduledTaskTypes;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.*;
import java.time.temporal.ChronoUnit;
import java.util.*;

import static java.time.temporal.ChronoUnit.SECONDS;

/**
 * Created by stanislava on 11/19/2014.
 */
public class ValidateTasksHandler extends BaseTasksHandler {
    public static List<String> errorMessages = new ArrayList<String>();


    public static boolean validateDPConfigurationTemplatesTask(HashMap<String, String> testProperties, VisionRestClient visionRestClient) throws Exception {
        boolean networkPoliciesSent = true;
        boolean serverPoliciesSent = true;
        List<String> deviceNameList = Arrays.asList(testProperties.get("deviceName").split(","));
        boolean serverValidation = BaseTasksHandler.runNowBaseTask(testProperties.get("taskColumnName"), testProperties.get("taskName"), deviceNameList, visionRestClient);

        if (!serverValidation) {
            BasicOperationsHandler.scheduler(true);
            WebUIUtils.generateAndReportScreenshot();
            return false;
        }
        //validate policies
        List<String> policies = Arrays.asList(testProperties.get("networkProtectionPolicyList").split("\\,"));
        for (int i = 0; i < policies.size() && networkPoliciesSent == true; i++) {
            if (!validateNetworkProtectionTemplate(testProperties.get("deviceName"), policies.get(i), testProperties.get("policyColumnName"))) {
                networkPoliciesSent = false;
            }
        }

        policies = Arrays.asList(testProperties.get("serverProtectionPolicyList").split("\\,"));
        for (int i = 0; i < policies.size() && serverPoliciesSent == true; i++) {
            if (!validateServerProtectionTemplate(testProperties.get("deviceName"), policies.get(i), testProperties.get("serverColumnName"))) {
                serverPoliciesSent = false;
            }
        }

        if (networkPoliciesSent && serverPoliciesSent && serverValidation) {
            return true;
        }
        return false;
    }

    public static boolean validateNetworkProtectionTemplate(String deviceName, String policyName, String columnName) {
        TopologyTreeHandler.clickTreeNode(deviceName);
        TopologyTreeHandler.openDeviceInfoPane();
        NetworkProtectionPolicies networkProtectionPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        networkProtectionPolicies.openPage();
        WebUITable table = networkProtectionPolicies.getTable();
        return TemplatesHandler.validateTemplate(columnName, policyName, table);
    }

    public static boolean validateServerProtectionTemplate(String deviceName, String policyName, String columnName) {
        TopologyTreeHandler.clickTreeNode(deviceName);
        TopologyTreeHandler.openDeviceInfoPane();
        ServerProtectionPolicy serverProtectionPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mServerProtection().mServerProtectionPolicy();
        serverProtectionPolicies.openPage();
        WebUITable table = serverProtectionPolicies.getTable();
        return TemplatesHandler.validateTemplate(columnName, policyName, table);
    }

    public static boolean validateDeviceConfigurationBackupTask(String taskName, String deviceName, String timePeriodToVerify, String filePath, String fileName, VisionRestClient visionRestClient, LinuxServerCredential linuxServerCredential) throws Exception {
        Map<String, Object> task = ScheduledTasksUtils.getTaskByNameAndType(visionRestClient, taskName, ScheduledTaskTypes.Device_Configuration_Backup.getTaskType());
        LocalTime taskScheduledTime = Utils.getTaskClientScheduleTime(task);
        List<String> deviceNameList = Arrays.asList(deviceName.split(","));
        String backupType = (String) task.get("backupDestination");
        wait4TaskFinished(taskName, visionRestClient);
        if (backupType.equals(BackupDestinations.EXTERNAL_LOCATION.toString())) {
            return validateExternalLocationDeviceConfBackup(filePath, fileName, deviceNameList, visionRestClient, linuxServerCredential);
        } else if (backupType.equals(BackupDestinations.VISION_SERVER.toString())) {
            return validateVisionServerDeviceConfBackup(taskName, deviceNameList, timePeriodToVerify, taskScheduledTime, visionRestClient);
        }

        return false;
    }

    /**
     * @param filePath              the file path
     * @param fileName              the file name
     * @param deviceNameList        the device to look for
     * @param visionRestClient
     * @param linuxServerCredential
     * @return checks if all the files under the file path their name matches the expected file convention
     * @throws Exception
     */
    public static boolean validateExternalLocationDeviceConfBackup(String filePath, String fileName, List<String> deviceNameList, VisionRestClient visionRestClient, LinuxServerCredential linuxServerCredential) throws Exception {
        String expectedFileName;
        String outputResult = ExecuteShellCommands.getInstance().runRemoteShellCommand(linuxServerCredential, "ls -l " + filePath);
        for (int i = 0; i < deviceNameList.size(); i++) {
            expectedFileName = buildExternalDeviceConfigurationFileNameConvention(fileName, deviceNameList.get(i), visionRestClient);
            if (outputResult.matches(expectedFileName)) {
                continue;
            } else {
                errorMessages.add("The file does not exists or it does not match the expected file name");
                errorMessages.add("Expected file name is " + expectedFileName.toString());
                errorMessages.add("The files under the path " + filePath + " are :" + outputResult.toString());
                return false;
            }
        }
        return true;
    }


    private static boolean validateVisionServerDeviceConfBackup(String taskName, List<String> deviceNameList, String timePeriodToVerify, LocalTime taskScheduledTime, VisionRestClient visionRestClient) throws InterruptedException {

        DeviceBackups deviceBackups = openDeviceBackupMenu();
        WebUITable table = deviceBackups.getDeviceBackupsTable();
        BasicOperationsHandler.refresh();
        table.setWaitForTableToLoad(true);
        table.analyzeTable("div");
        if (!table.waitForContent(60 * 1000)) {
            errorMessages.add("the device backups table is empty");
            return false;
        }

        for (String deviceName : deviceNameList) {

            int matchRow = validateBackupDate(table, timePeriodToVerify, taskScheduledTime, deviceName);
            if (matchRow == -1) {
                errorMessages.add("no entry was found that matches the test params");
                return false;
            } else {
                final int exportDateColumn = table.getColIndex("Export Date");
                LocalTime exportDate = TimeUtils.addMissingDigits(table.getRows().get(matchRow).getCell(exportDateColumn).value().split(" ")[1]);
                String expectedBackupFileName = buildVisionDeviceConfigurationFileNameConvention(deviceName, exportDate, visionRestClient);
                if (!validateBackupFileName(table, matchRow, expectedBackupFileName)) {
                    return false;
                }
            }
        }
        return true;
    }

    public static boolean validateBackupFileName(WebUITable table, int row, String expectedBackupFileName) {
        int fileNameColumn = table.getColumnIndex("File Name");
        String fileName = table.getRows().get(row).getCell(fileNameColumn).value();
        if (fileName.equals(expectedBackupFileName)) {
            return true;
        }
        errorMessages.add("Actual file name is <" + fileName + "> is not equal to expected <" + expectedBackupFileName + ">");
        return false;
    }

    /**
     * @param deviceName       the device name
     * @param exportDate       task scheduled time to run
     * @param visionRestClient vision rest client
     * @return the device configuration back name
     */
    public static String buildVisionDeviceConfigurationFileNameConvention(String deviceName, LocalTime exportDate, VisionRestClient visionRestClient) {
        LocalDateTime serverDateTime = LocalDateTime.now(ZoneId.ofOffset("", ZoneOffset.UTC));
        int systemOffSetInHours = OffsetDateTime.now(ZoneId.systemDefault()).getOffset().getId().contains("2") ? 2 : 3;
        String fileNameExtension;
        if (DeviceUtils.getDeviceType(visionRestClient, deviceName).toLowerCase().contains("defensepro")) {
            fileNameExtension = ".txt";
        } else {
            fileNameExtension = ".tgz";
        }
        //update task schedule time to the server hour time
        LocalTime fileNameTime = LocalTime.of(exportDate.minus(systemOffSetInHours, ChronoUnit.HOURS).getHour(), exportDate.getMinute(), exportDate.getSecond());

        StringBuilder fileName = new StringBuilder();
        fileName.append(deviceName)
                .append("_Configuration_")
                .append(serverDateTime.getYear() + "." + String.format("%02d", serverDateTime.getMonth().getValue()) + "." + String.format("%02d", serverDateTime.getDayOfMonth()))
                .append("_")
                .append(TimeUtils.get2DigitsTimeWithDelimiter(fileNameTime, "."))
                .append(fileNameExtension);
        return fileName.toString();


    }

    /**
     * @param fileName
     * @param deviceName
     * @param visionRestClient
     * @return the external device configuration name as regex
     */
    public static String buildExternalDeviceConfigurationFileNameConvention(String fileName, String deviceName, VisionRestClient visionRestClient) {
        LocalDate nowDate = LocalDate.now();
        StringBuilder expectedFileName = new StringBuilder();
        expectedFileName.append(fileName)
                .append("_")
                .append(nowDate.getYear())
                .append(String.format("%02d", nowDate.getMonth().getValue()))
                .append(String.format("%02d", nowDate.getDayOfMonth()))
                .append("_")
                .append("\\d{4}")
                .append("_");
        expectedFileName.append(deviceName);
        if (DeviceUtils.getDeviceType(visionRestClient, deviceName).toLowerCase().contains("defensepro")) {
            expectedFileName.append(".txt");
        } else {
            expectedFileName.append(".tgz");
        }
        return "(.)+(" + expectedFileName + ")(.)*";
    }

    public static boolean validateDeviceRebootTask(HashMap<String, String> testProperties, VisionRestClient visionRestClient) throws Exception {
        List<String> deviceNameList = Arrays.asList(testProperties.get("deviceName").split(","));
        BaseTasksHandler.wait4TaskFinished(testProperties.get("taskName"), visionRestClient);
        for (String deviceName : deviceNameList) {
            if (!validateDeviceStatus(deviceName, testProperties.get("timePeriodToVerify"))) {
                return false;
            }
        }
        return true;
    }

    public static boolean validateUpdateRSASecuritySignatureTask(HashMap<String, String> testProperties, VisionRestClient visionRestClient) throws Exception {
        List<String> deviceNameList = Arrays.asList(testProperties.get("deviceName").split(","));
        boolean serverValidation = BaseTasksHandler.runNowBaseTask(testProperties.get("taskColumnName"), testProperties.get("taskName"), deviceNameList, visionRestClient);
        if (serverValidation && validateUpdateRSASecuritySignature(testProperties.get("deviceName"))) {
            return true;
        } else return false;
    }

    public static boolean validateUpdateFraudSecuritySignatures(String taskName, String alertMessage, VisionRestClient visionRestClient) throws Exception {

        List<String> allAlerts = Arrays.asList(alertMessage.split("\\|"));
        wait4TaskFinished(taskName, visionRestClient);
        BasicOperationsHandler.delay(10);
        for (String alert : allAlerts) {
            if (AlertsHandler.validateAlert("Message", alert)) {
                return true;
            }
        }
        return false;
    }

    public static boolean validateERTActiveDDosFeed(String taskName, ImConstants$ScheduledTaskExecutionStatusEnumPojo status, String alertMessage, VisionRestClient visionRestClient) throws Exception {
        wait4TaskStatus(taskName, status, visionRestClient);
        BasicOperationsHandler.delay(10);
        if (AlertsHandler.validateAlert("Message", alertMessage)) {
            return true;
        }
        return false;
    }

    public static boolean validateUpdateSecuritySignatureFileTask(HashMap<String, String> testProperties, VisionRestClient visionRestClient) throws Exception {
//        renameDefaultFile(testProperties.get("defaultFileName"), cli);
        String ssVersion = getSignatureFileVersionFromSite();
        String deviceName = testProperties.get("deviceName");
        boolean serverValidation = wait4TaskFinished(testProperties.get("taskName"), visionRestClient);
        WebUIBasePage.refreshBrowser();
        BasicOperationsHandler.delay(5);
        if (serverValidation && validateUpdateSecuritySignatureFiles(deviceName, ssVersion, UpdateFromSource.UPDATE_FROM_RADWARE.getSource())) {
            return true;
        } else return false;
    }

    public static boolean validateUpdateSecuritySignatureFiles(String deviceName, String ssVersion, String updateType) {
        String signatureVersion = getSignatureVersionFromDp(deviceName);
        String errMsg = "";
        if (signatureVersion != null && !signatureVersion.equals("")) {
            if (updateType.equals(UpdateFromSource.UPDATE_FROM_CLIENT.getSource())) {
                if (signatureVersion.equals(ssVersion)) {
                    return true;
                }
                errMsg = String.format("Before Signature Version: %s, Current Signature Version: %s", ssVersion, signatureVersion);
            } else if (updateType.equals(UpdateFromSource.UPDATE_FROM_RADWARE.getSource())) {

                if (((ssVersion != null && !ssVersion.isEmpty()) ? (Integer.parseInt(ssVersion.replace(".", ""))) : 0)
                        == ((signatureVersion != null && !signatureVersion.isEmpty()) ? (Integer.parseInt(signatureVersion.replace(".", ""))) : 0)) {
                    return true;
                }
                errMsg = String.format("Radware Signature Version: %s, Current Signature Version: %s", ssVersion, signatureVersion);
            }
        }
        throw new RuntimeException(errMsg);
    }

    public static boolean validateUpdateRSASecuritySignatureOld(String deviceName, String timePeriodToVerify) throws Exception {
        long deviceDateAndTime = getDeviceDate(deviceName);
        if (timePeriodToVerify != null && !timePeriodToVerify.equals("")) {
            int timePeriodToVerifyMili = Integer.parseInt(timePeriodToVerify) * 1000;
            String rsaSignatureLastUpdateField = getRSASignatureLastUpdateField(deviceName);
            Long rsaSignatureLastUpdateDateAndTime = parseSignaturesLastUpdateDate(rsaSignatureLastUpdateField);
            if (rsaSignatureLastUpdateDateAndTime - deviceDateAndTime < timePeriodToVerifyMili && rsaSignatureLastUpdateDateAndTime - deviceDateAndTime >= 0) {
                return true;
            }
            return false;
        }
        return true;
    }

    public static boolean validateUpdateRSASecuritySignature(String deviceName) throws Exception {
        String rsaSignatureLastUpdateDateAndTime = getRSASignatureLastUpdateField(deviceName);
        if (!rsaSignatureLastUpdateDateAndTime.equals("") && !rsaSignatureLastUpdateDateAndTime.contains("No Feeds Received Since Device Boot")) {
            return true;
        } else if (rsaSignatureLastUpdateDateAndTime.contains("No Feeds Received Since Device Boot")) {
            throw new RuntimeException("RSA Signatures were not updated or noUpdate is available!");
        }
        return false;
    }

    public static boolean validateUpdateAttackDescriptionFileTask(HashMap<String, String> testProperties, VisionRestClient visionRestClient, String alerts) throws Exception {
        List<String> deviceNameList = new LinkedList<>();
        wait4TaskFinished(testProperties.get("taskName"), visionRestClient);
        List<String> allAlertsToVerify = Arrays.asList(alerts.split(","));
        BasicOperationsHandler.delay(10);
        for (String alert : allAlertsToVerify) {
            if (!AlertsHandler.validateAlert("Message", alert)) {
                errorMessages.add(alert + " did not found");
                return false;
            }
        }
        String attachDescriptionFileLastUpdate = getAttachDescriptionFileLastUpdate();
        if (attachDescriptionFileLastUpdate != null && !attachDescriptionFileLastUpdate.equalsIgnoreCase("")) {
            return true;
        }
        errorMessages.add("Attack Descriptions File Last Update is empty");
        return false;
    }

    public static String getAttachDescriptionFileLastUpdate() {
        BasicOperationsHandler.settings();
        BasicParameters basicParameters = openBasicParametersMenu();

        return basicParameters.getAttackDescriptionsFile().getAttackDescriptionsFileLastUpdate();
    }

    public static void renameDefaultFile(String defaultFileName, CliConnectionImpl cli) throws Exception {

        try {
            String baseCommand = "system file-system files rename";
            String command = baseCommand.concat(" ").concat(defaultFileName).concat(" ").concat(defaultFileName.concat("Old"));
            InvokeUtils.invokeCommand(command, cli);

        } catch (Exception e) {
            throw new Exception("renameFile operation has failed: " + e.getMessage());
        }
    }

    public static long getDeviceDate(String deviceName) {
        TopologyTreeHandler.clickTreeNode(deviceName);
        GlobalParameters globalParameters = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mGlobalParameters();

        globalParameters.openPage();
        globalParameters.mDateAndTime().openTab();
        String deviceDate = globalParameters.mDateAndTime().getDeviceDate();
        String deviceTime = globalParameters.mDateAndTime().getDeviceTime();

        return getBackupDateEpoch((deviceDate.concat(" ").concat(deviceTime)).replace("/", "."));
    }

    public static String getRSASignatureLastUpdateField(String deviceName) {
        TopologyTreeHandler.clickTreeNode(deviceName);
        Overview overview = DeviceVisionWebUIUtils.dpUtils.dpProduct.mMonitoring().mOperationalStatus().mOverview();

        overview.openPage();
        overview.mSignatureUpdate().openTab();
        String rsaSignaturesLastUpdate = overview.mSignatureUpdate().getRSASignaturesLastUpdate();

        return rsaSignaturesLastUpdate;
    }

    public static String getSignatureVersionFromDp(String deviceName) {
        TopologyTreeHandler.openDeviceSitesClusters(deviceName);
        Overview overview = DeviceVisionWebUIUtils.dpUtils.dpProduct.mMonitoring().mOperationalStatus().mOverview();
        overview.openPage();
        overview.mSignatureUpdate().openTab();
        String signaturesVersion = "";
        int count = 0;
        do {
            BasicOperationsHandler.delay(1);
            signaturesVersion = overview.mSignatureUpdate().getRadwareSignatureFileVersion();
        } while (signaturesVersion.isEmpty() && (count++ < 5));
        return signaturesVersion;
    }

    public static long parseSignaturesLastUpdateDate(String date) {
        DateFormat format = new SimpleDateFormat("EEE MMM dd hh:mm:ss yyyy");
        Date parsedDate = new Date();
        try {
            parsedDate = format.parse(date);
        } catch (Exception e) {

        }
        return parsedDate.getTime();
    }

    public static boolean validateDeviceStatus(String deviceName, String maxTimePeriodToVerifyStatus) {
        long second = 1000;
        long maxWaitTimeout = 0;
        try {
            maxWaitTimeout = Integer.parseInt(maxTimePeriodToVerifyStatus) * second;
        } catch (Exception e) {

        }
        long startTime = System.currentTimeMillis();
        String deviceStatus;
        do {
            TopologyTreeHandler.clickTreeNode(deviceName);
            BasicOperationsHandler.delay(1);
            VisionServerInfoPane visionServerInfoPane = new VisionServerInfoPane();
            deviceStatus = visionServerInfoPane.getDeviceStatus();
            if (deviceStatus.equals("Down") || deviceStatus.equals("Maintenance")) {
                return true;
            }
        }
        while (System.currentTimeMillis() - startTime < maxWaitTimeout);
        BasicOperationsHandler.scheduler(false);
        errorMessages.add("Device name " + deviceName + " and it status " + deviceStatus);
        return false;
    }

    /**
     * @param table              device backups table
     * @param timePeriodToVerify time in seconds
     * @param taskScheduledTime  the task scheduled time to run
     * @param deviceName         the device name
     * @return if its timePeriodToVerify is lower that taskScheduledTime - Export Date will be returned the row number else -1
     */

    public static int validateBackupDate(WebUITable table, String timePeriodToVerify, LocalTime taskScheduledTime, String deviceName) {
        if (table.getRows().size() == 0) {
            return -1;
        }
        final int validTimePeriod = Integer.parseInt(timePeriodToVerify);
        final int exportDateColumn = table.getColIndex("Export Date");
        final int deviceNameColumn = table.getColIndex("Device Name");
        List<WebUIRow> backupForDevices = table.getRows();
        for (int i = 0; i < backupForDevices.size(); i++) {
            if (backupForDevices.get(i).getCell(deviceNameColumn).value().equals(deviceName)) {
                LocalTime backupDate = TimeUtils.addMissingDigits(backupForDevices.get(i).getCell(exportDateColumn).value().split(" ")[1]);

                long timeElapsed = taskScheduledTime.until(backupDate, SECONDS);
                //not the one we are looking for
                if (timeElapsed < 0) {
                    continue;
                } else if (timeElapsed <= validTimePeriod) {
                    return i;
                }
            }
        }
        return -1;
    }

    public static boolean validateBackupDeviceName(WebUITable table, String deviceName) {
        if (table.getRows().get(0).getCells().get(table.getColIndex("Device Name")).value().equals(deviceName)) {
            return true;
        }
        return false;
    }

    public static long getBackupDateEpoch(String backupDate) {
        return TimeUtils.getEpochTime(backupDate, "dd.MM.yyyy hh:mm:ss");
    }


    public static DeviceBackups openDeviceBackupMenu() {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        return menuPane.openSystemDeviceResources().deviceBackupsMenu();
    }

    public static BasicParameters openBasicParametersMenu() {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        return menuPane.openSystemGeneralSettings().basicParametersMenu();
    }

    /**
     * if the file exists return true
     *
     * @param cli
     * @param filePath
     * @param fileName
     * @return
     * @throws Exception
     */
    public static boolean executeFileExistenceVerifyScript(CliConnectionImpl cli, String filePath, String fileName) throws Exception {
        try {
            String baseCommand = "ls -l ";
            String command = baseCommand.concat(filePath).concat("/").concat(fileName).concat("*");
            InvokeUtils.invokeCommand(command, cli);
            return !InvokeUtils.isTextAppearInOutput(cli, "cannot access");

        } catch (Exception e) {
            throw new Exception("executeScript operation has failed: " + e.getMessage());
        }
    }

//    public static void scpFileNameChange(String defaultFileName, String deviceIp, String userName, String password) {
//        try {
//            ch.ethz.ssh2.Connection conn = new ch.ethz.ssh2.Connection(deviceIp);
//            conn.connect();
//            conn.authenticateWithPassword(userName, password);
//            SCPClient scpclient = conn.createSCPClient();
//            scpclient.put(defaultFileName, "/root");
//        } catch (Exception e) {
//            throw new NullPointerException("copyFile operation has failed: " + e.getMessage());
//        }
//    }

//    public static void sshFtpFileNameChange(String defaultFileName, String deviceIp, String userName, String password) {
//        try {
//            ch.ethz.ssh2.Connection conn = new ch.ethz.ssh2.Connection(deviceIp);
//            conn.connect();
//            conn.authenticateWithPassword(userName, password);
//            SFTPClient scpclient = conn.;
//            scpclient.put(defaultFileName, "/root");
//        } catch (Exception e) {
//            throw new NullPointerException("copyFile operation has failed: " + e.getMessage());
//        }
//    }

    public static boolean validateTaskRunByServer(long timeout) {
        try {
            String message = WebUIBasePage.waitForLastYellowMessage(timeout);
            if (message != null && message.contains("failed to run scheduled task")) {
                WebUIUtils.isFindExceptionOccur = true;
                WebUIUtils.generateAndReportScreenshot();
                return false;
            } else return true;
        } catch (Exception e) {
//          Ignore - Warning pane probably does not exist
        } finally {
            WebUIUtils.isFindExceptionOccur = false;
        }
        return false;
    }

    public static String getSignatureFileVersionFromSite() {
        int requestNum = 3;
        String errorMsg = "";
        String url = "http://www.radware.com/modules/radware/packages/mis/autoattackupdate/FIRST.asp?protocol=2&pass=0003B254D4C0";
        GetMethod method = new GetMethod(url);

        HttpClient httpClient = new HttpClient();
        httpClient.getParams().setParameter("http.socket.timeout", new Integer(0));

        for (int i = 0; i < requestNum; i++) {
            try {
                httpClient.executeMethod(method);
                String response = method.getResponseBodyAsString();
                return response.substring(0, response.indexOf("@"));
            } catch (IOException e) {
                errorMsg = e.getMessage();
                if (i < requestNum) {
                    continue;
                }
            }
        }
        throw new RuntimeException(errorMsg);
    }

    public static void removeDpSecurityFileRepeater(String deviceIp, RootServerCli rootServerCli, String username, String password, String filePath, int tryCount) throws Exception {
        if (username == null || username.isEmpty()) {
            username = "radware";
        }
        if (password == null || password.isEmpty()) {
            password = "radware";
        }
        String rootServerCommand = "lftp sftp://" + username + ":" + password + "@" + deviceIp + " -e \"rm " + filePath + "\"";
        for (int i = 0; i < tryCount; i++) {
            try {
                InvokeUtils.invokeCommand(rootServerCommand, rootServerCli);
                String result = (rootServerCli.getTestAgainstObject() != null) ? rootServerCli.getTestAgainstObject().toString() : "";
                if (result.toLowerCase().contains("ok")) {
                    BaseTestUtils.report("File deleted", Reporter.PASS);
                    return;
                } else if (result.contains("Access failed: Failure (/cm:/db_f.bin)")) {
                    BaseTestUtils.report("Maybe the file does not exist : " + result, Reporter.WARNING);
                    return;
                } else if (i == tryCount - 1) {
                    BaseTestUtils.report(result, Reporter.WARNING);
                }

            } catch (Exception e) {
                if (e.getMessage() != null && e.getMessage().toLowerCase().contains("timeout")) {
                    continue;
                } else {
                    continue;
                }
            }
        }
    }

}
