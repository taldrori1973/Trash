package com.radware.vision.bddtests.VRM;

import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Report;
import com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection.enums.QuickRange;
import com.radware.vision.infra.testhandlers.vrm.VRMHandler;
import com.radware.vision.infra.testhandlers.vrm.VRMHandler.*;
import com.radware.vision.infra.testhandlers.vrm.VRMReportsHandler;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.List;


public class VRMSteps {

    private VRMHandler vrmHandler = new VRMHandler();
    private VRMReportsHandler vrmReportsHandler = new VRMReportsHandler();


    @Then("^UI Validate (?:column chart \"([^\"]*)\" for )?Line Chart attributes \"([^\"]*)\" with Label \"([^\"]*)\"$")
    public void uiValidateLineChartAttributes(String columnChart, String chart, String label, List<DataSets> entries) {
        vrmHandler.validateChartDataSets(chart, label, columnChart, entries);
    }

    @Then("^UI Validate StackBar data with widget \"([^\"]*)\"$")
    public void uiValidateStackBarDataWithWidget(String chart, List<StackBarData> entries) {
        vrmHandler.validateStackBarData(chart, entries);
    }

    @Then("^UI Validate StackBar Timedata with widget \"([^\"]*)\"$")
    public void uiValidateStackBarTimedataWithWidget(String chart, List<StackBarData> entries) {
        vrmHandler.uiValidateStackBarTimeDataWithWidget(chart, entries);
    }

    @Then("^UI Validate VRM Report Existence by Name \"(.*)\" if Exists \"(true|false)\"$")
    public void validateVRMReportExistenceByName(String reportName, boolean isExists) {
        vrmReportsHandler.validateVRMReport(reportName, isExists);
    }

    @Then("^UI validate Quick Range between Starting Date \"([^\"]*)\" End Date \"([^\"]*)\" with QuickRange \"([^\"]*)\"(?: with time Format \"([^\"]*)\")?(?: by error threshold in minutes \"([^\"]*)\")?$")
    public void validateDate(String startingLabel, String endLabel, String quickRange, String timeFormat, String thresholdInMinutes) {
        vrmReportsHandler.validateQuickRange(startingLabel, endLabel, QuickRange.getQuickRangeEnum(quickRange), timeFormat, thresholdInMinutes);
    }

    @Then("^UI Validate (?:column chart \"([^\"]*)\" for )?Line Chart data \"([^\"]*)\" with Label \"([^\"]*)\"$")
    public void uiValidateLineChartData(String columnChart, String chart, String label, List<Data> entries) {
        vrmHandler.validateChartDataOfDataSets(chart, label, columnChart, entries);
    }

    @Then("^UI Validate Pie Chart attributes \"([^\"]*)\"$")
    public void uiValidatePieChartAttributes(String chart, List<DataSets> entries) {
        /*without validate*/
        vrmHandler.validatePieChartDataSets(chart, entries);
    }

    @Then("^UI Validate Pie Chart data \"([^\"]*)\"$")
    public void uiValidatePieChartData(String chart, List<PieChart> entries) {
        vrmHandler.validatePieChartDataOfDataSets(chart, entries);
    }

    @Then("^UI Total Pie Chart data \"([^\"]*)\"$")
    public void uiTotalPieChartData(String chart, List<DataSize> entries) {
        vrmHandler.validatePieChartDataOfDataSetsSize(chart, entries);
    }

    @Then("^UI Total (?:column chart \"([^\"]*)\" for )?Line Chart data \"([^\"]*)\" With Label \"([^\"]*)\"$")
    public void uiTotalLineChartDataWithLabel(String columnChart, String chart, String label, List<DataSize> entries) {
        vrmHandler.validateLineChartDataOfDataSetsSize(chart, label, columnChart, entries);

    }

    /**
     * Select DP devices by their SUT index
     * if entries is empty , it will select all the devices
     *
     * @param saveFilter - optional parameter to save the filter
     * @param entries    - DpDeviceFilter class index, ports and policies
     */
    @When("^UI VRM Select device from dashboard( and Save Filter)?(?: device type \"(.*)\")?$")
    public void selectDeviceWithPoliciesAndPorts(String saveFilter, SUTDeviceType deviceType, List<DpDeviceFilter> entries) {
        vrmHandler.innerSelectDeviceWithPoliciesAndPorts(saveFilter, deviceType, entries, true);
    }

    @When("^UI Select device from dashboard(?: device type \"(.*)\")?$")
    public void selectDeviceWithPolicies(SUTDeviceType deviceType, List<DpDeviceFilter> entries) {
        vrmHandler.innerSelectDeviceWithPoliciesAndPortsTestClickChange(deviceType, entries);
    }

    @Then("^UI validate if policy is Exist$")
    public void validatepolicyIsExist(List<Polices> entries) {
        vrmHandler.innerSelectDeviceWithPoliciesAndPortsTest(entries);
    }

    /**
     * @param entries Table of type DevicesAndPolices
     *                if entries.total can be absolute number or equalsIgnoreCase to "All" , in case it equal to "All"
     *                rest
     */
    @Then("^UI VRM Validate Devices policies$")
    public void uiVRMValidateDevicesPolicies(List<DevicesAndPolices> entries) {
        vrmHandler.validateDevicePolicies(entries);
    }

    @When("^UI VRM Drag And Drop \"([^\"]*)\" chart with X offset (-?\\d+) and Y offset (-?\\d+)$")
    public void dragAndDropVRMChart(String elementName, int xOffset, int yOffset) {
        vrmHandler.dragAndDropVRMChart(elementName, xOffset, yOffset);
    }

    @When("^UI VRM Resize \"([^\"]*)\" chart with X offset (-?\\d+) and Y offset (-?\\d+)$")
    public void resizeVRMChart(String elementName, int xOffset, int yOffset) {
        vrmHandler.resizeVRMChart(elementName, xOffset, yOffset);
    }

    /**
     * check if the current available devices match the given value
     *
     * @param totalNumOfDevices - The total number of expected devices
     */
    @Then("^UI VRM Total Available Device's (\\d+)$")
    public void uiVRMTotalAvailableDeviceS(int totalNumOfDevices) {
        vrmHandler.uiVRMTotalAvailableDeviceS(totalNumOfDevices);
    }

    /**
     * Select widget from the widgets repository and add them.
     *
     * @param entries - List of widgets to add
     */
    @When("^UI VRM Select Widgets$")
    public void uiVRMSelectWidgets(List<String> entries) {
        vrmHandler.uiVRMSelectWidgets(entries);
    }

    /**
     * Clear all widgets.
     * must have in property file "Clear Dashboard" and "Remove All Confirm"
     */
    @When("^UI VRM Clear All Widgets$")
    public void uiVRMSelectWidgets() {
        vrmHandler.uiVRMSelectWidgets(null);
    }

    /**
     * works both in pie chart and stack bar
     *
     * @param chart - Session storage key
     * @param total - The expected number of labels in the chart
     */
    @Then("^UI Total \"(.*)\" legends equal to (\\d+)$")
    public void uiTotalLegendsEqualTo(String chart, int total) {
        vrmHandler.ValidateTotalLegends(chart, total);
    }

    /**
     * Validate the existence of session storage element
     *
     * @param sessionStorage - session storage name
     * @param isExist        - is expected
     */
    @Then("^UI Validate Session Storage \"(.*)\" exists \"(true|false)\"$")
    public void isSessionStorageExists(String sessionStorage, Boolean isExist) {
        vrmHandler.isSessionStorageExists(sessionStorage, isExist);
    }

    /**
     * Remove Session Storage
     *
     * @param sessionStorage - label
     */
    @When("^UI Remove Session Storage \"(.*)\"$")
    public void removeSessionStorage(String sessionStorage) {
        vrmHandler.removeSessionStorage(sessionStorage);
    }


    @And("^UI Select scope from dashboard and Save Filter device type \"([^\"]*)\"$")
    public void uiVRMSelectApplicationFromDashboardAndSaveFilterDeviceType(String deviceType, List<DpApplicationFilter> entries) throws Exception {
        vrmHandler.selectApplications(entries,deviceType, true);
    }

    @Then("^UI Validate Line Chart rate time with \"([^\"]*)\"(?: with offset \"([^\"]*)\")? for \"([^\"]*)\" chart$")
    public void uiValidateLineChartRateTimeWithForWidget(String rate, String offset, String chart) throws Exception {
        vrmHandler.validateLineChartRateTime(rate, offset, chart);
    }

    @Then("^UI validate dataSets of lineChart \"([^\"]*)\" with size \"([^\"]*)\"$")
    public void uiValidateDataSetsOfChartWithSize(String chart, String size) {
        vrmHandler.uiValidateDataSetsOfChartWithSize(chart, Integer.valueOf(size));
    }

    @Then("^UI validate refresh interval of \"([^\"]*)\" for Line chart \"([^\"]*)\"$")
    public void uiValidateRefreshIntervalForLineChart(String interval, String chart) {
        vrmHandler.uiValidateRefreshIntervalForLineChart(interval, chart);
    }

    @Then("^UI validate max time frame in line chart \"([^\"]*)\" equals to \"([^\"]*)\"(?: with offset \"([^\"]*)\")?$")
    public void uiValidateMaxTimeFrameInLineChartEqualsTo(String chart, String maxIntervalTime, Integer offset) {
        vrmHandler.uiValidateMaxTimeFrameInLineChartEqualsTo(chart, maxIntervalTime, offset);
    }

    @Then("^UI Validate Line Chart data \"([^\"]*)\" with LabelTime$")
    public void uiValidateLineChartDataWithLabelTime(String chart, List<DataTime> entries) {
        vrmHandler.uiValidateLineChartDataWithLabelTime(chart, entries);
    }

    @Then("^UI Select Time From: (\\d+) To: (\\d+) Time, in Line Chart data \"([^\"]*)\"(?: with timeFormat \"([^\"]*)\")?$")
    public void uiSelectFromTo(int from, int to, String chart, String timeFormat) {
        vrmHandler.selectTimeFromTo(from, to, chart, timeFormat);
    }

    /**
     * Clears storage by type
     *
     * @param storageType - valid values "Local" or "Session"
     */
    @Given("^UI clear (Session|Local) storage")
    public void clearStorageByType(String storageType) {
        vrmHandler.clearStorageByType(storageType);
    }

    @Then("^Validate Memory Utilization$")
    public void validateMemoryUtilization() throws Exception {
        vrmHandler.validateMemoryUtilization();
    }


    @Then("^Validate Line Chart data \"([^\"]*)\" with Label \"([^\"]*)\" in report \"([^\"]*)\"$")
    public void validateLineChartDataWithLabelInReport(String chart, String label, String reportName,  List<VRMHandler.Data> entries) throws Throwable {
        new Report().getVRMReportsChartsHandler(reportName).validateChartDataOfDataSets(chart, label, null, entries);
    }

    @Then("^UI Validate StackBar data with widget \"([^\"]*)\" in report \"([^\"]*)\"$")
    public void uiValidateStackBarDataWithWidgetInReport(String chart, String reportName, List<StackBarData> entries) throws Throwable {
        new Report().getVRMReportsChartsHandler(reportName).validateStackBarData(chart, entries);
    }

    @Then("^UI Validate Pie Chart data \"([^\"]*)\" in Report \"([^\"]*)\"$")
    public void uiValidatePieChartDataInReport(String chart, String reportName, List<PieChart> entries) throws Throwable {
        new Report().getVRMReportsChartsHandler(reportName).validatePieChartDataOfDataSets(chart, entries);
    }
}

