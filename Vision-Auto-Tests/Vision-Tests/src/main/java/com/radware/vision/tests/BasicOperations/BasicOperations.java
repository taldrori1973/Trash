package com.radware.vision.tests.BasicOperations;

import com.google.common.io.ByteStreams;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.connection.VisionConnectionAuthentication;
import com.radware.automation.webui.utils.image.ImageCompression;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.jsonparsers.impl.JsonUtils;
import com.radware.restcommands.RestCommands;
import com.radware.restcore.utils.enums.ExpectedHttpCodes;
import com.radware.vision.automation.AutoUtils.utils.SystemProperties;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.bddtests.basicoperations.BasicOperationsSteps;
import com.radware.vision.infra.base.pages.system.usermanagement.localusers.UserEntry;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.system.usermanagement.localusers.LocalUsersHandler;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.vision_project_cli.RootServerCli;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.Test;
import org.openqa.selenium.OutputType;
import org.openqa.selenium.TakesScreenshot;
import org.openqa.selenium.WebDriver;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import static java.lang.Long.parseLong;

public class BasicOperations extends WebUITestBase {

    public Boolean ignoreRestResponseValidation = false;
    String username;
    String password;
    int timeOut;
    String waitAfterClick;
    String loginTimeout = "1";
    String visionServerCommand;
    String rootServerCommand;
    String mysqlGlobalVariable;
    String mysqlGlobalVariableValue;
    boolean screenshotGenerationOperational = true;
    String waitForWebElementDefaultTimeout = "30";
    String findElementDefaultTimeout;
    String findElementShortTimeout;
    String fluentWaitObjectFindIntervals;
    String waitBeforeFindElementStart;
    boolean autoClosePopupAfterTest = false;
    boolean restartVisionServerFlag = false;
    boolean disableAutoRefresh = false;
    boolean generateScreenshotAfterWebClickOperation = false;
    boolean generateScreenshotAfterWebFindOperation = false;
    boolean validateLogoutOperation = false;
    String testFolder;
    String elementID;
    GeneralEnums.State state;
    int seconds = 30;
    ExpectedHttpCodes expectedHttpCodes = ExpectedHttpCodes.OK;

    /* @Test
     @TestProperties(name = "Save Image Portion", paramsInclude = {"qcTestId", "elementID"})
     public void saveImagePortion() throws IOException {
        WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementID).getBy(), WebUIUtils.SHORT_WAIT_TIME, false);

 //        BufferedImage fullImg = ImageIO.read(screenshot);

 //        Point point = element.getLocation();

 // Get width and height of the element
 //        int eleWidth = element.getSize().getWidth();
 //        int eleHeight = element.getSize().getHeight();

 // Crop the entire page screenshot to get only element screenshot
         BufferedImage eleScreenshot = WebUIUtils.getScreenPortionImage(element);
 //        BufferedImage eleScreenshot= fullImg.getSubimage(point.getX(), point.getY(),
 //                eleWidth, eleHeight);

         File screenshot = ((TakesScreenshot)WebUIUtils.getDriver()).getScreenshotAs(OutputType.FILE);
         ImageIO.write(eleScreenshot, "png", screenshot);

 // Copy the element screenshot to disk
         File screenshotLocation = new File("C:\\images\\GoogleLogo_screenshot.png");
         FileUtils.copyFile(screenshot, screenshotLocation);
         DataBuffer dbActual = eleScreenshot.getRaster().getDataBuffer();


     }
 */

    /*
      public static BufferedImage getScreenPortionImage() throws IOException {
        return getScreenPortionImage(null);
    }

    public static BufferedImage getScreenPortionImage(WebElement targetElement) throws IOException {
        File screenshot = ((TakesScreenshot)WebUIUtils.getDriver()).getScreenshotAs(OutputType.FILE);
        BufferedImage fullImg = ImageIO.read(screenshot);

        if(targetElement == null) {
            return fullImg;
        }

        try {
            Point point = targetElement.getLocation();
            int eleWidth = targetElement.getSize().getWidth();
            int eleHeight = targetElement.getSize().getHeight();
            return fullImg.getSubimage(point.getX(), point.getY(), eleWidth, eleHeight);
        }
        catch (Exception e) {
            return fullImg;
        }
    }
    *
    * */

    @Test
    public void takeScreenShot() {
        try {
            BasicOperationsHandler.takeScreenShot();
        } catch (IOException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Publish up to date results", paramsInclude = {"targetTestId"})
    public void publishUpToDateResults() {
        try {
            publishResults(Integer.parseInt(targetTestId));
        } finally {
            resultsManager.resetAllResults();
        }
    }

    @Test
    @TestProperties(name = "Login", paramsInclude = {"qcTestId", "username", "password", "targetTestId"})
    public void login() {
        try {
            BasicOperationsSteps.loginToServer(username, password, restTestBase.getVisionRestClient());
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Login." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Login - ReST", paramsInclude = {"qcTestId", "expectedHttpCodes", "ignoreRestResponseValidation", "username", "password", "sessionID"})
    public void loginRest() {
        try {
            restTestBase.setExpectedHttpCodes(expectedHttpCodes);
            restTestBase.setIgnoreRestResponseValidation(ignoreRestResponseValidation);
            restTestBase.getVisionRestClient().login(username, password, "", 1);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to login with: " + username + "@" + password + ".\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    private boolean validateConnectedSession() {
        browserSessionId = WebUIUtils.getDriver().manage().getCookieNamed("JSESSIONID").getValue();
        BaseTestUtils.reporter.report("Browser Session Id = " + browserSessionId);
        try {
            restTestBase.getVisionRestClient().login(username, password, null, 1);
            restTestBase.getVisionRestClient().setIgnoreResponseCodeValidation(true);
            String restUrl = "mgmt/system/user/connectedsessions";
            RestCommands restCommands = new RestCommands(restTestBase.getVisionRestClient());
            long startTime = System.currentTimeMillis();
            String result = "";
            do {
                result = restCommands.getLocalCommand(restUrl, false);
                if (!result.isEmpty())
                    break;
            }
            while (System.currentTimeMillis() - startTime < 30 * 1000);
            BaseTestUtils.reporter.report(JsonUtils.prettifyJson(result));
            JSONArray jsonArray = new JSONArray(result);
            for (int i = 1; i < jsonArray.length(); i++) {
                JSONObject jsonObj = (JSONObject) jsonArray.get(i);
                if (jsonObj.get("Usernamname").equals(username)) {
                    JSONArray sessions = (JSONArray) jsonObj.get("HTTPS sessions");
                    for (int s = 0; s < sessions.length(); s++) {
                        String session = sessions.getString(s);
                        if (session.equals(browserSessionId)) {
                            return true;
                        }
                    }
                }
            }
            generateScreenshot();
            return false;
        } finally {
            restTestBase.getVisionRestClient().setIgnoreResponseCodeValidation(false);
        }
    }

    @Test
    @TestProperties(name = "Negative Login", paramsInclude = {"qcTestId", "username", "password", "loginTimeout"})
    public void negativeLogin() {
        try {
            if (BasicOperationsHandler.negativeLogin(username, password, Double.valueOf(loginTimeout))) {
                BaseTestUtils.report("Login with username:" + username + " " + "Password: " + password + " Must NOT be allowed:\n", Reporter.FAIL);
            }
            validateConnectedSession();
        } catch (Exception e) {
            BaseTestUtils.report("Login with username:" + username + " " + "Password: " + password + " failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        } finally {
            ((VisionConnectionAuthentication) webUtils.getConnection()).setDefaultPage("");
        }
    }


    @Test
    @TestProperties(name = "Logout", paramsInclude = {"qcTestId"})
    public void logout() {
        try {
            BasicOperationsHandler.logout();
        } finally {
            try {
                restTestBase.getVisionRestClient().logout(1);
            } catch (IllegalStateException ise) {
//                Ignore
            }
        }
    }

    @Test
    @TestProperties(name = "Close Browser", paramsInclude = {"qcTestId"})
    public void closeBrowser() {
        try {
            BasicOperationsHandler.closeBrowser();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to close browser. Further Web Client tests may fail." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Refresh Page", paramsInclude = {"qcTestId"})
    public void refreshPage() {

        try {
            BasicOperationsHandler.refresh();
        } catch (Exception e) {
            BaseTestUtils.report("Refresh Page failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Refresh Browser Page", paramsInclude = {""})
    public void refreshBrowserPage() {
        try {
            BasicOperationsHandler.refreshBrowserPage();
        } catch (Exception e) {
            BaseTestUtils.report("Refresh Browser Page failed with the following error:\n" + parseExceptionBody(e), Reporter.PASS);
        }
    }

    @Test
    @TestProperties(name = "Scheduler Page", paramsInclude = {"qcTestId"})
    public void schedulerPage() {

        try {
            BasicOperationsHandler.scheduler(true);
        } catch (Exception e) {
            BaseTestUtils.report("Scheduler Page failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Timeout", paramsInclude = {"qcTestId", "timeOut"})
    public void timeOut() {

        try {
            BasicOperationsHandler.delay(timeOut);
        } catch (Exception e) {
            BaseTestUtils.report("Timeout operation has failed :\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Set Restart Vision Server Flag", paramsInclude = {"restartVisionServerFlag"})
    public void setRestartVisionServerFlag() {
        WebUITestBase.globalRestartVisionServerInNoResponse = restartVisionServerFlag;
    }

    @Test
    @TestProperties(name = "Restart Vision Server Services", paramsInclude = {""})
    public void restartVisionServerServices() {
        try {
            BasicOperationsHandler.restartVisionServerServices(WebUITestBase.getRestTestBase().getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report("Failed to restart the Vision Server services." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Set wait after click operation", paramsInclude = {"waitAfterClick"})
    public void setwWitAfterClickOperation() {
        try {
            BasicOperationsHandler.setWaitAfterClick(Long.valueOf(waitAfterClick));
        } catch (Exception e) {
            BaseTestUtils.report("Failed to set click timeout. No affect on further testing." + parseExceptionBody(e), Reporter.PASS);
        }
    }

    @Test
    @TestProperties(name = "Add Rest Operations User", paramsInclude = {"qcTestId"})
    public void addRestOperationUser() {
        try {
            List<UserEntry> existingUsers = LocalUsersHandler.getExistingUsers();
            boolean userAlreadyExists = false;
            for (UserEntry user : existingUsers) {
                if (user.getUsername().equals(WebUITestBase.restOperationsUsername)) {
                    userAlreadyExists = true;
                }
            }
            if (!userAlreadyExists) {
                LocalUsersHandler.addUser(WebUITestBase.restOperationsUsername, WebUITestBase.restOperationsPassword, "", "", "", "Administrator,", null, null);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Add Rest user (" + WebUITestBase.restOperationsUsername + "@" + WebUITestBase.restOperationsPassword + ")" + " " + "failed. Further tests might fail.", Reporter.WARNING);
        }
    }

    @Test
    @TestProperties(name = "Start Vision Server in Debug Mode", paramsInclude = {""})
    public void startVisionServerInDebugMode() {
        try {
            BasicOperationsHandler.runVisionServerDebugMode(getRestTestBase().getRootServerCli());
        } catch (Exception e) {
            BaseTestUtils.report("Failed to start Vision Server in Debug Mode. Debugging will not be available", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Output Vision Server Threads Status", paramsInclude = {"outputVisionThreadUtilization", "visionThreadUtilizationReportIntervals"})
    public void outputVisionServerThreadsStatus() {
        setOutputVisionThreadUtilization(getOutputVisionThreadUtilization());
        setVisionThreadUtilizationReportIntervals(getVisionThreadUtilizationReportIntervals());
        startTimedTask();
    }

    @Test
    @TestProperties(name = "Run Vision Server Command", paramsInclude = {"visionServerCommand"})
    public void runVisionServerCommand() {
        try {
            InvokeUtils.invokeCommand(visionServerCommand, getRestTestBase().getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + visionServerCommand + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Run Root Server Command", paramsInclude = {"rootServerCommand"})
    public void runRootServerCommand() {
        try {
            InvokeUtils.invokeCommand(rootServerCommand, getRestTestBase().getRootServerCli());
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + rootServerCommand + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Run MySql Command", paramsInclude = {"mysqlGlobalVariable", "mysqlGlobalVariableValue"})
    public void runMySqlCommand() {
        try {
            String sqlCommandResult = BasicOperationsHandler.setMysqlGlobalVariable(getRestTestBase().getRootServerCli(), getRestTestBase().getMysqlServer(), mysqlGlobalVariable, mysqlGlobalVariableValue);
            if (sqlCommandResult.contains("ERROR")) {
                BaseTestUtils.report("Failed to set global variable: " + mysqlGlobalVariable + ", with value:" + mysqlGlobalVariableValue + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + visionServerCommand + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Add My.Cnf Attribute", paramsInclude = {"mysqlGlobalVariable", "mysqlGlobalVariableValue"})
    public void addMyCnfAttribute() {
        try {
            BasicOperationsHandler.appendMyCnfFile(getRestTestBase().getRootServerCli(), mysqlGlobalVariable, mysqlGlobalVariableValue);
        } catch (Exception e) {
            BaseTestUtils.report("Failed modify the /etc/my.cnf file with attribute: " + mysqlGlobalVariable + "=" + mysqlGlobalVariableValue + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Stop Vision Server Threads Output Operation", paramsInclude = {""})
    public void stopVisionServerThreadsOutputOperation() {
        stopTimedTask();
    }

    @Test
    @TestProperties(name = "Generate Screenshot Upon Find Element Failure", paramsInclude = {"screenshotGenerationOperational"})
    public void setScreenshotGenerationOnOff() {
        WebUIUtils.isScreenshotGenerationOperational = getScreenshotGenerationOperational();
    }

    @Test
    @TestProperties(name = "Set Default Timeout for Wait for Web Element", paramsInclude = {"waitForWebElementDefaultTimeout"})
    public void setDefaultTimeoutForWaitForWebElement() {
        try {
            WebUIUtils.DEFAULT_WAIT_TIME = Integer.parseInt(waitForWebElementDefaultTimeout) * 1000;
        } catch (Exception e) {
            WebUIUtils.DEFAULT_WAIT_TIME = 10 * 1000;
        }
    }

    @Test
    @TestProperties(name = "Generate screenshot after Web Click Operation", paramsInclude = {"generateScreenshotAfterWebClickOperation"})
    public void generatescreenshotafterWebClickOperation() {
        WebUIDriver.setListenerScreenshotAfterClick(generateScreenshotAfterWebClickOperation);
    }

    @Test
    @TestProperties(name = "Generate screenshot after Web Find Operation", paramsInclude = {"generateScreenshotAfterWebFindOperation"})
    public void generatescreenshotafterWebFindOperation() {
        WebUIDriver.setListenerScreenshotAfterFind(generateScreenshotAfterWebFindOperation);
    }

    @Test
    @TestProperties(name = "Auto Close Popup", paramsInclude = {"state"})
    public void autoClosePopup() {
        try {
            if (GeneralEnums.State.ENABLE.equals(state)) {
                WebUIUtils.isTriggerPopupSearchEvent4FreeTest = true;
            } else if (GeneralEnums.State.DISABLE.equals(state)) {
                WebUIUtils.isTriggerPopupSearchEvent4FreeTest = false;
            }
        } catch (Exception e) {
            BaseTestUtils.report("Auto Close Popup failed with the following error:\n" + parseExceptionBody(e), Reporter.PASS);
        }
    }

    @Test
    @TestProperties(name = "Set Global Parameters", paramsInclude = {"findElementDefaultTimeout", "findElementShortTimeout", "fluentWaitObjectFindIntervals", "waitBeforeFindElementStart", "autoClosePopupAfterTest"})
    public void setGlobalParameters() {
        if (findElementDefaultTimeout != null) {
            long value = parseLong(findElementDefaultTimeout);
            WebUIUtils.DEFAULT_WAIT_TIME = value != -1 ? value : WebUIUtils.DEFAULT_WAIT_TIME;
        }
        if (findElementShortTimeout != null) {
            long value = parseLong(findElementShortTimeout);
            WebUIUtils.SHORT_WAIT_TIME = value != -1 ? value : WebUIUtils.SHORT_WAIT_TIME;
        }
        if (fluentWaitObjectFindIntervals != null) {
            long value = parseLong(fluentWaitObjectFindIntervals);
            WebUIUtils.fluentWaitObjectFindIntervals = value != -1 ? value : WebUIUtils.fluentWaitObjectFindIntervals;
        }
        if (waitBeforeFindElementStart != null) {
            long value = parseLong(waitBeforeFindElementStart);
            WebUIUtils.waitBeforeFluentWaitStart = value != -1 ? value : WebUIUtils.waitBeforeFluentWaitStart;
        }

        WebUIUtils.setIsTriggerPopupSearchEvent(autoClosePopupAfterTest);
    }

    @Test
    @TestProperties(name = "set Current Time Plus Seconds", paramsInclude = {"seconds", "targetTestId"})
    public void setCurrentTimePlusSeconds() {
        try {
            SystemProperties systemProperties=new SystemProperties();
            LocalTime currentTime = LocalTime.now();
            currentTime = currentTime.plusSeconds(this.seconds);
            String hours = Integer.toString(currentTime.getHour());
            String minutes = Integer.toString(currentTime.getMinute());
            String seconds = Integer.toString(currentTime.getSecond());
            String dateString = hours + ":" + minutes + ":" + seconds;
            systemProperties.setRunTimeProperty("currentTimePlus", dateString);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Add Test Folder", paramsInclude = {"testFolder"})
    public void addTestFolder() {
        rallyTestReporter.addTestFolder(testFolder);
    }

    @Test
    @TestProperties(name = "Connect Radware CLI", paramsInclude = {})
    public void connectRadwareCLI() {
        try {
            RadwareServerCli radwareServerCli = restTestBase.getRadwareServerCli();
            radwareServerCli.disconnect();
            radwareServerCli.connect();
        } catch (Exception e) {
            BaseTestUtils.report("failed to connect Radware CLI: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Connect Root CLI", paramsInclude = {})
    public void connectRootCLI() {
        try {
            RootServerCli rootServerCli = restTestBase.getRootServerCli();
            rootServerCli.disconnect();
            rootServerCli.connect();
        } catch (Exception e) {
            BaseTestUtils.report("failed to connect Root CLI: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Reset Test Folder", paramsInclude = {})
    public void resetTestFolder() {
        rallyTestReporter.resetTestFolder();
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

    public String getLoginTimeout() {
        return loginTimeout;
    }

    public void setLoginTimeout(String loginTimeout) {
        this.loginTimeout = loginTimeout;
    }


    public String getTimeOut() {
        return String.valueOf(timeOut);
    }

    @ParameterProperties(description = "Please specify timeout You would like to wait (in seconds)")
    public void setTimeOut(String timeOut) {
        if (timeOut != null && !timeOut.equals("") && !timeOut.equals("null")) {
            this.timeOut = Integer.valueOf(StringUtils.fixNumeric(timeOut));
        }
    }

    public boolean isDisableAutoRefresh() {
        return disableAutoRefresh;
    }

    public void setDisableAutoRefresh(boolean disableAutoRefresh) {
        this.disableAutoRefresh = disableAutoRefresh;
    }

    public boolean getRestartVisionServerFlag() {
        return restartVisionServerFlag;
    }

    public void setRestartVisionServerFlag(boolean restartVisionServerFlag) {
        this.restartVisionServerFlag = restartVisionServerFlag;
    }

    public String getVisionServerCommand() {
        return visionServerCommand;
    }

    public void setVisionServerCommand(String visionServerCommand) {
        this.visionServerCommand = visionServerCommand;
    }

    public String getRootServerCommand() {
        return rootServerCommand;
    }

    public void setRootServerCommand(String rootServerCommand) {
        this.rootServerCommand = rootServerCommand;
    }

    public String getMysqlGlobalVariable() {
        return mysqlGlobalVariable;
    }

    public void setMysqlGlobalVariable(String mysqlGlobalVariable) {
        this.mysqlGlobalVariable = mysqlGlobalVariable;
    }

    public String getMysqlGlobalVariableValue() {
        return mysqlGlobalVariableValue;
    }

    public void setMysqlGlobalVariableValue(String mysqlGlobalVariableValue) {
        this.mysqlGlobalVariableValue = mysqlGlobalVariableValue;
    }

    public boolean getScreenshotGenerationOperational() {
        return screenshotGenerationOperational;
    }

    public void setScreenshotGenerationOperational(boolean isScreenshotGenerationOperational) {
        this.screenshotGenerationOperational = isScreenshotGenerationOperational;
    }

    public String getWaitForWebElementDefaultTimeout() {
        return waitForWebElementDefaultTimeout;
    }

    public void setWaitForWebElementDefaultTimeout(String waitForWebElementDefaultTimeout) {
        this.waitForWebElementDefaultTimeout = waitForWebElementDefaultTimeout;
    }

    public String getWaitAfterClick() {
        return waitAfterClick;
    }

    public void setWaitAfterClick(String waitAfterClick) {
        this.waitAfterClick = waitAfterClick;
    }

    public GeneralEnums.State getState() {
        return state;
    }

    public void setState(GeneralEnums.State state) {
        this.state = state;
    }

    public String getFindElementDefaultTimeout() {
        return findElementDefaultTimeout;
    }

    public void setFindElementDefaultTimeout(String findElementDefaultTimeout) {
        this.findElementDefaultTimeout = findElementDefaultTimeout;
    }

    public String getFindElementShortTimeout() {
        return findElementShortTimeout;
    }

    public void setFindElementShortTimeout(String findElementShortTimeout) {
        this.findElementShortTimeout = findElementShortTimeout;
    }

    public String getFluentWaitObjectFindIntervals() {
        return fluentWaitObjectFindIntervals;
    }

    public void setFluentWaitObjectFindIntervals(String fluentWaitObjectFindIntervals) {
        this.fluentWaitObjectFindIntervals = fluentWaitObjectFindIntervals;
    }

    public String getWaitBeforeFindElementStart() {
        return waitBeforeFindElementStart;
    }

    public void setWaitBeforeFindElementStart(String waitBeforeFindElementStart) {
        this.waitBeforeFindElementStart = waitBeforeFindElementStart;
    }

    public String getElementID() {
        return elementID;
    }

    public void setElementID(String elementID) {
        this.elementID = elementID;
    }

    public boolean getGenerateScreenshotAfterWebClickOperation() {
        return generateScreenshotAfterWebClickOperation;
    }

    public void setGenerateScreenshotAfterWebClickOperation(boolean generateScreenshotAfterWebClickOperation) {
        try {
            if (System.getProperty("generateScreenshotAfterWebClickOperation") != null) {
                this.generateScreenshotAfterWebClickOperation = Boolean.valueOf(System.getProperty("generateScreenshotAfterWebClickOperation"));
            }
        } catch (Exception e) {
//            Ignore
        }
        this.generateScreenshotAfterWebClickOperation = generateScreenshotAfterWebClickOperation;
        WebUIDriver.setListenerScreenshotAfterClick(this.generateScreenshotAfterWebClickOperation);
    }

    public boolean getGenerateScreenshotAfterWebFindOperation() {
        return generateScreenshotAfterWebFindOperation;
    }

    public void setGenerateScreenshotAfterWebFindOperation(boolean generateScreenshotAfterWebFindOperation) {
        try {
            if (System.getProperty("generateScreenshotAfterWebFindOperation") != null) {
                this.generateScreenshotAfterWebFindOperation = Boolean.valueOf(System.getProperty("generateScreenshotAfterWebFindOperation"));
            }
        } catch (Exception e) {
//            Ignore
        }
        this.generateScreenshotAfterWebFindOperation = generateScreenshotAfterWebFindOperation;
        WebUIDriver.setListenerScreenshotAfterFind(this.generateScreenshotAfterWebFindOperation);
    }

    private void generateScreenshot() {
        try {
            InputStream inputStream = null;
            String time = new SimpleDateFormat("HH:mm:ss").format(new Date(System.currentTimeMillis()));
            WebDriver driver = WebUIUtils.getDriver();
            byte[] buff = ((TakesScreenshot) driver).getScreenshotAs(OutputType.BYTES);
            inputStream = new ByteArrayInputStream(buff);
            //generate random name for screenshot file
            String randomFileName = UUID.randomUUID().toString();
            randomFileName += ".png";
            inputStream = ImageCompression.compressFile(inputStream);
            BaseTestUtils.reporter.saveFile(randomFileName, ByteStreams.toByteArray(inputStream));

            String imageSource = randomFileName;
            BaseTestUtils.reporter.reportHtml(time + " Screenshot. Login", "<img src=" + imageSource + " alt=screenshot width=1280 height=848>", true);
        } catch (IOException e) {
        }
    }


    public boolean isValidateLogoutOperation() {
        return validateLogoutOperation;
    }

    public void setValidateLogoutOperation(boolean validateLogoutOperation) {
        this.validateLogoutOperation = validateLogoutOperation;
    }

    public String getTestFolder() {
        return testFolder;
    }

    public void setTestFolder(String testFolder) {
        this.testFolder = testFolder;
    }

    public int getSeconds() {
        return this.seconds;
    }

    @ParameterProperties(description = "Please specify number of seconds to add to the current time.")
    public void setSeconds(int seconds) {
        this.seconds = seconds;
    }

    public ExpectedHttpCodes getExpectedHttpCodes() {
        return expectedHttpCodes;
    }

    @ParameterProperties(description = "Specify the expected HTTP result to verify against.")
    public void setExpectedHttpCodes(ExpectedHttpCodes expectedHttpCodes) {
        this.expectedHttpCodes = expectedHttpCodes;
    }

    public boolean getIgnoreRestResponseValidation() {
        return ignoreRestResponseValidation;
    }

    public void setIgnoreRestResponseValidation(boolean ignoreRestResponseValidation) {
        this.ignoreRestResponseValidation = ignoreRestResponseValidation;
    }
}
