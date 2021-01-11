package com.radware.vision.infra.testhandlers.vrm;

import com.google.common.collect.Lists;
import com.radware.automation.react.widgets.impl.ReactDropdown;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.FileUtils;
import com.radware.automation.webui.utils.draganddrop.WebUIDragAndDrop;
import com.radware.automation.webui.utils.html5.webstorage.LocalStorage;
import com.radware.automation.webui.utils.html5.webstorage.LocalStorageImpl;
import com.radware.automation.webui.utils.html5.webstorage.SessionStorage;
import com.radware.automation.webui.utils.html5.webstorage.SessionStorageImpl;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.api.LazyView;
import com.radware.automation.webui.widgets.api.TextField;
import com.radware.automation.webui.widgets.impl.LazyViewImpl;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.jsonparsers.impl.JsonUtils;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.exceptions.web.SessionStorageException;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.WebElementType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.infra.testhandlers.vrm.enums.VRMDashboards;
import com.radware.vision.infra.utils.ReportsUtils;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.vision_project_cli.RootServerCli;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import static com.radware.vision.infra.testhandlers.BaseHandler.devicesManager;
import static com.radware.vision.infra.testhandlers.BaseHandler.restTestBase;
import static com.radware.vision.infra.utils.ReportsUtils.addErrorMessage;
import static com.radware.vision.infra.utils.ReportsUtils.reportErrors;
import static jodd.util.ThreadUtil.sleep;


public class VRMHandler {
    protected static final String LABEL = "label";
    protected static final String DATA = "data";
    protected static final String DATASETS = "datasets";
    protected static final String LABELS = "labels";
    protected static final String BACKGROUND_COLOR = "backgroundColor";
    protected static final String SHAPE = "shapeType";
    protected static final String SHAPE_COLOR = "colors";
    protected static JSONObject foundObject;
    protected SessionStorage sessionStorage;
    protected LocalStorage localStorage;

    public VRMHandler() {
        this.sessionStorage = new SessionStorageImpl();
        this.localStorage = new LocalStorageImpl();
    }

    public Map getSessionStorage(String chart) throws SessionStorageException {
        Map jsonMap;
        String item = sessionStorage.getItem(chart);
        jsonMap = JsonUtils.getJsonMap(item);
        return jsonMap;
    }

    /**
     * works both for stack-bar and pie charts
     *
     * @param chart    - Chart's name
     * @param expected - Total number of occurrences
     */
    public void ValidateTotalLegends(String chart, int expected) {
        int actual = getLabelsFromData(chart).length();
        if (actual != expected) {
            BaseTestUtils.report(String.format("Total number of legends mismatch: EXPECTED [%s], ACTUAL [%s]", expected, actual), Reporter.FAIL);
        }
    }

    /**
     * @param chart   Session storage key
     * @param label   - Session Storage internal label
     * @param entries contains attribute and value
     *                else add ErrorMessage in the report
     */
    public void validateChartDataSets(String chart, String label, String columnGraph, List<DataSets> entries) {
        Objects.requireNonNull(chart, "Chart is equal to null");
        Objects.requireNonNull(label, "Label is equal to null");

        if (getObjectFromDataSets(chart, label, columnGraph) != null) {
            entries.forEach(entry -> {

                if (!String.valueOf(foundObject.get(entry.attribute)).equals(entry.value)) {
                    String actualValue = String.valueOf(foundObject.get(entry.attribute));
                    addErrorMessage(String.format("No Match Found in --> [ Chart : %s with label : %s,  attribute : %s, value : %s ] and the actual value is %s"
                            , chart, label, entry.attribute, entry.value, actualValue));
                    scrollAndTakeScreenshot(chart);
                }
            });
        }
        reportErrors();
    }

    /**
     * @param chart   - Session Storage key
     * @param entries stackBar entry that contains legenedName, exist, label, value and offset
     *                if the label in the chart doesn't match with the an entry params, it add an ErrorMessage to the report
     */
    public void validateStackBarData(String chart, List<StackBarData> entries) {

        Objects.requireNonNull(chart, "Chart is equal to null");

        JSONArray legends = getLabelsFromData(chart);
        JSONArray dataSets = getObjectArraysFromDataSets(chart);
        if (dataSets != null && legends != null) {
            entries.forEach(entry -> {
                Objects.requireNonNull(entry.legendName, "Legend can't be null");
                if (isLegendNameExistAndShouldReturn(chart, entry)) return;
                if (isLabanAndEntryExists(chart, entry)) return;
                int legendIndex;
                legendIndex = legends.toList().stream().map(s-> String.valueOf(s)).collect(Collectors.toList()).indexOf(entry.legendName);
                if (legendIndex == -1) {
                    addErrorMessage("There is no legend with name " + entry.legendName);
                    scrollAndTakeScreenshot(chart);
                    return;
                }

                getObjectFromDataArray(dataSets, entry.label, chart);
                JSONArray dataArray = (JSONArray) foundObject.get(DATA);
                String actualData = String.valueOf(dataArray.get(legendIndex));
                //Value has an offset that is not "0"
                if (entry.offset != null && entry.offset != 0) {
                    int maxValue = Integer.parseInt(entry.value) + entry.offset;
                    int minValue = Integer.parseInt(entry.value) - entry.offset;
                    if ((Integer.parseInt(actualData) > maxValue) || (Integer.parseInt(actualData) < minValue)) {
                        addErrorMessage("The EXPECTED between " + maxValue + " and " + minValue + ", The ACTUAL value of " + entry.legendName + " is " + actualData);
                        scrollAndTakeScreenshot(chart);
                    }
                    //Value does not have offset or offset is "0"
                } else if (!actualData.equals(entry.value)) {
                    addErrorMessage("There is no match found in --> the EXPECTED data is " + entry.toString() + " and the ACTUAL value is " + actualData);
                    scrollAndTakeScreenshot(chart);
                }

                if (entry.min != null)
                {
                    int actualCount = dataArray.toList().stream().map(s->s.toString().equals(entry.value)).collect(Collectors.toList()).size();
                    if(actualCount < entry.min)
                        addErrorMessage("The count of value " + entry.value + " is " + actualCount + " but the expected is " + entry.count);
                    scrollAndTakeScreenshot(chart);

                }
            });
        }
        reportErrors();
    }

    protected boolean isLegendNameExistAndShouldReturn(String chart, StackBarData entry) {
        boolean returnValue = entry.legendNameExist != null;
        entry.legendNameExist = entry.legendNameExist == null || entry.legendNameExist;
        JSONArray legends = getLabelsFromData(chart);
        if (!((legends.toList().contains(entry.legendName) && entry.legendNameExist) || (!legends.toList().contains(entry.legendName) && !entry.legendNameExist))) {
//            addErrorMessage("The existence of " + entry.legendName + " is " + entry.legendNameExist + " but ACTUAL is " + legends.toList().contains(entry.legendName));
            addErrorMessage("The Legend Name of '" + entry.legendName + "'" + (entry.label != null ? " of label '" + entry.label + "'" : "") + " is Not as expected, Expected result is: " + (entry.legendNameExist.equals(true) ? "'exist'" : "'doesn't exist'") + " But Actual result is: " + (legends.toList().contains(entry.legendName) ? "'exist'" : "'doesn't exist'"));
        }
        return returnValue;
    }

    protected boolean isLabanAndEntryExists(String chart, StackBarData entry) {
        entry.exist = entry.exist == null ? true : entry.exist;
        if (!(isLabelExist(chart, entry.label)) && entry.exist || (isLabelExist(chart, entry.label)) && !entry.exist) {
//            addErrorMessage("The existence of " + entry.label + " is " + entry.exist + " but ACTUAL is " + isLabelExist(chart, entry.label));
            addErrorMessage("The Label Name of '" + entry.label + "' is Not as expected, Expected result is: " + (entry.exist.equals(true) ? "'exist'" : "'doesn't exist'") + " But Actual result is: " + (isLabelExist(chart, entry.label) ? "'exist'" : "'doesn't exist'"));
            scrollAndTakeScreenshot(chart);
            return true;
        }
        return (!isLabelExist(chart, entry.label)) && !entry.exist;
    }

    public void uiValidateStackBarTimeDataWithWidget(String chart, List<StackBarData> entries) {

        Objects.requireNonNull(chart, "Chart is equal to null");
        JSONArray legends = getLabelsFromData(chart);
        JSONArray dataSets = getObjectArraysFromDataSets(chart);
        if (dataSets != null && legends != null) {
            entries.forEach(entry -> {
                if (isLabanAndEntryExists(chart, entry)) return;
                getObjectFromDataArray(dataSets, entry.label, chart);
                JSONArray dataArray = (JSONArray) foundObject.get(DATA);
                if (entry.count != null) {
                    int actualCount = 0;
                    for (Object value : dataArray) {
                        if (value.toString().equals(entry.value))
                            actualCount++;
                    }
                    int countOffset = entry.countOffset == null ? 0 : entry.countOffset;
                    double minValue = entry.count - countOffset;
                    double maxValue = entry.count + countOffset;
                    if (actualCount > maxValue || actualCount < minValue)
                        addErrorMessage("The Actual count of value " + entry.value + " of label " + entry.label + " in chart " + chart + " is " + actualCount + " and the Expected is between minCount " + (minValue) + " and maxCount " + (maxValue));
                    return;
                }
                if (entry.min != null)
                {
                    int actualCount = 0;
                    for (Object value : dataArray) {
                        if (value.toString().equals(entry.value))
                            actualCount++;
                    }
                    if (actualCount < entry.min)
                        addErrorMessage("The Actual count of value " + entry.value + " of label " + entry.label + " in chart " + chart + " is " + actualCount + " and the Expected minCount is " + entry.min);
                    return;
                }

                Objects.requireNonNull(entry.legendName, "Legend can't be null");
                int legendIndex;
                DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
                String legendTime = TimeUtils.getAddedDate(entry.legendName).format(inputFormatter);
                legendIndex = legends.toList().indexOf(legendTime);
                if (legendIndex == -1) {
                    addErrorMessage("There is no legend with name " + legendTime);
                    scrollAndTakeScreenshot(chart);
                    return;
                }
                String actualData = String.valueOf(dataArray.get(legendIndex));
                //Value has an offset that is not "0"
                if (entry.offset != null && entry.offset != 0) {
                    int maxValue = Integer.parseInt(entry.value) + entry.offset;
                    int minValue = Integer.parseInt(entry.value) - entry.offset;
                    if (!((Integer.parseInt(actualData) > maxValue) || (Integer.parseInt(actualData) < minValue))) {
                        addErrorMessage("The EXPECTED between " + maxValue + " and " + minValue + ", The ACTUAL value of " + legendTime + " is " + actualData);
                        scrollAndTakeScreenshot(chart);
                    }
                    //Value does not have offset or offset is "0"
                } else if (!actualData.equals(entry.value)) {
                    addErrorMessage("There is no match found in --> the EXPECTED data is " + entry.toString() + " and the ACTUAL value is " + actualData);
                    scrollAndTakeScreenshot(chart);
                }
            });
        }
        reportErrors();
    }

    /**
     * @param chart   - Session storage key
     * @param label   - Chart internal key
     * @param entries if no match between an entry and the actual label params it adds errorMessage to the report
     */
    public void validateChartDataOfDataSets(String chart, String label, String columnGraph, List<Data> entries) {


        Objects.requireNonNull(chart, "Chart is equal to null");
        Objects.requireNonNull(label, "Label is equal to null");
        getObjectFromDataSets(chart, label, columnGraph);
        JSONArray data = (JSONArray) foundObject.get(DATA);

        entries.forEach(entry -> {
            entry.count = (entry.count == null) ? -1 : entry.count;
            entry.exist = entry.exist == null || entry.exist;
            entry.index = (entry.index == null) ? -1 : entry.index;
            entry.value = (entry.value == null) ? null : entry.value;
            entry.valueOffset = (entry.value == null) ? 0 : entry.valueOffset;

            if (isLabelExist(chart, label) ^ entry.exist) {
                return;
            }
            if ((!isLabelExist(chart, label)) && !entry.exist) {
                return;
            }

            long valueAppearances = StreamSupport.stream(data.spliterator(), false)
                    .map(String::valueOf)
                    .filter(s -> isDataMatch(entry, s))
                    .count();
            if (entry.min != null) {
                if (valueAppearances < entry.min) {
                    addErrorMessage("The ACTUAL count of the label " + label + " in the chart " + chart + " of value: " + entry.value + " is " + valueAppearances + " and the EXPECTED minimum is " + entry.min);
                    scrollAndTakeScreenshot(chart);
                }
            } else if (entry.count > 0) {
                // Value has offset that is not "0"
                if (entry.offset != null && entry.offset != 0 || entry.valueOffset != 0) {
                    if (entry.valueOffset != 0) {
                        double actualValue = (Double) data.get(entry.index);
                        double maxVal = actualValue + entry.valueOffset;
                        double minVal = actualValue - entry.valueOffset;
                        if (actualValue > maxVal || actualValue < minVal) {
                            addErrorMessage("The ACTUAL value of the label " + label + " in the chart " + chart + " is " + valueAppearances + " and the EXPECTED is between " + minVal
                                    + " and " + maxVal);
                            scrollAndTakeScreenshot(chart);
                        }
                    } else {
                        int maxVal = entry.count + entry.offset;
                        int minVal = entry.count - entry.offset;
                        if (valueAppearances > maxVal || valueAppearances < minVal) {
                            addErrorMessage("The ACTUAL count of the label " + label + " in the chart " + chart + " is " + valueAppearances + " and the EXPECTED is between " + minVal
                                    + " and " + maxVal);
                            scrollAndTakeScreenshot(chart);
                        }
                    }
                }
                //Value does not have offset or offset is "0"
                else if (!(valueAppearances == entry.count)) {
                    addErrorMessage("The ACTUAL count of the label " + label + " in the chart " + chart + " is " + valueAppearances + " and the EXPECTED is " + entry.count);
                    scrollAndTakeScreenshot(chart);
                }
            }
            if (entry.index != -1 && entry.valueOffset == 0) {
                if (!data.get(entry.index).toString().trim().equalsIgnoreCase(entry.value.trim())) {
                    addErrorMessage("The ACTUAL value of the index " + entry.index + " is: " + data.get(entry.index) + " BUT the EXPECTED is " + entry.value);
                }
            }
        });
        reportErrors();
    }

    protected boolean isDataMatch(Data entry, String s) {
        if (!s.matches("\\d+\\.\\d+|\\d+"))
            return s.equals(entry.value);
        else if (entry.value.matches("\\d+\\.\\d+|\\d+"))
            return Double.parseDouble(s) >= (Double.parseDouble(entry.value)- entry.valueOffset) && (Double.parseDouble(s) <= (Double.parseDouble(entry.value)+ entry.valueOffset));
        else return false;
    }

    /**
     * @param chart - Session storage key
     * @param label - Chart internal key
     * @return true if the label exists at the web's chart
     */
    protected boolean isLabelExist(String chart, String label) {
        JSONArray dataArray = null;
        try {
            Map jsonMap = getSessionStorage(chart);
            jsonMap = JsonUtils.getJsonMap(jsonMap.get(DATA));
            dataArray = (JSONArray) jsonMap.get(DATASETS);

        } catch (SessionStorageException e) {
            BaseTestUtils.report("Failed to get label: " + label + " from chart: " + chart, e);
        }
        assert dataArray != null;
        return StreamSupport.stream(dataArray.spliterator(), false)
                .map(JSONObject.class::cast)
                .filter(jsonObject -> jsonObject.getString(LABEL).equals(label))
                .findAny().isPresent();
    }

    /**
     * @param dataArray - Chart as JSON object
     * @param label     - Chart internal key
     * @param chart     - Session storage key (for report use only)
     * @return updates foundObject parameter with JSONObject that found at in given JSONArray and returns it
     */
    protected JSONObject getObjectFromDataArray(JSONArray dataArray, String label, String chart) {
        try {
            foundObject = StreamSupport.stream(dataArray.spliterator(), false)
                    .map(JSONObject.class::cast)
                    .filter(jsonObject -> jsonObject.getString(LABEL).equals(label))
                    .findFirst()
                    .orElseThrow(() -> new NullPointerException(String.join(" ", "Chart :", chart, "With label :", label, "Could not be found")));
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get label: " + label + " from chart: " + chart, e);
        }
        return foundObject;
    }

    /**
     * @param chart - Session storage key
     * @param label - Chart internal key
     * @return update the foundObject parameter with JSONArray that found at sessionStorage->DATA->DATASETS and returns  it
     */
    protected JSONObject getObjectFromDataSets(String chart, String label, String columnGraph) {
        JSONArray dataArray;
        try {
            Map jsonMap = getSessionStorage(chart);
            if (columnGraph != null)
                try {
                    jsonMap = JsonUtils.getJsonMap(jsonMap.get(columnGraph));
                } catch (Exception e) {
                    BaseTestUtils.report("The graph column " + columnGraph + " is not found", Reporter.FAIL);
                }
            jsonMap = JsonUtils.getJsonMap(jsonMap.get(DATA));
            dataArray = (JSONArray) jsonMap.get(DATASETS);

            foundObject = StreamSupport.stream(dataArray.spliterator(), false)
                    .map(JSONObject.class::cast)
                    .filter(jsonObject -> jsonObject.getString(LABEL).equals(label))
                    .findFirst()
                    .orElseThrow(() -> new NullPointerException(String.join(" ", "Chart :", chart, "With label :", label, "Could not be found")));
        } catch (SessionStorageException e) {
            BaseTestUtils.report("Failed to get label: " + label + " from chart: " + chart, e);
            foundObject = null;
        }
        return foundObject;
    }

    /**
     * @param chart - Session storage key
     * @return it returns JSONArray that found at sessionStorage->DATA->DATASETS
     */
    protected JSONArray getObjectArraysFromDataSets(String chart) {
        JSONArray dataArray;
        try {
            Map jsonMap = getSessionStorage(chart);
            jsonMap = JsonUtils.getJsonMap(jsonMap.get(DATA));
            dataArray = (JSONArray) jsonMap.get(DATASETS);
        } catch (SessionStorageException e) {
            BaseTestUtils.report("Failed to get chart: " + chart, e);
            dataArray = null;
        }
        return dataArray;
    }

    /**
     * @param chart - Session storage key
     * @return it update foundObject parameter with JSONObject that found at sessionStorage->DATA->DATASETS->get(0) and returns it
     */
    protected JSONObject getObjectFromDataSets(String chart) {
        JSONArray dataArray;
        try {
            Map jsonMap = getSessionStorage(chart);
            jsonMap = JsonUtils.getJsonMap(jsonMap.get(DATA));
            dataArray = (JSONArray) jsonMap.get(DATASETS);

            foundObject = (JSONObject) dataArray.get(0);
        } catch (SessionStorageException e) {
            BaseTestUtils.report("Failed to get chart: " + chart, e);
        }
        return foundObject;
    }

    /**
     * @param chart - Session storage key
     * @return it returns JSONArray that found at sessionStorage->DATA->LABELS
     */
    protected JSONArray getLabelsFromData(String chart) {

        Map jsonMap = null;
        try {
            jsonMap = getSessionStorage(chart);
            jsonMap = JsonUtils.getJsonMap(jsonMap.get(DATA));
        } catch (SessionStorageException e) {
            BaseTestUtils.report("Failed to get chart: " + chart, e);
        }
        assert jsonMap != null;
        return (JSONArray) jsonMap.get(LABELS);

    }

    /**
     * Validate if all the parameters are as expected
     *
     * @param chart   - Chart name
     * @param entries - DataSets type
     */
    public void validatePieChartDataSets(String chart, List<DataSets> entries) {
        Objects.requireNonNull(chart, "Chart is equal to null");
        getObjectFromDataSets(chart);
        entries.forEach(entry -> {
            if (!String.valueOf(foundObject.get(entry.attribute)).equals(entry.value))
                addErrorMessage(String.format("No Match Found in --> [ Chart : %s, attribute : %s, value : %s ] and the actual value is %s"
                        , chart, entry.attribute, entry.value, foundObject.get(entry.attribute)));
            scrollAndTakeScreenshot(chart);
        });
        reportErrors();
    }

    public static void scroll(String chart) {
        VisionDebugIdsManager.setLabel("Chart");
        VisionDebugIdsManager.setParams(chart);
        try {
            WebElement element = WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
            if (element == null)
                return;
            WebUIUtils.scrollIntoView(element,true);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public void validatePieChartDataOfDataSetsSize(String chart, List<DataSize> entries) {
        Objects.requireNonNull(chart, "Chart is equal to null");
        Objects.requireNonNull(chart, "Chart is equal to null");
        getObjectFromDataSets(chart);

        entries.forEach(entry -> {
            int dataSize = ((JSONArray) foundObject.get(DATA)).length();
            //Value has an offset that is not "0"
            if (entry.offset != null && entry.offset != 0) {
                int minVal = (entry.size - entry.offset);
                int maxVal = (entry.size + entry.offset);
                if (!((dataSize > maxVal || dataSize < minVal))) {
                    addErrorMessage(String.format("No Match Found in --> [ Chart : %s, The size EXPECTED between %s and %s], the ACTUAL size is %s"
                            , chart, minVal, maxVal, dataSize));
                    scrollAndTakeScreenshot(chart);
                }
            }
            //Value does not have an offset or offset is "0"
            else if (!(dataSize == entry.size)) {
                addErrorMessage(String.format("No Match Found in --> EXPECTED [ Chart : %s, size : %s], the ACTUAL size is %s"
                        , chart, entry.size, dataSize));
                scrollAndTakeScreenshot(chart);
            }
        });
        reportErrors();
    }

    public void validateLineChartDataOfDataSetsSize(String chart, String label, String columnGraph, List<DataSize> entries) {

        Objects.requireNonNull(chart, "Chart is equal to null");
        Objects.requireNonNull(label, "Label is equal to null");
        getObjectFromDataSets(chart, label, columnGraph);

        entries.forEach(entry -> {
            int dataSize = ((JSONArray) foundObject.get(DATA)).length();
            //Value has offset that is not "0"
            if (entry.offset != null && entry.offset != 0) {
                int maxVal = entry.size + entry.offset;
                int minVal = entry.size - entry.offset;
                if (!((dataSize > maxVal || dataSize < minVal))) {
                    addErrorMessage(String.format("No Match Found in --> [ Chart : %s, Label : %s,The size EXPECTED between %s and %s], and the ACTUAL size is %s"
                            , chart, label, minVal, maxVal, dataSize));
                    scrollAndTakeScreenshot(chart);
                }
            }
            //Value does not have an offset or offset is "0"
            else if (dataSize != entry.size) {
                addErrorMessage(String.format("No Match Found in --> EXPECTED[ Chart : %s, size : %s], and the ACTUAL size is %s"
                        , chart, entry.size, dataSize));
                scrollAndTakeScreenshot(chart);
            }
        });
        reportErrors();
    }

    public void dragAndDropVRMChart(String elementName, int xOffset, int yOffset) {
        try {
            VisionDebugIdsManager.setLabel("Chart");
            VisionDebugIdsManager.setParams(elementName);

            String elementID = VisionDebugIdsManager.getDataDebugId();
            String elementXpath = ".//*[starts-with(@data-debug-id,'" + elementID + "')]";
            ComponentLocator elementLocator = new ComponentLocator(How.XPATH, elementXpath);
            int beforeX = WebUIUtils.getElementLocation(elementLocator).getX();
            int beforeY = WebUIUtils.getElementLocation(elementLocator).getY();
            int afterX;
            int afterY;
            WebUIDragAndDrop.dragAndDrop(elementLocator, xOffset, yOffset);
            afterX = WebUIUtils.getElementLocation(elementLocator).getX();
            afterY = WebUIUtils.getElementLocation(elementLocator).getY();

            if (xOffset > 0) {
                if (afterX <= beforeX) {
                    throw new Exception("Dragging to right did not succeed");
                }
            } else if (xOffset < 0) {
                if (afterX >= beforeX) {
                    throw new Exception("Dragging to left did not succeed");
                }
            }

            if (yOffset > 0) {
                if ((afterY - beforeY) <= 0) {
                    throw new Exception("Dragging to down did not succeed");
                }
            } else if (yOffset < 0) {
                if ((afterY - beforeY) >= 0) {
                    throw new Exception("Dragging to up did not succeed");
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to drag and drop element.", e);
        }
    }

    public void resizeVRMChart(String elementName, int xOffset, int yOffset) {
        try {
            if (xOffset > 600 || xOffset < -600) {
                throw new Exception("xOffset must be between -600 and 600.");
            }
            if (yOffset > 300 || yOffset < -300) {
                throw new Exception("yOffset must be between -300 and 300.");
            }

            if (VisionDebugIdsManager.getSubTab().equals(VRMDashboards.DP_ANALYTICS.getLabel())) {
                VisionDebugIdsManager.setLabel("Chart");
            } else if (VisionDebugIdsManager.getSubTab().equals(VRMDashboards.DP_MONITORING_DASHBOARD.getLabel())) {
                VisionDebugIdsManager.setLabel(elementName);
            }
            VisionDebugIdsManager.setParams(elementName);
            String elementID = VisionDebugIdsManager.getDataDebugId();
//            String elementXpath = ".//*[starts-with(@data-debug-id,'" + elementID + "')]";
            String elementBlockXpath = ".//*[starts-with(@data-debug-id,'" + elementID + "')]" + "/ancestor::div[5]";
            String resizeElementXpath = ".//*[starts-with(@data-debug-id,'" + elementID + "')]" + "/ancestor::div[4]/following-sibling::span[@class='react-resizable-handle']";
            ComponentLocator blockLocator = new ComponentLocator(How.XPATH, elementBlockXpath);
            ComponentLocator resizeElementLocator = new ComponentLocator(How.XPATH, resizeElementXpath);
            int beforeWidth = WebUIUtils.getElementWidth(blockLocator);
            int beforeHeight = WebUIUtils.getElementHeight(blockLocator);
            int afterWidth;
            int afterHeight;
            String javaScript = "$(arguments[0]).css('visibility','visible');";
            WebUIUtils.fluentWaitJSExecutor(javaScript, WebUIUtils.DEFAULT_WAIT_TIME, false, resizeElementLocator);
            WebUIDragAndDrop.dragAndDrop(resizeElementLocator, xOffset, yOffset);
            afterWidth = WebUIUtils.getElementWidth(blockLocator);
            afterHeight = WebUIUtils.getElementHeight(blockLocator);

            if ((xOffset > 0 && afterWidth <= beforeWidth) || (xOffset < 0 && afterWidth >= beforeWidth)) {
                addErrorMessage("Width did not change as expected while offset is - " + xOffset + " started with - " + beforeWidth + " now is - " + afterHeight);
            }

            if ((yOffset > 0 && afterHeight <= beforeHeight) || (yOffset < 0 && afterHeight >= beforeHeight)) {
                addErrorMessage("Height did not change as expected while offset is - " + yOffset + " started with - " + beforeHeight + " now is - " + afterWidth);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to resize element.", e);
        }
        reportErrors();
    }

    protected static void scrollAndTakeScreenshot(String chart) {
        scroll(chart);
        WebUIUtils.forceGenerateAndReportScreenshot();
    }

    void innerSelectDeviceWithPoliciesAndPorts(String saveFilter, SUTDeviceType deviceType, List<DpDeviceFilter> entries) {
        innerSelectDeviceWithPoliciesAndPorts(saveFilter, deviceType, entries, false);
    }

    /**
     * @param chart   - Session storage key
     * @param entries it validate the entries values with the actual web values
     */
    public void validatePieChartDataOfDataSets(String chart, List<PieChart> entries) {
        Objects.requireNonNull(chart, "Chart is equal to null");
        getObjectFromDataSets(chart);
        JSONArray labels = getLabelsFromData(chart);
        JSONArray dataArray = (JSONArray) foundObject.get(DATA);
        JSONArray backGroundColorArray = (JSONArray) foundObject.get(BACKGROUND_COLOR);

        entries.forEach(entry -> {
            if (entry.exist == null) entry.exist = true;
            int labelIndex = labels.toList().indexOf(entry.label);
            if (labelIndex == -1 && !entry.exist)
                return;
            if ((labelIndex == -1) == entry.exist) {//labelIndex == -1 && entry.exist || labelIndex != -1 && !entry.exist
                addErrorMessage("The label " + entry.label + " existence EXPECTED to be " + entry.exist + " ACTUAL is " + (labelIndex == -1 ? "Not Found" : "Was Found"));
                scrollAndTakeScreenshot(chart);
                return;
            }
            if (entry.backgroundcolor != null && !entry.backgroundcolor.isEmpty()) {
                if (!backGroundColorArray.get(labelIndex).equals(entry.backgroundcolor)) {
                    addErrorMessage("The ACTUAL color of " + entry.label + " in chart " + chart + " is " + backGroundColorArray.get(labelIndex) + " The EXPECTED is " + entry.backgroundcolor);
                    scrollAndTakeScreenshot(chart);
                }
            }

            if (entry.data != null) {
                double entryData = Double.parseDouble(entry.data);
                Double dataFromArray = Double.parseDouble(dataArray.get(labelIndex).toString());
                if (entry.offset == 0 && entry.offsetPercentage == null) {
                    if (!dataFromArray.equals(entryData)) {
                        addErrorMessage("The ACTUAL data of label: " + entry.label + " in chart " + chart + " is " + dataFromArray.toString() + " The EXPECTED is " + entryData);
                        scrollAndTakeScreenshot(chart);
                    }
                } else {
                    Pattern pattern = Pattern.compile("((\\d+)(\\.\\d+)?)%");
                    Matcher matcher = pattern.matcher(entry.offsetPercentage);
                    if (matcher.matches()) {
                        double percentage = Double.parseDouble(matcher.group(1)) / 100.0;
                        entry.offset =(int) (entryData * percentage);
                    }
                    if (!(entryData - entry.offset <= dataFromArray || entryData + entry.offset >= dataFromArray))
                        addErrorMessage("The EXPECTED between " + (entryData + entry.offset) + " and " + (entryData - entry.offset) + ", The ACTUAL value of " + entry.label + " is " + dataFromArray);
                }

            }


            if (entry.shapeType != null) {
                JSONArray shapesArray = (JSONArray) foundObject.get(SHAPE);
                if (!shapesArray.get(labelIndex).toString().equals(entry.shapeType)) {
                    addErrorMessage("The ACTUAL shapeType of label: " + entry.label + " in chart " + chart + " is " + shapesArray.get(labelIndex).toString() + " The EXPECTED is " + entry.shapeType);
                }
            }
            if (entry.colors != null) {
                JSONArray shapesColorArray = (JSONArray) foundObject.get(SHAPE_COLOR);
                if (!shapesColorArray.get(labelIndex).toString().equals(entry.colors)) {
                    addErrorMessage("The ACTUAL color of label: " + entry.label + " in chart " + chart + " is " + shapesColorArray.get(labelIndex).toString() + " The EXPECTED is " + entry.colors);
                }
            }

        });

        reportErrors();
    }

    /**
     * Validate session storage element existence
     *
     * @param sessionStorage - Session Storage identifier
     * @param isExist        - Does session storage expected to exist
     */
    public void isSessionStorageExists(String sessionStorage, Boolean isExist) {
        boolean expected = isExist == null || isExist;
        if (this.sessionStorage.isSessionStorageExists(sessionStorage) != expected) {
            BaseTestUtils.report(String.format("Session Storage {%s} expected existence to be [%s], actual [%s]", sessionStorage, expected, !expected), Reporter.FAIL);
        }
    }

    /**
     * Remove session storage element
     *
     * @param sessionStorage - name
     */
    public void removeSessionStorage(String sessionStorage) {
        try {
            this.sessionStorage.removeItem(sessionStorage);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to remove element: " + sessionStorage, e);
        }
    }

    public void selectApplications(List<DpApplicationFilter> entries, String deviceType, boolean shouldSaved) throws Exception {
        VisionDebugIdsManager.setLabel("Device Selection.All Devices Selection");
        WebUICheckbox checkbox = new WebUICheckbox(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
        checkbox.check();
        if (!entries.isEmpty()) {
            checkbox.uncheck();
            if (entries.get(0).name.equalsIgnoreCase("All")) {
                checkbox.check();
            } else {
                for (DpApplicationFilter entry : entries) {
                    VisionDebugIdsManager.setLabel("Device Selection.Available Device CheckBox");
                    entry.name = entry.name.trim();
                    VisionDebugIdsManager.setParams(entry.name);
                    checkbox.setLocator(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
//                    checkbox.setLocator(ComponentLocatorFactory.getEqualLocatorByDbgId("scopeSelection_deviceIP_" + entry.name + "_Label"));
                    if (checkbox.getWebElement() == null) {
                        switch (deviceType.toLowerCase()) {
                            case "defenseflow":
                            case "appwall":
                            case "alteon":
                                VisionDebugIdsManager.setLabel("Filter");
                                TextField textField = WebUIVisionBasePage.getCurrentPage().getContainer().getTextField(VisionDebugIdsManager.getDataDebugId());
                                BasicOperationsHandler.setTextField("Filter", "");
                                ((WebUITextField) textField).sendKeysByCharacter(entry.name);
                                if (checkbox.getWebElement() != null)
                                    checkbox.check();
                                else
                                    throw new Exception(" checkBox element not found " + entry.name + " ");

                                break;
                            default:
                                throw new Exception(" checkBox element not found " + entry.name + " ");
                        }
                    } else {
                        checkbox.check();
                    }
                }
            }
        }
        if (shouldSaved) {
            BasicOperationsHandler.clickButton("Device Selection.Save Filter");
        }
    }

    public void uiVRMTotalAvailableDeviceS(int totalNumOfDevices) {
        WebUIComponent availableDevicesList = new WebUIComponent(ComponentLocatorFactory.getEqualLocatorByDbgId("undefined_Items"));
        int actualNumOfDevices = 0;
        if (availableDevicesList.find()) {
            actualNumOfDevices = availableDevicesList.findInners(new ComponentLocator(How.XPATH, "//li")).size();
        }
        if (actualNumOfDevices != totalNumOfDevices)
            ReportsUtils.reportAndTakeScreenShot(String.format("Actual number of available devices [%s] , Expected value [%s]", actualNumOfDevices, totalNumOfDevices), Reporter.FAIL);
    }

    /**
     * Select Widgets from the list
     *
     * @param entries - list of widget to be selected if is "null" will remove all widgets
     */
    public void uiVRMSelectWidgets(List<String> entries) {
//      Select widgets container
        VisionDebugIdsManager.setLabel("Widget Selection");
        if (entries == null)
            uiVRMSelectWidgets();
        else {
//      Open widget selection popup
            ComponentLocator locator = WebUIVisionBasePage.getCurrentPage().getContainer().getWidget("").getLocator();
            ReactDropdown dd = new ReactDropdown(locator);
            dd.selectMultiOptionsByText(entries);
//      Add selected widgets
            VisionDebugIdsManager.setLabel("Widget Selection.Add Selected Widgets");
            WebUIVisionBasePage.getCurrentPage().getContainer().getWidget("").click();
        }
    }

    void uiVRMDragAndDropWidgets(List<String> entries) throws TargetWebElementNotFoundException { /// change to drag and drop
        VisionDebugIdsManager.setLabel("Widget Select");
        if (entries == null) {
            BasicOperationsHandler.clickButton("Undo All");
        } else {
            for (String entry : entries) {
                try {
                    VisionDebugIdsManager.setParams(entry);

                    ComponentLocator targetLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='dd-list_content_custom']");
//                    ComponentLocator sourceLocator = ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
                    ComponentLocator sourceLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() + "']");
                    WebUIDragAndDrop.dragAndDrop(sourceLocator, targetLocator);
                } catch (Exception e) {
                    BaseTestUtils.report("Failed to Drag&Drop: " + entry + " widget" + "\n The path is:" +
                            FileUtils.getAbsoluteClassesPath().concat("\\dragAndDropHTML5\\jquery_load_helper.js") + "\n The Exception is :" + e, Reporter.FAIL);

                }
            }

            List<WebElement> draggedWidgets = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[@data-debug-id='dd-list_content_custom']//div[contains(@data-debug-id,'dd-list_text_')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

            for (String widgetName : entries) {
                boolean dragged = false;
                for (WebElement draggedWidget : draggedWidgets) {
                    if ((widgetName.equalsIgnoreCase(draggedWidget.getText()))) {
                        dragged = true;
                    }
                }
                if (!dragged) {
                    BaseTestUtils.report("The Widget: " + widgetName + " has Not Draged", Reporter.FAIL);
                }
            }

        }

    }


    protected void uiVRMSelectWidgets() {
//      Open widget selection popup
        WebUIVisionBasePage.getCurrentPage().getContainer().getWidget("").click();
//      Remove all
        VisionDebugIdsManager.setLabel("Widget Selection.Clear Dashboard");
        WebUIVisionBasePage.getCurrentPage().getContainer().getWidget("").click();
        VisionDebugIdsManager.setLabel("Widget Selection.Remove All Confirm");
        WebUIVisionBasePage.getCurrentPage().getContainer().getWidget("").click();
    }


    public void innerSelectDeviceWithPoliciesAndPorts(String saveFilter, SUTDeviceType deviceType, List<DpDeviceFilter> entries, boolean moveMouse) {
        try {
            //ALL Button
            String selectAllCheckBox = "Device Selection.All Devices Selection";
            VisionDebugIdsManager.setLabel(selectAllCheckBox);
            WebUICheckbox checkbox = new WebUICheckbox(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
//            To Clear previous settings
            checkbox.check();
            if (!entries.isEmpty())
                checkbox.uncheck();

            entries.forEach(entry -> {
                String deviceIp = null;
                String deviceName = null;
                try {
                    if (entry.index == null) {
                        throw new Exception("Index entry is empty please enter it!");
                    }
                    if (deviceType == null) {
                        deviceIp = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, entry.index).getDeviceIp();
                        deviceName = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, entry.index).getDeviceName();
                    } else {
                        deviceIp = devicesManager.getDeviceInfo(deviceType, entry.index).getDeviceIp();
                        deviceName = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, entry.index).getDeviceName();
                    }

                } catch (Exception e) {
                    BaseTestUtils.report(e.getMessage(), e);
                }
                //select the device
                checkbox.setLocator(ComponentLocatorFactory.getEqualLocatorByDbgId("scopeSelection_" + deviceName + "_Label"));
                checkbox.check();
                boolean changePolicies = entry.policies != null && !entry.policies.equals("");
                boolean changePorts = entry.ports != null && !entry.ports.equals("");
                if (changePolicies || changePorts) {
                    //click on change
                    ClickOperationsHandler.clickWebElement(ComponentLocatorFactory.getEqualLocatorByDbgId("scopeSelection_change_" + deviceName), false);
                    String policyPrefix = "scopeSelection_" + deviceName + "_policiesLabel_";
                    String portPrefix = "scopeSelection_" + deviceName + "_portsLabel_";
                    String policySearch = "scopeSelection_[" + deviceName + "]_policy_Text";
                    String portSearch = "scopeSelection_[" + deviceName + "]_port_Text";
                    List<String> policiesList, portsList;
                    if (changePolicies) {
                        WebUITextField policyText = new WebUITextField(ComponentLocatorFactory.getEqualLocatorByDbgId(policySearch));
                        WebUIUtils.scrollIntoView(policyText.getWebElement(), true);
                        if (!entry.policies.equalsIgnoreCase("ALL")) {
                            policiesList = Arrays.asList(entry.policies.split("(,)"));
                            for (String policy : policiesList) {
                                policyText.type(policy.trim());
                                if (WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualLocatorByDbgId(policyPrefix + policy.trim()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME / 2) == null) {
                                    policyText.type(""); //clear
                                    scrollUntilElementDisplayed(ComponentLocatorFactory.getLocatorByXpathDbgId("scopeSelection_" + deviceName + "_policiesLabel_"), ComponentLocatorFactory.getEqualLocatorByDbgId(policyPrefix + policy.trim()));
                                } else if (!WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualLocatorByDbgId(policyPrefix + policy.trim()).getBy()).isDisplayed()) {
                                    WebUIUtils.scrollIntoView(WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualLocatorByDbgId(policyPrefix + policy.trim()).getBy()));
                                }
                                checkbox.setLocator(ComponentLocatorFactory.getEqualLocatorByDbgId(policyPrefix + policy.trim()));
                                checkbox.check();
                            }
                        } else {
                            LazyView lazyView = new LazyViewImpl(ComponentLocatorFactory.getEqualLocatorByDbgId("VRM_Scope_Selection_policies_" + deviceName), new ComponentLocator(How.XPATH, "//lablel"));
                            policiesList = lazyView.getViewValues();
                            for (String policy : policiesList) {
                                policyText.type(policy.trim());
                                checkbox.setLocator(ComponentLocatorFactory.getEqualLocatorByDbgId(policyPrefix + policy.trim()));
                                checkbox.check();
                            }
                        }
                    }
                    if (changePorts) {
                        WebUITextField portText = new WebUITextField(ComponentLocatorFactory.getEqualLocatorByDbgId(portSearch));
                        if (!entry.ports.equalsIgnoreCase("ALL")) {
                            portsList = Arrays.asList(entry.ports.split("(,)"));
                            for (String port : portsList) {
                                portText.type(port.trim());
                                checkbox.setLocator(ComponentLocatorFactory.getEqualLocatorByDbgId(portPrefix + port.trim()));
                                checkbox.check();
                            }
                        } else {
                            LazyView lazyView = new LazyViewImpl(ComponentLocatorFactory.getEqualLocatorByDbgId("VRM_Scope_Selection_policies_" + deviceName), new ComponentLocator(How.XPATH, "//lablel"));
                            portsList = lazyView.getViewValues();
                            for (String port : portsList) {
                                portText.type(port.trim());
                                checkbox.setLocator(ComponentLocatorFactory.getEqualLocatorByDbgId(portPrefix + port.trim()));
                                checkbox.check();
                            }
                        }
                    }
                }
                if (!(entry.virtualServices == null) && !entry.virtualServices.equals("")) {
                    ClickOperationsHandler.clickWebElement(ComponentLocatorFactory.getEqualLocatorByDbgId("scopeSelection_change_" + deviceIp), false);
                    String servicePrefix = "scopeSelection_deviceIP_" + deviceIp + "_portsLabel_";
                    String serviceSearch = "scopeSelection_deviceIP_[" + deviceIp + "]";
                    List<String> servicesList;

                    servicesList = Arrays.asList(entry.virtualServices.split("(,)"));
                    WebUITextField serviceText = new WebUITextField(ComponentLocatorFactory.getEqualLocatorByDbgId(serviceSearch));
                    for (String service : servicesList) {
                        serviceText.type(service.trim());
                        checkbox.setLocator(ComponentLocatorFactory.getEqualLocatorByDbgId(servicePrefix + service.trim()));
                        checkbox.check();
                    }
                }
            });
            //Save Filter
            if (saveFilter != null) {
                VisionDebugIdsManager.setLabel("Device Selection.Save Filter");
                WebUIVisionBasePage.getCurrentPage().getContainer().getWidget("Device Selection.Save Filter").click();
            }

        } catch (
                Exception e) {
            BaseTestUtils.report(e.getMessage(), e);
        }
    }

    /**
     * @param elementsLocator      this the common comparator of all elements list
     * @param targetElementLocator this target comparator of element who we'r seeking about
     *                             this method searches about an element in list - and do scroll to this element
     */
    public void scrollUntilElementDisplayed(ComponentLocator elementsLocator, ComponentLocator targetElementLocator, boolean isScrollElementToTop) {
        if (WebUIUtils.fluentWait(targetElementLocator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME) != null) //if targetElement exist
            return;

        WebElement firstElementInList = WebUIUtils.fluentWait(elementsLocator.getBy());
        if (firstElementInList == null) //if the list is empty
            BaseTestUtils.report("The list is empty", Reporter.FAIL);

        if (!isTargetLocatorExistInList(elementsLocator, targetElementLocator, isScrollElementToTop))
            BaseTestUtils.report("The target Element '" + targetElementLocator.getLocatorValue() + "' is not found", Reporter.FAIL);
        else
            WebUIUtils.scrollIntoView(WebUIUtils.fluentWait(targetElementLocator.getBy()));
    }
    public void scrollUntilElementDisplayed(ComponentLocator elementsLocator, ComponentLocator targetElementLocator)
    {
        scrollUntilElementDisplayed(elementsLocator, targetElementLocator, false);
    }

    /**
     * @param elementsLocator      this the common comparator of all elements list
     * @param targetElementLocator this target comparator of element who we'r seeking about
     * @return true - if the targetElement exist in list
     * false - if the targetElement doesn't exist in list
     * <p>
     * this method do scrolls until find the target element
     */
    protected boolean isTargetLocatorExistInList(ComponentLocator elementsLocator, ComponentLocator targetElementLocator, boolean isScrollElementToTop) {
        List<String> elementsTextsList = new ArrayList();

        while (!isTargetLocatorExist(targetElementLocator)) {
            List<WebElement> elementsShouldBeAddedList = WebUIUtils.fluentWaitMultiple(elementsLocator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME / 2);
            elementsShouldBeAddedList = extractJustNewElements(elementsTextsList, elementsShouldBeAddedList);
            if (elementsShouldBeAddedList.size() == 0) break; // there aren't new elements to add
            for (WebElement element : elementsShouldBeAddedList) {
                elementsTextsList.add(element.getText());
            }
            if (isScrollElementToTop)
                ((JavascriptExecutor)WebUIUtils.getDriver()).executeScript("arguments[0].scrollIntoView();", elementsShouldBeAddedList.get(elementsShouldBeAddedList.size() - 1));
            else WebUIUtils.scrollIntoView(elementsShouldBeAddedList.size() != 0 ? elementsShouldBeAddedList.get(elementsShouldBeAddedList.size() - 1) : null);
        }

        return isTargetLocatorExist(targetElementLocator);
    }

    protected boolean isTargetLocatorExist(ComponentLocator targetElementLocator) {
        return WebUIUtils.fluentWait(targetElementLocator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME / 2) != null;
    }

    /**
     * @param elementsTextsList         list of all texts of the found elements
     * @param elementsShouldBeAddedList list of the new elements that should be added
     * @return return just the new elements - elements their texts aren't found in the elementsTextsList
     */
    protected List<WebElement> extractJustNewElements(List<String> elementsTextsList, List<WebElement> elementsShouldBeAddedList) {
        if (!elementsTextsList.isEmpty()) {
            Collections.reverse(elementsShouldBeAddedList);
            int i = 0;
            for (WebElement element : elementsShouldBeAddedList) {
                if (element.getText().equals(elementsTextsList.get(elementsTextsList.size() - 1)))
                    break;
                i++;
            }
            elementsShouldBeAddedList = elementsShouldBeAddedList.subList(0, i);
            Collections.reverse(elementsShouldBeAddedList);
        }
        return elementsShouldBeAddedList;
    }

    public void validateDevicePolicies(List<DevicesAndPolices> entries) {
        entries.forEach(entry -> {
            String deviceIp = "";
            try {
                deviceIp = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, entry.index).getDeviceIp();
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
            VisionDebugIdsManager.setLabel("Device Selection.Available Device.change");
            VisionDebugIdsManager.setParams(deviceIp);
            WebUIVisionBasePage.getCurrentPage().getContainer().getWidget("").click();

            String policySearch = "scopeSelection_deviceIP_[" + deviceIp + "]_policy_Text";
            WebUITextField policyText = new WebUITextField(ComponentLocatorFactory.getEqualLocatorByDbgId(policySearch));

            List<String> polices = Lists.newArrayList(entry.polices.split(","));
            //validate the polices exist
            for (String policy : polices) {
                policy = policy.trim();
                policyText.type(policy);
                VisionDebugIdsManager.setLabel("Device Selection.Available Device.change.policy");
                VisionDebugIdsManager.setParams(deviceIp, policy);
                if (WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()) == null) {
                    addErrorMessage(String.format("device [%s] ->Expected policy [%s] does not exist", deviceIp, policy));
                    WebUIUtils.generateAndReportScreenshot();
                }
            }
            //count the policies
            int actualPoliciesNumber = new LazyViewImpl(ComponentLocatorFactory.getEqualLocatorByDbgId("VRM_Scope_Selection_policies_DefensePro_" + deviceIp), new ComponentLocator(How.XPATH, "//label")).getViewValues().size();
            if (entry.total.equalsIgnoreCase("All")) {
                CliOperations.runCommand(restTestBase.getRootServerCli(), String.format("mysql -u root -prad123 vision_ng -e \"select * from security_policies_view where device_ip='%s'\" | grep \"Network Protection\" | grep -v + | grep -v ALL | wc -l", deviceIp));
                int totalDpPolicesNumber = Integer.valueOf(CliOperations.lastRow);
                if (String.valueOf(actualPoliciesNumber).equals(totalDpPolicesNumber)) {
                    addErrorMessage(String.format("device [%s] ->Actual polices total number [%s] , Expected \"All =\" [%s]", deviceIp, actualPoliciesNumber, totalDpPolicesNumber));
                    WebUIUtils.generateAndReportScreenshot();
                }
            } else if (!String.valueOf(actualPoliciesNumber).equals(entry.total)) {
                addErrorMessage(String.format("device [%s] ->Actual polices total number [%s] , Expected [%s]", deviceIp, actualPoliciesNumber, entry.total));
                WebUIUtils.generateAndReportScreenshot();
            }
        });
        reportErrors();
    }

    public void validateLineChartRateTime(String rate, String offset, String chart) throws Exception {
        Objects.requireNonNull(chart, "Chart is equal to null");
        JSONArray legends = getLabelsFromData(chart);
        String amount = rate.split("[^(0-9)]")[0].trim();
        String amountType = rate.split("\\d+")[1].trim();

        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

        for (int i = 0; i < legends.length() - 1; i++) {
            LocalDateTime actualNextTime, expectedNextTime;
            try {
                actualNextTime = LocalDateTime.parse((CharSequence) legends.get(i + 1), inputFormatter);
                expectedNextTime = LocalDateTime.parse((CharSequence) legends.get(i), inputFormatter);
            } catch (Exception e) {
                throw new Exception("The Expected time format should be yyyy-MM-dd'T'HH:mm:ss.SSS'Z' but the Actual time is " + legends.get(i + 1));
            }
            expectedNextTime = getLocalDateTime(amount, amountType, expectedNextTime);

            if (offset == null) {
                if (!(actualNextTime.isEqual(expectedNextTime))) {
                    addErrorMessage("The Expected time number [" + (i + 1) + "] is " + expectedNextTime.plusHours(2) + " but the Actual is " + actualNextTime.plusHours(2));
                }
            } else {
                String offsetAmount = offset.split("[^(0-9)]")[0].trim();
                String offsetAmountType = offset.split("\\d+")[1].trim();
                LocalDateTime maxTime = getLocalDateTime(offsetAmount, offsetAmountType, expectedNextTime);
                LocalDateTime minTime = getLocalDateTime("-" + offsetAmount, offsetAmountType, expectedNextTime);
                if (actualNextTime.isAfter(maxTime) || actualNextTime.isBefore(minTime))
                    addErrorMessage("The Expected time number of [" + (i + 1) + "] is more than " + minTime.plusHours(2) + " and less than " + maxTime + " but the Actual is " + actualNextTime.plusHours(2));
            }

        }
        reportErrors();
    }

    protected LocalDateTime getLocalDateTime(String amount, String amountType, LocalDateTime localDateTime) {
        switch (amountType) {
            case "M":
                localDateTime = localDateTime.plusMonths(Integer.parseInt(amount));
            case "d":
                localDateTime = localDateTime.plusDays(Integer.parseInt(amount));
            case "y":
                localDateTime = localDateTime.plusYears(Integer.parseInt(amount));
            case "H":
                localDateTime = localDateTime.plusHours(Integer.parseInt(amount));
            case "m":
                localDateTime = localDateTime.plusMinutes(Integer.parseInt(amount));
            case "s":
                localDateTime = localDateTime.plusSeconds(Integer.parseInt(amount));
        }
        return localDateTime;
    }

    public void uiValidateDataSetsOfChartWithSize(String chart, Integer expectedSize) {
        Objects.requireNonNull(chart, "Chart is equal to null");
        Objects.requireNonNull(expectedSize, "expectedSize is equal to null");
        if (getObjectArraysFromDataSets(chart).length() != expectedSize) {
            BaseTestUtils.report("The ACTUAL size of chart " + chart + " is " + getObjectArraysFromDataSets(chart).length() + " But the EXPECTED is " + expectedSize, Reporter.FAIL);
        }
    }

    public void uiValidateRefreshIntervalForLineChart(String interval, String chart) {
        Objects.requireNonNull(chart, "Chart is equal to null");
        JSONArray legends = getLabelsFromData(chart);
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        LocalDateTime firstTimeBeforeRefresh = LocalDateTime.parse((CharSequence) legends.get(0), inputFormatter);
        String amount = interval.split("[^(0-9)]")[0].trim();
        String amountType = interval.split("\\d+")[1].trim();
        switch (amountType) {
            case "s":
                sleep(Integer.parseInt(amount) * 1000);
                break;
            case "m":
                sleep(Integer.valueOf(amount) * 1000 * 60);
                break;
        }
        LocalDateTime firstTimeAfterRefresh = LocalDateTime.parse((CharSequence) legends.get(0), inputFormatter);
        if (!firstTimeBeforeRefresh.isBefore(firstTimeAfterRefresh)) {
            BaseTestUtils.report("In chart " + chart + " Expected that the first time before the " + interval + " wait, is before the first time after waiting "
                    + interval + ", But the Actual first time before waiting is " + firstTimeBeforeRefresh + " and after waiting is " + firstTimeAfterRefresh, Reporter.FAIL);
        }
    }

    public void uiValidateMaxTimeFrameInLineChartEqualsTo(String chart, String maxIntervalTime, Integer offset) {
        if (offset == null) offset = 0;
        Objects.requireNonNull(chart, "Chart is equal to null");
        JSONArray legends = getLabelsFromData(chart);
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        LocalDateTime firstTime = LocalDateTime.parse(legends.get(0).toString(), inputFormatter);
        LocalDateTime lastTime = LocalDateTime.parse(legends.get(legends.length() - 1).toString(), inputFormatter);
        Duration duration = Duration.between(lastTime, firstTime);
        String amount = maxIntervalTime.split("[^(0-9)]")[0].trim();
        String amountType = maxIntervalTime.split("\\d+")[1].trim();
        switch (amountType) {
            case "m": {
                if (!((Long.valueOf(amount)) >= (Math.abs(duration.toMinutes()) - offset) && (Long.valueOf(amount)) <= (Math.abs(duration.toMinutes()) + offset)))
                    BaseTestUtils.report("The Expected max interval in " + chart + " is " + maxIntervalTime + " but the Actual " + Math.abs(duration.toMinutes()) + " minutes, with offset " + offset, Reporter.FAIL);
                break;
            }
            case "H": {
                if (!((Long.valueOf(amount)) >= (Math.abs(duration.toHours()) - offset) && (Long.valueOf(amount)) <= (Math.abs(duration.toHours()) + offset)))
                    BaseTestUtils.report("The Expected max interval in " + chart + " is " + maxIntervalTime + " but the Actual " + Math.abs(duration.toHours()) + " Hours, with offset " + offset, Reporter.FAIL);
                break;
            }
            case "d": {
                if (!((Long.valueOf(amount)) >= (Math.abs(duration.toDays()) - offset) && (Long.valueOf(amount)) <= (Math.abs(duration.toDays()) + offset)))
                    BaseTestUtils.report("The Expected max interval in " + chart + " is " + maxIntervalTime + " but the Actual " + Math.abs(duration.toDays()) + " days, with offset " + offset, Reporter.FAIL);
                break;
            }
            case "M": {
                if (!(((Long.valueOf(amount)) >= Period.between(firstTime.toLocalDate().plusMonths(offset), lastTime.toLocalDate()).toTotalMonths()) && (Long.valueOf(amount)) <= Period.between(firstTime.toLocalDate().minusMonths(offset), lastTime.toLocalDate()).toTotalMonths()))
                    BaseTestUtils.report("The Expected max interval in " + chart + " is " + maxIntervalTime + " but the Actual " + Period.between(firstTime.toLocalDate(), lastTime.toLocalDate()).toTotalMonths() + " Months, with offset " + offset, Reporter.FAIL);
                break;
            }
        }
    }

    public void uiValidateLineChartDataWithLabelTime(String chart, List<DataTime> entries) {
        Objects.requireNonNull(chart, "Chart is equal to null");
        getObjectFromDataSets(chart);
        JSONArray data = (JSONArray) foundObject.get(DATA);
        JSONArray legends = getLabelsFromData(chart);

        for (DataTime entry : entries) {
            if (entry.offset == null) {
                entry.offset = 0;
            }
            if (entry.countOffset == null) {
                entry.countOffset = 0;
            }
            if (entry.count != null) {
                int count = 0;
                for (int i = 0; i < data.length(); i++) {
                    if (!data.get(i).equals(null)) {
                        if ((Double.valueOf(data.get(i).toString()) >= entry.value - entry.offset) && (Double.valueOf(data.get(i).toString()) <= entry.value + entry.offset))
                            count++;
                    }
                }
                if (entry.count > count + entry.countOffset || entry.count < count - entry.countOffset) {
                    addErrorMessage("The EXPECTED count of value " + entry.value + " is " + entry.count + " but the ACTUAL is " + count + " with offset " + entry.offset + " with countOffset=" + entry.countOffset);
                }
            } else {
                DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("MMM d");
                LocalDateTime expectedTime = TimeUtils.getAddedDate(entry.time);
                int index = -1;
                for (int i = 0; i < legends.length(); i++) {
                    if (legends.get(i).toString().equalsIgnoreCase(expectedTime.format(inputFormatter)))
                        index = i;
                }
                if (index == -1 || index == legends.length()) {
                    scrollAndTakeScreenshot(chart);
                    addErrorMessage("No label with date " + expectedTime.format(inputFormatter));
                } else {
                    if (!((entry.value >= (Double.parseDouble(data.get(index).toString())) - entry.offset) && (entry.value <= (Double.valueOf(data.get(index).toString())) + entry.offset))) {
                        addErrorMessage("In the label " + expectedTime + " The EXPECTED value is " + entry.value + " but the ACTUAL is " + data.get(index) + " with offset " + entry.offset);
                        scrollAndTakeScreenshot(chart);
                    }
                }
            }


        }
        reportErrors();
    }

    public static class DataTime {
        public String time;
        public double value;
        public Integer count;
        public Integer offset;
        Integer countOffset;

        @Override
        public String toString() {
            return "DataTime{" +
                    "time=" + time +
                    ", value=" + value +
                    ", count=" + count +
                    "offset=" + offset +
                    "countOffset=" + countOffset +
                    '}';
        }
    }

    public static class ToggleData {
        String text;
        String value;
        Boolean selected;
    }

    public static class DataSize {
        public int size;
        Integer offset;

        @Override
        public String toString() {
            return "DataSize{" +
                    "size=" + size +
                    ", offset=" + offset +
                    '}';
        }
    }

    public static class DataSets {
        public String attribute, value;

        @Override
        public String toString() {
            return "DataSets{" +
                    "attribute='" + attribute + '\'' +
                    ", value='" + value + '\'' +
                    '}';
        }
    }

    public static class Data {
        public String value;
        Integer count;
        Integer offset;
        Integer min;
        Boolean exist;
        Integer index;
        double valueOffset;

        @Override
        public String toString() {
            return "Data{" +
                    "value='" + value + '\'' +
                    ", count=" + count +
                    ", offset=" + offset +
                    ", exist=" + exist +
                    ", index=" + index +
                    ", valueOffset=" + valueOffset +
                    '}';
        }
    }

    public static class StackBarData {
        public String value;
        Integer offset;
        Boolean exist;
        Boolean legendNameExist;
        String label;
        String legendName;
        Integer count;
        Integer countOffset;
        Integer min;

        @Override
        public String toString() {
            return "Data{" +
                    "value='" + value + '\'' +
                    ", offset=" + offset +
                    ", exist=" + exist +
                    ", label=" + label +
                    ", legendName=" + legendName +
                    ", count=" + count +
                    ", countOffset=" + countOffset +
                    ", legendNameExist=" + legendNameExist +
                    '}';
        }
    }

    public static class PieChart {
        String label, data, backgroundcolor, shapeType, colors, offsetPercentage;
        int offset = 0;
        Boolean exist;

        @Override
        public String toString() {
            return "PieChart{" +
                    "label='" + label + '\'' +
                    ", data='" + data + '\'' +
                    ", backgroundcolor='" + backgroundcolor + '\'' +
                    ", shapeType='" + shapeType + '\'' +
                    ", colors='" + colors + '\'' +
                    ", exist=" + exist +
                    ", offset=" + offset +
                    ", offsetPercentage=" + offsetPercentage +
                    '}';
        }
    }

    public static class DpDeviceFilter {
        public Integer index;
        public String ports;
        public String policies;
        String virtualServices;
    }

    public static class DpApplicationFilter {
        public String name;

        public DpApplicationFilter(String name) {
            this.name = name;
        }
    }

    public static class DfProtectedObject{
        public String name;
        public Integer index;
    }

    public static class DevicesAndPolices {
        int index;
        String polices, total;
    }

    public static class Polices {
        public Integer index;
        public String policies;
        public Boolean isExist;
    }

    public static class LabelParam {
        protected String param = "";
        protected String label = "";
        public boolean exist;

        public String getDataDebugId() {
            VisionDebugIdsManager.setLabel(label);
            VisionDebugIdsManager.setParams(param);
            return VisionDebugIdsManager.getDataDebugId();
        }

        public String getLabel() {
            return label;
        }

        public String getParam() {
            return param;
        }

    }

    /**
     * function select a range in the char.
     *
     * @param fromIndex - is an index of label in the session storage.
     * @param toIndex   - is an index of label in the sesison storage
     * @param chart     - chart name
     * @parm timeFormat
     */
    public void selectTimeFromTo(int fromIndex, int toIndex, String chart, String timeFormat) {
        try {
            Objects.requireNonNull(chart, "Chart is equal to null");
            JSONArray dataArray;
            Map jsonMap = getSessionStorage(chart);
            jsonMap = JsonUtils.getJsonMap(jsonMap.get(DATA));
            dataArray = (JSONArray) jsonMap.get(LABELS);
            DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern(timeFormat != null ? timeFormat : "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

            if (dataArray.length() < toIndex)
                BaseTestUtils.report("There is no Enough data in Session Storage", Reporter.FAIL);
            LocalDateTime from = LocalDateTime.parse((CharSequence) dataArray.get(fromIndex), inputFormatter);
            LocalDateTime to = LocalDateTime.parse((CharSequence) dataArray.get(toIndex), inputFormatter);
            VisionDebugIdsManager.setLabel("Traffic Bandwidth FromTo");
            VisionDebugIdsManager.setParams("from");
            WebElement firstElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            JavascriptExecutor executor = (JavascriptExecutor) WebUIUtils.getDriver();
            executor.executeScript("arguments[1].value = arguments[0]; ", Timestamp.valueOf(from).getTime(), firstElement);

            VisionDebugIdsManager.setParams("to");
            WebElement secondElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            executor.executeScript("arguments[1].value = arguments[0]; ", Timestamp.valueOf(to).getTime(), secondElement);
            WebElement button = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId("qa-call-attacks-dialog").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            executor.executeScript("arguments[0].click(); ", button);

        } catch (Exception e) {
            BaseTestUtils.report("Could not select time: " + e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Clears either session or local storage
     *
     * @param storageType - storage type - valid values: "Local"|Session"
     */
    public void clearStorageByType(String storageType) {
        try {
            switch (storageType) {
                case "Session":
                    this.sessionStorage.clear();
                    break;
                case "Local":
                    this.localStorage.clear();
                    break;
                default:
                    BaseTestUtils.report("No such storage type as: " + storageType, Reporter.FAIL);
                    break;
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public void validateMemoryUtilization() throws Exception {
        RootServerCli rootServerCli = new RootServerCli(restTestBase.getRootServerCli().getHost(), restTestBase.getRootServerCli().getUser(), restTestBase.getRootServerCli().getPassword());
        rootServerCli.init();
        InvokeUtils.invokeCommand(null, "yum install stress", rootServerCli, 3 * 60 * 1000, true);
        InvokeUtils.invokeCommand(null, "sudo yum install -y epel-release", rootServerCli, 3 * 60 * 1000, true);
        InvokeUtils.invokeCommand(null, "sudo yum install -y stress", rootServerCli, 3 * 60 * 1000, true);
        CliOperations.runCommand(rootServerCli, "free");
        int number;
        String warningRising;
        String warningFalling;
        String errorRising;
        String errorFalling;
        try {
            String[] a = rootServerCli.getCmdOutput().get(1).split("\\s+");
            double num = Double.parseDouble(a[2]) / Double.parseDouble(a[1]);
            number = (int) (num * 100);
            if (number >= 85)
                number = 85;
            warningRising = String.valueOf(number + 5);
            warningFalling = String.valueOf(number + 2);
            errorRising = String.valueOf(number + 10);
            errorFalling = String.valueOf(number + 7);
        } catch (IndexOutOfBoundsException e) {
            throw new Exception(" the index out of bound , output of command is not correct ");
        }

        changeValuesMemoryUtilization(warningRising, errorRising, warningFalling, errorFalling);
        InvokeUtils.invokeCommand(null, "stress  --vm 1 --vm-bytes 9G --vm-hang 30 --timeout 3m", rootServerCli, 4 * 60 * 1000, true, false, true);
        Thread.sleep(60 * 1000);
        WebUIUtils.fluentWaitClick((new ComponentLocator(How.ID, "gwt-debug-Global_Refresh")).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        WebUIUtils.fluentWaitClick((new ComponentLocator(How.ID, "gwt-debug-AlertsMaximize")).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

        // validate rising error alert (major) and falling (info)
        WebElement fallingWarningElement = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//tr[contains(@id,'gwt-debug-alerts')and //div[contains(text(),'Falling: Memory utilization is normal')] and .//div[contains(text(),'Info')]]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        WebElement risingErrorElement = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//tr[contains(@id,'gwt-debug-alerts')and //div[contains(text(),'Rising: Memory utilization is high')] and .//div[contains(text(),'Major')]]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (risingErrorElement == null || fallingWarningElement == null)
            BaseTestUtils.report("Failed to get Rising memory error (major) or falling info", Reporter.FAIL);

        WebUIUtils.fluentWaitClick((new ComponentLocator(How.ID, "gwt-debug-ConfigTab_EDIT_AlertBrowser.Alerts_Submit")).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        changeValuesMemoryUtilization(warningRising, "99", String.valueOf(number - 10), "99");
        InvokeUtils.invokeCommand(null, "stress  --vm 1 --vm-bytes 6G --vm-hang 30 --timeout 3m", rootServerCli, 4 * 60 * 1000, true, false, true);
        Thread.sleep(60 * 1000);
        WebUIUtils.fluentWaitClick((new ComponentLocator(How.ID, "gwt-debug-Global_Refresh")).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        WebUIUtils.fluentWaitClick((new ComponentLocator(How.ID, "gwt-debug-AlertsMaximize")).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

        // validate rising warning alert (minor) and falling (warning)
        WebElement risingWarningElement = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//tr[contains(@id,'gwt-debug-alerts')and //div[contains(text(),'Rising: Memory utilization is high')] and .//div[contains(text(),'Minor')]]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (risingWarningElement == null)
            BaseTestUtils.report("Failed to get Rising memory warning (minor) ", Reporter.FAIL);

        WebUIUtils.fluentWaitClick((new ComponentLocator(How.ID, "gwt-debug-ConfigTab_EDIT_AlertBrowser.Alerts_Submit")).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        changeValuesMemoryUtilization(warningRising, errorRising, String.valueOf(number - 10), "90");
        InvokeUtils.invokeCommand(null, "stress  --vm 1 --vm-bytes 9G --vm-hang 30 --timeout 3m", rootServerCli, 4 * 60 * 1000, true, false, true);
        Thread.sleep(60 * 1000);

        WebUIUtils.fluentWaitClick((new ComponentLocator(How.ID, "gwt-debug-Global_Refresh")).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        WebUIUtils.fluentWaitClick((new ComponentLocator(How.ID, "gwt-debug-AlertsMaximize")).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
//       // validate falling (warning)
        WebElement fallingErrorElement = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//tr[contains(@id,'gwt-debug-alerts')and //div[contains(text(),'Falling: Memory utilization is normal')] and .//div[contains(text(),'Warning')]]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (fallingErrorElement == null)
            BaseTestUtils.report("Failed to get Falling memory Warning ", Reporter.FAIL);
    }

    protected void changeValuesMemoryUtilization(String warningRising, String errorRising, String warningFalling, String errorFalling) {
        if (WebUIUtils.fluentWait(new ComponentLocator(How.ID, "gwt-debug-ConfigTab_EDIT_AlertBrowser.Alerts_Submit").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false) != null)
            WebUIUtils.fluentWaitClick((new ComponentLocator(How.ID, "gwt-debug-ConfigTab_EDIT_AlertBrowser.Alerts_Submit")).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        WebUIUtils.fluentWaitClick(new ComponentLocator(How.XPATH, "//*[contains(@id,'CellID_parameterName')]//div[contains(text(),'MEMORY')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        WebUIUtils.fluentWaitClick((new ComponentLocator(How.ID, "gwt-debug-WarningThresholdsEntry_EDIT")).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        BasicOperationsHandler.setCheckboxById("gwt-debug-enabled_Widget-input", true);
        ClickOperationsHandler.setTextToElement(WebElementType.Id, "gwt-debug-risingWarningThreshold_Widget", warningRising, false);
        ClickOperationsHandler.setTextToElement(WebElementType.Id, "gwt-debug-fallingWarningThreshold_Widget", warningFalling, false);
        ClickOperationsHandler.setTextToElement(WebElementType.Id, "gwt-debug-risingErrorThreshold_Widget", errorRising, false);
        ClickOperationsHandler.setTextToElement(WebElementType.Id, "gwt-debug-fallingErrorThreshold_Widget", errorFalling, false);
        WebUIUtils.fluentWaitClick((new ComponentLocator(How.ID, "gwt-debug-ConfigTab_EDIT_WarningThresholdsEntry_Submit")).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

    }


    public static void innerChangePoliciesOfSelectDevice(String deviceIp) throws Exception {
        //ALL Button
        String selectAllCheckBox = "Device Selection.All Devices Selection";
        VisionDebugIdsManager.setLabel(selectAllCheckBox);
        WebUICheckbox checkbox = new WebUICheckbox(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
//            To Clear previous settings
        if (checkbox.isChecked()) {
            checkbox.uncheck();
        }

        //select the device
        checkbox.setLocator(ComponentLocatorFactory.getEqualLocatorByDbgId("scopeSelection_deviceIP_" + deviceIp + "_Label"));
        checkbox.check();
        ClickOperationsHandler.clickWebElement(ComponentLocatorFactory.getEqualLocatorByDbgId("scopeSelection_change_" + deviceIp), false);


    }


    public void innerSelectDeviceWithPoliciesAndPortsTest(List<Polices> entries) {
        try {
            //ALL Button
            String selectAllCheckBox = "Device Selection.All Devices Selection";
            VisionDebugIdsManager.setLabel(selectAllCheckBox);
            WebUICheckbox checkbox = new WebUICheckbox(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
            entries.forEach(entry -> {
                String deviceIp = null;
                try {
                    if (entry.index == null) {
                        throw new Exception("Index entry is empty please enter it!");
                    } else {
                        deviceIp = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, entry.index).getDeviceIp();
                    }

                } catch (Exception e) {
                    BaseTestUtils.report(e.getMessage(), e);
                }
                boolean changePolicies = entry.policies != null && !entry.policies.equals("");
                boolean isExist = entry.isExist;
                if (changePolicies) {
                    String policyPrefix = "scopeSelection_deviceIP_" + deviceIp + "_policiesLabel_";
                    String policySearch = "scopeSelection_deviceIP_[" + deviceIp + "]_policy_Text";
                    List<String> policiesList;
                    if (changePolicies) {
                        WebUITextField policyText = new WebUITextField(ComponentLocatorFactory.getEqualLocatorByDbgId(policySearch));
                        if (!entry.policies.equalsIgnoreCase("ALL")) {
                            policiesList = Arrays.asList(entry.policies.split("(,)"));
                            for (String policy : policiesList) {
                                policyText.type(policy.trim());
                                // WebUIUtils.scrollIntoView(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
                                if (!isExist) {
                                    if (WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualLocatorByDbgId(policyPrefix + policy.trim()).getBy()) != null) {
                                        // addErrorMessage(String.format("device [%s] ->Expected policy [%s] does exist", deviceIp, policy));
                                        BaseTestUtils.report("Expected policy: " + policy + " does exist", Reporter.FAIL);
                                        WebUIUtils.generateAndReportScreenshot();
                                    }
                                }
                                if (isExist) {
                                    if (!WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualLocatorByDbgId(policyPrefix + policy.trim()).getBy()).isDisplayed()) {
                                        BaseTestUtils.report("Expected policy: " + policy + " does not exist", Reporter.FAIL);
                                        WebUIUtils.generateAndReportScreenshot();
                                    }
                                }

                            }
                        } else {
                            LazyView lazyView = new LazyViewImpl(ComponentLocatorFactory.getEqualLocatorByDbgId("VRM_Scope_Selection_policies_DefensePro_" + deviceIp), new ComponentLocator(How.XPATH, "//lablel"));
                            policiesList = lazyView.getViewValues();
                            for (String policy : policiesList) {
                                policyText.type(policy.trim());
                                checkbox.setLocator(ComponentLocatorFactory.getEqualLocatorByDbgId(policyPrefix + policy.trim()));
                                checkbox.check();
                            }
                        }
                    }
                }
            });

        } catch (
                Exception e) {
            BaseTestUtils.report(e.getMessage(), e);
        }
    }

    public void innerSelectDeviceWithPoliciesAndPortsTestClickChange(SUTDeviceType deviceType, List<DpDeviceFilter> entries) {
        try {
            //ALL Button
            String selectAllCheckBox = "Device Selection.All Devices Selection";
            VisionDebugIdsManager.setLabel(selectAllCheckBox);
            WebUICheckbox checkbox = new WebUICheckbox(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()));
//            To Clear previous settings
            checkbox.check();
            if (!entries.isEmpty())
                checkbox.uncheck();

            entries.forEach(entry -> {
                String deviceIp = null;
                try {
                    if (entry.index == null) {
                        throw new Exception("Index entry is empty please enter it!");
                    }
                    if (deviceType == null) {
                        deviceIp = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, entry.index).getDeviceIp();
                    } else {
                        deviceIp = devicesManager.getDeviceInfo(deviceType, entry.index).getDeviceIp();
                    }

                } catch (Exception e) {
                    BaseTestUtils.report(e.getMessage(), e);
                }
                //select the device
                checkbox.setLocator(ComponentLocatorFactory.getEqualLocatorByDbgId("scopeSelection_deviceIP_" + deviceIp + "_Label"));
                checkbox.check();
                ClickOperationsHandler.clickWebElement(ComponentLocatorFactory.getEqualLocatorByDbgId("scopeSelection_change_" + deviceIp), false);
            });

        } catch (
                Exception e) {
            BaseTestUtils.report(e.getMessage(), e);
        }
    }

}
