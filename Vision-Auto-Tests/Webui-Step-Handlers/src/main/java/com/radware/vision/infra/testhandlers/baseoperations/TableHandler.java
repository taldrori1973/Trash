package com.radware.vision.infra.testhandlers.baseoperations;

import com.radware.automation.react.widgets.impl.enums.TableSortingCriteria;
import com.radware.automation.react.widgets.impl.gridTable.ReactGridTable;
import com.radware.automation.react.widgets.impl.gridTable.ReactGridTableControlItems;
import com.radware.automation.react.widgets.impl.listTable.*;
import com.radware.automation.react.widgets.impl.table.SortTable;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.api.table.AbstractColumn;
import com.radware.automation.webui.widgets.api.table.AbstractTable;
import com.radware.automation.webui.widgets.impl.table.BasicTable;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.SortableColumn;
import com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.SortingDataSet;
import com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.TableSortingHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import static com.radware.automation.webui.UIUtils.sleep;
import static com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler.setTextField;
import static com.radware.vision.infra.utils.ReportsUtils.addErrorMessage;

public class TableHandler {
    AbstractTable table;
    String REACT_TABLE_OLD = "list-wrapper";
    String REACT_GRID = "genericTableWrapper";
    String Simple_Table = "groups-and-content-rule-expand-row-legends";
    public final String BASIC_TABLE = "vrm-generic-table";

    public void validateTableRecordByContent(String elementLabel, String columnName, String cellValue, List<WebUITable.TableDataSets> cells, int index, String extension) {
        try {
            if (extension == null) {
                extension = "";
            }
            setTable(elementLabel, extension, false);
            sleep(1);
            String bugs = table.validateTableRowContent(cells, columnName, cellValue, index);
            if (bugs.equalsIgnoreCase("")) {
                BaseTestUtils.report("Provided record Content was found in the Table: ", Reporter.PASS);
            } else {
                ReportsUtils.reportAndTakeScreenShot("Provided record Content was NOT found in the Table:\n " + bugs, Reporter.FAIL);
            }
        } catch (Exception e) {
            ReportsUtils.reportAndTakeScreenShot("Failed to validate record Content: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public void validateTableRecordTooltipContent(String elementLabel, String columnName, String cellValue, List<WebUITable.TableDataSets> cells, int index, String extension) {
        try {
            if (extension == null) {
                extension = "";
            }
            setTable(elementLabel, extension, false);
            int rowIndex;
            if (index < 0) {
                rowIndex = (cellValue != null && columnName != null) ? table.getRowIndex(columnName, cellValue) : -1;
            } else {
                rowIndex = index;
            }
            String failures = table.validateTableCellsTooltipWithFailures(cells, rowIndex);
            if (failures.equalsIgnoreCase("")) {
                BaseTestUtils.report("Provided cells tooltip content is found in the Table: ", Reporter.PASS);
            } else {
                ReportsUtils.reportAndTakeScreenShot("Provided cells tooltip content was NOT found in the table: " + failures, Reporter.FAIL);
            }
        } catch (Exception e) {
            ReportsUtils.reportAndTakeScreenShot("Failed to validate cells tooltip content: " + e.getMessage(), Reporter.FAIL);
        }
    }


    public void validateTableRowsCount(String elementLabel, int count, Integer offset) {
        try {
            int actualRowsCount;
            if (!isReactTable(elementLabel)) {
                setTable(elementLabel, false);
                actualRowsCount = table.getRowCount();
            } else {
                actualRowsCount = getReactGridRowCount();
            }
            boolean isValid;
            if (offset == null || offset == 0)
                isValid = actualRowsCount == count;
            else
                isValid = (count >= (actualRowsCount - offset) && count <= (actualRowsCount + offset));
            if (isValid) {
                BaseTestUtils.report("Table Rows count = " + count, Reporter.PASS);
            } else {
                ReportsUtils.reportAndTakeScreenShot("Expected rows count: " + count + " is not equal to actual rows count: " + actualRowsCount, Reporter.FAIL);
            }
        } catch (Exception e) {
            ReportsUtils.reportAndTakeScreenShot("Failed to validate table rows count: " + e.getMessage(), Reporter.FAIL);
        }
    }

    private int getReactGridRowCount() {
        String totalRowsXpath = ".//li[contains(@class,'rc-pagination-total-text')]";
        WebElement totalRowsText = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, totalRowsXpath).getBy());
        if (totalRowsText != null) {
            return Integer.parseInt(totalRowsText.getText().split(" ")[4]);
        } else if (WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualLocatorByDbgId("pagination_sum").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false) != null) {
            return Integer.parseInt(WebUIUtils.fluentWaitGetText(ComponentLocatorFactory.getEqualLocatorByDbgId("pagination_sum").getBy(), WebUIUtils.SHORT_WAIT_TIME, false).split("of")[1].trim());
        } else {
            String rowsXpath = "//div[contains(@class,'" + ReactGridTableControlItems.GRID_VIEWPORT.getSelector() + "')]//div[contains(@class,'" + ReactGridTableControlItems.GRID_ROW.getSelector() + "')]";
            ComponentLocator rowsLocator = new ComponentLocator(How.XPATH, rowsXpath);
            List<WebElement> insertRowsList = WebUIUtils.fluentWaitMultiple(rowsLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
            return insertRowsList.size();
        }
    }

    private boolean isReactTable(String elementLabel) {
        VisionDebugIdsManager.setLabel(elementLabel);
        VisionDebugIdsManager.setParams("");
        WebElement tableElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME);
        if (tableElement != null) {
            if (tableElement.getAttribute("class").contains(REACT_GRID)) {
                return true;
            }
        } else
            return VisionDebugIdsManager.getDataDebugId().contains(REACT_GRID);
        return false;
    }

    public void setTable(String label, boolean withReadAllTable) throws Exception {
        setTable(label, "", withReadAllTable);
    }

    private void setTable(String label, String params, boolean withReadAllTable) throws Exception {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        String tableSelector = VisionDebugIdsManager.getDataDebugId();
        ComponentLocator tableLocator = ComponentLocatorFactory.getEqualLocatorByDbgId(tableSelector);
        WebElement tableElement = WebUIUtils.fluentWait(tableLocator.getBy(), WebUIUtils.NAVIGATION_TREE_WAIT_TIME, false);
        try {
            constructTable(tableSelector, tableLocator, tableElement, withReadAllTable);
        } catch (Exception e) {
            table = null;
            sleep(2);
            constructTable(tableSelector, tableLocator, tableElement, withReadAllTable);
        }

    }

    private void constructTable(String tableSelector, ComponentLocator tableLocator, WebElement tableElement, boolean withReadAllTable) throws Exception {
        if (tableElement != null) {
            String classValue = WebUIUtils.fluentWaitAttribute(tableLocator.getBy(), WebUIUtils.MAX_RENDER_WAIT_TIME, true, "class", null);
            if (classValue.contains(BASIC_TABLE) || tableSelector.contains("instances-table"))
                table = new BasicTable(tableLocator, withReadAllTable);
            else if (tableSelector.contains(REACT_GRID) || classValue.contains(REACT_GRID))
                table = new ReactGridTable(tableLocator, withReadAllTable);
            else if (tableSelector.equals("default-eventtable"))
                table = new TrafficLogTable(tableSelector, withReadAllTable);
            else if (tableSelector.startsWith("tedTopAnalyticsSummary"))
                table = new BasicTable(tableLocator, withReadAllTable);
        } else {
            if (tableSelector.contains(REACT_GRID)) {
                table = new ReactGridTable(tableSelector, withReadAllTable);
            } else if (tableSelector.equals("rt-table")) {
                table = new TrafficLogTable(tableSelector, withReadAllTable);
            } else if (tableSelector.contains("topProtectionPoliciesWrapper") || tableSelector.contains("dpProtectionPerPolicy") || tableSelector.contains("topProtectionPoliciesGrid")) {
                table = new ReactListTable(tableSelector, withReadAllTable);
            } else if (/*tableSelector.contains("AlertDetailsWrapper") || */tableSelector.contains("virtual-scroll-table")) {
                table = new ListTable(tableSelector, withReadAllTable);
            } else if (tableSelector.contains(Simple_Table)) {
                table = new SimpleTable(tableSelector, VisionDebugIdsManager.getLabel() + VisionDebugIdsManager.getParams().get(0), withReadAllTable);
            } else {
                throw new Exception("No table with name " + VisionDebugIdsManager.getLabel());
            }
        }
    }

    public void clickTableRowByKeyValueOrIndex(String label, String columnName, String value, int index) throws Exception {
        setTable(label, false);
//        if (table.getRowCount() == 0) {
//            throw new Exception("The table is empty");// EmptyTable
//        }
        if (index >= 0) {
            table.clickOnRow(index);
        } else if (columnName != null && value != null) {
            table.selectRowByKeyValue(columnName, value);
        } else {
            throw new IllegalArgumentException("Failed due to an incorrect input data: columnName is " + columnName + " value is " + value);
        }
    }

    public void expandOrCollapseRow(String operation, String label, String columnName, String value, int index) throws Exception {
        setTable(label, false);
        if (table.getRowCount() == 0) {
            throw new Exception("The table is empty");// EmptyTable
        }
        if (index >= 0) {
            table.expandOrCollapseRow(operation, index);
        } else if (columnName != null && value != null) {
            table.expandOrCollapseRow(operation, columnName, value);
        } else {
            throw new IllegalArgumentException("Failed due to an incorrect input data: columnName is " + columnName + " value is " + value);
        }
    }


    public void clickTableRowByKeyValueOrIndex(String label, List<String> columnName, List<String> value, int index) throws Exception {
        setTable(label, true);
        if (index >= 0) {
            table.clickOnRow(index);
        } else if (columnName != null && value != null) {
            table.clickOnRow(table.getRowIndex(columnName.get(0), value.get(0)));
        } else {
            throw new IllegalArgumentException("Failed due to an incorrect input data: columnName is " + columnName + " value is " + value);
        }
    }

    public void validateTableRowByKeyValue(String label, String columnName, String value) throws Exception {
        setTable(label, true);
        int rowIndexFound = -1;
        if (columnName != null && value != null) {
            rowIndexFound = table.getRowIndex(columnName, value);
        } else {
            ReportsUtils.reportAndTakeScreenShot("Failed due to an incorrect input data: columnName is " + columnName + " value is " + value, Reporter.FAIL);
        }
        if (rowIndexFound >= 0) {
            BaseTestUtils.report("Specified value was Found in the Table: row index found in is " + String.valueOf(rowIndexFound), Reporter.PASS);
        } else {
            ReportsUtils.reportAndTakeScreenShot("Specified value was NOT found in the Table: columnName = " + columnName + " value = " + value, Reporter.FAIL);
        }
    }

    public void validateValueExistenceAtTableByColumn(String label, String columnName, String value, boolean expectedExistance) throws Exception {
        setTable(label, true);
        int rowIndexFound = -1;
        if (columnName != null && value != null) {
            rowIndexFound = table.getRowIndex(columnName, value);
        } else {
            ReportsUtils.reportAndTakeScreenShot("Failed due to an incorrect input data: columnName is " + columnName + " value is " + value, Reporter.FAIL);
        }
        if (rowIndexFound >= 0 && expectedExistance || rowIndexFound < 0 && !expectedExistance) {
            BaseTestUtils.report("Specified value Existence Verified in the Table: row index is " + String.valueOf(rowIndexFound), Reporter.PASS);
        } else {
            ReportsUtils.reportAndTakeScreenShot("Specified value Existence Not Verified in the Table: columnName = " + columnName + " value = " + value + " ,Expected: " + expectedExistance, Reporter.FAIL);
        }
    }

    public void validateTableSortingByColumn(String label, String columnName, TableSortingCriteria criteria) {
        try {
            boolean isValid;
            VisionDebugIdsManager.setLabel(label);
            String debugId = VisionDebugIdsManager.getDataDebugId();
            SortTable sortTable = new SortTable();
            isValid = sortTable.sortTableByCriteria(debugId, columnName, criteria);

            if (isValid) {
                BaseTestUtils.report("Table sorting was executed/validated correctly: ", Reporter.PASS);
            } else {
                ReportsUtils.reportAndTakeScreenShot("to validate Table Sorting of: " + columnName + " by " + criteria.name(), Reporter.FAIL);
            }

        } catch (Exception e) {
            ReportsUtils.reportAndTakeScreenShot("Failed to validate Table Sorting of: " + columnName + " by " + criteria.name() + e.getMessage(), Reporter.FAIL);
        }
    }

    public void uiValidateTableIsSorted(String tableLabel, List<SortingDataSet> cells) throws Exception {
        setTable(tableLabel, false);
        if (table == null) ReportsUtils.reportAndTakeScreenShot("failed to construct table", Reporter.FAIL);
        int listsSize = cells.size();
        if (listsSize == 0)
            ReportsUtils.reportAndTakeScreenShot("the number of sortingColumns is 0", Reporter.FAIL);
        List<SortableColumn> sortableColumns = new ArrayList<>();
        for (SortingDataSet sortingDataSet : cells) {
            List<String> columnData = table.getColumnData(sortingDataSet.getColumnName());
            sortableColumns.add(new SortableColumn(columnData, sortingDataSet));
        }
        TableSortingHandler tableSortingHandler = new TableSortingHandler(sortableColumns);
        if (tableSortingHandler.isSorted()) {
            ReportsUtils.reportAndTakeScreenShot("the table is sorted", Reporter.PASS);
        } else {
            String sortingResults = tableSortingHandler.doSort();
            ReportsUtils.reportAndTakeScreenShot("The table is not sorted:" + sortingResults, Reporter.FAIL);
        }
    }

    public void uiValidateSearchInTableInSearchLabelWithParamsWithText(String tableName, String searchLabel, String searchParams, String text, List<TableValues> entries) throws Exception {
        setTextField(searchLabel, searchParams, text, false);
        VisionDebugIdsManager.setLabel(tableName);
        BasicTable table = new BasicTable(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()), true);
        setTable(tableName, true);
        for (TableValues entry : entries) {
            List<String> columnName = new ArrayList();
            columnName.add(entry.columnName);
            List<String> value = new ArrayList();
            value.add(entry.value);
            if (table.findRowByKeysValues(columnName, value) < 0) {
                addErrorMessage("The Expected is: the columnName: '" + columnName.get(0) + "' with value: '" + value.get(0) + "' should be exist in table " + tableName + " but they arn't");
            }
        }
        ReportsUtils.reportErrors();
    }

    public void uiValidateRowsIsBetweenDates(String tableName, String first, String second) throws Exception {
        setTable(tableName, true);
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
        LocalDateTime from = LocalDateTime.parse((CharSequence) first, inputFormatter);
        LocalDateTime to = LocalDateTime.parse((CharSequence) second, inputFormatter);
        LocalDateTime fromGMT = from.plusHours(2);
        LocalDateTime toGMT = to.plusHours(2);
        AbstractColumn startTimeColumn = table.getColumn("Start Time");
        DateTimeFormatter inputFormatter2 = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss");
        for (String rowdate : startTimeColumn.columnValues) {
            LocalDateTime rowdateTime = LocalDateTime.parse((CharSequence) rowdate, inputFormatter2);
            if (!rowdateTime.isBefore(toGMT))
                BaseTestUtils.report("The row is after the end time", Reporter.FAIL);
            if (!rowdateTime.isAfter(fromGMT))
                BaseTestUtils.report("The row is before the strart time", Reporter.FAIL);

        }
    }

    static public class TableValues {
        public String columnName;
        public String value;
    }
}
