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
import com.radware.automation.tools.cli.ServerCliBase;
import com.radware.automation.tools.reports.RallyTestReporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.automation.webui.UIUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.events.PopupEventHandler;
import com.radware.automation.webui.events.ReportWebDriverEventListener;
import com.radware.automation.webui.utils.VisionUtils;
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
import com.radware.utils.DeviceUtils;
import com.radware.utils.TreeUtils;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DevicesManager;
import com.radware.vision.infra.enums.DeviceDriverType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.utils.VisionWebUIUtils;
import com.radware.vision.pojomodel.helpers.constants.ImConstants$DeviceStatusEnumPojo;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.vision_tests.CliTests;
import cucumber.runtime.junit.FeatureRunner;
import enums.SUTEntryType;
import models.RestResponse;
import org.junit.After;
import org.junit.Before;
import testhandlers.Device;

import java.io.File;
import java.io.IOException;
import java.nio.file.NoSuchFileException;
import java.util.*;

public abstract class WebUITestBase extends TestBase {
    protected boolean doTheVisionLabRestart = false;
    public static String retrievedParamValue = "";
    public static RestManagement restTestBase;
    public static VisionWebUIUtils webUtils;
    public static String restOperationsUsername;
    public static String restOperationsPassword;
    private static Boolean isDeviceManagedByVision = false;

    protected static DevicesManager devicesManager;
    private static final Map<String, String> deviceDriverNamesMap = new HashMap<>();
    private static final Map<String, VisionNavigationXmlParser> navigationParsers = new HashMap<>();
    private static boolean isUIInit = false;
    String browserSessionId;
    private final String popupContentKey = "popupContent";
    private DeviceDriverType deviceDriverType = DeviceDriverType.VISION;
    private String deviceName;
    private static boolean isRestInit = false;


    public static VisionRestClient getVisionRestClient() {
        return restTestBase != null ? restTestBase.getVisionRestClient() : new VisionRestClient(null, null, null);
    }

    public static RestTestBase getRestTestBase() {
        return restTestBase;
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
        return DeviceDriverName.substring(DeviceDriverName.indexOf("-") + 1, DeviceDriverName.lastIndexOf("DD") - 1);
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

                String fileSeparator = System.getProperty("file.separator");
                // Set SMB timeouts
                System.setProperty("jcifs.smb.client.responseTimeout", "120000"); // default: 30000 millisec.
                System.setProperty("jcifs.smb.client.soTimeout", "140000"); // default: 35000 millisec.
//                AasVisionEnums.UtilitiesStrings.BROWSER_TYPE = BaseTestUtils.getRuntimeProperty(RuntimePropertiesEnum.BROWSER_TYPE.name(), RuntimePropertiesEnum.BROWSER_TYPE.getDefaultValue());

                // For Results Reporting
                RallyTestReporter rallyTestReporter = new RallyTestReporter();
                rallyTestReporter.init(managementInfo.getVersion(), "WebUI", managementInfo.getBuild());

                restOperationsUsername = clientConfigurations.getUserName();
                restOperationsPassword = clientConfigurations.getPassword();
//                getVisionRestClient().setSessionUsername(restOperationsUsername);
//                getVisionRestClient().setSessionPassword(restOperationsPassword);
//                getVisionRestClient().getHttpSession(1).setEnableAutomaticLogin(true);
                setGenerateScreenshotAfterWebClickOperation();
                setGenerateScreenshotAfterWebFindOperation();
                String mode = BddReporterManager.getRunMode();
                //send version , build and mode to FeatureRunner
                /*
                The code below used to send the version, build and mode to RunnerFeature class in order to create Before Feature and After Feature in cucumber
                this code will run once , at the begin of the test .
                 */
                FeatureRunner.update_version_build_mode(managementInfo.getVersion(),
                        managementInfo.getBuild(),
                        mode);

            }
        } catch (Exception e) {
            throw new IllegalStateException(e.getMessage() + "\n" + Arrays.toString(e.getStackTrace()));
        }

        setDeviceName(deviceName);
    }

    public void coreInit() throws Exception {
        if (!isRestInit) {

            isRestInit = true;
//
//            devicesManager = DevicesManager.getInstance("devices");
            restTestBase = new RestManagement();
            restTestBase.init();
//            BaseHandler.restTestBase = restTestBase;
//            BaseHandler.devicesManager = devicesManager;
        }

    }


    @After
    public void testClosure() {
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
                                BaseTestUtils.report("Test failed due to the following error popup dialogs: \n" + popupErrorsToString(popupError), Reporter.FAIL);
                            }
                        }
                    }
                    // Try to close any left opened Device Properties Dialog
                }

                if (BaseTestUtils.getBooleanRuntimeProperty(RuntimePropertiesEnum.ADD_AUTO_RESULT.name(), RuntimePropertiesEnum.ADD_AUTO_RESULT.getDefaultValue())) {
//                    ReportResultEntity report = new ReportResultEntity().withtestID(targetTestId).withName(this.getName()).withDescription(getFailCause()).withStatus(this.isPassAccordingToFlags()).withUID(UUID.randomUUID().toString());
//                    resultsManager.addResult(report);
//                    if (targetTestId != null) {
//                        publishResults(Integer.parseInt(targetTestId));
//                    }
                }

//                rallyTestReporter.updateTestResult(ScenarioHelpers.getRunnerTest(this), qcTestId, isPass(), getFailCause());
            } catch (Exception e) {
                BaseTestUtils.report(" Test after method " + e.getMessage(), Reporter.FAIL);
            } finally {
                ((ReportWebDriverEventListener) Objects.requireNonNull(WebUIDriver.getListenerManager().getWebUIDriverEventListener())).clearLastPopupEventList();
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
            StringBuilder clearString = new StringBuilder();
            for (int i = 0; i < 60; i++) {
                clearString.append("\b");
            }
            InvokeUtils.invokeCommand(null, clearString.toString(), restTestBase.getRadwareServerCli(), 2 * 2000, true, true, true, null, true, true);
            InvokeUtils.invokeCommand(null, clearString.toString(), restTestBase.getRootServerCli(), 2 * 2000, true, true, true, null, true, true);
            CliTests.report.stopLevel();
            CliTests.report.startLevel("Begining to Finish the test(After).");

            if (doTheVisionLabRestart) {
                InvokeUtils.invokeCommand(null, "", restTestBase.getRadwareServerCli(), 6000, true);
                if (restTestBase.getRadwareServerCli().getTestAgainstObject().toString().endsWith("$ ")) {
                    InvokeUtils.invokeCommand(null, Menu.system().database().access().revoke().build() + " all", restTestBase.getRadwareServerCli());
                    InvokeUtils.invokeCommand(null, "y", restTestBase.getRadwareServerCli());
                }
                doTheVisionLabRestart = false;
            }

            if (BaseTestUtils.getBooleanRuntimeProperty(RuntimePropertiesEnum.ADD_AUTO_RESULT.name(), RuntimePropertiesEnum.ADD_AUTO_RESULT.getDefaultValue())) {
//                ReportResultEntity report = new ReportResultEntity().withtestID("").withName(this.getName()).withDescription(getFailCause()).withStatus(this.isPassAccordingToFlags()).withUID(UUID.randomUUID().toString());
//                resultsManager.addResult(report);
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


    public void setVisionBuildAndVersion() {
        try {
            restTestBase.getRootServerCli().setConnectOnInit(true);
            restTestBase.getRootServerCli().connect();
            restTestBase.getRootServerCli().getVersionAndBuildFromSever();
            restTestBase.initReporter();
            FeatureRunner.update_version_build_mode(managementInfo.getVersion(),
                    managementInfo.getBuild(),
                    BddReporterManager.getRunMode());
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
        return "Dialog: " + "\n" +
                "Type: " + popupErrors.getType().toString() + "\n" +
                "Content: " + popupErrors.getContent();
    }

    protected String parseExceptionBody(Exception e) {
        StringBuilder exceptionBody = new StringBuilder();
        if (e != null) {
            exceptionBody.append("Cause: ").append(e.getCause()).append("\n").
                    append(" ,Message: ").append(e.getMessage()).append("\n").
                    append(" ,Stack Trace: ").append(Collections.singletonList(Arrays.asList(e.getStackTrace()))).append("\n");
        }
        if (e instanceof IllegalStateException) {
            exceptionBody.append("Additional Info: ").append((e).getLocalizedMessage());
        }
        return exceptionBody.toString();
    }


    public String getVisionServerIp() {
        return clientConfigurations.getHostIp();
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

    public void setDeviceDriverType(DeviceDriverType deviceDriverType) {
        this.deviceDriverType = deviceDriverType;
    }

    public String getPopupContentKey() {
        return popupContentKey;
    }

    public void updateVisionNavigationXml() throws Exception {

        String visionHost = clientConfigurations.getHostIp();
        if (navigationParsers.containsKey(visionHost)) {
            VisionUtils.navParser = navigationParsers.get(visionHost);
        } else {
            GenericVisionRestAPI restAPI = new GenericVisionRestAPI("Vision/SystemManagement.json", "Update Vision Navigation Xml");
            RestResponse result = restAPI.sendRequest();
//            String url = VisionUrlPath.mgmt().system().config().dd().screen("navigation.xml").build();
            String filePath = WebUIUtils.deviceDriversBaseDirectory_VisionServer + File.separator + "client" + File.separator + "navigation.xml";
            if (FileUtils.isFileExist(filePath)) {
                FileUtils.deleteFile(WebUIUtils.deviceDriversBaseDirectory_VisionServer + File.separator + "client", "navigation.xml");
            }
            FileUtils.writeToFile(filePath, result.getBody().getBodyAsString());
            WebUIUtils.visionUtils.setDeviceIpIfNew(null);
            navigationParsers.put(visionHost, VisionUtils.navParser);
        }

        WebUIUtils.selectedDeviceDriverId = WebUIUtils.VISION_DEVICE_DRIVER_ID;


    }

    public void updateNavigationParser(String deviceIp) throws Exception {
        if (deviceIp != null) {
            if (navigationParsers.containsKey(WebUIUtils.selectedDeviceDriverId)) {
                VisionUtils.navParser = navigationParsers.get(WebUIUtils.selectedDeviceDriverId);
            } else if (isDeviceManagedByVision) {
                getNavigationXml(deviceIp, "client", "navigation.xml");
                getNavigationXml(deviceIp, "server", "version_hierarchy.xml");

                WebUIUtils.visionUtils.setDeviceIpIfNew(null);
                navigationParsers.put(WebUIUtils.selectedDeviceDriverId, VisionUtils.navParser);
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
        FileUtils.writeToFile(filePath, result);
    }

    private void setGenerateScreenshotAfterWebFindOperation() {
        try {
            WebUIDriver.setListenerScreenshotAfterFind(Boolean.parseBoolean(System.getProperty("generateScreenshotAfterWebFindOperation")));
        } catch (Exception e) {
//            Ignore
        }
    }

    private void setGenerateScreenshotAfterWebClickOperation() {
        try {
            WebUIDriver.setListenerScreenshotAfterClick(Boolean.parseBoolean(System.getProperty("generateScreenshotAfterWebClickOperation")));
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


    public static String getRetrievedParamValue() {
        return retrievedParamValue;
    }

}
