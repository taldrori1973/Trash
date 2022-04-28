package com.radware.vision.infra.testhandlers.baseoperations;

import com.radware.automation.react.widgets.impl.enums.TableSortingCriteria;
import com.radware.automation.react.widgets.impl.gridTable.ReactGridTable;
import com.radware.automation.react.widgets.impl.gridTable.ReactGridTableControlItems;
import com.radware.automation.react.widgets.impl.listTable.ListTable;
import com.radware.automation.react.widgets.impl.listTable.ReactListTable;
import com.radware.automation.react.widgets.impl.listTable.SimpleTable;
import com.radware.automation.react.widgets.impl.listTable.TrafficLogTable;
import com.radware.automation.react.widgets.impl.table.SortTable;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.api.table.AbstractColumn;
import com.radware.automation.webui.widgets.api.table.AbstractTable;
import com.radware.automation.webui.widgets.impl.table.*;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.SortableColumn;
import com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.SortingDataSet;
import com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.TableSortingHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriverException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.interactions.Locatable;
import org.openqa.selenium.interactions.internal.Coordinates;
import org.openqa.selenium.support.How;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.FluentWait;
import org.openqa.selenium.support.ui.Wait;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import static com.radware.automation.webui.UIUtils.sleep;
import static com.radware.vision.automation.AutoUtils.Operators.Comparator.compareResults;
import static com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler.setTextField;
import static com.radware.vision.infra.utils.ReportsUtils.addErrorMessage;

public class TableHandler {
    AbstractTable table;
    //    String REACT_TABLE_OLD = "list-wrapper";
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
    public float sumColOfTableByTableName(String TableName){
        float sum =0;
        try {
            setTable(TableName,true);
            sleep(1);
            for(int i =0;i<table.getRowCount();i++)
            sum += Float.parseFloat(table.getCellValue(i,"Count"));
        }catch (Exception e){
            ReportsUtils.reportAndTakeScreenShot("Failed to calculate the sum of column " + e.getMessage(), Reporter.FAIL);

        }
        return sum;
    }
    public ArrayList<String> getIpsFromSummaryTable(String TableName , String ColName){
        ArrayList<String> NamesList= new ArrayList<String>();
        try {
            setTable(TableName,true);
            sleep(1);
            for(int i =0;i<table.getRowCount();i++)
                 NamesList.add(table.getCellValue(i,ColName));
        }catch (Exception e){
            ReportsUtils.reportAndTakeScreenShot("Failed get all names From Summary Table " + e.getMessage(), Reporter.FAIL);

        }
        return NamesList;
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


    public void validateTableRowsCount(String elementLabel, int count, OperatorsEnum operatorsEnum, Integer offset) {
        try {
            int actualRowsCount;
            if (!isReactTable(elementLabel)) {
                setTable(elementLabel, false);
                actualRowsCount = table.getRowCount();
            } else {
                actualRowsCount = getReactGridRowCount();
            }
            boolean isValid;
            isValid = compareResults(String.valueOf(count), String.valueOf(actualRowsCount), operatorsEnum, offset);
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
            return tableElement.getAttribute("class").contains(REACT_GRID);
        } else
            return VisionDebugIdsManager.getDataDebugId().contains(REACT_GRID);
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
        WebUIUtils.scrollIntoView(tableElement,true);
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
            if(tableSelector.equals("IPLookup-table") || tableSelector.equals("vrm-generic-table-vrm-dpm-applications-table-list-physical-devices-table"))
                table = new CustomBasicTable(tableLocator, withReadAllTable);
            else if (tableSelector.contains("table_minMaxTable") || classValue.contains(BASIC_TABLE) || tableSelector.contains("instances-table") || tableSelector.contains("table_sample-data-table") || tableSelector.equals("summary-table"))
                table = new BasicTable(tableLocator, withReadAllTable);
            else if (tableSelector.contains("table_attacksTable"))
                table = new BasicTableWithPagination(tableLocator, withReadAllTable);
            else if (tableSelector.contains(REACT_GRID) || classValue.contains(REACT_GRID))
                table = new ReactGridTable(tableLocator, withReadAllTable);
            else if (tableSelector.equals("default-eventtable"))
                table = new TrafficLogTable(tableSelector, withReadAllTable);
            else if (tableSelector.startsWith("tedTopAnalyticsSummary") ||tableSelector.contains("table_WanLinkStatus"))
                table = new BasicTable(tableLocator, withReadAllTable);
            else if(tableSelector.contains("BadgeExtendedInfoTable"))
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
            } else if (tableSelector.contains("BadgeExtendedInfoTable")) {
                table = new BasicTable(tableLocator, withReadAllTable);
            }  else {
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

    public void clickTableRowByLabelValue(String elementTable, String tableName, String label, String value) throws Exception {
        setTable(elementTable, false);
        VisionDebugIdsManager.setParams(tableName);
        VisionDebugIdsManager.setLabel(label);

        for(int i=table.getRowCount()-1; i >= 0; --i)
        {
            table.clickOnRow(i);
            String actualValue = WebUIVisionBasePage.getCurrentPage().getContainer().getLabel(label).getInnerText();
            if (actualValue.contains(value))
                return;
        }

        throw new IllegalArgumentException("Failed due to an incorrect input data:tableName "+ tableName +" label is " + label + " value is " + value);
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
        setTable(label, false);
        int rowIndexFound = -1;
        if (columnName != null && value != null) {
            rowIndexFound = table.getRowIndex(columnName, value);
        } else {
            ReportsUtils.reportAndTakeScreenShot("Failed due to an incorrect input data: columnName is " + columnName + " value is " + value, Reporter.FAIL);
        }
        if (rowIndexFound >= 0) {
            BaseTestUtils.report("Specified value was Found in the Table: row index found in is " + rowIndexFound, Reporter.PASS);
        } else {
            ReportsUtils.reportAndTakeScreenShot("Specified value was NOT found in the Table: columnName = " + columnName + " value = " + value, Reporter.FAIL);
        }
    }

    public void validateValueExistenceAtTableByColumn(String label, String columnName, String value, boolean expectedExistence) throws Exception {
        setTable(label, true);
        int rowIndexFound = -1;
        if (columnName != null && value != null) {
            rowIndexFound = table.getRowIndex(columnName, value);
        } else {
            ReportsUtils.reportAndTakeScreenShot("Failed due to an incorrect input data: columnName is " + columnName + " value is " + value, Reporter.FAIL);
        }
        if (rowIndexFound >= 0 && expectedExistence || rowIndexFound < 0 && !expectedExistence) {
            BaseTestUtils.report("Specified value Existence Verified in the Table: row index is " + rowIndexFound, Reporter.PASS);
        } else {
            ReportsUtils.reportAndTakeScreenShot("Specified value Existence Not Verified in the Table: columnName = " + columnName + " value = " + value + " ,Expected: " + expectedExistence, Reporter.FAIL);
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
        LocalDateTime from = LocalDateTime.parse(first, inputFormatter);
        LocalDateTime to = LocalDateTime.parse(second, inputFormatter);
        LocalDateTime fromGMT = from.plusHours(2);
        LocalDateTime toGMT = to.plusHours(2);
        AbstractColumn startTimeColumn = table.getColumn("Start Time");
        DateTimeFormatter inputFormatter2 = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss");
        for (String rowdate : startTimeColumn.columnValues) {
            LocalDateTime rowdateTime = LocalDateTime.parse(rowdate, inputFormatter2);
            if (!rowdateTime.isBefore(toGMT))
                BaseTestUtils.report("The row is after the end time", Reporter.FAIL);
            if (!rowdateTime.isAfter(fromGMT))
                BaseTestUtils.report("The row is before the strart time", Reporter.FAIL);

        }
    }

    public boolean fluentWaitTableByRowsNumber(String label, String extension, OperatorsEnum operatorsEnum, int rowsNumber) throws Exception {

        setTable(label, extension, false);

        Wait<AbstractTable> wait = new FluentWait<>(table).
                withTimeout(Duration.ofMillis(5 * WebUIUtils.DEFAULT_WAIT_TIME)).
                pollingEvery(Duration.ofMillis(10)).
                ignoring(StaleElementReferenceException.class, WebDriverException.class);

        return wait.until(table -> {
            try {
                setTable(label, extension, false);
            } catch (Exception e) {
                e.printStackTrace();
            }
            int rowCount = table.getRowCount();
            switch (operatorsEnum) {
                case LTE:
                    return rowCount <= rowsNumber;
                case GTE:
                    return rowCount >= rowsNumber;
                case LT:
                    return rowCount < rowsNumber;
                case GT:
                    return rowCount > rowsNumber;
                case EQUALS:
                    return rowCount == rowsNumber;
            }
            return false;

        });
    }


    static public class TableValues {
        public String columnName;
        public String value;
    }
}

class CustomBasicTable extends BasicTable{

    public CustomBasicTable(ComponentLocator tableLocator, boolean withReadAllTheTable) {
        super(tableLocator, withReadAllTheTable);
    }

    @Override
    public String validateTableRowContent(List<TableDataSets> cellsContentToValidate, String columnName, String cellValue, Integer index) throws Exception {
        String failures = "";
        BasicTableRow targetBasicTableRow = null;
        if (index < 0) {
            TargetRow targetRow = this.findTargetRow(columnName, cellValue);
            targetBasicTableRow = new BasicTableRow(targetRow.rowIndex, this.tableLocator, this.headersFieldNames);
        } else {
            targetBasicTableRow = new BasicTableRow(index+1, this.tableLocator, this.headersFieldNames);
        }

        Iterator var10 = cellsContentToValidate.iterator();

        while(var10.hasNext()) {
            TableDataSets tableDataSet = (TableDataSets)var10.next();
            String actualCellValue = targetBasicTableRow.cell(tableDataSet.columnName).textValue();
            if (!actualCellValue.equalsIgnoreCase(tableDataSet.value)) {
                failures = failures + tableDataSet.columnName + ": Actual value is '" + actualCellValue + "' BUT Expected is " + tableDataSet.value + "\n";
            }
        }

        return failures;
    }

    @Override
    public int getRowCount() {
        String rowsLocator = "//*" + tableLocator.getLocatorValue().replaceFirst("\\[", "[@") + "//tbody//tr";
        return WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, rowsLocator).getBy()).size();

    }

    @Override
    public String validateTableCellsTooltipWithFailures(List<WebUITable.TableDataSets> cellsTooltipContentToValidate, int rowIndex) throws TargetWebElementNotFoundException {
        if(!tableLocator.getLocatorValue().contains("IPLookup-table"))
            return super.validateTableCellsTooltipWithFailures(cellsTooltipContentToValidate,rowIndex);
        String res = "";
        for (TableDataSets tableDataSet : cellsTooltipContentToValidate) {
            BasicTableCell targetCell = (BasicTableCell) new BasicTableRow(rowIndex, tableLocator, headersFieldNames).cell(tableDataSet.columnName);
            if (targetCell != null) {
                String actualTitle = targetCell.getInnerText();
                if (!actualTitle.equalsIgnoreCase(tableDataSet.value)) {
                    res += "The Actual value in column " + tableDataSet.columnName + " and rowIndex " + rowIndex + 1 + " is " + actualTitle + " " +
                            "but the Expected is " + tableDataSet.value + "\n";
                }
            } else {
                throw new TargetWebElementNotFoundException("No cell in row: " + rowIndex + 1 + " and in column " + tableDataSet.columnName);
            }

        }
        return res;
    }

    @Override
    protected TargetRow findTargetRow(String key, String value) throws Exception {
        int columnIndex = this.headersFieldNames.indexOf(key);
        if (columnIndex == -1) {
            throw new Exception("No column with name " + key);
        } else {
            for (int i = 1; i <= getRowCount(); i++) {
                String targetCellLocator = "(//*" + this.tableLocator.getLocatorValue().replaceFirst("\\[", "[@") + "//tbody//tr["+i+"]/td[" + (columnIndex + 1) + "])[ . = '" + value + "']";
                WebElement targetCellElement = WebUIUtils.fluentWait((new ComponentLocator(How.XPATH, targetCellLocator)).getBy(),1);
                if (targetCellElement != null) {
                    return new TargetRow(targetCellElement, i);
                }
            }
        }

        throw new Exception("No row with key: " + key + " and value: " + value);
    }
}