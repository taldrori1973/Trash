package com.radware.vision.infra.testhandlers.vrm;

import com.google.common.collect.Lists;
import com.radware.automation.react.widgets.impl.ReactDateControl;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.testhandlers.EmailHandler;
import com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection.enums.QuickRange;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.enums.vrmActions;
import com.radware.vision.infra.testresthandlers.ElasticSearchHandler;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;

import static com.radware.automation.webui.UIUtils.sleep;
import static com.radware.vision.infra.testhandlers.BaseHandler.devicesManager;
import static com.radware.vision.vision_tests.CliTests.rootServerCli;


public class VRMReportsHandler extends VRMBaseUtilies {
    private VRMReportsDateUtils vrmReportsDateUtils = new VRMReportsDateUtils();
    private VRMHandler vrmHandler = new VRMHandler();
    private long timePeriodThreshold = 1000 * 60 * 3;

    public VRMReportsHandler() {
    }

    public void validateSimpleDate(String dateToValidateLabel, String timeFormat, String errorThresholdInMinutes) {
        long errorThreshold = (errorThresholdInMinutes == null || errorThresholdInMinutes.equals("")) ? timePeriodThreshold : Long.valueOf(errorThresholdInMinutes) * vrmReportsDateUtils.minute;
        String timeFormatFinal = (timeFormat == null || timeFormat.equals("")) ? vrmReportsDateUtils.timeFormat : timeFormat;
        String dateString = getDateString(dateToValidateLabel);
        long dateToValidate = TimeUtils.getEpochTime(dateString, timeFormatFinal);
        long expectedTime = System.currentTimeMillis();
        if (validateDate(dateToValidate, expectedTime, errorThreshold)) {
            BaseTestUtils.report("Validate Date " + dateString + " is successful", Reporter.PASS);
        } else {
            BaseTestUtils.report("Validate Date " + dateString + " has Failed, expected Date is " + (new Date(expectedTime)).toString(), Reporter.PASS);
        }
    }

    public void validateQuickRange(String startingDateSelector, String endDateSelector, QuickRange quickRange, String timeFormat, String errorThresholdInMinutes) {
        long errorThreshold = (errorThresholdInMinutes == null || errorThresholdInMinutes.equals("")) ? timePeriodThreshold : Long.valueOf(errorThresholdInMinutes) * vrmReportsDateUtils.minute;
        String timeFormatFinal = (timeFormat == null || timeFormat.equals("")) ? vrmReportsDateUtils.timeFormat : timeFormat;
        String staringDateString = getDateString(startingDateSelector);
        String endDateString = getDateString(endDateSelector);
        long actualStartDate = TimeUtils.getEpochTime(staringDateString, timeFormatFinal);
        long actualEndDate = TimeUtils.getEpochTime(endDateString, timeFormatFinal);
        long expectedEndDate = System.currentTimeMillis();
        long expectedStartDate = vrmReportsDateUtils.getExpectedStartTime(quickRange, expectedEndDate);
        if (validateDate(actualStartDate, expectedStartDate, errorThreshold) && validateDate(actualEndDate, expectedEndDate, errorThreshold)) {
            BaseTestUtils.report("Validate QuickRange for " + staringDateString + " to - " + endDateString + "is successful", Reporter.PASS);
        } else {
            BaseTestUtils.report("Validate QuickRange for " + staringDateString + " to - " + endDateString + " has Failed, expected Date is ", Reporter.PASS);
        }

    }

    private String getDateString(String dateToValidateLabel) {
        VisionDebugIdsManager.setLabel(dateToValidateLabel);
        ReactDateControl reactDateControl = new ReactDateControl(VisionDebugIdsManager.getDataDebugId());
        return reactDateControl.getDateText();
    }


    public void validateVRMReport(String reportName, boolean isExists) {
        ComponentLocator locator = ComponentLocatorFactory.getLocatorByDbgId(WebUIStringsVision.getVRMReportListItemIdByName(reportName));
        WebElement listItemElement = WebUIUtils.fluentWait(locator.getBy());
        if (listItemElement != null && isExists || listItemElement == null && !isExists) {
            BaseTestUtils.report("Validate AMS Report Name " + reportName + " is successful", Reporter.PASS);
        } else {
            BaseTestUtils.report("AMS Report " + reportName + " is Failed", Reporter.FAIL);
        }
    }

    public void validateReportTimePeriod(String reportName, QuickRange timePeriod) throws TargetWebElementNotFoundException {
        generateNewReport(reportName);
        vrmReportsDateUtils.setStartEndTime(timePeriod);
        Long timePeriodFinal = vrmReportsDateUtils.getEndTimeActual() - vrmReportsDateUtils.getStartTimeActual();
        Long timePeriodExpected = vrmReportsDateUtils.getEndTimeExpected() - vrmReportsDateUtils.getStartTimeExpected();
        boolean isValid = false;
        if (validatePeriod(timePeriodExpected, timePeriodFinal, timePeriod) && validateDate(vrmReportsDateUtils.getEndTimeActual(), vrmReportsDateUtils.getEndTimeExpected(), timePeriodThreshold))
            if (isValid) {
                BaseTestUtils.report("Validate Report period " + timePeriod.getQuickRange() + " is successful", Reporter.PASS);
            } else {
                BaseTestUtils.report("Validate Report period " + timePeriod.getQuickRange() + " is Failed", Reporter.FAIL);
            }
    }

    public void generateNewReport(String reportName) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Reports List Item", reportName);
        BasicOperationsHandler.clickButton("Generate Now", reportName);
    }


    private boolean validatePeriod(Long timePeriodExpected, Long timePeriodFinal, QuickRange timePeriod) {
        if ((Math.abs(timePeriodFinal - timePeriodExpected) / vrmReportsDateUtils.minute) < Long.valueOf(timePeriod.getErrorThresholdInTimeUnits())) {
            return true;
        }
        return false;
    }

    private boolean validateDate(long dateToValidate, long dateExpected, long thresholdToValidateAgainst) {
        if ((Math.abs(dateExpected - dateToValidate)) < thresholdToValidateAgainst) {
            return true;
        }
        return false;
    }

    /*******************************************************************************************************************************************************/
    public void VRMReportOperation(vrmActions operationType, String reportName, Map<String, String> reportsEntry, RootServerCli rootServerCli) throws Exception {
        BaseVRMOperation(operationType, reportName, reportsEntry, rootServerCli);
    }

    protected void editVRMBase(String reportName, Map<String, String> map) throws Exception {
        enterToEdit(reportName);
        editDevices(map);
        BasicOperationsHandler.clickButton("Time Definition Step", "initial");
        editTimeDefinitions(map);
        BasicOperationsHandler.clickButton("Schedule Step", "initial");
        editSchedule(map);
        BasicOperationsHandler.clickButton("Delivery Step", "initial");
        editDelivery(map);
        BasicOperationsHandler.clickButton("Design Step", "initial");
        editDesign(reportName, map);
        BasicOperationsHandler.clickButton("Summary Step", "initial");
        BasicOperationsHandler.clickButton("Submit", "");
    }

    protected void editVRMBaseNew(String reportName, Map<String, String> map) throws Exception {
        enterToEdit(reportName);
        editDesignNew(reportName, map);
        editCustomizedOptions(map);
        expandViews(true);
        editDevices(map);
        editTimeDefinitionsNew(map);
        editScheduleNew(map);
        editShare(map);
        editFormat(map);
        BasicOperationsHandler.clickButton("Submit", "");
    }

    private void editDesign(String reportName, Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Design")) {
            Design(reportName, map);
        }
    }

    private void editDesignNew(String reportName, Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("reportType")) {
            selectTemplate(map);
//            BasicOperationsHandler.clickButton("Undo All");
            if (map.containsKey("Design")) {
                BasicOperationsHandler.clickButton("Undo All");
                DesignNew(map);
            }
            BasicOperationsHandler.clickButton("Template Apply");
        }
    }

    public void editCustomizedOptions(Map<String, String> map) throws Exception {
        if (map.containsKey("Customized Options")) {
            BasicOperationsHandler.clickButton("Customized Options");
            WebElement showTable = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId("Show_Table_Item").getBy());
            WebElement logo = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId("Add_Logo_Item").getBy());
            // class contains "bHftNV" that's mean clicked
            if (showTable != null && showTable.getAttribute("class").contains("bHftNV"))
                BasicOperationsHandler.clickButton("Show Table");
            // class contains "bHftNV" that's mean clicked
            if (logo != null && logo.getAttribute("class").contains("bHftNV"))
                BasicOperationsHandler.clickButton("Add Logo");
            BasicOperationsHandler.clickButton("Customized Options");
            customizedOptions(map);
        }
    }

    protected void validateVRMBase(RootServerCli rootServerCli, String reportName, Map<String, String> map) throws Exception {
        EnterToValidateOrEdit(reportName);
//        new Report().validate(rootServerCli, reportName, map);
        JSONObject basicRestResult = waitForESDocument(rootServerCli, "reportName", reportName, "vrm-scheduled-report-definition-vrm", 0);
        if (basicRestResult == null) {
            BaseTestUtils.report("Could not find document: " + reportName, Reporter.FAIL);
            return;
        }

        try {
            StringBuilder errorMessage = new StringBuilder();
            String ObjectString = basicRestResult.get("content").toString().replace("\\", "");
            JSONObject restResult = new JSONObject(ObjectString);
            errorMessage.append(validateCustomizedOption(restResult, map, reportName));
            errorMessage.append(validateDevices(restResult.getJSONArray("scopeSelection"), map));
            errorMessage.append(validateTimeDefinitions(restResult.get("timeRange"), map));
            errorMessage.append(validateSchedule(basicRestResult.get("schedulingDefinition"), map));
            errorMessage.append(validateDelivery(basicRestResult.get("deliveryMethod"), map));
            errorMessage.append(validateDesign(restResult.get("currentGridsterContent"), map));
            errorMessage.append(validateFormat(basicRestResult.get("exportFormat"), map));
            if (errorMessage.length() != 0)
                BaseTestUtils.report(errorMessage.toString(), Reporter.FAIL);
        } catch (JSONException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    private StringBuilder validateCustomizedOption(JSONObject restResult, Map<String, String> map, String reportName) {

        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Customized Options")) {
            JSONObject customizedJsonObject = new JSONObject(map.get("Customized Options"));
            if (!customizedJsonObject.isNull("addLogo")) {
                boolean isSelected = !customizedJsonObject.get("addLogo").toString().trim().equals("unselected");
                if (!((JSONObject) ((JSONObject) restResult.get("customOptions")).get("logo")).get("selected").equals(isSelected)) {
                    if (isSelected)
                        errorMessage.append("No selected logo!! in '").append(reportName).append("' report").append("\n");
                    else
                        errorMessage.append("In report '").append(reportName).append("' The expected is no selected logo but the actual is selected").append("\n");
                }
                if (!((JSONObject) ((JSONObject) restResult.get("customOptions")).get("logo")).get("fileName").equals(customizedJsonObject.get("addLogo")) && isSelected)
                    errorMessage.append("In report '").append(reportName).append("', The Expected logo file name is ").append(customizedJsonObject.get("addLogo")).append(" but the                 Actual is ").append(((JSONObject) ((JSONObject) restResult.get("customOptions")).get("logo")).get("fileName"));
            }
            if (!customizedJsonObject.isNull("showTable"))
                if (!((JSONObject) ((JSONObject) restResult.get("customOptions")).get("table")).get("selected").equals(customizedJsonObject.get("showTable")))
                    errorMessage.append("In report '").append(reportName).append("' the table in customized options should be ").append(customizedJsonObject.get("showTable").equals(true) ? "selected" : "not selected").append("but the Actual is ").append(((JSONObject) ((JSONObject) restResult.get("customOptions")).get("table")).get("selected"));

//                if(errorMessage.length() != 0) BaseTestUtils.report(errorMessage.toString(), Reporter.FAIL);
        }
        return errorMessage;
    }

    protected void generateVRMBase(String reportName, Map<String, String> map) throws TargetWebElementNotFoundException {
        generate(reportName, map);
    }

    @Override
    protected Map<String, String> getReportLogStatus(WebElement reportContainer) {
        Map<String, String> status = new HashMap<>();

        int listSize = 0;
        String time = "";
        WebElement reportLogsList;
        try {
            reportLogsList = reportContainer.findElement(By.cssSelector("ul[data-debug-id=\"Reports_Logs_List_Items\"]"));
            if (reportLogsList != null) listSize = reportLogsList.findElements(By.tagName("li")).size();

            if (listSize > 0) {
                String firstLog = reportLogsList.findElements(By.tagName("li")).get(0).getText();
                String[] firstLogTokens = firstLog.trim().split("\n");
                time = firstLogTokens[0];
            }

            status.put("logSize", String.valueOf(listSize / 2));
            status.put("lastLogTime", time);
        } catch (NoSuchElementException e) {
            status.put("logSize", "0");
            status.put("lastLogTime", "None");
            return status;
        }
        return status;
    }

    protected boolean isExistVRMBaseResult(String reportName, Map<String, String> map) {
        ComponentLocator componentLocator = ComponentLocatorFactory.getEqualLocatorByDbgId("VRM_report_summary_title_" + reportName);
        WebElement element = WebUIUtils.fluentWait(componentLocator.getBy());
        if (element == null) {
            return false;
        } else {
            return true;
        }
    }


    protected void isExistVRMBase(String reportName, Map<String, String> map) {
        ComponentLocator componentLocator = ComponentLocatorFactory.getEqualLocatorByDbgId("VRM_report_summary_title_" + reportName);
        WebElement element = WebUIUtils.fluentWait(componentLocator.getBy());
        if (element == null) {
            BaseTestUtils.report("report with name: " + reportName + " does NOT exist", Reporter.FAIL);
        } else {
            BaseTestUtils.report("report with name: " + reportName + " exists", Reporter.PASS);
        }
    }

    protected void validateGeneratedReport(String reportName, Map<String, String> map) {
        //TODO
//        validateGeneratedReportSchedule(map);
//        generateNewReport(reportName);
//        BasicOperationsHandler.clickButton("Log Preview", 60,reportName);
//        validateGeneratedReportDevices(map);
//        validateGeneratedReportTimeDefinitions(map);
//        validateGeneratedReportDelivery(map);
//        validateGeneratedReportDesign(map);
    }

    private StringBuilder validateDesign(Object design, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Design")) {
            List deliveryList = ((JSONArray) design).toList();
            List<String> expectedDesignList = new ArrayList<>();
            try {
                expectedDesignList = ((List<String>) (new JSONObject(map.get("Design")).toMap().get("Widgets")));
            } catch (Exception e) {
            }

            if (deliveryList.size() != expectedDesignList.size()) {
//                BaseTestUtils.report("The number of actual widgets is " + deliveryList.size() + " but the Expected's number is  " + expectedDesignList.size(), Reporter.FAIL);
                errorMessage.append("The number of actual widgets is " + deliveryList.size() + " but the Expected's number is  " + expectedDesignList.size()).append("\n");
            }
            for (int i = 0; i < expectedDesignList.size(); i++) {
                String expectedWidget = expectedDesignList.get(i).toUpperCase().trim();
                boolean exist = false;
                for (Object aDeliveryList : deliveryList) {
                    String actualWidget = ((HashMap) aDeliveryList).get("title").toString().toUpperCase();
                    if (expectedWidget.equalsIgnoreCase(actualWidget))
                        exist = true;
                }
                if (!exist)
                    if (i >= deliveryList.size()) {
                        errorMessage.append("The expected widget '" + expectedWidget + "' doesn't exist ");
                    } else
//                    BaseTestUtils.report("The Actual " + i + " th widget is " + ((HashMap) deliveryList.get(i)).get("title").toString() + " but the Expected widget is " + expectedWidget, Reporter.FAIL);
                    {
                        errorMessage.append("The Actual " + i + " the widget is " + ((HashMap) deliveryList.get(i)).get("title").toString() + " but the Expected widget is " + expectedWidget).append("\n");
                    }

                /*
                String actualWidget = ((HashMap) deliveryList.get(i)).get("title").toString().split("-")[0].toUpperCase();
                String expectedWidget = expectedDesignList.get(i).toUpperCase();

                if (!actualWidget.equalsIgnoreCase(expectedWidget)) {
                    BaseTestUtils.report("The Actual" + i + "th widget is " + ((HashMap) deliveryList.get(i)).get("title").toString() + " but the Expected widget is " + expectedWidget, Reporter.FAIL);
                }
                */
            }
        }
        return errorMessage;
    }

    private StringBuilder validateDelivery(Object delivery, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Delivery")) {
            Map<String, Object> deliveryMap = ((JSONObject) delivery).toMap();
            Map<String, Object> expectedDeliveryMap = (new JSONObject(map.get("Delivery"))).toMap();
            String actualEmails = ((Map) deliveryMap.get("email")).get("recipients").toString().replace("[", "").replace("]", "").replace(" ", "");
            String[] expectedEmailsArray = expectedDeliveryMap.get("Email").toString().replaceAll("(])|(\\[)", "").split(",");
            for (String s : expectedEmailsArray) {
                if (!actualEmails.toUpperCase().contains(s.toUpperCase().trim())) {
//                    BaseTestUtils.report("The emails aren't the same, the actual is " + actualEmails + " and the Expected email " + s + " isn't found", Reporter.FAIL);
                    errorMessage.append("The emails aren't the same, the actual is " + actualEmails + " and the Expected email " + s + " isn't found").append("\n");
                }
            }
            String actualSubject = ((Map) deliveryMap.get("email")).get("subject").toString();
            String expectedSubject = expectedDeliveryMap.get("Subject").toString();
            if (!actualSubject.equalsIgnoreCase(expectedSubject)) {
//                BaseTestUtils.report("the Actual Subject is " + actualSubject + ", but the Expected Subject is " + expectedSubject, Reporter.FAIL);
                errorMessage.append("the Actual Subject is " + actualSubject + ", but the Expected Subject is " + expectedSubject).append("\n");
            } else {
                String actualBody = ((Map) deliveryMap.get("email")).get("message").toString();
                String expectedBody = expectedDeliveryMap.get("Body").toString();
                if (!actualBody.equalsIgnoreCase(expectedBody)) {
//                    BaseTestUtils.report("the Actual Body is " + actualBody + ", but the Expected Body is " + expectedBody, Reporter.FAIL);
                    errorMessage.append("the Actual Body is " + actualBody + ", but the Expected Body is " + expectedBody).append("\n");
                }
            }

        }
        return errorMessage;
    }

    private StringBuilder validateFormat(Object format, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Format")) {
            Map<String, Object> expectedFormatMap = new JSONObject(map.get("Format")).toMap();
            Map<String, Object> formatMap = ((JSONObject) format).toMap();
            if (!formatMap.get("type").toString().equalsIgnoreCase(expectedFormatMap.get("Select").toString())) {
//                BaseTestUtils.report("The actual Format is: " + formatMap.get("type").toString() + "but the Expedted format is: " + expectedFormatMap.get("Select").toString(), Reporter.FAIL);
                errorMessage.append("The actual Format is: " + formatMap.get("type").toString() + "but the Expedted format is: " + expectedFormatMap.get("Select").toString()).append("\n");
            }
        }
        return errorMessage;
    }

    private StringBuilder validateSchedule(Object schedule, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Schedule")) {
            Map<String, String> textsMatchs = buildindMatches();
            Map<String, Object> scheduleMap = ((JSONObject) schedule).toMap();
            Map<String, Object> expectedScheduleMap = new JSONObject(map.get("Schedule")).toMap();
            String actualType = scheduleMap.get("type").toString();
            String expectedType = expectedScheduleMap.get("Run Every").toString();
            if (!expectedType.equalsIgnoreCase(actualType)) {
//                BaseTestUtils.report("The Actual schedule type is " + actualType + " but the Expected type is " + expectedType, Reporter.FAIL);
                errorMessage.append("The Actual schedule type is " + actualType + " but the Expected type is " + expectedType).append("\n");
            } else {
                String expectedOnTime = "";
                if (expectedScheduleMap.containsKey("On Time")) {
                    expectedOnTime = expectedScheduleMap.get("On Time").toString();
                }
                if (expectedOnTime.contains("+") || expectedOnTime.contains("-")) {
                    String actualOnTime = scheduleMap.get("time").toString();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
                    String expectedTimeOfDay = scheduleLocalDateTime.format(formatter);
                    if (!actualOnTime.equalsIgnoreCase(expectedTimeOfDay)) {
//                        BaseTestUtils.report("the Actual on Time is" + actualOnTime + " but the Expected is " + expectedTimeOfDay, Reporter.FAIL);
                        errorMessage.append("the Actual on Time is" + actualOnTime + " but the Expected is " + expectedTimeOfDay).append("\n");
                    }
                    LocalDateTime actualLocalDateTime = scheduleLocalDateTime;
                    actualLocalDateTime.withHour(Integer.parseInt(actualOnTime.split(":")[0]));
                    actualLocalDateTime.withMinute(Integer.parseInt(actualOnTime.split(":")[1]));
                    String expectedDayOfWeeks = "SUN";
                    if (expectedType.equalsIgnoreCase("weekly")) {
                        switch ((scheduleLocalDateTime.getDayOfWeek().getValue() + 1) % 7) {
                            case 1:
                                expectedDayOfWeeks = "SUN";
                                break;
                            case 2:
                                expectedDayOfWeeks = "MON";
                                break;
                            case 3:
                                expectedDayOfWeeks = "TUE";
                                break;
                            case 4:
                                expectedDayOfWeeks = "WED";
                                break;
                            case 5:
                                expectedDayOfWeeks = "THU";
                                break;
                            case 6:
                                expectedDayOfWeeks = "FRI";
                                break;
                            case 7:
                                expectedDayOfWeeks = "SAT";
                                break;
                        }

                        String actualDayOfWeek = ((JSONObject) schedule).toMap().get("daysOfWeek").toString();
                        if (!actualDayOfWeek.replaceAll("(])|(\\[)", "").equalsIgnoreCase(textsMatchs.get(expectedDayOfWeeks))) {
//                            BaseTestUtils.report("the Actual day of week is " + actualDayOfWeek + " but thye Expected is " + expectedDayOfWeeks, Reporter.FAIL);
                            errorMessage.append("the Actual day of week is " + actualDayOfWeek + " but thye Expected is " + expectedDayOfWeeks).append("\n");
                        }
                    }
                    if (expectedType.equalsIgnoreCase("Monthly")) {
                        String expectedMonth = "JAN";
                        switch (scheduleLocalDateTime.getMonth().getValue()) {
                            case 1:
                                expectedMonth = "JAN";
                                break;
                            case 2:
                                expectedMonth = "FEB";
                                break;
                            case 3:
                                expectedMonth = "MAR";
                                break;
                            case 4:
                                expectedMonth = "APR";
                                break;
                            case 5:
                                expectedMonth = "MAY";
                                break;
                            case 6:
                                expectedMonth = "JUN";
                                break;
                            case 7:
                                expectedMonth = "JUL";
                                break;
                            case 8:
                                expectedMonth = "AUG";
                                break;
                            case 9:
                                expectedMonth = "SEP";
                                break;
                            case 10:
                                expectedMonth = "OCT";
                                break;
                            case 11:
                                expectedMonth = "NOV";
                                break;
                            case 12:
                                expectedMonth = "DEC";
                                break;
                        }
                        String actualOnDayOfMonth = scheduleMap.get("dayOfMonth").toString();
                        String expectedOnDayOfMonth = String.valueOf(scheduleLocalDateTime.getDayOfMonth());
                        if (!expectedOnDayOfMonth.equalsIgnoreCase(actualOnDayOfMonth)) {
//                            BaseTestUtils.report("the Actual day of expectedMonth is " + actualOnDayOfMonth + " but the expected is " + expectedOnDayOfMonth, Reporter.FAIL);
                            errorMessage.append("the Actual day of expectedMonth is " + actualOnDayOfMonth + " but the expected is " + expectedOnDayOfMonth).append("\n");
                        }
                        List actualMonths = ((List) ((JSONObject) schedule).toMap().get("months"));
                        expectedMonth = textsMatchs.get(expectedMonth);
                        if (expectedMonth.equalsIgnoreCase(textsMatchs.get(actualMonths.get(0).toString()))) {
//                            BaseTestUtils.report("the Actual Month is " + actualMonths.get(0).toString() + " but the expected is " + expectedMonth, Reporter.FAIL);
                            errorMessage.append("the Actual Month is " + actualMonths.get(0).toString() + " but the expected is " + expectedMonth).append("\n");
                        }
                    }

                    if (expectedType.equalsIgnoreCase("Once")) {
                        if (!actualType.equalsIgnoreCase("Once")) {
//                            BaseTestUtils.report("the Actual type is " + actualType + " but the expected is Once", Reporter.FAIL);
                            errorMessage.append("the Actual type is " + actualType + " but the expected is Once").append("\n");
                        }

                        DateTimeFormatter onDayFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                        String expectedOnDay = scheduleLocalDateTime.format(onDayFormatter);
                        String actualOnDay = scheduleMap.get("date").toString();
                        if (!expectedOnDay.equalsIgnoreCase(actualOnDay)) {
//                            BaseTestUtils.report("the Actual onDay is " + actualOnDay + " but the expected is " + expectedOnDay, Reporter.FAIL);
                            errorMessage.append("the Actual onDay is " + actualOnDay + " but the expected is " + expectedOnDay).append("\n");
                        }

                    }


                } else {
                    if (expectedType.equalsIgnoreCase("weekly")) {
                        List<String> expectedDatsOfWeeks = Arrays.asList(expectedScheduleMap.get("At Week Day").toString().split(","));
                        for (int i = 0; i < expectedDatsOfWeeks.size(); i++) {
                            String tempVal = textsMatchs.get(expectedDatsOfWeeks.get(i));
                            expectedDatsOfWeeks.set(i, tempVal);
                        }
                        List actualdaysOfWeeks = ((List) ((JSONObject) schedule).toMap().get("daysOfWeek"));

                        if (!expectedDatsOfWeeks.containsAll(actualdaysOfWeeks)) {
//                            BaseTestUtils.report("The Actual daysOfWeek type is " + actualdaysOfWeeks + " but the Expected daysOfWeek is " + expectedDatsOfWeeks, Reporter.FAIL);
                            errorMessage.append("The Actual daysOfWeek type is " + actualdaysOfWeeks + " but the Expected daysOfWeek is " + expectedDatsOfWeeks).append("\n");
                        }
                    } else {
                        if (expectedType.equalsIgnoreCase("monthly")) {
                            List<String> expecteMonths = Arrays.asList(expectedScheduleMap.get("At Months").toString().trim().split(","));
                            for (int i = 0; i < expecteMonths.size(); i++) {
                                String tempVal = textsMatchs.get(expecteMonths.get(i));
                                expecteMonths.set(i, tempVal);
                            }
                            List actualMonths = ((List) ((JSONObject) schedule).toMap().get("months"));
                            if (!expecteMonths.containsAll(actualMonths)) {
//                                BaseTestUtils.report("The Actual months are " + actualMonths + " but the Expected expecteMonths is " + expecteMonths, Reporter.FAIL);
                                errorMessage.append("The Actual months are " + actualMonths + " but the Expected expecteMonths is " + expecteMonths).append("\n");
                            }
                            String expectedOnDayOfMonth = expectedScheduleMap.get("ON Day of Month").toString();
                            String actualOnDayOfMonth = scheduleMap.get("dayOfMonth").toString();
                            if (!expectedOnDayOfMonth.equals(actualOnDayOfMonth)) {
//                                BaseTestUtils.report("The Actual onDayOfMonths is " + actualOnDayOfMonth + " but the Expected onDayOfMonths is " + expectedOnDayOfMonth, Reporter.FAIL);
                                errorMessage.append("The Actual onDayOfMonths is " + actualOnDayOfMonth + " but the Expected onDayOfMonths is " + expectedOnDayOfMonth).append("\n");
                            }
                        }
                    }
                    String actualOnTime = scheduleMap.get("time").toString();
                    if (!actualOnTime.equals(expectedOnTime)) {
//                        BaseTestUtils.report("The Actual OnTime is " + actualOnTime + " but the Expected OnTime is " + expectedOnTime, Reporter.FAIL);
                        errorMessage.append("The Actual OnTime is " + actualOnTime + " but the Expected OnTime is " + expectedOnTime).append("\n");
                    }
                }
            }
        }
        return errorMessage;
    }

    private Map<String, String> buildindMatches() {
        Map<String, String> textsMatchs = new HashMap<>();
        textsMatchs.put("Week", "weekly");
        textsMatchs.put("SUN", "sunday");
        textsMatchs.put("MON", "monday");
        textsMatchs.put("TUE", "tuesday");
        textsMatchs.put("WED", "wednesday");
        textsMatchs.put("THU", "thursday");
        textsMatchs.put("FRI", "friday");
        textsMatchs.put("SAT", "saturday");
        textsMatchs.put("Month", "monthly");
        textsMatchs.put("JAN", "january");
        textsMatchs.put("FEB", "february");
        textsMatchs.put("MAR", "march");
        textsMatchs.put("APR", "april");
        textsMatchs.put("MAY", "may");
        textsMatchs.put("JUN", "june");
        textsMatchs.put("JUL", "july");
        textsMatchs.put("AUG", "august");
        textsMatchs.put("SEP", "september");
        textsMatchs.put("OCT", "october");
        textsMatchs.put("NOV", "november");
        textsMatchs.put("DEC", "december");
        textsMatchs.put("Day", "daily");
        textsMatchs.put("Hour", "hourly");
        textsMatchs.put("Once", "once");
        return textsMatchs;
    }

    private StringBuilder validateTimeDefinitions(Object timeDefinitions, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Time Definitions.Date")) {
            Map<String, Object> actualTimeDefinitionsMap = ((JSONObject) timeDefinitions).toMap();
            JSONObject expectedTimeDefinitions = new JSONObject(map.get("Time Definitions.Date"));
            if (expectedTimeDefinitions.toMap().containsKey("Quick")) {
                if (!actualTimeDefinitionsMap.get("rangeType").toString().equalsIgnoreCase("quick")) {
//                    BaseTestUtils.report("The rangeType is " + actualTimeDefinitionsMap.get("rangeType") + " and not quick", Reporter.FAIL);
                    errorMessage.append("The rangeType is " + actualTimeDefinitionsMap.get("rangeType") + " and not quick").append("\n");
                } else {
                    if (!actualTimeDefinitionsMap.get("quickRangeSelection").toString().equalsIgnoreCase(expectedTimeDefinitions.getString("Quick"))) {
//                        BaseTestUtils.report("The value of the quickRange is " + actualTimeDefinitionsMap.get("quickRangeSelection") + " and not " + expectedTimeDefinitions.getString("Quick"), Reporter.FAIL);
                        errorMessage.append("The value of the quickRange is " + actualTimeDefinitionsMap.get("quickRangeSelection") + " and not " + expectedTimeDefinitions.getString("Quick")).append("\n");
                    }
                }
            } else {
                if (expectedTimeDefinitions.toMap().containsKey("Absolute")) {
                    if (!(expectedTimeDefinitions.get("Absolute").toString().contains("+") || expectedTimeDefinitions.get("Absolute").toString().contains("-"))) {
                        if (!actualTimeDefinitionsMap.get("rangeType").toString().equalsIgnoreCase("absolute")) {
//                            BaseTestUtils.report("The rangeType is " + actualTimeDefinitionsMap.get("rangeType") + " and not Absolute", Reporter.FAIL);
                            errorMessage.append("The rangeType is " + actualTimeDefinitionsMap.get("rangeType") + " and not Absolute").append("\n");
                        }
                    } else {
                        LocalDateTime actualDate =
                                LocalDateTime.ofInstant(Instant.ofEpochMilli(new Long(actualTimeDefinitionsMap.get("to").toString())), ZoneId.systemDefault());
                        DateTimeFormatter absoluteFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
                        String actualAbsoluteText = actualDate.format(absoluteFormatter);
                        String expectedAbsoluteText = timeDefinitionLocalDateTime.format(absoluteFormatter);
                        if (!actualAbsoluteText.equalsIgnoreCase(expectedAbsoluteText)) {
//                            BaseTestUtils.report("the Actual absolute time is " + actualDate + " but the expected is " + timeDefinitionLocalDateTime, Reporter.FAIL);
                            errorMessage.append("the Actual absolute time is " + actualDate + " but the expected is " + timeDefinitionLocalDateTime).append("\n");
                        }
                    }

                } else {
                    if (expectedTimeDefinitions.toMap().containsKey("Relative")) {
                        if (!actualTimeDefinitionsMap.get("rangeType").toString().equalsIgnoreCase("relative")) {
//                            BaseTestUtils.report("The rangeType is " + actualTimeDefinitionsMap.get("rangeType") + " and not relative", Reporter.FAIL);
                            errorMessage.append("The rangeType is " + actualTimeDefinitionsMap.get("rangeType") + " and not relative").append("\n");
                        } else {
                            if (!actualTimeDefinitionsMap.get("relativeRange").toString().equalsIgnoreCase(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(0).toString())) {
//                                BaseTestUtils.report("The relative range is " + actualTimeDefinitionsMap.get("relativeRange") + " and not " + new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(0).toString(), Reporter.FAIL);
                                errorMessage.append("The relative range is " + actualTimeDefinitionsMap.get("relativeRange") + " and not " + new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(0).toString()).append("\n");
                            } else {
                                if (!actualTimeDefinitionsMap.get("relativeRangeValue").toString().equalsIgnoreCase(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(1).toString())) {
//                                    BaseTestUtils.report("The relativeRangeValue is " + actualTimeDefinitionsMap.get("relativeRangeValue") + " and not " + new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(1).toString(), Reporter.FAIL);
                                    errorMessage.append("The relativeRangeValue is " + actualTimeDefinitionsMap.get("relativeRangeValue") + " and not " + new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(1).toString()).append("'n");
                                }
                            }
                        }
                    }
                }
            }

        }
        return errorMessage;
    }

    protected StringBuilder validateDevices(Object devices, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        JSONArray actualDevicesJsonArray = (JSONArray) devices;
        String deviceType = map.containsKey("devices") ? "devices" : map.containsKey("policy") ? "policy" : map.containsKey("projectObjects") ? "projectObjects" : map.containsKey("webApplications") ? "webApplications" : "";
        switch (deviceType) {
            case "devices": {
                errorMessage.append(validateSelectDevices(map, actualDevicesJsonArray));
                break;
            }
            case "policy": {
                errorMessage.append(validateSelectPolicy((JSONArray) devices, map));
                break;
            }
            case "projectObjects": {
                errorMessage.append(validateSelectPOs(map, actualDevicesJsonArray));
                break;
            }
            case "webApplications": {
                break;
            }
            default:
                break;
        }
        return errorMessage;
    }

    private StringBuilder validateSelectPOs(Map<String, String> map, JSONArray actualDevicesJsonArray) {
        ArrayList<String> selectedApplication = new ArrayList<>();
        for (Object poValues : actualDevicesJsonArray) {
            if (((JSONObject) poValues).get("selected").equals(true))
                selectedApplication.add(((JSONObject) poValues).get("name").toString());
        }
        StringBuilder errorMessage = new StringBuilder();
        for (String poName : map.get("projectObjects").split(",")) {
            if (!selectedApplication.contains(poName.trim()))
                errorMessage.append("PO '").append(poName).append("' isn't selected").append("\n");
        }
//        if (errorMessage.length() != 0) BaseTestUtils.report(String.valueOf(errorMessage), Reporter.FAIL);
        return errorMessage;
    }

    private StringBuilder validateSelectPolicy(JSONArray devices, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        JSONArray policy = devices;
        Map<String, String> expected = new HashMap<>();

        String[] expectedPolicy = map.get("policy").replaceAll("\\{|\\}|\"", "").trim().split(",");
        for (String atr : expectedPolicy) {
            String[] keyValue = atr.split(":");
            expected.put(keyValue[0], keyValue[1]);
        }
        if (!((JSONObject) policy.get(0)).get("deviceName").equals(expected.get("deviceName")))
//            BaseTestUtils.report("ERROR:Scope Selection Device Name Incorrect;Expected : " + expected.get("deviceName") + ",Actual: " + ((JSONObject) policy.get(0)).get("deviceName"), Reporter.FAIL);
        {
            errorMessage.append("ERROR:Scope Selection Device Name Incorrect;Expected : " + expected.get("deviceName") + ",Actual: " + ((JSONObject) policy.get(0)).get("deviceName")).append("\n");
            return errorMessage;
        }


        if (!((JSONObject) policy.get(0)).get("serverName").equals(expected.get("serverName")))
//            BaseTestUtils.report("ERROR:Scope Selection Server Name Incorrect;Expected : " + expected.get("serverName") + ",Actual: " + ((JSONObject) policy.get(0)).get("serverName"), Reporter.FAIL);
            errorMessage.append("ERROR:Scope Selection Server Name Incorrect;Expected : " + expected.get("serverName") + ",Actual: " + ((JSONObject) policy.get(0)).get("serverName")).append("\n");


        if (!((JSONObject) policy.get(0)).get("policyName").equals(expected.get("policyName")))
//            BaseTestUtils.report("ERROR:Scope Selection Policy Name Incorrect;Expected : " + expected.get("policyName") + ",Actual: " + ((JSONObject) policy.get(0)).get("policyName"), Reporter.FAIL);
            errorMessage.append("ERROR:Scope Selection Policy Name Incorrect;Expected : " + expected.get("policyName") + ",Actual: " + ((JSONObject) policy.get(0)).get("policyName")).append("\n");
        return errorMessage;
    }

    private StringBuilder validateSelectDevices(Map<String, String> map, JSONArray actualDevicesJsonArray) {
        StringBuilder errorMessage = new StringBuilder();
        String deviceIp;
        List<VRMHandler.DpDeviceFilter> expectedDevicesEntry = extractDevicesList(map);
        for (VRMHandler.DpDeviceFilter deviceEntry : expectedDevicesEntry) {
            try {
                int indexDevice;
//                deviceIp = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, deviceEntry.index).getDeviceIp();
                deviceIp="11111";
                indexDevice = arrayJsonContainsBasicKey("ip", deviceIp, actualDevicesJsonArray);
                if (indexDevice == -1) {
//                    BaseTestUtils.report("The device IP :" + deviceIp + " is not found", Reporter.FAIL);
                    errorMessage.append("The device IP :" + deviceIp + " is not found\n");
                    continue;
                }
                Map<Integer, String> portsMap = convertFromArrayToMap(deviceEntry.ports.split(","));
                JSONArray actualPorts = actualDevicesJsonArray.getJSONObject(indexDevice).getJSONArray("ports");
                for (int k = 0; k < actualPorts.length(); k++) {
                    if (portsMap.containsValue(actualPorts.getJSONObject(k).get("name"))) {
                        if (!actualPorts.getJSONObject(k).toMap().get("selected").equals(true)) {
//                            BaseTestUtils.report("The port " + actualPorts.getJSONObject(k) + " should be selected", Reporter.FAIL);
                            errorMessage.append("The port " + actualPorts.getJSONObject(k) + " should be selected\n");
                        }
                    } else {
                        if (!actualPorts.getJSONObject(k).toMap().get("selected").equals(false)) {
//                            BaseTestUtils.report("The port " + actualPorts.getJSONObject(k) + " shouldn't be selected", Reporter.FAIL);
                            errorMessage.append("The port " + actualPorts.getJSONObject(k) + " shouldn't be selected\n");
                        }
                    }
                }

                Map<Integer, String> policiesMap = convertFromArrayToMap(deviceEntry.policies.split(","));
                JSONArray actualPolicies = actualDevicesJsonArray.getJSONObject(indexDevice).getJSONArray("policies");
                for (int k = 0; k < actualPolicies.length(); k++) {
                    if (policiesMap.containsValue(actualPolicies.getJSONObject(k).get("name"))) {
                        if (!actualPolicies.getJSONObject(k).toMap().get("selected").equals(true)) {
//                            BaseTestUtils.report("The policy " + actualPolicies.getJSONObject(k) + " should be selected", Reporter.FAIL);
                            errorMessage.append("The policy " + actualPolicies.getJSONObject(k) + " should be selected\n");
                        }
                    } else {
                        if (!actualPolicies.getJSONObject(k).toMap().get("selected").equals(false)) {
//                            BaseTestUtils.report("The policy " + actualPolicies.getJSONObject(k) + " shouldn't be selected", Reporter.FAIL);
                            errorMessage.append("The policy " + actualPolicies.getJSONObject(k) + " shouldn't be selected\n");
                        }
                    }
                }

            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }
        return errorMessage;
    }

    private Map<Integer, String> convertFromArrayToMap(String[] portsArray) {
        Map<Integer, String> newMap = new HashMap<>();
        for (Integer i = 0; i < portsArray.length; i++) {
            newMap.put(i, portsArray[i]);
        }
        return newMap;
    }

    private int arrayJsonContainsBasicKey(String key, String expectedValue, JSONArray JsonArray) {
        for (int i = 0; i < JsonArray.length(); i++) {
            if (JsonArray.getJSONObject(i).toMap().get(key).equals(expectedValue)) {
                return i;
            }
        }
        return -1;
    }

    protected void createVRMBase(String reportName, Map<String, String> map) throws Exception {
        try {
            enterToCreatingReport(reportName, map.getOrDefault("reportType", null));
            selectDevices(map);
            BasicOperationsHandler.clickButton("Next", "");
            selectTimeDefinitions(map);
            BasicOperationsHandler.clickButton("Next", "");
            selectSchedule(map);
            BasicOperationsHandler.clickButton("Next", "");
            //TODO - restore delivery after R&D fix delivery wizard
            //            Delivery(map);
            //BasicOperationsHandler.clickButton("Next", "");
            Design(reportName, map);
            BasicOperationsHandler.clickButton("Submit", "");
        } finally {
            try {
                VisionDebugIdsManager.setLabel("Close");
                WebUIUtils.fluentWaitClick(new ComponentLocator(How.ID, VisionDebugIdsManager.getDataDebugId()).getBy(), 2, false);
                BasicOperationsHandler.clickButton("Close", "");
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }
    }

    protected void createVRMBaseNew(String reportName, Map<String, String> map) throws TargetWebElementNotFoundException {
        try {
            deleteVRMBase(reportName);
            BasicOperationsHandler.clickButton("Add New", "");
            BasicOperationsHandler.setTextField("Wizard Report Name", reportName);
            selectTemplate(map);
            DesignNew(map);
            BasicOperationsHandler.clickButton("Widget Apply");
            customizedOptions(map);
            expandViews(true);
            selectDevices(map);
            selectTimeDefinitionsNew(map);
            share(map);
            format(map);
            selectScheduleNew(map);

            //   ValidateExpand();

            BasicOperationsHandler.clickButton("Submit", "");
        } catch (Exception e) {
            BasicOperationsHandler.clickButton("Cancel");
            BaseTestUtils.report("cause " + e.getMessage(), Reporter.FAIL);
        }
    }


    private void Design(String reportName, Map<String, String> map) throws TargetWebElementNotFoundException {
//        BasicOperationsHandler.setTextField("Report Name", reportName);
        if (map.containsKey("Design")) {
            JSONObject designJsonObject = new JSONObject(map.get("Design"));
            if (designJsonObject.toMap().containsKey("Delete")) {
                deleteWidgets(designJsonObject.getJSONArray("Delete"));
            }
            if (designJsonObject.toMap().containsKey("Add")) {
                addWidgets(designJsonObject.getJSONArray("Add"));
            }
            if (designJsonObject.toMap().containsKey("Position")) {
                vrmHandler.dragAndDropVRMChart(designJsonObject.toMap().get("Position").toString(), designJsonObject.getInt("X"), designJsonObject.getInt("Y"));
            }
        }
    }

    private void addWidgets(JSONArray addWidgetsText) {
        List widgetsList;
        if (addWidgetsText.toList().contains("ALL")) {
            try {
                widgetsList = new ArrayList();
                widgetsList.add("Traffic Bandwidth");
                widgetsList.add("Connections Rate");
                widgetsList.add("Concurrent Connections");
                widgetsList.add("Top Attacks By Duration");
                widgetsList.add("Top Attacks");
                widgetsList.add("Top Attacks By Bandwidth");
                widgetsList.add("Top Attacks By Protocol");
                widgetsList.add("Critical Attacks By Mitigation Action");
                widgetsList.add("Attacks By Threat Category");
                widgetsList.add("Attacks By Mitigation Action");
                // widgetsList.add("Attacks By Source And Destination");
                widgetsList.add("Top Attack Destination");
                widgetsList.add("Top Attack Sources");
                widgetsList.add("Top Scanners");
                widgetsList.add("Top Probed IP Addresses");
                widgetsList.add("Attacks By Protection Policy");
                widgetsList.add("Attack Categories By Bandwidth");
                widgetsList.add("Top Forwarded Attack Sources");
                vrmHandler.uiVRMSelectWidgets(widgetsList);
            } catch (Exception e) {
            }
        } else {

            widgetsList = addWidgetsText.toList();
            vrmHandler.uiVRMSelectWidgets(widgetsList);
        }
    }

    private void deleteWidgets(JSONArray deletedWidgets) throws TargetWebElementNotFoundException {
        if (deletedWidgets.toList().contains("ALL")) {
            BasicOperationsHandler.clickButton("Widget Selection", "");
            BasicOperationsHandler.clickButton("Widget Selection.Clear Dashboard", "");
            BasicOperationsHandler.clickButton("Widget Selection.Remove All Confirm", "");
        } else {
            for (Object aDeletedWidgetsArray : deletedWidgets) {
                try {
                    BasicOperationsHandler.doOperation("hover", "Design.delete widget", aDeletedWidgetsArray.toString());
                } catch (Exception e) {
                }
                BasicOperationsHandler.clickButton("Design.delete widget", aDeletedWidgetsArray.toString());
            }
        }
    }

    private void enterToCreatingReport(String reportName, String reportType) throws TargetWebElementNotFoundException {
        EnterToCreatingView(reportName);
        if (reportType != null) {
            BasicOperationsHandler.clickButton(reportType, "");
        } else {
            BasicOperationsHandler.clickButton("DefensePro Analytics Dashboard", "");
        }

    }

    private void EnterToValidateOrEdit(String reportName) {
        try {
            BasicOperationsHandler.clickButton("Edit", reportName);
        } catch (Exception e) {
            BaseTestUtils.report("The " + reportName + " isn't found", Reporter.FAIL);
        }
    }

    private void validateGeneratedReportDesign(Map<String, String> map) {
        if (map.containsKey("Design")) {
            List<String> expectedDesignList = new ArrayList<>();
            try {
                expectedDesignList = ((List<String>) (new JSONObject(map.get("Design")).toMap().get("Widgets")));
            } catch (Exception e) {
            }
            for (String anExpectedDesignList : expectedDesignList) {
                String replacedReportName = anExpectedDesignList.trim().replaceAll(" ", "_");
                if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(replacedReportName).getBy()) == null) {
                    BaseTestUtils.report("The element " + replacedReportName + " doesn't exist", Reporter.FAIL);
                }
            }
        }
    }

    protected void validateGeneratedReportDelivery(Map<String, String> map) {
    }

    protected void validateGeneratedReportSchedule(Map<String, String> map) {
        if (map.containsKey("schedule")) {
            VisionDebugIdsManager.setLabel("schedule in view");
            ComponentLocator scheduleLocator = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
            WebElement webElement = WebUIUtils.fluentWaitDisplayedEnabled(scheduleLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
            String actualScheduleViewText = webElement.getText();
            String expectedScheduleViewText = new JSONObject(map.get("Schedule")).getString("Run Every");
            if (!actualScheduleViewText.equalsIgnoreCase(expectedScheduleViewText)) {
                BaseTestUtils.report("The actual schedule is " + actualScheduleViewText + " but the expected is " + expectedScheduleViewText, Reporter.FAIL);
            }
        }
    }

    protected void validateGeneratedReportTimeDefinitions(Map<String, String> map) {
        if (map.containsKey("Time Definitions.Date")) {
            VisionDebugIdsManager.setLabel("generationTime");
            ComponentLocator periodLocator = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
            WebElement webElement = WebUIUtils.fluentWaitDisplayedEnabled(periodLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
            if (webElement != null) {
                String actualPeriodReportText = webElement.getText();
                DateTimeFormatter actualFormat = DateTimeFormatter.ofPattern("MMMM dd yyyy HH:mm");
                DateTimeFormatter actualFormatWithOneD = DateTimeFormatter.ofPattern("MMMM d yyyy HH:mm");
                LocalDateTime actualDateFrom = LocalDateTime.now();
                LocalDateTime actualDateTo = LocalDateTime.now();
                try {
                    actualDateFrom = LocalDateTime.parse((actualPeriodReportText.split("for period ")[1].split("-")[0]).trim(), actualFormat);
                } catch (Exception e) {
                    actualDateFrom = LocalDateTime.parse((actualPeriodReportText.split("for period ")[1].split("-")[0]).trim(), actualFormatWithOneD);
                }
                try {
                    actualDateTo = LocalDateTime.parse((actualPeriodReportText.split("for period ")[1].split("-")[1]).trim(), actualFormat);
                } catch (Exception e) {
                    actualDateTo = LocalDateTime.parse((actualPeriodReportText.split("for period ")[1].split("-")[1]).trim(), actualFormatWithOneD);
                }

                if (!validateTime(actualDateFrom, actualDateTo, map.get("Time Definitions.Date"))) {
                    BaseTestUtils.report("The time definition doesn't equal to " + map.get("Time Definitions.Date") + " and the actual period is " + actualDateFrom + " - " + actualDateTo, Reporter.FAIL);
                }
            } else {
                BaseTestUtils.report("webElement was not found " + VisionDebugIdsManager.getDataDebugId(), Reporter.FAIL);
            }
        }
    }

    protected boolean validateTime(LocalDateTime actualDateFrom, LocalDateTime actualDateTo, String time_definitions) {
        JSONObject timeDefinitionJSON = new JSONObject(time_definitions);
        if (time_definitions.contains("Quick")) {
            time_definitions = timeDefinitionJSON.get("Quick").toString();
            switch (time_definitions) {
                case "15m":
                    if (actualDateFrom.until(actualDateTo, ChronoUnit.MINUTES) == 15) return true;
                    break;
                case "30m":
                    if (actualDateFrom.until(actualDateTo, ChronoUnit.MINUTES) == 30) return true;
                    break;
                case "1H":
                    if (actualDateFrom.until(actualDateTo, ChronoUnit.HOURS) == 1) return true;
                    break;
                case "1D":
                    if (actualDateFrom.until(actualDateTo, ChronoUnit.DAYS) == 1) return true;
                    break;
                case "1W":
                    if (actualDateFrom.until(actualDateTo, ChronoUnit.WEEKS) == 1) return true;
                    break;
                case "1M":
                    if (actualDateFrom.until(actualDateTo, ChronoUnit.MONTHS) == 1) return true;
                    break;
                case "3M":
                    if (actualDateFrom.until(actualDateTo, ChronoUnit.MONTHS) == 3) return true;
                    break;
                case "Today":
                    if (actualDateTo.getDayOfYear() == (LocalDateTime.now().atZone(ZoneId.of("Etc/UTC")).getDayOfYear()) && actualDateFrom.getHour() == 0 && actualDateFrom.getMinute() == 0) {
                        return true;
                    } else return false;
                case "Yesterday":
                    if (actualDateFrom.getDayOfYear() == (LocalDateTime.now().atZone(ZoneId.of("Etc/UTC")).getDayOfYear() - 1) && actualDateFrom.getHour() == 0 && actualDateFrom.getMinute() == 0
                            && actualDateTo.getDayOfYear() == actualDateFrom.getDayOfYear() && actualDateTo.getHour() == 23 && actualDateTo.getMinute() == 59) {
                        return true;
                    } else return false;
                case "This Week":
                    if (actualDateFrom.getDayOfWeek().getValue() == 7 && actualDateFrom.until(actualDateTo, ChronoUnit.DAYS) < Math.abs(7)
                            && actualDateFrom.getHour() == 0 && actualDateFrom.getMinute() == 0 && actualDateTo.until(LocalDateTime.now(ZoneId.of("GMT")), ChronoUnit.MINUTES) < 60) {
                        return true;
                    } else return false;
                case "This Month":
                    if (actualDateFrom.getMinute() == 0 && actualDateFrom.getHour() == 0 && actualDateFrom.getDayOfMonth() == 1
                            && actualDateFrom.until(actualDateTo, ChronoUnit.DAYS) < Math.abs(30) && actualDateTo.until(LocalDateTime.now(ZoneId.of("GMT")), ChronoUnit.MINUTES) < Math.abs(60))
                        return true;
                    else return false;
                case "Previous Month":
                    if (actualDateFrom.getMinute() == 0 && actualDateFrom.getHour() == 0 && actualDateFrom.getDayOfMonth() == 1 && actualDateFrom.until(actualDateFrom, ChronoUnit.DAYS) <= Math.abs(30)
                            && actualDateFrom.until(LocalDateTime.now(ZoneId.of("GMT")), ChronoUnit.DAYS) < Math.abs(60))
                        return true;
                    else return false;
                case "Quarter":
                    if (actualDateFrom.getMinute() == 0 && actualDateFrom.getHour() == 0 && actualDateFrom.getDayOfMonth() == 1
                            && actualDateTo.until(LocalDateTime.now(ZoneId.of("GMT")), ChronoUnit.MINUTES) < Math.abs(60)
                            && (((int) LocalDateTime.now().getMonth().getValue() / 4) * 4) == actualDateFrom.getMonth().getValue())
                        return true;
                    else return false;
            }
        }
        if (time_definitions.contains("Relative")) {
            switch (timeDefinitionJSON.getJSONArray("Relative").get(0).toString()) {
                case "Hours":
                    if (actualDateTo.until(LocalDateTime.now(ZoneId.of("GMT")), ChronoUnit.MINUTES) < Math.abs(60) && actualDateFrom.until(actualDateTo, ChronoUnit.HOURS) == Math.abs(Integer.valueOf(timeDefinitionJSON.getJSONArray("Relative").get(1).toString())))
                        return true;
                case "Days":
                    if (actualDateTo.until(LocalDateTime.now(ZoneId.of("GMT")), ChronoUnit.MINUTES) < Math.abs(60) && actualDateFrom.until(actualDateTo, ChronoUnit.DAYS) == Math.abs(Integer.valueOf(timeDefinitionJSON.getJSONArray("Relative").get(1).toString())))
                        return true;
                case "Weeks":
                    if (actualDateTo.until(LocalDateTime.now(ZoneId.of("GMT")), ChronoUnit.MINUTES) < Math.abs(60) && actualDateFrom.until(actualDateTo, ChronoUnit.WEEKS) == Math.abs(Integer.valueOf(timeDefinitionJSON.getJSONArray("Relative").get(1).toString())))
                        return true;
                case "Months":
                    if (actualDateTo.until(LocalDateTime.now(ZoneId.of("GMT")), ChronoUnit.MINUTES) < Math.abs(60) && actualDateFrom.until(actualDateTo, ChronoUnit.MONTHS) == Math.abs(Integer.valueOf(timeDefinitionJSON.getJSONArray("Relative").get(1).toString())))
                        return true;
            }
            return false;
        }
        if (time_definitions.contains("Quick"))
            return false;
        else return true;
    }

    protected void Delivery(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Delivery")) {
            super.Delivery(map);
            JSONObject deliveryJsonObject = new JSONObject(map.get("Delivery"));
            if (!deliveryJsonObject.isNull("Export")) {
                String ExportText = deliveryJsonObject.getString("Export");
                switch (ExportText) {
                    case "CSV":
                        ExportText = "csv";
                        break;
                    case "PDF":
                        ExportText = "pdf";
                        break;
                    case "HTML":
                        ExportText = "html";
                        break;
                }
                BasicOperationsHandler.clickButton("Report Format", ExportText);
            } else {
                BasicOperationsHandler.clickButton("Report Format", "html");
            }

        }
    }

    protected void share(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Share")) {
            super.share(map);
        }
    }


    public void validateMailReport(String subject, String content) throws Exception {
        String mail = "automation.vision1@radware.com";
        String password = "Qwerty1!";
        EmailHandler emailHandler = new EmailHandler(mail, password);

        emailHandler.verifyLastUnreadEmail(null, subject, content, null, 300);


    }

    protected void validateGeneratedReportDevices(Map<String, String> map) {
    }

    public void uiValidateInvalidMessageInDelivery() throws TargetWebElementNotFoundException {
        enterToCreatingReport("forValidationInvalidMessage", "DefensePro Analytics Dashboard");
        VisionDebugIdsManager.setLabel("Device Selection.All Devices Selection");
        WebUICheckbox checkbox = new WebUICheckbox(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
        checkbox.check();
        BasicOperationsHandler.clickButton("Next", "");
        BasicOperationsHandler.clickButton("Next", "");
        BasicOperationsHandler.clickButton("Next", "");
        ComponentLocator popupMessageLocator = ComponentLocatorFactory.getLocatorByClass("email-settings-message show");
        WebUIComponent webUIComponent = new WebUIComponent(popupMessageLocator);
        if (webUIComponent.getWebElement() == null) {
            BaseTestUtils.report("Should be message that says Email Reporting Configurations is incomplete, invalid or disable", Reporter.FAIL);
        }
        BasicOperationsHandler.clickButton("Close", "");
    }

    @Override
    protected void generateView(String viewName) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Generate Now", viewName);
        int count = 0;
        while (250 > count && WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByClass("vrm-forensics-list-item-loading").getBy()) != null) {
            sleep(1);
            count++;
        }
        BasicOperationsHandler.clickButton("Log Preview", viewName);
    }

    @Override
    protected List<String> getViewsList(int maxValue) throws TargetWebElementNotFoundException {
        List<String> snapshotsName = new ArrayList<>();
        snapshotsName.clear();
        for (int i = 0; i < maxValue + 1; i++) {
            generateView("validateMaxViews");
            WebElement iGenerationElement = WebUIUtils.fluentWaitMultipleDisplayed(ComponentLocatorFactory.getLocatorByDbgId("VRM_Reports_Log_preview_time_validateMaxViews").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).get(0);
            snapshotsName.add(i, iGenerationElement.getText());
        }
        snapshotsName = Lists.reverse(snapshotsName);
        return snapshotsName;
    }

    @Override
    protected List<WebElement> getSnapshotElements() {
        return WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByDbgId("VRM_Reports_Log_preview_time_validateMaxViews").getBy());
    }

    /**
     * @param rootServerCli     - root user object
     * @param documentFieldName - Field name
     * @param reportName        - file name
     * @param indexName         - Index
     * @param timeout           - timeout to wait for the document if 0 applied default timeout is used
     * @return JSON object, null if not found
     */
    private JSONObject waitForESDocument(RootServerCli rootServerCli, String documentFieldName, String reportName, String indexName, long timeout) {
        if (timeout == 0)
            timeout = WebUIUtils.DEFAULT_WAIT_TIME;
        JSONObject foundObject;
        long startTime = System.currentTimeMillis();
        do {
            try {
                //kvision
//                foundObject = ElasticSearchHandler.getDocument(rootServerCli, documentFieldName, reportName, indexName);
//                return foundObject;
            } catch (JSONException e) {
            }
        }
        while (System.currentTimeMillis() - startTime < timeout);
        return null;
    }

    public void uiValidateTogglesDataInReportWithWidget(String reportName, String widget, List<VRMHandler.ToggleData> entries) {
        String errorMessage = "";
        //kvision
//        JSONObject basicRestResult = waitForESDocument(rootServerCli, "reportName", reportName, "vrm-scheduled-report-definition-vrm", 0);
//        String ObjectString = basicRestResult.get("content").toString().replace("\\", "");
//        JSONObject restResult = new JSONObject(ObjectString);
//        List deliveryList = ((JSONArray) (restResult).get("currentGridsterContent")).toList();
//
//        String udid = "";
//        for (Object a : (ArrayList) deliveryList) {
//            if (((HashMap) a).get("title").toString().equalsIgnoreCase(widget))
//                udid = ((HashMap) a).get("uuid").toString();
//        }
//        for (VRMHandler.ToggleData entry : entries) {
//            boolean textExist = false;
//            for (Object b : ((JSONArray) ((JSONObject) restResult.get("togglesData")).get(udid))) {
//                if (((JSONObject) b).get("text").toString().equalsIgnoreCase(entry.text)) {
//                    textExist = true;
//                    if (!((JSONObject) b).get("value").toString().equalsIgnoreCase(entry.value))
//                        errorMessage = ("The Expected value of " + widget + " in report " + reportName + " in option " + entry.text + " is " + entry.value + " but the actual is " + ((JSONObject) b).get("value").toString() + "/n");
//                    if (!((JSONObject) b).get("selected").toString().equalsIgnoreCase(entry.selected.toString()))
//                        errorMessage = ("The Expected value of " + widget + " in report " + reportName + " in option " + entry.selected + " is " + entry.selected + " but the actual is " + ((JSONObject) b).get("selected").toString() + "/n");
//                    break;
//                }
//            }
//            if (!textExist)
//                errorMessage = ("The option of " + entry.text + " in widget " + widget + " in report " + reportName + "doesn't found " + "/n");
//        }
        if (!errorMessage.equals(""))
            BaseTestUtils.report(errorMessage, Reporter.FAIL);

    }

}
