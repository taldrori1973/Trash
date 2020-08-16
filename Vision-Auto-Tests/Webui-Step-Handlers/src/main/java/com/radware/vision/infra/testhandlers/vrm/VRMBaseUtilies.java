package com.radware.vision.infra.testhandlers.vrm;

import com.radware.automation.react.widgets.impl.ReactDateControl;
import com.radware.automation.react.widgets.impl.ReactSelectControl;
import com.radware.automation.react.widgets.impl.enums.OnOffStatus;
import com.radware.automation.react.widgets.impl.enums.WebElementType;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.UIUtils;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.draganddrop.WebUIDragAndDrop;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.exceptions.web.DropdownItemNotFoundException;
import com.radware.vision.automation.tools.exceptions.web.DropdownNotOpenedException;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.vision_project_cli.RootServerCli;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.infra.testhandlers.vrm.enums.vrmActions;
import com.radware.vision.infra.utils.ReportsUtils;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.infra.utils.json.CustomizedJsonManager;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.radware.vision.infra.testhandlers.BaseHandler.devicesManager;
import static com.radware.vision.infra.testhandlers.BaseHandler.restTestBase;
import static com.radware.vision.infra.utils.ReportsUtils.addErrorMessage;
import static com.radware.vision.infra.utils.ReportsUtils.reportErrors;

public class VRMBaseUtilies {

    VRMHandler vrmHandler = new VRMHandler();
    public static LocalDateTime scheduleLocalDateTime = LocalDateTime.now();
    public static LocalDateTime timeDefinitionLocalDateTime;
    public static String oldOrNew = "new"; // "old"/"new"


    public void BaseVRMOperation(vrmActions operationType, String vrmBaseName, Map<String, String> entry, RootServerCli rootServerCli) throws Exception {
        Map<String, String> map = null;
        if (operationType != vrmActions.GENERATE)
            map = CustomizedJsonManager.fixJson(entry);

        switch (operationType.name().toUpperCase()) {
            case "CREATE":
                switch (oldOrNew) {
                    case "old":
                        createVRMBase(vrmBaseName, map);
                        break;
                    case "new":
                        createVRMBaseNew(vrmBaseName, map);
                        break;
                }
                break;
            case "VALIDATE":
                validateVRMBase(rootServerCli, vrmBaseName, map);
                break;
            case "EDIT":
                switch (oldOrNew) {
                    case "old":
                        editVRMBase(vrmBaseName, map);
                        break;
                    case "new":
                        editVRMBaseNew(vrmBaseName, map);
                        break;
                }
                break;
            case "GENERATE":
                generateVRMBase(vrmBaseName, entry);
                break;
            case "ISEXIST":
                isExistVRMBase(vrmBaseName, map);
                break;
        }
    }

    protected void editVRMBase(String vrmBaseName, Map<String, String> map) throws Exception {
    }

    protected void editVRMBaseNew(String vrmBaseName, Map<String, String> map) throws Exception {
    }

    protected void validateVRMBase(RootServerCli rootServerCli, String vrmBaseName, Map<String, String> map) throws TargetWebElementNotFoundException {
    }

    protected void createVRMBase(String vrmBaseName, Map<String, String> map) throws Exception {
    }

    protected void createVRMBaseNew(String vrmBaseName, Map<String, String> map) throws TargetWebElementNotFoundException {
    }

    protected void generateVRMBase(String vrmBaseName, Map<String, String> map) throws TargetWebElementNotFoundException {
    }

    protected boolean isExistVRMBaseResult(String vrmBaseName, Map<String, String> map) {
        return false;
    }

    protected void isExistVRMBase(String vrmBaseName, Map<String, String> map) {
    }


    protected void selectDevices(Map<String, String> map) throws Exception {
//        if ((map.get("reportType") != null && map.get("reportType").equalsIgnoreCase("HTTPS Flood")) && (map.get("devices") != null || map.get("policy") == null))
//            BaseTestUtils.report("HTTPS Flood Scope Selection is by Policy , Can't Select Devices", Reporter.FAIL);
//        if (map.get("policy") != null) {
//            selectPolicy(map.get("policy"));
//            return;
//        }
        if ((map.get("reportType") != null)) {
            switch ((map.get("reportType").toLowerCase())) {
                case "https flood":
                    if (map.get("policy") != null)
                        selectPolicy(map.get("policy"));
                    return;
                case "appwall dashboard":
                case "defenseflow analytics dashboard": {
                    List<VRMHandler.DpApplicationFilter> devicesEntries = new ArrayList<>();
                    if (map.get("projectObjects") != null || map.get("webApplications") != null) {
                        String type = map.get("projectObjects") != null ? "projectObjects" : map.get("webApplications") != null ? "webApplications" : "";
                        String[] devices = !map.get(type).matches("(All|all|)") ? map.get(type).split(",") : new String[0];
                        for (String appName : devices) {
                            devicesEntries.add(new VRMHandler.DpApplicationFilter(appName));
                        }
                        if (devices.length == 0)
                            devicesEntries.add(new VRMHandler.DpApplicationFilter("All"));
                    } else {
                        devicesEntries.add(new VRMHandler.DpApplicationFilter("All"));
                    }
                    vrmHandler.selectApplications(devicesEntries, map.get("reportType").toLowerCase().startsWith("defenseflow") ? "defenseflow" : "appwall", false);
                    return;
                }
                case "defensepro behavioral protections dashboard":
                case "defensepro analytics dashboard":
                default:
                    selectDefenseProDevices(map);
                    return;
            }
        }
        selectDefenseProDevices(map);
    }

    private void selectDefenseProDevices(Map<String, String> map) {
        List<VRMHandler.DpDeviceFilter> devicesEntries = new ArrayList<>();
        if (map.containsKey("devices")) {
            devicesEntries = extractDevicesList(map);
        }
        vrmHandler.innerSelectDeviceWithPoliciesAndPorts(null, SUTDeviceType.DefensePro, devicesEntries);
    }

    private static void selectPolicy(String policy) {
        String serverLabel = "Server Selection";
        String serverNameLabel = "Server Selection.Server Name";
        String loadMoreButton = "Server Selection.Load More";
        String filter = "Server Selection.Search";


        Pattern pattern = Pattern.compile("\\{\"serverName\":\"(.*)\",\"deviceName\":\"(.*)\",\"policyName\":\"(.*)\"\\}");
        Matcher matcher = pattern.matcher(policy);
        if (!matcher.matches())
            BaseTestUtils.report("The Policy Should be with the following pattern:\n" +
                    "serverName:{Server Name},deviceName:{Device Name},policyName:{Policy Name}", Reporter.FAIL);


        class Policy {
            String serverName;
            String deviceName;
            String policyName;
        }


        Policy policyToSelect = new Policy();
        policyToSelect.serverName = matcher.group(1);
        policyToSelect.deviceName = matcher.group(2);
        policyToSelect.policyName = matcher.group(3);

        String extension = policyToSelect.serverName + "," + policyToSelect.deviceName + "," + policyToSelect.policyName;
        try {
            BasicOperationsHandler.setTextField(filter, null, policyToSelect.serverName, false);


            while (BasicOperationsHandler.isItemAvailableById(loadMoreButton, null) != null)
                BasicOperationsHandler.clickButton(loadMoreButton, null);


            if (BasicOperationsHandler.isItemAvailableById(serverLabel, extension) == null)
                BaseTestUtils.report("Can't Find the Policy :\n" +
                        "serverName:" + policyToSelect.serverName + ",deviceName:" + policyToSelect.deviceName + ",policyName:" + policyToSelect.policyName, Reporter.FAIL);


            BasicOperationsHandler.clickButton(serverNameLabel, policyToSelect.serverName, policyToSelect.deviceName, policyToSelect.policyName);

        } catch (TargetWebElementNotFoundException e) {
            e.printStackTrace();
        }


    }

    public List<VRMHandler.DpDeviceFilter> extractDevicesList(Map<String, String> map) {

        JSONArray devicesJsonArray = new JSONArray();
        try {
            devicesJsonArray = new JSONArray(map.get("devices"));
        } catch (Exception e) {
            JSONObject deviceJsonObject;
            if (!map.get("devices").equals("")) {
                deviceJsonObject = new JSONObject(map.get("devices"));
                devicesJsonArray.put(deviceJsonObject);
            }
        }
        List<VRMHandler.DpDeviceFilter> devicesEntries = new ArrayList<VRMHandler.DpDeviceFilter>();
        for (int i = 0; i < devicesJsonArray.length(); i++) {
            VRMHandler.DpDeviceFilter deviceEntry = new VRMHandler.DpDeviceFilter();
            deviceEntry.index = ((JSONObject) devicesJsonArray.get(i)).getInt("index");
            deviceEntry.ports = ((JSONObject) devicesJsonArray.get(i)).toMap().getOrDefault("ports", "").toString().replaceAll("(])|(\\[)", "");
            deviceEntry.policies = ((JSONObject) devicesJsonArray.get(i)).toMap().getOrDefault("policies", "").toString().replaceAll("(])|(\\[)", "");
            devicesEntries.add(deviceEntry);
        }
        return devicesEntries;
    }

    protected void selectProductNew(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Product")) {
            String productSelection = map.get("Product");
            if (productSelection.equals("Appwall") || productSelection.equals("DefenseFlow") || productSelection.equals("DefensePro")) {
                BasicOperationsHandler.clickButton(productSelection);
            } else {
                BaseTestUtils.report("The Product definition should be Appwall, or DefenseFlow or DefensePro: " + productSelection, Reporter.FAIL);
            }
        }
    }

    protected void selectTimeDefinitions(Map<String, String> map) throws TargetWebElementNotFoundException, DropdownItemNotFoundException, DropdownNotOpenedException {
        if (map.containsKey("Time Definitions.Date")) {
            JSONObject timeDefinitionJSONObject = new JSONObject(map.get("Time Definitions.Date"));
            ReactSelectControl reactSelectControl = new ReactSelectControl(new ComponentLocator(How.ID, "Time Definition Type"));
            List<String> timeType = new ArrayList<>();
            if (timeDefinitionJSONObject.toMap().containsKey("Quick")) {
                timeType.add("Quick Range");
                reactSelectControl.selectOptions(timeType, false, false);
                BasicOperationsHandler.clickButton("TimeFrame", timeDefinitionJSONObject.getString("Quick"));
            } else if (timeDefinitionJSONObject.toMap().containsKey("Absolute")) {
                timeType.add("Absolute");
                reactSelectControl.selectOptions(timeType, false, false);
                JSONArray absoluteJArray = new JSONArray();
                try {
                    absoluteJArray = timeDefinitionJSONObject.getJSONArray("Absolute");
                } catch (Exception e) {
                    absoluteJArray.put(timeDefinitionJSONObject.get("Absolute"));
                }
                selectAbsoluteTime(absoluteJArray);
            } else {
                if (timeDefinitionJSONObject.toMap().containsKey("Relative")) {
                    timeType.add("Relative");
                    reactSelectControl.selectOptions(timeType, false, false);
                    ClickRelativeDate(timeDefinitionJSONObject.getJSONArray("Relative"));
                } else {
                    BaseTestUtils.report("The time definition should be or Quick or Absolute or Relative not " + timeDefinitionJSONObject.toString(), Reporter.FAIL);
                }
            }

        }
    }

    protected void selectTimeDefinitionsNew(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Time Definitions.Date")) {
            JSONObject timeDefinitionJSONObject = new JSONObject(map.get("Time Definitions.Date"));

            if (!timeDefinitionJSONObject.isNull("Quick")) { // timeDefinitionJSONObject.toMap().containsKey("Quick")

                BasicOperationsHandler.clickButton("Quick Range");
                BasicOperationsHandler.clickButton("TimeFrame", timeDefinitionJSONObject.getString("Quick"));

            } else if (!timeDefinitionJSONObject.isNull("Absolute")) {//timeDefinitionJSONObject.toMap().containsKey("Absolute"
//
                BasicOperationsHandler.clickButton("Absolute");
                JSONArray absoluteJArray = new JSONArray();
                try {
                    absoluteJArray = timeDefinitionJSONObject.getJSONArray("Absolute");
                } catch (Exception e) {
                    absoluteJArray.put(timeDefinitionJSONObject.get("Absolute"));
                }
                selectAbsoluteTimeNew(absoluteJArray);
            } else {
                if (!timeDefinitionJSONObject.isNull("Relative")) {//timeDefinitionJSONObject.toMap().containsKey("Relative")

                    BasicOperationsHandler.clickButton("Relative");
                    ClickRelativeDateNew(timeDefinitionJSONObject.getJSONArray("Relative"));
                } else {
                    BaseTestUtils.report("The time definition should be or Quick or Absolute or Relative not " + timeDefinitionJSONObject.toString(), Reporter.FAIL);
                }
            }

        }
    }

    private void selectAbsoluteTime(JSONArray absoluteJArray) {
        DateTimeFormatter absoluteFormat = DateTimeFormatter.ofPattern("dd.MM.YYYY HH:mm:ss");
        if (absoluteJArray.length() == 1) {
            timeDefinitionLocalDateTime = TimeUtils.getAddedDate(absoluteJArray.get(0).toString().trim());
            try {
                setDateString("Time Frame From", absoluteFormat.format(TimeUtils.getAddedDate(absoluteJArray.get(0).toString().trim())));
            } catch (Exception e) {
            }
        } else {
            String fromDate = absoluteJArray.get(0).toString();
            try {
                setDateString("Time Frame From", fromDate);
            } catch (Exception e) {
            }

            try {
                setDateString("Time Frame To", absoluteFormat.format(TimeUtils.getAddedDate(absoluteJArray.get(1).toString().trim())));
            } catch (Exception e) {
            }
        }
    }

    private void selectAbsoluteTimeNew(JSONArray absoluteJArray) {
        DateTimeFormatter absoluteFormat = DateTimeFormatter.ofPattern("dd.MM.YYYY HH:mm:ss");
        if (absoluteJArray.length() == 1) {
            timeDefinitionLocalDateTime = TimeUtils.getAddedDate(absoluteJArray.get(0).toString().trim());
            try {
                BasicOperationsHandler.setTextField("Time Frame From", absoluteFormat.format(TimeUtils.getAddedDate(absoluteJArray.get(0).toString().trim())));
            } catch (Exception e) {
            }
        } else {
            String fromDate = absoluteJArray.get(0).toString();
            try {

                if (fromDate.equals("Today")) {
                    Calendar c = new GregorianCalendar();
                    LocalDateTime localDateTime = LocalDateTime.from(Instant.ofEpochMilli(c.getTime().getTime()).atZone(ZoneId.systemDefault()));
                    BasicOperationsHandler.setTextField("Time Frame From", absoluteFormat.format(localDateTime));
                } else {
                    BasicOperationsHandler.setTextField("Time Frame From", fromDate);
                }

            } catch (Exception e) {
            }

            try {

                BasicOperationsHandler.setTextField("Time Frame To", absoluteFormat.format(TimeUtils.getAddedDate(absoluteJArray.get(1).toString().trim())));
                timeDefinitionLocalDateTime = TimeUtils.getAddedDate(absoluteJArray.get(1).toString().trim());
            } catch (Exception e) {
            }
        }
    }

    private void ClickRelativeDate(JSONArray timeDefinitions) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.newSelectItemFromDropDown("From Time Selection", timeDefinitions.get(0).toString());
        BasicOperationsHandler.setTextField("From Text", timeDefinitions.get(1).toString());
    }

    private void ClickRelativeDateNew(JSONArray timeDefinitions) throws TargetWebElementNotFoundException {
//        BasicOperationsHandler.newSelectItemFromDropDown("From Time Selection", timeDefinitions.get(0).toString());
        BasicOperationsHandler.clickButton("Time Relative Period", timeDefinitions.get(0).toString());
        BasicOperationsHandler.setTextField("Time Relative Period Input", timeDefinitions.get(0).toString(), timeDefinitions.get(1).toString(), false);
    }

    private void setDateString(String dateSelector, String date) {
        VisionDebugIdsManager.setLabel(dateSelector);
        ReactDateControl reactDateControl = new ReactDateControl(VisionDebugIdsManager.getDataDebugId());
        reactDateControl.type(date, false);
    }


    protected void selectSchedule(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Schedule")) {
            JSONObject scheduleJson = new JSONObject(map.getOrDefault("Schedule", null));
            VisionDebugIdsManager.setLabel("Schedule Switch Button");
            WebUIComponent webUIComponent = new WebUIComponent(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
            if (webUIComponent.getAttribute("class").toUpperCase().contains("OFF")) {
                BasicOperationsHandler.clickButton("Schedule Switch Button", "");
            }

            String runEvery = scheduleJson.getString("Run Every");
            BasicOperationsHandler.newSelectItemFromDropDown("Scheduling Run Every", runEvery);

            String onTime = "??";
            try {
                onTime = scheduleJson.toMap().get("On Time").toString();
            } catch (Exception e) {
            }
            if (onTime.contains("+") || onTime.contains("-")) {
                scheduleLocalDateTime = TimeUtils.getAddedDate(scheduleJson.toMap().get("On Time").toString().trim());
                DateTimeFormatter onTimeFormat = DateTimeFormatter.ofPattern("HH:mm");
                String onTimeText = onTimeFormat.format(scheduleLocalDateTime);

                BasicOperationsHandler.setTextField("Scheduling At Time", onTimeText);
                if (runEvery.contains("Once")) {
                    DateTimeFormatter onDayFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    String onDay = onDayFormat.format(scheduleLocalDateTime);
                    setDateString("Scheduling On Day", onDay);
                }
                if (runEvery.contains("Weekly")) {
                    String weekDay = "SUN";
                    switch ((scheduleLocalDateTime.getDayOfWeek().getValue() % 7) + 1) {
                        case 1:
                            weekDay = "SUN";
                            break;
                        case 2:
                            weekDay = "MON";
                            break;
                        case 3:
                            weekDay = "TUE";
                            break;
                        case 4:
                            weekDay = "WED";
                            break;
                        case 5:
                            weekDay = "THU";
                            break;
                        case 6:
                            weekDay = "FRI";
                            break;
                        case 7:
                            weekDay = "SAT";
                            break;
                    }

                    BasicOperationsHandler.clickButton("Scheduling Week Day", weekDay);
                }
                if (runEvery.contains("Monthly")) {
                    String month = "JAN";
                    switch (scheduleLocalDateTime.getMonth().getValue()) {
                        case 1:
                            month = "JAN";
                            break;
                        case 2:
                            month = "FEB";
                            break;
                        case 3:
                            month = "MAR";
                            break;
                        case 4:
                            month = "APR";
                            break;
                        case 5:
                            month = "MAY";
                            break;
                        case 6:
                            month = "JUN";
                            break;
                        case 7:
                            month = "JUL";
                            break;
                        case 8:
                            month = "AUG";
                            break;
                        case 9:
                            month = "SEP";
                            break;
                        case 10:
                            month = "OCT";
                            break;
                        case 11:
                            month = "NOV";
                            break;
                        case 12:
                            month = "DEC";
                            break;
                    }
                    BasicOperationsHandler.clickButton("Scheduling At Month", month);
                    BasicOperationsHandler.setTextField("Scheduling On Day of Month", String.valueOf(scheduleLocalDateTime.getDayOfMonth()));
                }

            } else {
                if (runEvery.contains("Monthly")) {
                    JSONArray monthArray = scheduleJson.getJSONArray("At Months");
                    for (Object aMonthsArray : monthArray) {
                        VisionDebugIdsManager.setLabel("Scheduling At Month");
                        VisionDebugIdsManager.setParams(aMonthsArray.toString());
                        WebUIComponent webUIComponentAtMomth = new WebUIComponent(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
                        if (!webUIComponentAtMomth.getAttribute("class").toUpperCase().contains("SELECTED")) {
                            BasicOperationsHandler.clickButton("Scheduling At Month", aMonthsArray.toString());
                        }
                    }
                    String dayOfMonth = scheduleJson.getString("ON Day of Month");
                    BasicOperationsHandler.clickButton("Scheduling On Day of Month");
                    BasicOperationsHandler.setTextField("Scheduling On Day of Month", dayOfMonth);
                } else {
                    if (runEvery.contains("Weekly")) {
                        if (scheduleJson.toMap().containsKey("At Week Day")) {
                            JSONArray weekJsonArray = scheduleJson.getJSONArray("At Week Day");
                            for (Object aWeekArray : weekJsonArray) {
                                VisionDebugIdsManager.setLabel("Scheduling Week Day");
                                VisionDebugIdsManager.setParams(aWeekArray.toString());
                                WebUIComponent webUIComponentAtMomth = new WebUIComponent(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
                                if (!webUIComponentAtMomth.getAttribute("class").toUpperCase().contains("SELECTED")) {
                                    BasicOperationsHandler.clickButton("Scheduling Week Day", aWeekArray.toString());
                                }
                            }
                        }
                    }
                    if (runEvery.contains("Once")) {
                        if (scheduleJson.toMap().containsKey("On Day"))
                            setDateString("Scheduling On Day", scheduleJson.getString("On Day").trim());
                    }
                }
                String realOnTime = "10:00";
                try {
                    realOnTime = scheduleJson.getString("On Time");
                } catch (Exception e) {
                }
                BasicOperationsHandler.setTextField("Scheduling At Time", realOnTime);
            }
        }
    }


    protected void selectScheduleNew(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Schedule")) {
            JSONObject scheduleJson = new JSONObject(map.getOrDefault("Schedule", null));
            VisionDebugIdsManager.setLabel("Schedule Switch Button");
            WebUIComponent webUIComponent = new WebUIComponent(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
            if (webUIComponent.getAttribute("class").toUpperCase().contains("OFF")) {
                BasicOperationsHandler.clickButton("Schedule Switch Button", "");
            }

            String runEvery = scheduleJson.getString("Run Every");
//            BasicOperationsHandler.newSelectItemFromDropDown("Scheduling Run Every", runEvery);
            BasicOperationsHandler.clickButton("Schedule Run Every", runEvery);
            String onTime = "??";
            try {
                onTime = scheduleJson.toMap().get("On Time").toString();
            } catch (Exception e) {
            }
            if (onTime.contains("+") || onTime.contains("-")) {
                scheduleLocalDateTime = TimeUtils.getAddedDate(scheduleJson.toMap().get("On Time").toString().trim());
                DateTimeFormatter onTimeFormat = DateTimeFormatter.ofPattern("hh:mm a");
                String onTimeText = onTimeFormat.format(scheduleLocalDateTime);

                BasicOperationsHandler.setTextField("Scheduling At Time", onTimeText);
                if (runEvery.contains("Once")) {
                    DateTimeFormatter onDayFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    String onDay = onDayFormat.format(scheduleLocalDateTime);
//                    setDateString("Scheduling On Day", onDay);
                    BasicOperationsHandler.setTextField("Scheduling On Day", onDay);
                }
                if (runEvery.contains("Weekly")) {
                    String weekDay = "SUN";
                    switch ((scheduleLocalDateTime.getDayOfWeek().getValue() % 7) + 1) {
                        case 1:
                            weekDay = "SUN";
                            break;
                        case 2:
                            weekDay = "MON";
                            break;
                        case 3:
                            weekDay = "TUE";
                            break;
                        case 4:
                            weekDay = "WED";
                            break;
                        case 5:
                            weekDay = "THU";
                            break;
                        case 6:
                            weekDay = "FRI";
                            break;
                        case 7:
                            weekDay = "SAT";
                            break;
                    }

                    BasicOperationsHandler.clickButton("Scheduling Week Day", weekDay);
                }
                if (runEvery.contains("Monthly")) {
                    String month = "JAN";
                    switch (scheduleLocalDateTime.getMonth().getValue()) {
                        case 1:
                            month = "JAN";
                            break;
                        case 2:
                            month = "FEB";
                            break;
                        case 3:
                            month = "MAR";
                            break;
                        case 4:
                            month = "APR";
                            break;
                        case 5:
                            month = "MAY";
                            break;
                        case 6:
                            month = "JUN";
                            break;
                        case 7:
                            month = "JUL";
                            break;
                        case 8:
                            month = "AUG";
                            break;
                        case 9:
                            month = "SEP";
                            break;
                        case 10:
                            month = "OCT";
                            break;
                        case 11:
                            month = "NOV";
                            break;
                        case 12:
                            month = "DEC";
                            break;
                    }
                    BasicOperationsHandler.clickButton("Scheduling At Month", month);
                    BasicOperationsHandler.setTextField("Scheduling On Day of Month", String.valueOf(scheduleLocalDateTime.getDayOfMonth()));
                }

            } else {
                if (runEvery.contains("Monthly")) {
                    JSONArray monthArray = scheduleJson.getJSONArray("At Months");
                    for (Object aMonthsArray : monthArray) {
                        VisionDebugIdsManager.setLabel("Scheduling At Month");
                        VisionDebugIdsManager.setParams(aMonthsArray.toString());
                        WebUIComponent webUIComponentAtMomth = new WebUIComponent(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
                        if (!webUIComponentAtMomth.getAttribute("class").toUpperCase().contains("SELECTED")) {
                            BasicOperationsHandler.clickButton("Scheduling At Month", aMonthsArray.toString());
                        }
                    }
                    String dayOfMonth = scheduleJson.getString("ON Day of Month");
                    BasicOperationsHandler.clickButton("Scheduling On Day of Month");
                    BasicOperationsHandler.setTextField("Scheduling On Day of Month", dayOfMonth);
                } else {
                    if (runEvery.contains("Weekly")) {
                        if (scheduleJson.toMap().containsKey("At Week Day")) {
                            JSONArray weekJsonArray = scheduleJson.getJSONArray("At Week Day");
                            for (Object aWeekArray : weekJsonArray) {
                                VisionDebugIdsManager.setLabel("Scheduling Week Day");
                                VisionDebugIdsManager.setParams(aWeekArray.toString());
                                WebUIComponent webUIComponentAtMomth = new WebUIComponent(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
                                if (!webUIComponentAtMomth.getAttribute("class").toUpperCase().contains("SELECTED")) {
                                    BasicOperationsHandler.clickButton("Scheduling Week Day", aWeekArray.toString());
                                }
                            }
                        }
                    }
                    if (runEvery.contains("Once")) {
                        if (scheduleJson.toMap().containsKey("On Day"))
//                            setDateString("Scheduling On Day", scheduleJson.getString("On Day").trim());
                            BasicOperationsHandler.setTextField("Scheduling On Day", scheduleJson.getString("On Day").trim());
                    }
                }
                String realOnTime = "10:00 AM";
                try {
                    realOnTime = scheduleJson.getString("On Time");
                } catch (Exception e) {
                }
                BasicOperationsHandler.setTextField("Scheduling At Time", realOnTime);
            }
        }
    }

    protected void Delivery(Map<String, String> map) throws TargetWebElementNotFoundException {

        if (map.containsKey("Delivery")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Delivery"));
            String Emails;
            if (!deliveryJsonObject.isNull("Email")) {
                Emails = deliveryJsonObject.getJSONArray("Email").toString().replaceAll("(])|(\\[)|(\")", "");

                VisionDebugIdsManager.setLabel("Send Email Enable");
                String debugId = VisionDebugIdsManager.getDataDebugId();
                BasicOperationsHandler.clickSwitchButton(WebElementType.Data_Debug_Id, debugId, OnOffStatus.ON);

                BasicOperationsHandler.setTextField("Email Recipients", Emails);
                BasicOperationsHandler.setTextField("Send Email Subject", deliveryJsonObject.getString("Subject"));
                if (!deliveryJsonObject.isNull("Body")) {
                    BasicOperationsHandler.setTextField("Send Email Body", deliveryJsonObject.getString("Body"));
                }
            }
            if (!deliveryJsonObject.isNull("FTP")) {
                VisionDebugIdsManager.setLabel("Send.FTP Enable");
                WebUICheckbox ftpCheckbox = new WebUICheckbox(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
                ftpCheckbox.check();
                if (!deliveryJsonObject.isNull("FTP.Location"))
                    BasicOperationsHandler.setTextField("Send.FTP Location", deliveryJsonObject.getString("FTP.Location"));
                if (!deliveryJsonObject.isNull("FTP.Path"))
                    BasicOperationsHandler.setTextField("Send.FTP Path", deliveryJsonObject.getString("FTP.Path"));
                if (!deliveryJsonObject.isNull("FTP.Username"))
                    BasicOperationsHandler.setTextField("Send.FTP Username", deliveryJsonObject.getString("FTP.Username"));
                if (!deliveryJsonObject.isNull("FTP.Password"))
                    BasicOperationsHandler.setTextField("Send.FTP Password", deliveryJsonObject.getString("FTP.Password"));
            }
        }

    }

    protected void share(Map<String, String> map) throws TargetWebElementNotFoundException {

        if (map.containsKey("Share")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Share"));
            String Emails;
            if (!deliveryJsonObject.isNull("Email")) {
                Emails = deliveryJsonObject.getJSONArray("Email").toString().replaceAll("(])|(\\[)|(\")", "");

                VisionDebugIdsManager.setLabel("Send Email Enable");
                String debugId = VisionDebugIdsManager.getDataDebugId();
                BasicOperationsHandler.clickSwitchButton(WebElementType.Data_Debug_Id, debugId, OnOffStatus.ON);

                BasicOperationsHandler.setTextField("Email Recipients", Emails);
                BasicOperationsHandler.setTextField("Send Email Subject", deliveryJsonObject.getString("Subject"));
                if (!deliveryJsonObject.isNull("Body")) {
                    BasicOperationsHandler.setTextField("Send Email Body", deliveryJsonObject.getString("Body"));
                }
            }

        }

    }

    protected void removeEmptyMails(String emails) {
        BasicOperationsHandler.delay(2);
        int emailsCount = emails.split(",").length;
        for (int i = 0; i < emailsCount + 1; i++) {
            try {
                VisionDebugIdsManager.setLabel("Delete Email");
                VisionDebugIdsManager.setParams(String.valueOf(i));
                ComponentLocator emailValue = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
                WebUIComponent emailValueElement = new WebUIComponent(emailValue);
                if (emailValueElement.getInnerText().equalsIgnoreCase("")) {
                    BasicOperationsHandler.clickButton("Delete Email", String.valueOf(i) + "_Delete");
                }
            } catch (Exception e) {
            }

        }

    }

    protected void EnterToCreatingView(String viewName) throws TargetWebElementNotFoundException {
        deleteVRMBase(viewName);
        BasicOperationsHandler.clickButton("Add", "");
    }

    public void deleteVRMBase(String viewName) throws TargetWebElementNotFoundException {
        VisionDebugIdsManager.setLabel("Delete");
        VisionDebugIdsManager.setParams(viewName);
        if ((new WebUIComponent(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()))).getWebElement(true, true, true) != null) {
            BasicOperationsHandler.clickButton("Delete", viewName);
            BasicOperationsHandler.clickButton("Delete.Approve", "");
        }

    }

    protected void editDevices(Map<String, String> map) throws Exception {

        if (map.containsKey("devices")) {
            selectDevices(map);
        }
    }

    protected void enterToEdit(String reportName) {
        try {
            BasicOperationsHandler.clickButton("Edit", reportName);
        } catch (Exception e) {
            BaseTestUtils.report("There is no report with name " + reportName, Reporter.FAIL);
        }
    }

    protected void editTimeDefinitions(Map<String, String> map) throws TargetWebElementNotFoundException, DropdownItemNotFoundException, DropdownNotOpenedException {
        if (map.containsKey("Time Definitions.Date")) {
            selectTimeDefinitions(map);
        }
    }

    protected void editTimeDefinitionsNew(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Time Definitions.Date")) {
            selectTimeDefinitionsNew(map);
        }
    }

    protected void editSchedule(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Schedule")) {
            try {
                BasicOperationsHandler.newSelectItemFromDropDown("Scheduling Run Every", "Daily");
                BasicOperationsHandler.clickButton("Scheduling At Time", "");
            } catch (Exception e) {
            }

            selectSchedule(map);
        }
    }

    protected void editScheduleNew(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Schedule")) {
            JSONObject scheduleJson = new JSONObject(map.getOrDefault("Schedule", null));
            switch (scheduleJson.getString("Run Every")) {
                case "Weekly":
                    if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId("scheduler_run_every_Weekly").getBy()).getAttribute("class").contains("selected")) {
                        List<WebElement> daysButton = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId("Vrm_Schedule_week_item_").getBy());
                        for (WebElement dayButton : daysButton) {
                            if (dayButton.getAttribute("class").contains("selected")) {
                                dayButton.click();
                            }
                        }
                    }
                    break;
                case "Monthly":
                    if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId("scheduler_run_every_Monthly").getBy()).getAttribute("class").contains("selected")) {
                        List<WebElement> daysButton = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId("Vrm_Schedule_month_item_").getBy());
                        for (WebElement dayButton : daysButton) {
                            if (dayButton.getAttribute("class").contains("selected")) {
                                dayButton.click();
                            }
                        }
                    }
                    break;
            }
            selectScheduleNew(map);
        }
    }

    protected void editDelivery(Map<String, String> map) throws TargetWebElementNotFoundException {

        if (map.containsKey("Delivery")) {

            BasicOperationsHandler.setTextField("Email Recipients", "");
            BasicOperationsHandler.setTextField("Send Email Subject", "");
//            VisionDebugIdsManager.setLabel("Email Recipients");
//            ClickOperationsHandler.setTextToElement(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getLocatorValue(), "", true, true);
//            VisionDebugIdsManager.setLabel("Send Email Subject");
//            ClickOperationsHandler.setTextToElement(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getLocatorValue(), "", true, true);
            Delivery(map);
        }

    }

    protected void editShare(Map<String, String> map) throws TargetWebElementNotFoundException {

        if (map.containsKey("Share")) {
            WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorById("email").getBy()).click();
            BasicOperationsHandler.setTextField("Email Recipients", "");
            BasicOperationsHandler.setTextField("Send Email Subject", "");
            BasicOperationsHandler.setTextField("Send Email Body", "");
            share(map);
        }
    }

    protected void editFormat(Map<String, String> map) throws TargetWebElementNotFoundException {

        if (map.containsKey("Format")) {
            format(map);
        }
    }


    public void uiValidateMaxGenerateView(int maxValue) throws Exception {
        validateMaxGenerateView(maxValue);
    }

    protected void validateMaxGenerateView(int maxValue) throws Exception {
        try {
            openDevicePort(null);
        } catch (Exception e) {
        }
        switch (oldOrNew) {
            case "old":
                createVRMBase("validateMaxViews", new HashMap<>());
            case "new":
                createVRMBaseNew("validateMaxViews", new HashMap<>());
        }
        BasicOperationsHandler.clickButton("Views.Expand", "validateMaxViews");
        List<String> snapshotsName = new ArrayList<>();
        snapshotsName = getViewsList(maxValue);
        List<WebElement> snapshots = getSnapshotElements();
        if (snapshots.size() != maxValue) {
            addErrorMessage("The Expected number of the snapshots is: " + maxValue + " but the Actual is: " + snapshots.size());
        }
        int i = 0;
        for (WebElement snapshotElement : snapshots) {
            if (snapshotElement.getText().equalsIgnoreCase(snapshotsName.get(maxValue)) && i < maxValue) {
                addErrorMessage("The snapshot " + snapshotsName.get(maxValue) + " shouldn't be exist BUT it exist");
            }
            i++;
        }


        ReportsUtils.reportErrors();
    }

    public void uivalidateMaxGenerateTemplateView(int maxValue) throws Exception {
        validateMaxGenerateTemplateView(maxValue);
    }


    protected void validateMaxGenerateTemplateView(int maxValue) throws Exception {

        int iCurrentIndex;

        // Format for leading zerros
        String srtFormat = String.format("%%0%dd", 2);
        String strReportName;

        // loop the create and verify the allowed maximum report template number
        for (iCurrentIndex = 1; iCurrentIndex <= maxValue; iCurrentIndex++) {
            // Set report name
            strReportName = String.format(srtFormat, iCurrentIndex) + "_report";

            // create a report
            createVRMBase(strReportName, new HashMap<>());

            // verify report was created by expanding the report
            if (!isExistVRMBaseResult(strReportName, new HashMap<>())) {
                addErrorMessage("report number " + iCurrentIndex + "didn't create, but the maximum allowed template reports  is - " + maxValue);
            }
        }

        // Set report name of the excided report template (max =1)
        strReportName = String.format(srtFormat, iCurrentIndex) + "_report";

        // create a report
        createVRMBase(strReportName, new HashMap<>());

        if (isExistVRMBaseResult(strReportName, new HashMap<>())) {
            // if didn't got exception the report tamplate (max + 1 exist) creating an error to the log
            addErrorMessage("report " + strReportName + "excided the maximum allowed template reports, The maximum allowed reports are: " + iCurrentIndex);
        }

        // insert the errors (if exist) to the log
        ReportsUtils.reportErrors();
    }

    protected List<WebElement> getSnapshotElements() {
        return null;
    }

    protected List<String> getViewsList(int maxValue) throws TargetWebElementNotFoundException {
        List<String> snapshotsName = new ArrayList<>();
        return snapshotsName;
    }

    protected void deleteAllViews() throws TargetWebElementNotFoundException {
        List<WebElement> deleteButtons = WebUIUtils.fluentWaitMultipleDisplayed(ComponentLocatorFactory.getLocatorByDbgId("vrm-forensics-delete-item-button_").getBy(), WebUIUtils.SHORT_WAIT_TIME, true);
        for (WebElement deleteButton : deleteButtons) {
            deleteButton.click();
            BasicOperationsHandler.clickButton("Delete.Approve", "");
        }
    }

    protected void generateView(String viewName) throws TargetWebElementNotFoundException {
    }

    public static void openDevicePort(String host) {
        RadwareServerCli radwareServerCli = restTestBase.getRadwareServerCli();
        RootServerCli rootServerCli = restTestBase.getRootServerCli();
        if (host == null) {
            host = restTestBase.getRadwareServerCli().getHost();
        }
        if (host != null && !host.equals(restTestBase.getRadwareServerCli().getHost())) {
            try {
                radwareServerCli = new RadwareServerCli(host, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRootServerCli().getPassword());
                radwareServerCli.init();
                rootServerCli = new RootServerCli(host, restTestBase.getRootServerCli().getUser(), restTestBase.getRootServerCli().getPassword());
                rootServerCli.init();
            } catch (Exception e) {
                BaseTestUtils.report("Failed to build with host: " + host + " " + e.getMessage(), Reporter.FAIL);
            }
        }
//        CliOperations.runCommand(rootServerCli, "service iptables stop");
        String commandToExecute = "net firewall open-port 10080 open";
        CliOperations.runCommand(radwareServerCli, commandToExecute);
        String port = "10080";
        commandToExecute = "curl -X POST --header 'Content-Type: application/json' --header 'Accept: */*' 'http://" + host + ":" + port + "/reporter/mgmt/monitor/reporter/internal-dashboard/scheduledTasks?jobClassName=com.reporter.scheduled.report.vrm.retention.VrmScheduledReportRetentionTask'";
        CliOperations.runCommand(rootServerCli, commandToExecute);
    }

    /**
     * @param expandOrCollapse - true: expands all, false: collapse all.
     */
    public static void expandViews(boolean expandOrCollapse) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Expand Collapse");
        BasicOperationsHandler.clickButton("Expand Collapse");
        if (expandOrCollapse) {
            if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).getText().equalsIgnoreCase("Expand All"))
                BasicOperationsHandler.clickButton("Expand Collapse");
        } else {
            if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).getText().equalsIgnoreCase("Collapse All"))
                BasicOperationsHandler.clickButton("Expand Collapse");
        }
    }


    public void validateExpand() throws TargetWebElementNotFoundException {
        expandViews(true);

        List<WebElement> expands = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId("Wizard_step_").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        for (WebElement itr : expands) {
            if (itr.getAttribute("class").contains("collapsed"))
                addErrorMessage("The Actual's situation of " + itr.getAttribute("data-debug-id") + " is collapsed BUT the " +
                        "Expected is expanded");
        }

        BasicOperationsHandler.clickButton("Expand Collapse");
        for (WebElement itr : expands) {
            if (itr.getAttribute("class").contains("expanded"))
                addErrorMessage("The Actual's situation of " + itr.getAttribute("data-debug-id") + " is expanded BUT the " +
                        "Expected is collapsed");
        }

        reportErrors();
    }

    public void validateSearch(String sutDeviceType, int index) throws Exception {

//       DeviceInfo deviceInfo = devicesManager.getDeviceInfo(SUTDeviceType.valueOf(sutDeviceType), index);
        BasicOperationsHandler.clickButton("Add New");
        expandViews(false);
        BasicOperationsHandler.clickButton("Scope Selection");
        SUTDeviceType elementType = SUTDeviceType.getConstant(sutDeviceType);
        if (elementType == null) {
            BaseTestUtils.report(sutDeviceType + " is not supported here! , supported={Alteon or DefensePro or LinkProof NG or AppWall}", Reporter.FAIL);
        }
        DeviceInfo deviceInfo = devicesManager.getDeviceInfo(elementType, index);
        String deviceIp = deviceInfo.getDeviceIp();

        BasicOperationsHandler.setTextField("Search", deviceIp);
        List<WebElement> deviceElements = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId("scopeSelection_deviceCheck_").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId("scopeSelection_deviceCheck_" + deviceIp).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false) == null) {
            BaseTestUtils.report("Device : " + deviceIp + " is not exist ", Reporter.FAIL);
        } else if (deviceElements.size() > 1) {
            BaseTestUtils.report("There are more things that should not appear ", Reporter.FAIL);
        } else {
            BasicOperationsHandler.clickButton("Cancel");
            BaseTestUtils.report("Device : " + deviceIp + " is exist ", Reporter.PASS);
        }
    }


    public void validateFilterWithLabelText(String label, String param, String searchLabel) throws Exception {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(param);
        String value = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).getText();
        BasicOperationsHandler.setTextField(searchLabel, value);
        if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false) == null) {
            BaseTestUtils.report("label : '" + label + "' is not exist ", Reporter.FAIL);
        }
    }

    public void validateFilter(String text, String searchLabel, List<VRMHandler.LabelParam> elementsExist, String prefixLabel) throws Exception {
        if ((text == null || text.equals("")) && elementsExist.size() > 0) {
            BaseTestUtils.report("have to put text ", Reporter.FAIL);
        }
        if (elementsExist.size() == 0 && (text == null || text.equals(""))) {
            BaseTestUtils.report("", Reporter.PASS);
            return;
        }
        BasicOperationsHandler.setTextField(searchLabel, text);
        VisionDebugIdsManager.setLabel(prefixLabel);
        Set<String> elementsDebugIds = getElementsSet();
        for (VRMHandler.LabelParam element : elementsExist) {
            VisionDebugIdsManager.setLabel(prefixLabel);
            VisionDebugIdsManager.setParams(element.getParam());
            if (!elementsDebugIds.contains(VisionDebugIdsManager.getDataDebugId())) {
                addErrorMessage("the label '" + prefixLabel + "' with param: '" + element.getParam() + "' is not exist OR text: \"" + text + "\" is not correct");
            }
        }
        reportErrors();
    }

    public void validateFilterNumbering(String text, String label, String searchLabel, int expectedNumber) throws Exception {
        BasicOperationsHandler.setTextField(searchLabel, text);
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams("");
        Thread.sleep(15 * 1000);
        Set<String> elementsDebugIds = getElementsSet();
        if (elementsDebugIds.size() != expectedNumber) {
            BaseTestUtils.report("actual number : '" + elementsDebugIds.size() + "' is not equal to expected number : '" + expectedNumber + "' ", Reporter.FAIL);
        } else {
            BaseTestUtils.report("actual number equal to expected number ", Reporter.PASS);
        }
    }

    private Set<String> getElementsSet() {
        Set<String> elementsDebugIds = new HashSet<String>();
        int elemntsCount = -1;
        while (elementsDebugIds.size() > elemntsCount) {
            elemntsCount = elementsDebugIds.size();
            List<WebElement> elements = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId().split("%s")[0]).getBy());
            elements.forEach(n -> {
                try {
                    elementsDebugIds.add(n.getAttribute("data-debug-id"));
                } catch (StaleElementReferenceException exception) {
                    WebUIUtils.sleep(1);
                    elementsDebugIds.add(n.getAttribute("data-debug-id"));
                }
            });
            WebUIUtils.scrollIntoView(ComponentLocatorFactory.getEqualLocatorByDbgId(elements.get(elements.size() - 1).getAttribute("data-debug-id")));
            WebUIUtils.sleep(1);
        }
        return elementsDebugIds;
    }

    public void DesignNew(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Design")) {
            BasicOperationsHandler.clickButton("Undo All");
            JSONObject designJsonObject = new JSONObject(map.get("Design"));
            if (designJsonObject.toMap().containsKey("Add")) {
                addWidgetsNew(designJsonObject.getJSONArray("Add"));
            }
        }
    }

    public void customizedOptions(Map<String, String> map) throws Exception {

        if (map.containsKey("Customized Options")) {
            BasicOperationsHandler.clickButton("Customized Options");
            JSONObject customizedOptions = new JSONObject(map.get("Customized Options"));
            if (!customizedOptions.isNull("showTable")) {
                if (customizedOptions.get("showTable").equals("true")) {
                    // class contains "kcdiqW" that's mean not clicked
                    if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId("Show_Table_Item").getBy()).getAttribute("class").contains("kcdiqW")) {
                        BasicOperationsHandler.clickButton("Show Table");
                    }
                    // showTable is false
                } else {
                    // class contains "bHftNV" that's mean clicked
                    if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId("Show_Table_Item").getBy()).getAttribute("class").contains("bHftNV")) {
                        BasicOperationsHandler.clickButton("Show Table");
                    }
                }
            }
            // upload logo to report
            if (!customizedOptions.isNull("addLogo")) {
                String name = customizedOptions.get("addLogo").toString();
                if (!name.trim().equals("unselected"))
                    BasicOperationsHandler.uploadFileToVision(name, null, null);
            }
            BasicOperationsHandler.clickButton("Customized Options");
        }
    }

    private void addWidgetsNew(JSONArray addWidgetsText) throws TargetWebElementNotFoundException {
        List<String> widgetsList = new ArrayList<>();
        if (addWidgetsText.toList().contains("ALL")) {
            try {
                BasicOperationsHandler.clickButton("Select All");
                VisionDebugIdsManager.setLabel("Widget Select");
                VisionDebugIdsManager.setParams("");
                List<WebElement> widgetsDragble = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                ComponentLocator targetLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='dd-list_content_custom']");
                ComponentLocator sourceLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='" + widgetsDragble.get(0).getAttribute("data-debug-id") + "']");
                WebUIDragAndDrop.dragAndDrop(sourceLocator, targetLocator);
                List<WebElement> widgets = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[@data-debug-id='dd-list_content_default']//div[contains(@data-debug-id,'dd-list_text_')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                List<WebElement> dragedWidgets = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[@data-debug-id='dd-list_content_custom']//div[contains(@data-debug-id,'dd-list_text_')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

                for (int i = 0; i < widgets.size(); i++) {
                    String widgetName = widgets.get(i).getText();
                    if (!(widgetName.equalsIgnoreCase(dragedWidgets.get(i).getText()))) {
                        BaseTestUtils.report("The Widget: " + widgetName + " has Not Draged", Reporter.FAIL);
                    }
                }
            } catch (Exception e) {
                BaseTestUtils.report("Failed to Drag & Drop all the widgets", Reporter.FAIL);
            }
        } else {
            List<Object> widgetsList2;
            widgetsList2 = addWidgetsText.toList();
            for (int i = 0; i < addWidgetsText.length(); i++) {
                if (widgetsList2.get(i).getClass().getName().contains("HashMap")) {
                    Map<String, Object> widgetMap = new HashMap<String, Object>(((HashMap) widgetsList2.get(i)));
                    for (String entry : widgetMap.keySet()) {
                        entry = entry.trim();
                        try {
                            ArrayList<Object> widgetOptions = (ArrayList) widgetMap.get(entry);
                            ComponentLocator optionLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='dd-list_draggable-item_" + entry + "']//div[@data-debug-id='expand-icon-down']");
                            WebUIComponent webUIComponent = new WebUIComponent(optionLocator);
                            ((JavascriptExecutor) WebUIUtils.getDriver()).executeScript("arguments[0].click();", webUIComponent.getWebElement());
                            for (Object option : widgetOptions) {
                                if (option.getClass().getName().equalsIgnoreCase("java.util.HashMap")) {
                                    VisionDebugIdsManager.setLabel("Widget Option");
                                    VisionDebugIdsManager.setParams(((Map) option).keySet().toArray()[0].toString());
                                    WebElement wb = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
                                    ((JavascriptExecutor) WebUIUtils.getDriver()).executeScript("arguments[0].value='" + ((Map) option).get(((Map) option).keySet().toArray()[0]).toString() + "';", wb.findElement(By.xpath("./input")));
                                    wb.findElement(By.xpath("./input")).click();
                                } else
                                    BasicOperationsHandler.clickButton("Widget Option", option + "_" + entry);
                            }
                            widgetsList.add(entry);
                        } catch (Exception e) {
                            BaseTestUtils.report("Failed to select a widget option:", Reporter.FAIL);
                        }
                    }
                } else {
                    widgetsList.add(addWidgetsText.getString(i).trim());
                }
            }
            vrmHandler.uiVRMDragAndDropWidgets(widgetsList);
        }
    }

    public void validateDragAndDrop(Map<String, String> reportsEntry) {
        Map<String, String> map = CustomizedJsonManager.fixJson(reportsEntry);
        selectTemplate(map);
        try {
            DesignNew(map);
        } catch (TargetWebElementNotFoundException e) {
            BaseTestUtils.report("Failed to Drag and Drop.", Reporter.FAIL);
        }

    }

    protected void selectTemplate(Map<String, String> map) {
        try {
            VisionDebugIdsManager.setLabel("Template");
            VisionDebugIdsManager.setParams("");
            String reportType = map.getOrDefault("reportType", null);
            WebElement selectTemplate = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            if (selectTemplate.getAttribute("class").contains("collapsed"))
                BasicOperationsHandler.clickButton("Template", "");
            if (reportType != null) {
                switch (reportType.toLowerCase()) {
                    case "defensepro behavioral protections dashboard":
                        BasicOperationsHandler.clickButton("DefensePro Behavioral Protections Template", "");
                        break;
                    case "defensepro analytics dashboard":
                        BasicOperationsHandler.clickButton("DefensePro Analytics Template", "");
                        break;
                    case "https flood":
                        BasicOperationsHandler.clickButton("HTTPS Flood Template", "");
                        break;
                    case "defenseflow analytics dashboard":
                        BasicOperationsHandler.clickButton("DefenseFlow Analytics Template", "");
                        break;
                    case "appwall dashboard":
                        BasicOperationsHandler.clickButton("AppWall Template", "");
                        break;
                    default:
                        BasicOperationsHandler.clickButton("DefensePro Analytics Template", "");
                }
            } else BasicOperationsHandler.clickButton("DefensePro Analytics Template", "");


        } catch (Exception e) {
            BaseTestUtils.report("Failed to select Template.", Reporter.FAIL);
        }
    }

    public void undoWidgets(String label, List<String> widgets) {
        for (String widget : widgets) {
            try {
                ComponentLocator optionLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='dd-list_cross-icon_" + widget + "']");
                WebUIComponent webUIComponent = new WebUIComponent(optionLocator);
                ((JavascriptExecutor) WebUIUtils.getDriver()).executeScript("arguments[0].click();", webUIComponent.getWebElement());

            } catch (Exception e) {
                BaseTestUtils.report("The widget: " + widget + " has not Undo.", Reporter.FAIL);
            }
        }
    }

    protected void format(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Format")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Format"));
            if (!deliveryJsonObject.isNull("Select")) {
                String ExportText = deliveryJsonObject.getString("Select");
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
                    case "CSV_WITH_DETAILS":
                        ExportText = "csv_with_details";
                        break;
                }
                BasicOperationsHandler.clickButton("Report Format", ExportText);
            } else {
                BasicOperationsHandler.clickButton("Report Format", "html");
            }

        }
    }

    protected void generate(String reportName, Map<String, String> map) throws TargetWebElementNotFoundException {
        WebElement reportContainer = BasicOperationsHandler.isItemAvailableById("Reports List Item", reportName);
        WebElement generateButton = getGenerateReportButton(reportName, reportContainer);

        Map<String, String> reportLogsStatusBefore = null;
        if (map.get("validation") != null)
            reportLogsStatusBefore = getReportLogStatus(reportContainer);

        LocalTime start = LocalTime.now();
        BasicOperationsHandler.clickButton("Generate Now", reportName);

//        WebElement result = UIUtils.fluentWaitClickable(generateButton, Long.valueOf(map.get("timeout")), false);
        WebElement result = clickableTimeout(generateButton, Long.valueOf(map.get("timeout")));
        LocalTime end = LocalTime.now();
        Duration duration = Duration.between(start, end);

        String lastTimeBefore = reportLogsStatusBefore.get("lastLogTime");
        littleWaitingForGenerationSnapshotDisplayed(reportContainer, lastTimeBefore);

        if (result != null) {
            if (map.get("validation") != null) {
                Map<String, String> reportLogsStatusAfter = getReportLogStatus(reportContainer);

                String lastTimeAfter = reportLogsStatusAfter.get("lastLogTime");

                if (lastTimeAfter.equals(lastTimeBefore))
                    BaseTestUtils.report(String.format("No New Report Was Generated ,The Last Generate time is %s ,Generate Duration is %s", lastTimeAfter, duration.getSeconds() + " seconds"), Reporter.FAIL);
            }
            BaseTestUtils.report(String.format("Generate Duration is %s", duration.getSeconds() + " seconds"), Reporter.PASS);
        } else
            BaseTestUtils.report("Report is Not Generated After Waiting " + duration.getSeconds() + " seconds", Reporter.FAIL);

    }

    private void littleWaitingForGenerationSnapshotDisplayed(WebElement reportContainer, String lastTimeBefore) {
        boolean needToWait = true;
        int waitingSeconds = 0;
        while (needToWait && waitingSeconds < 2) {
            String lastTimeAfter = getReportLogStatus(reportContainer).get("lastLogTime");
            if (!lastTimeAfter.equals(lastTimeBefore)) {
                needToWait = false;
            }
            WebUIUtils.sleep(1);
            waitingSeconds++;
        }
    }

    private WebElement getGenerateReportButton(String reportName, WebElement reportContainer) throws TargetWebElementNotFoundException {
        if (reportContainer == null) BaseTestUtils.report(reportName + " Report Container not found", Reporter.FAIL);

        if (!BasicOperationsHandler.isElementContainsClass("Reports List Item", reportName, "selected"))
            BasicOperationsHandler.clickButton("Reports List Item", reportName);

        WebElement generateButton = BasicOperationsHandler.isItemAvailableById("Generate Now", reportName);
        if (generateButton == null) BaseTestUtils.report(reportName + " Generate Button not found", Reporter.FAIL);
        return generateButton;
    }

    protected Map<String, String> getReportLogStatus(WebElement reportContainer) {
        return null;
    }

    protected WebElement clickableTimeout(WebElement webElemnt, long timeOut) {
        return UIUtils.fluentWaitClickable(webElemnt, timeOut, false);
    }

}
