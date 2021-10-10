package com.radware.vision.bddtests.basicoperations;

import com.radware.automation.react.widgets.impl.enums.TableSortingCriteria;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.impl.table.BasicTable;
import com.radware.automation.webui.widgets.impl.table.BasicTableWithPagination;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.jsonparsers.impl.JsonUtils;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.enums.DeviceDriverType;
import com.radware.vision.infra.enums.FindByType;
import com.radware.vision.infra.enums.PopupDialogBoxTexts;
import com.radware.vision.infra.testhandlers.DPM.VirtsTableHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsByNameIdHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.TableHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.SortableColumn;
import com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.SortingDataSet;
import com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.TableSortingHandler;
import com.radware.vision.infra.testhandlers.vrm.VRMHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.tests.GeneralOperations.ByLabelValidations;
import cucumber.api.java.en.Then;
import org.json.JSONArray;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import static com.radware.vision.automation.invocation.InvokeMethod.invokeMethod;
import static com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler.setTextField;
import static com.radware.vision.infra.utils.ReportsUtils.addErrorMessage;

public class BasicValidationsTests extends VisionUITestBase {

    BasicOperationsByNameIdHandler basicOperationsByNameIdHandler = new BasicOperationsByNameIdHandler();
    TableHandler tableHandler = new TableHandler();
    VirtsTableHandler virtsTableHandler = new VirtsTableHandler();
    ByLabelValidations byLabelValidations = new ByLabelValidations();

    public BasicValidationsTests() throws Exception {
    }

    /**
     * @param label - element labal
     * @param isEnabled - element's expected status
     */
    @Then("^UI Validate Element EnableDisable status By Label \"([^\"]*)\"(?: and Value \"([^\"]*)\")? is Enabled \"(true|false)\"$")
    public void validateElementEnableDisableStatus(String label, String value, Boolean isEnabled) {
        ClickOperationsHandler.validateElementEnableDisableStatusByLabel(label, value, isEnabled);
    }

    /**
     * @param label - element labal
     * @param isExists - element's existance state
     */
    @Then("^UI Validate Element Existence By Label \"(.*)\" if Exists \"(true|false)\"(?: with value \"(.*)\")?$")
    public void validateElementExistenceByLabel(String label, Boolean isExists, String param) {
        BasicOperationsHandler.isElementFounds(label, isExists, param);
    }

    @Then("^UI Validate Element Existence By GWT id \"(.*)\" if Exists \"(true|false)\"(?: with value \"(.*)\")?$")
    public void validateElementExistenceByGwtId(String label, Boolean isExists, String param) {
        BasicOperationsHandler.isGwtElementExists(label, isExists, param);
    }

    @Then("^UI Validate Element Selection By Label \"(.*)\" if Exists \"(true|false)\"(?: with value \"(.*)\")?$")
    public void validateElementSelectionByLabel(String label, Boolean isExists, String param) {
        BasicOperationsHandler.isElementSelected(label, isExists, param);
    }

    @Then("^UI Validate Text field \"([^\"]*)\"(?: with params \"([^\"]*)\")?(?: On Regex \"([^\"]*)\")? (EQUALS|CONTAINS|MatchRegex|GT|GTE|LT|LTE) \"(.*)\"(?: cut Characters Number (\\S+))?(?: with offset (\\S+))?$")
    public void validateTextFieldElement(String selectorValue, String params, String regex, OperatorsEnum operatorsEnum, String expectedText, String cutCharsNumber, String offset) {
            try {
                if(params.contains("#")) {
                    params = params.replaceAll("#.*;", (String) invokeMethod(params));
                }
                if(expectedText.contains("#"))
                    expectedText = expectedText.replaceAll("#.*;", (String) invokeMethod(expectedText));
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }

        cutCharsNumber = cutCharsNumber == null ? "0" : cutCharsNumber;//this parameter can be used for equals or contains of String from char 0 until char cutCharsNumber
        expectedText = expectedText.equals("") ? getRetrievedParamValue() : expectedText;
        ClickOperationsHandler.validateTextFieldElementByLabel(selectorValue, params, expectedText, regex, operatorsEnum, Integer.parseInt(cutCharsNumber),offset);
    }


    @Then("^Validate Expand \"([^\"]*)\" Table with label \"([^\"]*)\" Equals to \"([^\"]*)\"$")
    public void validateExtendTable(String tableName, String label, String value) {
        BasicOperationsHandler.isTextEqualValue(label, value, tableName);

    }

    @Then("^UI Validate Text field by id \"([^\"]*)\" (EQUALS|CONTAINS) \"(.*)\"(?: cut Characters Number (\\S+))?(?: with offset (\\\\S+))?$")
    public void validateTextFieldElementbyId(String selectorValue, OperatorsEnum operatorsEnum, String expectedText, String cutCharsNumber, String offset) {
        cutCharsNumber = cutCharsNumber == null ? "0" : cutCharsNumber;
        expectedText = expectedText.equals("") ? getRetrievedParamValue() : expectedText;
        ClickOperationsHandler.validateTextFieldElementById(selectorValue, expectedText, operatorsEnum, Integer.parseInt(cutCharsNumber),offset);
    }

    @Then("^UI Validate Popup Dialog Box, have value \"(.*)\" with text Type \"(CAPTION|MESSAGE)\"$")
    public void validatePopupTextFieldElement(String expectedText, PopupDialogBoxTexts popupDialogBoxTexts) {
        BasicOperationsHandler.validatePopupMessageText(expectedText, popupDialogBoxTexts.getByTextType());
    }


    @Then("^UI validate Table RecordsCount \"(.*)\" with Identical ColumnValue \"(.*)\" by columnKey \"(.*)\" by elementLabelId \"(.*)\" by deviceDriverType \"(VISION|DEVICE)\" findBy Type \"(BY_NAME|BY_ID)\"$")
    public void validateTableRecordsNumberWithIdenticalColumnValue(String expectedRecordsNumber, String columnValue, String columnKey, String elementLabelId, DeviceDriverType deviceDriverType, FindByType findByType) {
        try {
            int actualRowAmount = basicOperationsByNameIdHandler.getRowsAmountByKeyValue(deviceDriverType.getDDType(), elementLabelId, columnKey, columnValue, findByType);
            if (actualRowAmount != Integer.valueOf(expectedRecordsNumber)) {
                BaseTestUtils.report("Records number by KeyValue validation has Failed : actualRowAmount = " + actualRowAmount + " expectedRecordsNumber: " + expectedRecordsNumber, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Records number by KeyValue validation has Failed : ", Reporter.FAIL);
        }
    }

    @Then("^UI validate Table RecordsCount per Page \"(.*)\" with Device Driver Type \"(VISION|DEVICE)\" by elementNameId \"(.*)\" findBy Type \"(BY_NAME|BY_ID)\"$")
    public void validateTableRecordsNumberPerPage(String expectedRecordsNumber, DeviceDriverType deviceDriverType, String elementNameId, FindByType findByType) {
        try {
            int actualRowAmount = basicOperationsByNameIdHandler.getRowsAmountPerPage(deviceDriverType.getDDType(), elementNameId, findByType);
            if (actualRowAmount != Integer.valueOf(expectedRecordsNumber)) {
                BaseTestUtils.report("Records number by KeyValue validation has Failed : actualRowAmount = " + actualRowAmount + " expectedRecordsNumber: " + expectedRecordsNumber, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Records number by KeyValue validation has Failed : ", Reporter.FAIL);
        }
    }

    @Then("^UI Validate Table record values by columns with elementLabel \"([^\"]*)\"(?: with extension (\\S+))?(?: findBy index (\\d+))?(?: findBy columnName \"([^\"]*)\")?(?: findBy cellValue \"([^\"]*)\")?$")
    public void validateTableRecordValuesByColumnName(String elementLabel, String extension, Integer index, String columnName, String cellValue, List<WebUITable.TableDataSets> cells) {
        int rowIndex = index != null ? index : -1;
        tableHandler.validateTableRecordByContent(elementLabel, columnName, cellValue, cells, rowIndex, extension);
    }

    @Then("^UI Validate Total Summary Table \"([^\"]*)\"$")
    public void uiValidateTotalSummaryTableWithWidget(String TableName) throws Throwable {
        float sum =0;
        sum = tableHandler.sumColOfTableByTableName(TableName);
        VisionDebugIdsManager.setLabel("Top Attack Total");
        String element = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).getText();
        if (element == null)
            BaseTestUtils.report("no Element with locator: " + ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()), Reporter.FAIL);
        float actualSum = Float.parseFloat(element.replaceAll("[^\\d.]", ""));
        if(actualSum !=sum){
            addErrorMessage("The total have to be eqaual to " + sum + ", not " + actualSum);
        }
    }

    @Then("^UI Validate Table record tooltip values with elementLabel \"([^\"]*)\"(?: with extension (\\S+))?(?: findBy index (\\d+))?(?: findBy columnName \"([^\"]*)\")?(?: findBy cellValue \"([^\"]*)\")?$")
    public void validateTableRecordTooltipValuesByColumnName(String elementLabel, String extension, Integer index, String columnName, String cellValue, List<WebUITable.TableDataSets> cells) {
        int rowIndex = index != null ? index : -1;
        tableHandler.validateTableRecordTooltipContent(elementLabel, columnName, cellValue, cells, rowIndex, extension);
    }

    @Then("^UI Validate \"(.*)\" Table rows count (EQUALS|NOT_EQUALS|CONTAINS|GT|GTE|LT|LTE) to (\\d+)(?: with offset (\\d+))?$")
    public void validateTableRowsCount(String elementLabel, OperatorsEnum operatorsEnum, int count, Integer offset) {
        tableHandler.validateTableRowsCount(elementLabel, count, operatorsEnum, offset);
    }

    @Then("^UI validate Table row by keyValue with elementLabel \"([^\"]*)\" findBy columnName \"([^\"]*)\" findBy cellValue \"([^\"]*)\"( negative)?$")
    public void validateTableRowByKeyValue(String elementLabel, String columnName, String cellValue, String negative) {
        try {
            tableHandler.validateTableRowByKeyValue(elementLabel, columnName, cellValue);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI validate Vision Table row by keyValue with elementLabel \"([^\"]*)\" findBy columnName \"([^\"]*)\" findBy(?: cellValue \"([^\"]*)\"| date value \"([\\+|\\-]\\d+[d|M|Y])\"(?: with format \"([^\"]*)\")?)?$")
    public void validateVisionTableRowByKeyValue(String elementLabel, String columnName, String cellValue, String dateValue, String format) {
        if (dateValue != null) {
            DateTimeFormatter inputFormatter;
            if (format != null)
                inputFormatter = DateTimeFormatter.ofPattern(format);
            else inputFormatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
            LocalDateTime fromLocalDate = TimeUtils.getAddedDate(dateValue);
            cellValue = fromLocalDate.format(inputFormatter);
        }
        if (!byLabelValidations.validateTableRecord(WebUIUtils.VISION_DEVICE_DRIVER_ID, elementLabel, columnName, cellValue)) {
            BaseTestUtils.report("No such record in this table: " + elementLabel + ", it may not be visible", Reporter.FAIL);
        }
    }

    @Then("^UI click Table row by keyValue or Index with elementLabel \"([^\"]*)\"(?: findBy index (\\S+))?(?: findBy columnName \"([^\"]*)\")?(?: findBy cellValue \"([^\"]*)\")?$")
    public void clickTableRowByKeyValueOrIndex(String elementLabel, Integer index, String columnName, String cellValue) {
        int rowIndex = index != null ? index : -1;
        try {
            try {
                if(cellValue.contains("#")) {
                    cellValue = cellValue.replaceAll("#.*;", (String) invokeMethod(cellValue));
                }
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }

            if (columnName != null && cellValue != null && columnName.contains(",") && cellValue.contains(","))
                tableHandler.clickTableRowByKeyValueOrIndex(elementLabel, Arrays.asList(columnName.split(",")), Arrays.asList(cellValue.split(",")), rowIndex);
            else
                tableHandler.clickTableRowByKeyValueOrIndex(elementLabel, columnName, cellValue, rowIndex);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), e);
        }
    }

    @Then("^UI click Table row by keyValue or Index with elementLabel \"([^\"]*)\" findBy columnName \"([^\"]*)\" with device attribute \"([^\"]*)\" for \"([^\"]*)\" Device with index (\\S+)$")
    public void clickTableRowByAttributeOfDeviceIndex(String elementLabel, String columnName, String deviceAttribute, SUTDeviceType deviceType, Integer deviceIndex) {
        if (deviceIndex == null)
            BaseTestUtils.report("Index wasn't Defined", Reporter.FAIL);
        try {
            String cellValue = devicesManager.getDeviceInfo(deviceType, deviceIndex).getProperty(deviceAttribute);
            if (columnName != null && cellValue != null && columnName.contains(",") && cellValue.contains(","))
                tableHandler.clickTableRowByKeyValueOrIndex(elementLabel, Arrays.asList(columnName.split(",")), Arrays.asList(cellValue.split(",")), -1);
            else
                tableHandler.clickTableRowByKeyValueOrIndex(elementLabel, columnName, cellValue, -1);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), e);
        }
    }


    @Then("^UI \"(expand|collapse)\" Table row by keyValue or Index with elementLabel \"([^\"]*)\"(?: findBy index (\\S+))?(?: findBy columnName \"([^\"]*)\")?(?: findBy cellValue \"([^\"]*)\")?$")
    public void uiExpandTableRowByKeyValueOrIndexWithElementLabelFindByColumnNameFindByCellValue(String operation, String elementLabel, Integer index, String columnName, String cellValue) {
        int rowIndex = index != null ? index : -1;
        try {
            tableHandler.expandOrCollapseRow(operation, elementLabel, columnName, cellValue, rowIndex);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), e);
        }
    }

    @Then("^UI Validate Table Sorting with elementLabel \"([^\"]*)\" Sort By columnName \"([^\"]*)\"(?: By Criteria (\\S+))?$")
    public void validateTableSortingByColumnName(String elementLabel, String columnName, TableSortingCriteria criteria) {
        tableHandler.validateTableSortingByColumn(elementLabel, columnName, criteria);
    }

    @Then("^UI validate DropDown textOption Existence \"(.*)\" by elementLabelId \"(.*)\" by deviceDriverType \"(VISION|DEVICE)\" findBy Type \"(BY_NAME|BY_ID)\"$")
    public void validateDropDownTextOptionExistence(String textOption, String elementLabelId, DeviceDriverType deviceDriverType, FindByType findByType) {
        basicOperationsByNameIdHandler.validateDropDownOptionExistence(textOption, elementLabelId, deviceDriverType.getDDType(), findByType);
    }

    @Then("^UI validate DropDown textOption Selection \"(.*)\" by elementLabelId \"(.*)\" by deviceDriverType \"(VISION|DEVICE)\" findBy Type \"(BY_NAME|BY_ID)\"$")
    public void validateDropDownTextOptionSelection(String textOption, String elementLabelId, DeviceDriverType deviceDriverType, FindByType findByType) {
        textOption = textOption.equals("") ? getRetrievedParamValue() : textOption;
        basicOperationsByNameIdHandler.validateDropDownSelection(textOption, elementLabelId, deviceDriverType.getDDType(), findByType);
    }

    @Then("^UI validate popup Message \"(.*)\"$")
    public void validatePopupContent(String expectedValue) {
        try {
            if (restTestBase.getGlobalParamsMap().get(getPopupContentKey()) != null) {
                String actualContent = restTestBase.getGlobalParamsMap().get(getPopupContentKey());
                if (!actualContent.equals(expectedValue)) {
                    BaseTestUtils.report("Popup Validation Failed. Expected Content is: " + expectedValue + ", Actual Content is:" + actualContent, Reporter.FAIL);
                }
            } else {
                BaseTestUtils.report("Failed to Validate Popup Content, it may not be visible", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Validate Popup Content, it may not be visible" + "\n" + parseExceptionBody(e), Reporter.FAIL);
        } finally {
            closePopupDialog();
        }
    }

    @Then("^UI validate CheckBox by ID \"(.*)\" if Selected \"(true|false)\"$")
    public void validateCheckboxSelection(String elementId, boolean expectedCheckboxSelection) {
        basicOperationsByNameIdHandler.validateCheckboxSelection(elementId, expectedCheckboxSelection);
    }

    @Then("^UI validate Checkbox by label \"([^\"]*)\"(?: optional (device IP|params) \"(.*)\")? if Selected \"(true|false)\"$")
    public void validateCheckboxSelectionbyLabel(String label, String ipOrParams, String deviceName, boolean expectedCheckboxSelection) {
        String deviceNameFinal = deviceName != null ? deviceName : "";
        basicOperationsByNameIdHandler.validateCheckboxSelectionByLabel(label, deviceNameFinal, expectedCheckboxSelection);
    }

    @Then("^UI validate Checkbox by label \"([^\"]*)\" with extension \"(.*)\" if Selected \"(true|false)\"$")
    public void validateCheckboxSelectionbyLabelWithExtention(String label, String param, boolean expectedCheckboxSelection) {
        basicOperationsByNameIdHandler.validateCheckboxSelectionByLabel(label, param, expectedCheckboxSelection);
    }


    @Then("^UI validate Vision DualList by ID \"(.*)\" with rightList \"(.*)\" with leftList \"(.*)\"$")
    public void moveDualListItems(String dualListId, String rightList, String leftList) {
        try {
            basicOperationsByNameIdHandler.validateVisionDualList(dualListId, rightList, leftList);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to validate dual list :" + dualListId + " \n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }

    @Then("^UI Validate Element tooltip value with elementLabel \"([^\"]*)\"(?: with extension \"([^\"]*)\")? equal to \"([^\"]*)\"$")
    public void validateElementTooltipValue(String elementLabel, String extension, String expectedTooltipValue) {
        ClickOperationsHandler.validateElementTooltipValue(elementLabel, extension, expectedTooltipValue);
    }


    @Then("^UI Validate \"([^\"]*)\" Table sorting by \"([^\"]*)\"$")
    public void uiValidateVirtsTableSortingBy(String tableName, String sortBy) {
        virtsTableHandler.validateVirtsTableSorting(tableName, sortBy);
    }

    @Then("^UI validate Login dialogBox existence \"(true|false)\"$")
    public void validateLoginDialogBoxExistence(boolean ifExists) {
        try {
            BasicOperationsHandler.validateLoginDialog(ifExists);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Login", e);
        }
    }

    @Then("^UI Validate Table \"([^\"]*)\" is Sorted by$")
    public void uiValidateTableIsSorted(String tableLabel, List<SortingDataSet> cells) throws Exception {
        tableHandler.uiValidateTableIsSorted(tableLabel, cells);
    }

    @Then("^UI Validate search in table \"([^\"]*)\" in searchLabel \"([^\"]*)\"(?: with params \"([^\"]*)\")? with text \"([^\"]*)\"$")
    public void uiValidateSearchInTableInSearchLabelWithParamsWithText(String tableName, String searchLabel, String searchParams, String text, List<TableValues> entries) throws Exception {
        VisionDebugIdsManager.setLabel(searchLabel);
        VisionDebugIdsManager.setParams(searchParams);
        WebElement searchElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (searchElement.findElement(By.xpath("./input")) != null) {
            searchElement.findElement(By.xpath("./input")).sendKeys(new CharSequence[]{text});
        } else {
            setTextField(searchLabel, searchParams, text, false);
        }
        VisionDebugIdsManager.setLabel(tableName);
        BasicTable table = new BasicTableWithPagination(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()), false);
        for (TableValues entry : entries) {
            List<String> columnName = new ArrayList();
            columnName.add(entry.columnName);
            List<String> value = new ArrayList();
            value.add(entry.value);
            WebUIUtils.sleep(1);
            if (table.findRowByKeysValues(columnName, value) < 0) {
                addErrorMessage("The Expected is: the columnName: '" + columnName.get(0) + "' with value: '" + value.get(0) + "' should be exist in table " + tableName + " but they arn't");
            }
        }
        ReportsUtils.reportErrors();
    }

    @Then("^UI search row table in searchLabel \"([^\"]*)\"(?: with params \"([^\"]*)\")? with text \"([^\"]*)\"$")
    public void uiTextToSearchInTableInSearchLabelWithParamsWithText(String searchLabel, String searchParams, String text) throws Exception {
        VisionDebugIdsManager.setLabel(searchLabel);
        VisionDebugIdsManager.setParams(searchParams);
        WebElement searchElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (searchElement.findElement(By.xpath("./input")) != null) {
            searchElement.findElement(By.xpath("./input")).clear();
            searchElement.findElement(By.xpath("./input")).sendKeys(new CharSequence[]{text});
        } else {
            setTextField(searchLabel, searchParams, text, false);
        }
        ReportsUtils.reportErrors();
    }

    @Then("^UI Validate elements \"([^\"]*)\"(?: with params \"([^\"]*)\")? are sorting (Ascending|Descending) by \"([^\"]*)\"$")
    public void uiValidateElementsWithParamsAreSortingAscendingDescendingBy(String label, String params, String order, String comparator) throws Throwable {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        List<WebElement> elements = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        List<String> columnData = new ArrayList<>();
        for (WebElement element : elements) {
            columnData.add(element.getText());
        }
        SortingDataSet sortingDataSet = new SortingDataSet("columnName", order, comparator);
        List<SortableColumn> sortableColumns = new ArrayList<>();
        sortableColumns.add(0, new SortableColumn(columnData, sortingDataSet));
        TableSortingHandler tableSortingHandler = new TableSortingHandler(sortableColumns);
        if (tableSortingHandler.isSorted()) {
            ReportsUtils.reportAndTakeScreenShot("the table is sorted", Reporter.PASS);
        } else {
            String sortingResults = tableSortingHandler.doSort();
            ReportsUtils.reportAndTakeScreenShot("The table is not sorted:" + sortingResults, Reporter.FAIL);
        }
    }

    @Then("^UI FluentWait For \"([^\"]*)\"(?: With Extension \"([^\"]*)\")? Table Until Rows Number (EQUALS|GTE|GT|LTE|LT) (\\d+)$")
    public void fluentWaitForTableWithRows(String label, String extension,OperatorsEnum operatorsEnum,int rowsNumber) {

        try {
            if (!tableHandler.fluentWaitTableByRowsNumber(label, extension,operatorsEnum, rowsNumber))
                BaseTestUtils.reporter.report("Fluent Wait Time Was Ended without find the number of expected rows", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.reporter.report(e.getMessage(), Reporter.FAIL);
        }

    }

    @Then("^UI Validate IP's in chart with Summary Table \"([^\"]*)\" with Col name \"([^\"]*)\" with widget name \"([^\"]*)\"$")
    public void uiValidateIPSInChartWithSummaryTable(String TableName,String ColName,String widgetName) throws Throwable {
        ArrayList<String> IPList = tableHandler.getIpsFromSummaryTable(TableName,ColName);
        List<WebElement> elements = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + widgetName +"_') and contains(@data-debug-id, '_label')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        for(WebElement w:elements){
            if(!IPList.contains(w.getText())){
                BaseTestUtils.reporter.report("The label "+ w.getText()+"is'nt exist in Summary Table", Reporter.FAIL);
            }
        }
    }

    class TableValues {
        public String columnName;
        public String value;
    }

    @Then("^UI Validate Table \"([^\"]*)\" rows is between index:(\\d+) and index:(\\d+) in \"(.*)\" Chart$")
    public void uiValidateTableRowsIsBetween(String tableLabel, int indexFrom, int indexTo, String chart) throws Exception {
        Objects.requireNonNull(chart, "Chart is equal to null");
        JSONArray dataArray;
        VRMHandler vrmHandler = new VRMHandler();
        Map jsonMap = vrmHandler.getSessionStorage(chart);
        jsonMap = JsonUtils.getJsonMap(jsonMap.get("data"));
        dataArray = (JSONArray) jsonMap.get("labels");
        String first = (String) dataArray.get(indexFrom);
        String second = (String) dataArray.get(indexTo);
        tableHandler.uiValidateRowsIsBetweenDates(tableLabel, first, second);
    }

    @Then("^Validate Expand  \"([^\"]*)\" table$")
    public void uiValidateValues(String label, List<TableContent> entries) throws Exception {

        String params = null;
        for (TableContent entry : entries) {
            List<String> name = new ArrayList();
            name.add(entry.name);
            List<String> value = new ArrayList();
            value.add(entry.value);
            List<String> index = new ArrayList();
            index.add(entry.index);
            params = name.get(0) + "-" + index.get(0);
            WebUIUtils.sleep(1);
            BasicOperationsHandler.isTextEqualValue(label, value.get(0), params);
        }


    }

    class TableContent {
        public String name;
        public String value;
        public String index;

    }

}
