package com.radware.vision.base;
/*

 */

import basejunit.RestTestBase;
import com.aas.vision.constants.AasVisionEnums;
import com.aqua.sysobj.conn.CliConnectionImpl;
import com.radware.automation.RadAutoDB;
import com.radware.automation.bdd.filtering.IgnoreList;
import com.radware.automation.bdd.reporter.BddReporterManager;
import com.radware.automation.bdd.reporter.JSystemReporter4Bdd;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.basetest.RuntimePropertiesEnum;
import com.radware.automation.tools.centralreporting.entities.ReportResultEntity;
import com.radware.automation.tools.centralreporting.manager.CentralReportingResultsManager;
import com.radware.automation.tools.cli.ServerCliBase;
import com.radware.automation.tools.reports.RallyTestReporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.automation.tools.utils.LinuxServerCredential;
import com.radware.automation.webui.UIUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.events.PopupEventHandler;
import com.radware.automation.webui.events.ReportWebDriverEventListener;
import com.radware.automation.webui.utils.navtree.VisionNavigationXmlParser;
import com.radware.automation.webui.utils.popup.MessageIdsIgnore;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.webpages.SerializeDeviceDriver;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.webpages.WebUIPage;
import com.radware.automation.webui.widgets.api.popups.PopupContent;
import com.radware.automation.webui.widgets.api.popups.PopupType;
import com.radware.restcommands.RestCommands;
import com.radware.restcore.VisionRestClient;
import com.radware.urlbuilder.vision.VisionUrlPath;
import com.radware.utils.DeviceUtils;
import com.radware.utils.TreeUtils;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DevicesManager;
import com.radware.vision.infra.enums.DeviceDriverType;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.utils.VisionWebUIUtils;
import com.radware.vision.infra.utils.threadutils.ThreadsStatusMonitor;
import com.radware.vision.pojomodel.helpers.constants.ImConstants$DeviceStatusEnumPojo;
import com.radware.vision.vision_project_cli.MysqlClientCli;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.vision_tests.CliTests;
import cucumber.runtime.junit.FeatureRunner;
import enums.SUTEntryType;
import jsystem.framework.ParameterProperties;
import junit.framework.SystemTestCase4;
import org.junit.After;
import org.junit.Before;
import testhandlers.Device;

import java.io.File;
import java.io.IOException;
import java.nio.file.NoSuchFileException;
import java.util.*;

public abstract class WebUITestBase extends SystemTestCase4 {
    protected boolean doTheVisionLabRestart = false;
    public static String retrievedParamValue = "";
    public static RestTestBase restTestBase;
    public static VisionWebUIUtils webUtils;
    public static String restOperationsUsername;
    public static String restOperationsPassword;
    public static boolean globalRestartVisionServerInNoResponse = false;
    private static Boolean isDeviceManagedByVision = false;

    // For Results Reporting
    public static CentralReportingResultsManager resultsManager = new CentralReportingResultsManager();
    protected static RallyTestReporter rallyTestReporter;
    protected static String reportAutomationMode;
    protected static DevicesManager devicesManager;
    private static String fileSeperator;
    private static String deviceTypeCurrent;
    private static boolean globalIsSeleniumRemoteOperation = false;
    private static Timer timer = new Timer();
    private static Map<String, String> deviceDriverNamesMap = new HashMap<String, String>();
    private static Map<String, VisionNavigationXmlParser> navigationParsers = new HashMap<String, VisionNavigationXmlParser>();
    private static boolean isUIInit = false;
    static boolean isRestInit = false;
    private static boolean outputVisionThreadUtilization = false;
    private static int visionThreadUtilizationReportIntervals = 5;
    public String browserSessionId;
    protected String targetTestId;
    protected String testCaseId = "0";
    protected boolean closeAllOpenedDialogsRequired = false;
    private String globalRemoteSeleniumServerHubIp = "10.205.191.170";
    private String globalRemoteSeleniumServerHubPort = "4444";
    private String popupContentKey = "popupContent";
    private DeviceDriverType deviceDriverType = DeviceDriverType.VISION;
    private String qcTestId;
    private String deviceName;

    public static VisionRestClient getVisionRestClient() {
        return restTestBase != null ? restTestBase.getVisionRestClient() : new VisionRestClient(null, null, null);
    }

    public static RestTestBase getRestTestBase() {
        return restTestBase;
    }

    public static MysqlClientCli getMysqlServerCli() {
        return restTestBase.getMysqlServer();
    }

    public static String getConnectionUsername() {
        return restTestBase.getVisionServer().getUser();
    }

    public static boolean getOutputVisionThreadUtilization() {
        return outputVisionThreadUtilization;
    }

    public static void setOutputVisionThreadUtilization(boolean outputVisionThreadUtilization) {
        WebUITestBase.outputVisionThreadUtilization = outputVisionThreadUtilization;
    }

    public static int getVisionThreadUtilizationReportIntervals() {
        return visionThreadUtilizationReportIntervals;
    }

    public static void setVisionThreadUtilizationReportIntervals(int visionThreadUtilizationReportIntervals) {
        WebUITestBase.visionThreadUtilizationReportIntervals = visionThreadUtilizationReportIntervals;
    }

    public static void selectDeviceVersion(String deviceName) {
        try {
            if (deviceName == null || deviceName.equals("")) return;
            if (deviceDriverNamesMap.containsKey(deviceName)) {
                String deviceDriverName = deviceDriverNamesMap.get(deviceName);
                WebUIUtils.selectedDeviceDriverId = normalizeDeviceDriverName(deviceDriverName);
                WebUIUtils.deviceVersion = getDeviceDriverVersion(deviceDriverName);
            } else {
                Device.waitForDeviceStatus(getVisionRestClient(), deviceName, ImConstants$DeviceStatusEnumPojo.OK, 5 * 1000);
                String deviceDriverName = TreeUtils.getDeviceDriverName(getVisionRestClient(), deviceName);
                if (deviceDriverName != null && !deviceDriverName.startsWith("Hud_Generic-BaseDriver")) {
                    deviceDriverNamesMap.put(deviceName, deviceDriverName);
                    WebUIUtils.selectedDeviceDriverId = normalizeDeviceDriverName(deviceDriverName);
                    WebUIUtils.deviceVersion = getDeviceDriverVersion(deviceDriverName);
                } else {
                    BaseTestUtils.report("Failed to Select Device by Name: " + deviceName, Reporter.PASS);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Select Device by Name: " + deviceName, Reporter.PASS);
        }
    }

    private static String normalizeDeviceDriverName(String DeviceDriverName) {
        String normalize = DeviceDriverName.substring(4);   // removed "Hud_"
        return normalize.replace("_", "-");
    }

    private static String getDeviceDriverVersion(String DeviceDriverName) {
        return DeviceDriverName.substring(DeviceDriverName.indexOf("-", 0) + 1, DeviceDriverName.lastIndexOf("DD") - 1);
    }

    public static String getDeviceTypeCurrent() {
        return deviceTypeCurrent;
    }

    public static boolean getGlobalIsSeleniumRemoteOperation() {
        return globalIsSeleniumRemoteOperation;
    }

    @Before
    public void uiInit() throws Exception {
        try {
            if (!isUIInit) {
                isUIInit = true;
                JSystemReporter4Bdd.screenShotOnFailure = true;

                AasVisionEnums.UtilitiesStrings.isDeviceWebClientMode = false;
                WebUIUtils.isVisionOriented = true; // to skip looking for specific dialog while at onException (Stas)
                WebUIBasePage.xmlFilesParsingMode = false;

                WebUIUtils.deviceDriversBaseDirectory_VisionServer = FileUtils.getAbsoluteClassesPath() + FileUtils.getDelimiter() + "clientdevicedrivers";
                SerializeDeviceDriver.init(FileUtils.getAbsoluteProjectPath());

                // Initialize the restTestBase
                coreInit();

                UIUtils.visionModeForTable = true;

                fileSeperator = System.getProperty("file.separator");
                // Set SMB timeouts
                System.setProperty("jcifs.smb.client.responseTimeout", "120000"); // default: 30000 millisec.
                System.setProperty("jcifs.smb.client.soTimeout", "140000"); // default: 35000 millisec.
//                AasVisionEnums.UtilitiesStrings.BROWSER_TYPE = BaseTestUtils.getRuntimeProperty(RuntimePropertiesEnum.BROWSER_TYPE.name(), RuntimePropertiesEnum.BROWSER_TYPE.getDefaultValue());

                rallyTestReporter = new RallyTestReporter();
                rallyTestReporter.init(restTestBase.getRootServerCli().getVersionNumebr(), "WebUI", restTestBase.getRootServerCli().getBuildNumber());

                restOperationsUsername = restTestBase.getVisionServer().getRestUsername();
                restOperationsPassword = restTestBase.getVisionServer().getRestPassword();
                getVisionRestClient().setSessionUsername(restOperationsUsername);
                getVisionRestClient().setSessionPassword(restOperationsPassword);
                getVisionRestClient().getHttpSession(1).setEnableAutomaticLogin(true);
                setGenerateScreenshotAfterWebClickOperation();
                setGenerateScreenshotAfterWebFindOperation();
                String mode = BddReporterManager.getRunMode();
                //send version , build and mode to FeatureRunner
                /*
                The code below used to send the version, build and mode to RunnerFeature class in order to create Before Feature and After Feature in cucumber
                this code will run once , at the begin of the test .
                 */
                FeatureRunner.update_version_build_mode(restTestBase.getRootServerCli().getVersionNumebr(),
                        restTestBase.getRootServerCli().getBuildNumber(),
                        mode);

                FeatureRunner.update_station_sutName(restTestBase.getRootServerCli().getHost(), System.getProperty("SUT"));
            }
        } catch (Exception e) {
            throw new IllegalStateException(e.getMessage() + "\n" + e.getStackTrace());
        }

        setDeviceName(deviceName);
    }

    public void coreInit() throws Exception {
        if (!isRestInit) {
            isRestInit = true;

            devicesManager = DevicesManager.getInstance("devices");
            restTestBase = new RestTestBase();
            restTestBase.init();
            BaseHandler.restTestBase = restTestBase;
            BaseHandler.devicesManager = devicesManager;
        }

    }


    @After
    public void testClosure() throws Exception {
        if (!WebUIUtils.isDriverQuit) {
            try {
                WebUIUtils.setIsTriggerPopupSearchEvent(false);
                WebUIUtils.isDevicePropertiesDialogCancel = true;
                WebUIBasePage.closeAllYellowMessages();
                // Try to close any popup message that is left open
                closePopupDialog();

                if (WebUIDriver.getListenerManager().getWebUIDriverEventListener() != null) {
                    List<PopupContent> popupErrors = ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).getLastPopupEvent();

                    if (popupErrors.size() > 0) {
                        for (PopupContent popupError : popupErrors) {
                            if (popupError.getType().equals(PopupType.ERROR) &&
                                    !ignoredMessageIds(popupError.getContent())) {
                                BaseTestUtils.report("Test :" + getName() + " " + "failed due to the following error popup dialogs: \n" + popupErrorsToString(popupError), Reporter.FAIL);
                            }
                        }
                    }
                    // Try to close any left opened Device Properties Dialog
                }

                if (BaseTestUtils.getBooleanRuntimeProperty(RuntimePropertiesEnum.ADD_AUTO_RESULT.name(), RuntimePropertiesEnum.ADD_AUTO_RESULT.getDefaultValue())) {
                    ReportResultEntity report = new ReportResultEntity().withtestID(targetTestId).withName(this.getName()).withDescription(getFailCause()).withStatus(this.isPassAccordingToFlags()).withUID(UUID.randomUUID().toString());
                    resultsManager.addResult(report);
//                    if (targetTestId != null) {
//                        publishResults(Integer.parseInt(targetTestId));
//                    }
                }

//                rallyTestReporter.updateTestResult(ScenarioHelpers.getRunnerTest(this), qcTestId, isPass(), getFailCause());
            } catch (Exception e) {
                BaseTestUtils.report(" Test after method " + e.getMessage(), Reporter.FAIL);
            } finally {
                ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).clearLastPopupEventList();
                WebUIUtils.isDevicePropertiesDialogCancel = false;
                WebUIUtils.isFindExceptionOccur = true;
                WebUIUtils.generateAndReportScreenshot();
                WebUIUtils.isFindExceptionOccur = false;
                WebUIUtils.isDriverQuit = false;
                WebUIUtils.setIsTriggerPopupSearchEvent(true);
            }
        }
    }

    public void cliAfterMethodMain() throws IOException {
        try {
            // Clear any remaining commands on the output (In case of a 'Help text' command)
            String clearString = "";
            for (int i = 0; i < 60; i++) {
                clearString += "\b";
            }
            InvokeUtils.invokeCommand(null, clearString, restTestBase.getRadwareServerCli(), 2 * 2000, true, true, true, null, true, true);
            InvokeUtils.invokeCommand(null, clearString, restTestBase.getRootServerCli(), 2 * 2000, true, true, true, null, true, true);
            CliTests.report.stopLevel();
            CliTests.report.startLevel("Beginning to Finish the test(After).");

            if (doTheVisionLabRestart) {
                InvokeUtils.invokeCommand(null, "", restTestBase.getRadwareServerCli(), 6000, true);
                if (restTestBase.getRadwareServerCli().getTestAgainstObject().toString().endsWith("$ ")) {
                    InvokeUtils.invokeCommand(null, Menu.system().database().access().revoke().build() + " all", restTestBase.getRadwareServerCli());
                    InvokeUtils.invokeCommand(null, "y", restTestBase.getRadwareServerCli());
                }
                doTheVisionLabRestart = false;
            }

            if (BaseTestUtils.getBooleanRuntimeProperty(RuntimePropertiesEnum.ADD_AUTO_RESULT.name(), RuntimePropertiesEnum.ADD_AUTO_RESULT.getDefaultValue())) {
                ReportResultEntity report = new ReportResultEntity().withtestID("").withName(this.getName()).withDescription(getFailCause()).withStatus(this.isPassAccordingToFlags()).withUID(UUID.randomUUID().toString());
                resultsManager.addResult(report);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (restTestBase.getRadwareServerCli() != null) {
                restTestBase.getRadwareServerCli().cleanCliBuffer();
            }
            if (restTestBase.getRootServerCli() != null) {
                restTestBase.getRootServerCli().cleanCliBuffer();
            }
            CliTests.report.stopLevel();
        }
    }

    public void publishResults(int targetTestCaseID) {
        StringBuilder results = new StringBuilder();
        for (ReportResultEntity result : resultsManager.getAllResults().values()) {
            results.append(result.toString());
        }
        restTestBase.automationTestReporter.updateTestResult(resultsManager.getUpToDateAggResult(), results.toString(), targetTestCaseID);
    }

    public void publishBddResults() {
        int testId = BddReporterManager.getTestCaseId();
        if (testId > 0) {
            setVisionBuildAndVersion();
            if (IgnoreList.getInstance().getIgnoreList().containsKey("TC" + testId))
                restTestBase.automationTestReporter.updateTestResult(false, BddReporterManager.getAllResult(), testId);
            else
                restTestBase.automationTestReporter.updateTestResult(BddReporterManager.isResultPass(), BddReporterManager.getAllResult(), testId);
        }
        BaseTestUtils.report("Scenario Result for testId: " + testId + "\n vision Version: " + restTestBase.getRootServerCli().getVersionNumebr() + "\n build number: " + restTestBase.getRootServerCli().getBuildNumber(), Reporter.PASS_NOR_FAIL);
    }

    public void setVisionBuildAndVersion() {
        try {
            restTestBase.getRootServerCli().setConnectOnInit(true);
            restTestBase.getRootServerCli().connect();
            restTestBase.getRootServerCli().getVersionAndBuildFromSever();
            restTestBase.initReporter();
            FeatureRunner.update_version_build_mode(restTestBase.getRootServerCli().getVersionNumebr(),
                    restTestBase.getRootServerCli().getBuildNumber(),
                    BddReporterManager.getRunMode());
            FeatureRunner.update_station_sutName(restTestBase.getRootServerCli().getHost(), System.getProperty("SUT"));

        } catch (Exception e) {
            BaseTestUtils.report("publish BDD results Failure!!! ", Reporter.PASS_NOR_FAIL);
        }
    }

    public void publishBddResults_new() {
        String status = BddReporterManager.isResultPass() ? "Passed" : "Failed";

        Integer testCaseId = BddReporterManager.getStepId();

        if (testCaseId != null && IgnoreList.getInstance().getIgnoreList().containsKey(testCaseId.toString()))
            status = "Failed";

        if (BddReporterManager.getAutoStepId() != null) {
            setVisionBuildAndVersion();
            RadAutoDB.getInstance().autoStepTbl.updateStepResult(BddReporterManager.getAutoStepId(), status);
            if (status.equals("Failed"))
                RadAutoDB.getInstance().autoStepFailReasonTbl.createStepFailReason(BddReporterManager.getAutoStepId(), "Error", BddReporterManager.getAllResult(), "", "", "");
        }
    }

    private boolean ignoredMessageIds(String msg) {
        for (String msgId : MessageIdsIgnore.ignoredMessageIds) {
            if (msg.contains(msgId)) return true;
        }
        return false;
    }

    protected void startTimedTask() {
        if (getOutputVisionThreadUtilization()) {
            timer.schedule(new ThreadsStatusMonitor(getRestTestBase().getRootServerCli()), 0, visionThreadUtilizationReportIntervals * 1000);
        }
    }

    protected void stopTimedTask() {
        timer.cancel();
        timer.purge();
    }

    public String buildRemoteSeleniumUrl() {
        return "http://" + getGlobalRemoteSeleniumServerHubIp() + ":" + getGlobalRemoteSeleniumServerHubPort() + "/wd/hub";
    }

    public void closePopupDialog() {
        // Try to close any popup message that is left open
        if (WebUIDriver.getListenerManager().getWebUIDriverEventListener() != null) {
            try {
                PopupEventHandler popupHandler = new PopupEventHandler();
                boolean need2ClosePopup = false;
                boolean isPopup = popupHandler.handle(need2ClosePopup);
                if (isPopup) {
                    RestTestBase.globalParamsMap.put(popupContentKey, getPopupContent());
                    WebUIDriver.getListenerManager().getWebUIDriverEventListener().afterClickOn(null, WebUIUtils.getDriver());
                }
            } catch (Exception e) {
                BaseTestUtils.report("Failed to close opened popup message: \n" + parseExceptionBody(e), Reporter.PASS);
            }
        }
    }

    public String getPopupContent() {
        String popupContent = "";
        try {
            PopupEventHandler popupHandler = new PopupEventHandler();
            boolean need2ClosePopup = false;
            boolean isPopup = popupHandler.handle(need2ClosePopup);
            if (isPopup) {
                popupContent = WebUIPage.getPopup().getContent();
            } else {
                BaseTestUtils.report("Failed to get Popup Content, it may not be visible", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get Popup Content, it may not be visible" + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
        return popupContent;
    }

    private String popupErrorsToString(PopupContent popupErrors) {
        StringBuffer result = new StringBuffer();
        result.append("Dialog: ").append("\n").
                append("Type: ").append(popupErrors.getType().toString()).append("\n").
                append("Content: ").append(popupErrors.getContent());
        return result.toString();
    }

    protected String parseExceptionBody(Exception e) {
        StringBuffer exceptionBody = new StringBuffer();
        if (e instanceof Exception) {
            exceptionBody.append("Cause: ").append(e.getCause()).append("\n").
                    append(" ,Message: ").append(e.getMessage()).append("\n").
                    append(" ,Stack Trace: ").append(Arrays.asList(Arrays.asList(e.getStackTrace()))).append("\n");
        }
        if (e instanceof IllegalStateException) {
            exceptionBody.append("Additional Info: ").append((e).getLocalizedMessage());
        }
        return exceptionBody.toString();
    }

    public LinuxServerCredential getLinuxServerCredential() {
        return restTestBase.getLinuxServerCredential();
    }

    public LinuxServerCredential getRootServerCliCredentials() {
        return restTestBase.getRootServerCliCredentials();
    }

    public String getVisionServerIp() {
        return restTestBase.getVisionServer().getHost();
    }

    public String getQcTestId() {
        return qcTestId;
    }

    public void setQcTestId(String qcTestId) {
        this.qcTestId = qcTestId;
    }

    public String getGlobalRemoteSeleniumServerHubIp() {
        return globalRemoteSeleniumServerHubIp;
    }

    public void setGlobalRemoteSeleniumServerHubIp(String globalRemoteSeleniumServerHubIp) {
        this.globalRemoteSeleniumServerHubIp = globalRemoteSeleniumServerHubIp;
    }

    public String getGlobalRemoteSeleniumServerHubPort() {
        return globalRemoteSeleniumServerHubPort;
    }

    public void setGlobalRemoteSeleniumServerHubPort(String globalRemoteSeleniumServerHubPort) {
        this.globalRemoteSeleniumServerHubPort = globalRemoteSeleniumServerHubPort;
    }

    public boolean getCloseAllOpenedDialogsRequired() {
        return closeAllOpenedDialogsRequired;
    }

    public void setCloseAllOpenedDialogsRequired(boolean closeAllOpenedDialogsRequired) {
        this.closeAllOpenedDialogsRequired = closeAllOpenedDialogsRequired;
    }

    public void setDeviceType(VisionRestClient visionRestClient, String deviceName) {
        try {
            this.deviceTypeCurrent = DeviceUtils.getDeviceType(visionRestClient, deviceName);
        } catch (Exception e) {
            deviceTypeCurrent = "";
        }
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) throws Exception {
        if (BasicOperationsHandler.isLoggedIn) {
            this.deviceName = deviceName;
            if (deviceName != null && !deviceName.equals("")) {
                if (DeviceUtils.isManagedByVision(getVisionRestClient(), deviceName)) {
                    isDeviceManagedByVision = true;
                    selectDeviceVersion(deviceName);
                    try {
                        updateNavigationParser(Device.getDeviceIp(getVisionRestClient(), deviceName));
                    } catch (IllegalStateException e) {
                        BaseTestUtils.report(e.getMessage(), Reporter.PASS);
                    }
                }
            } else {
                updateVisionNavigationXml();
                isDeviceManagedByVision = false;
            }
        }
    }

    public DeviceDriverType getDeviceDriverType() {
        return deviceDriverType;
    }

    @ParameterProperties(description = "Please, specify the Device Driver Type!")
    public void setDeviceDriverType(DeviceDriverType deviceDriverType) {
        this.deviceDriverType = deviceDriverType;
    }

    public String getPopupContentKey() {
        return popupContentKey;
    }

    public void updateVisionNavigationXml() throws Exception {

        String visionHost = restTestBase.getRadwareServerCli().getHost();
        if (navigationParsers.containsKey(visionHost)) {
            WebUIUtils.visionUtils.navParser = navigationParsers.get(visionHost);
        } else {

            String url = VisionUrlPath.mgmt().system().config().dd().screen("navigation.xml").build();
            String result = new RestCommands(restTestBase.getVisionRestClient()).getLocalCommand(url, false);

            String filePath = WebUIUtils.deviceDriversBaseDirectory_VisionServer + File.separator + "client" + File.separator + "navigation.xml";
            if (FileUtils.isFileExist(filePath)) {
                FileUtils.deleteFile(WebUIUtils.deviceDriversBaseDirectory_VisionServer + File.separator + "client", "navigation.xml");
            }
            File file = FileUtils.writeToFile(filePath, result);


            WebUIUtils.visionUtils.setDeviceIpIfNew(null);
            navigationParsers.put(visionHost, WebUIUtils.visionUtils.navParser);
        }

        WebUIUtils.selectedDeviceDriverId = WebUIUtils.VISION_DEVICE_DRIVER_ID;


    }

    public void updateNavigationParser(String deviceIp) throws Exception {
        if (deviceIp != null) {
            if (navigationParsers.containsKey(WebUIUtils.selectedDeviceDriverId)) {
                WebUIUtils.visionUtils.navParser = navigationParsers.get(WebUIUtils.selectedDeviceDriverId);
            } else if (isDeviceManagedByVision) {
                getNavigationXml(deviceIp, "client", "navigation.xml");
                getNavigationXml(deviceIp, "server", "version_hierarchy.xml");

                WebUIUtils.visionUtils.setDeviceIpIfNew(null);
                navigationParsers.put(WebUIUtils.selectedDeviceDriverId, WebUIUtils.visionUtils.navParser);
            }
        }
    }

    private void getNavigationXml(String deviceIp, String navigationPath, String navigationFile) throws NoSuchFileException {
        String restUrl = String.format("mgmt/device/byip/%s/config/dd/%s/%s", deviceIp, navigationPath, navigationFile);
        RestCommands restCommands = new RestCommands(restTestBase.getVisionRestClient());
        String result = restCommands.getLocalCommand(restUrl, false);
        String filePath = WebUIUtils.deviceDriversBaseDirectory_VisionServer + File.separator + navigationPath + File.separator + navigationFile;
        if (FileUtils.isFileExist(filePath)) {
            FileUtils.deleteFile(WebUIUtils.deviceDriversBaseDirectory_VisionServer + File.separator + navigationPath, navigationFile);
        }
        File file = FileUtils.writeToFile(filePath, result);
    }

    private void setGenerateScreenshotAfterWebFindOperation() {
        try {
            WebUIDriver.setListenerScreenshotAfterFind(Boolean.valueOf(System.getProperty("generateScreenshotAfterWebFindOperation")));
        } catch (Exception e) {
//            Ignore
        }
    }

    private void setGenerateScreenshotAfterWebClickOperation() {
        try {
            WebUIDriver.setListenerScreenshotAfterClick(Boolean.valueOf(System.getProperty("generateScreenshotAfterWebClickOperation")));
        } catch (Exception e) {
//            Ignore
        }
    }


    public CliConnectionImpl getSUTEntryType(SUTEntryType sutEntryType) {
        CliConnectionImpl cli = null;
        switch (sutEntryType) {
            case GENERIC_LINUX_SERVER:
                cli = restTestBase.getGenericLinuxServer();
                break;
            case LINUX_FILE_SERVER:
                cli = restTestBase.getLinuxFileServer();
                break;
            case RADWARE_SERVER_CLI:
                cli = restTestBase.getRadwareServerCli();
                break;
            case ROOT_SERVER_CLI:
                cli = restTestBase.getRootServerCli();
                break;
        }
        return cli;
    }

    public ServerCliBase getSUTEntryTypeByServerCliBase(SUTEntryType sutEntryType) {
        ServerCliBase cli = null;
        switch (sutEntryType) {
            case GENERIC_LINUX_SERVER:
                cli = restTestBase.getGenericLinuxServer();
                break;
            case LINUX_FILE_SERVER:
                cli = restTestBase.getLinuxFileServer();
                break;
            case RADWARE_SERVER_CLI:
                cli = restTestBase.getRadwareServerCli();
                break;
            case ROOT_SERVER_CLI:
                cli = restTestBase.getRootServerCli();
                break;
        }
        return cli;
    }

    public String getTestCaseId() {
        return testCaseId;
    }

    public void setTestCaseId(String testCaseId) {
        this.testCaseId = testCaseId;
    }

    public String getTargetTestId() {
        return targetTestId;
    }

    public void setTargetTestId(String targetTestId) {
        this.targetTestId = targetTestId;
    }

    public static String getRetrievedParamValue() {
        return retrievedParamValue;
    }

    public static void setRetrievedParamValue(String retrievedParamValue) {
        WebUITestBase.retrievedParamValue = retrievedParamValue;
    }
}
