package com.radware.vision.infra.testhandlers.csv.model;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class CSVTable {
    private String tableName;
    private List<String> header;
    private List<CSVRow> rows;
    private boolean isEmpty;


    /**
     * This Constructor set the header vaues only, use add/set rows methods
     *
     * @param headerAsCSV  - the header in CSV format , example: "X,Y,Z"
     * @param csvSeparator - the separator of the csv , example : "," at the previous example
     */
    public CSVTable(String headerAsCSV, String csvSeparator, String tableName, List<String> rowsAsCSV) {
        setHeader(headerAsCSV, csvSeparator);
        this.tableName = tableName;
        setRows(rowsAsCSV, csvSeparator);
    }


    //header

    /**
     * Convert the header from CSV Format to List , then setting the header
     *
     * @param headerAsCSV  - the header in CSV format , example: "X,Y,Z"
     * @param csvSeparator - the separator of the csv , example : "," at the previous example
     */
    public void setHeader(String headerAsCSV, String csvSeparator) {
        String[] header = headerAsCSV.split(csvSeparator);
        this.header = Arrays.asList(header);
    }

    /**
     * Setting the header
     *
     * @param header - header as List
     */
    public void setHeader(List<String> header) {
        this.header = header;
    }

    public List<String> getHeader() {
        return header;
    }


    //rows


    /**
     * @param rowsAsCSV    - List of Rows with CSV Format , Example:
     *                     ["1,2,5,7"
     *                     "8,5,5,4"]
     * @param csvSeparator the separator of the csv , example : "," at the previous example
     */
    public void setRows(List<String> rowsAsCSV, String csvSeparator) {
        List<CSVRow> rows = new ArrayList<>();
        if (rowsAsCSV != null)
            rowsAsCSV.forEach(row -> rows.add(new CSVRow(header, row, csvSeparator)));
        this.isEmpty = rows.isEmpty();
        this.rows = rows;
    }


    public List<CSVRow> getRows() {
        return rows;
    }


    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getTableName() {
        return tableName;
    }

    public boolean isEmpty() {
        return isEmpty;
    }

    //Controller Methods
    public int getTableSize() {
        return this.rows == null ? 0 : this.rows.size();
    }


    public int getValueFrequency(String columnName, String value) {

        if (!this.header.contains(columnName))
            BaseTestUtils.report("Column " + columnName + " Not exist at " + this.tableName + " table", Reporter.FAIL);
        return rows.stream().filter(row -> row.getValue(columnName).equals(value)).collect(Collectors.toList()).size();
    }

    public List<String> getColumn(String columnName) {
        if (!this.header.contains(columnName))
            BaseTestUtils.report("Column " + columnName + " Not exist at " + this.tableName + " table", Reporter.FAIL);

        List<String> column = new ArrayList<>();
        for (CSVRow row : this.rows) {
            column.add(row.getValue(columnName));
        }

        return column;


    }

    public List<String> getRowAsList(int index) {
        if (index >= this.rows.size())
            BaseTestUtils.report("maximum index value is " + (this.rows.size() - 1), Reporter.FAIL);

        List<String> row = new ArrayList<>();
        CSVRow csvRow = this.rows.get(index);
        for (String header : this.header) {
            row.add(csvRow.getValue(header));
        }

        return row;
    }

    public String getRowAsCSV(int index) {
        if (index >= this.rows.size())
            BaseTestUtils.report("maximum index value is " + (this.rows.size() - 1), Reporter.FAIL);

        return this.rows.get(index).getRowAsCSV();
    }
}
