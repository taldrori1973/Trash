package com.radware.vision.infra.validationutils;

import com.radware.automation.webui.widgets.api.table.Cell;
import com.radware.automation.webui.widgets.impl.table.WebUIRow;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.alerts.Alerts;
import com.radware.vision.infra.enums.AlertsTableColumns;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.utils.TimeUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by stanislava on 10/7/2014.
 */
public class ValidateAlertsTable extends Thread {

    private HashMap<String, List<String>> tableProperties;
    private WebUIRow row;
    private long clientCurrentEpochTime;
    private WebUITable table;

    private static List<String> tableColumns;

    volatile StringBuffer nonMatchingItems = new StringBuffer();

    public ValidateAlertsTable(HashMap<String, List<String>> tableProperties, WebUIRow row, long clientCurrentEpochTime) {
        this.tableProperties = tableProperties;
        this.tableProperties.put("Message", new ArrayList<String>());
        this.row = row;
        this.clientCurrentEpochTime = clientCurrentEpochTime;
    }

    public ValidateAlertsTable(HashMap<String, List<String>> tableProperties, WebUIRow row, long clientCurrentEpochTime, List<String> tableColumns) {
        this(tableProperties, row, clientCurrentEpochTime);
        this.tableColumns = tableColumns;
    }

    public static synchronized void initTable(WebUITable targetTable) {
        tableColumns = new ArrayList<String>();
        tableColumns = targetTable.getTableHeaders();
    }

    @Override
    synchronized public void run() {

        try {
            if(tableColumns == null) {
                throw new IllegalStateException("Static Member 'tableColumns' must be initialized prior to running this thread.");
            }

            List<Cell> cells = row.getCells();
            HashMap<String, List<String>> localTableProperties = new HashMap<String, List<String>>(tableProperties);

            Map<String, String> cellsContentMap;

 //           cellsContentMap = getCellValuesWithThread(cells);
            cellsContentMap = getCellValues(cells);

            List<String> tablePropertiesColNames = new ArrayList<String>();
            Map<String, String> rowData = new HashMap<String, String>();
            tablePropertiesColNames.addAll(localTableProperties.keySet());
            if(localTableProperties.containsKey("Device Name") && cellsContentMap.get("Product Name").equals("Vision")) {
                ArrayList<String> tempArr = new ArrayList<String>();
                tempArr.add("");
                localTableProperties.put("Device Name", tempArr);
            }
            for (int tablePropertiesIdx = 0; tablePropertiesIdx < localTableProperties.size(); tablePropertiesIdx++) {
                String colName = tablePropertiesColNames.get(tablePropertiesIdx);
                String colValue = cellsContentMap.get(tablePropertiesColNames.get(tablePropertiesIdx));
                if (colName.equals("Message")) continue;
                if (!colName.equals(AlertsTableColumns.TimeAndData.toString())) {
                    if (colName.equals(AlertsTableColumns.DeviceName.toString()) && colValue.isEmpty()) {
                        colValue = cellsContentMap.get("Message");
                        for (String deviceName : localTableProperties.get(colName)) {
                            if (!(colValue.contains(deviceName))) {
                                nonMatchingItems.append("Column: ").append(colName).append(", Current value: ").append(colValue).append(", Expected: ").append(localTableProperties.get(colName)).append("\n")
                                        .append("  Row: ").append(cellsContentMap.toString()).append("\n");
                                return;
                            }
                        }
                    } else if (!(localTableProperties.get(colName).contains(colValue))) {
                        nonMatchingItems.append("Column: ").append(colName).append(", Current value: ").append(colValue).append(", Expected: ").append(localTableProperties.get(colName)).append("\n")
                                .append("  Row: ").append(cellsContentMap.toString()).append("\n");
                        return;
                    }
                }
                else {
                    long validTimePeriod = Alerts.parseDateTime(localTableProperties.get(colName).get(0), localTableProperties.get(colName).get(1));
                    long currentTableEpoch = TimeUtils.getEpochTime(colValue, Alerts.TimeAndDateFormat);
                    if (Math.abs(this.clientCurrentEpochTime - currentTableEpoch) > validTimePeriod) {
                        nonMatchingItems.append("Column: ").append(colName).append(", Current value: ").append(colValue).append(", Time Interval: ").append((this.clientCurrentEpochTime - currentTableEpoch) / 1000 / 60).append(" Minutes").append("\n")
                                .append("  Row: ").append(cellsContentMap.toString()).append("\n");
                        return;
                    }
                }
            }

        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

    private Map<String, String> getCellValues(List<Cell> cells) {
        Map<String, String> cellsContentMap = new HashMap<String, String>();

        // For the "Device Type" column
        int deviceColIndex = AlertsTableColumnsIndex.valueOf("ProductName").getIndex();
        String deviceCellValue = cells.get(deviceColIndex).getInnerText();
        cellsContentMap.put(tableColumns.get(deviceColIndex), deviceCellValue);

        for (int cellIndex = 0; cellIndex < cells.size(); cellIndex++) {
            String cellValue = cells.get(cellIndex).getInnerText();
            cellsContentMap.put(tableColumns.get(cellIndex), cellValue);
        }
        return cellsContentMap;
    }

    private Map<String, String> getCellValuesWithThread(List<Cell> cells) {
        Map<String, String> cellsContentMap = new HashMap<String, String>();
        List<SingleCellValueExtractionThread> cellValuesCollectorThreads = new ArrayList<SingleCellValueExtractionThread>();

        // For the "Device Type" column
        int deviceColIndex = AlertsTableColumnsIndex.valueOf("ProductName").getIndex();
        SingleCellValueExtractionThread singleCellValueExtractionThreadDeviceType = new SingleCellValueExtractionThread(cells.get(deviceColIndex), deviceColIndex);
        singleCellValueExtractionThreadDeviceType.start();
        cellValuesCollectorThreads.add(singleCellValueExtractionThreadDeviceType);


        for (String currentTableProp : tableProperties.keySet()) {
            String currentTablePropNoSpaces = currentTableProp.replaceAll("\\s+", "");
            int colIndex = AlertsTableColumnsIndex.valueOf(currentTablePropNoSpaces).getIndex();
            SingleCellValueExtractionThread singleCellValueExtractionThread = new SingleCellValueExtractionThread(cells.get(colIndex), colIndex);
            singleCellValueExtractionThread.start();
            cellValuesCollectorThreads.add(singleCellValueExtractionThread);
        }

        for (SingleCellValueExtractionThread singleCellValueExtractionThread : cellValuesCollectorThreads) {
            String cellValue = singleCellValueExtractionThread.getCellValue();
            if (cellValue != null) {
                cellsContentMap.put(tableColumns.get(singleCellValueExtractionThread.getColumnIndex()), cellValue);
            }
        }

        return cellsContentMap;
    }

    synchronized public String getCompareResult() throws InterruptedException {
        try {
            this.join();
        }
        catch(InterruptedException ie) {
            throw ie;
        }
        return this.nonMatchingItems.toString();
    }

    private class SingleCellValueExtractionThread extends  Thread {

        Cell currentCell;
        int columnIndex;

        String cellValue;

        public SingleCellValueExtractionThread(Cell currentCell, int columnIndex) {
            this.currentCell = currentCell;
            this.columnIndex = columnIndex;
        }

        @Override
        synchronized public void run() {
            String value = (this.currentCell.value(true, false));
            int count = 0;
            while (value == null && count++ < 20) {
                BasicOperationsHandler.delay(0.1);
                value = (this.currentCell.value(true, false));
            }
            this.cellValue = value;
        }

        synchronized public String getCellValue() {
            try {
                this.join();
            }
            catch(InterruptedException ie) {
                return ie.getMessage();
            }
            return this.cellValue;
        }

        public Cell getCurrentCell() {
            return currentCell;
        }
        public int getColumnIndex() {
            return columnIndex;
        }
    }
}
