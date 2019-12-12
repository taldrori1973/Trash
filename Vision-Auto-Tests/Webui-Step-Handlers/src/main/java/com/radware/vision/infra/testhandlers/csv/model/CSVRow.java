package com.radware.vision.infra.testhandlers.csv.model;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CSVRow {


    private Map<String, String> perColumnValue;
    private String rowAsCSV;

    /**
     * Creating a Row as Map (header column,value)
     * <b>The Order is Important</b>
     *
     * @param header - list of header columns names
     * @param values - value of each column
     */
    public CSVRow(List<String> header, List<String> values, String rowAsCSV) {
        if (header.size() != values.size())
            throw new IllegalArgumentException("the header and values arrays size are not equal, please send on value for each header column");


        perColumnValue = new HashMap<>();

        int i = 0;
        for (String h : header) {
            perColumnValue.put(h, values.get(i));
            i++;
        }

        this.rowAsCSV = rowAsCSV;
    }


    /**
     * Creating a Row as Map (header column,value)
     * * <b>The Order is Important</b>
     *
     * @param header       - list of header columns names
     * @param valuesAsCsv  - the row as CSV , Example : "1,2,5,7,m"
     * @param csvSeparator - the CSV Separator of the valuesAsCsv , Example : "," at the example above
     */
    public CSVRow(List<String> header, String valuesAsCsv, String csvSeparator) {
        this(header, Arrays.asList(valuesAsCsv.split(csvSeparator)), valuesAsCsv);
    }

    /**
     * @param column - Column Name
     * @return the value at this row and column
     */
    public String getValue(String column) {
        return perColumnValue.get(column);
    }

    public String getRowAsCSV() {
        return rowAsCSV;
    }
}
