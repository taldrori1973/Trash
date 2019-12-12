package com.radware.vision.infra.testhandlers.csv;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.*;
import com.radware.vision.infra.testhandlers.csv.model.CSVFile;
import com.radware.vision.infra.testhandlers.csv.model.CSVRow;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class CSVTestHandler {

    private static CSVTestHandler _instance;
    private CSVFile csvFile;

    public static CSVTestHandler getInstance(String csvFileDir, String csvFileName, String csvSeparator, List<CSVFile.Metadata> tablesMetaData) {
        if (_instance != null &&
                _instance.csvFile.getCsvFileDir().equals(csvFileDir) &&
                _instance.csvFile.getCsvFileName().equals(csvFileName) &&
                _instance.csvFile.getCsvSeparator().equals(csvSeparator)) return _instance;

        _instance = new CSVTestHandler(csvFileDir, csvFileName, csvSeparator, tablesMetaData);

        return _instance;
    }

    public static CSVTestHandler getInstance() {
        if (_instance == null)
            BaseTestUtils.report("No CSV File Was Loaded , Please Use CSV Read CSV File Step", Reporter.FAIL);
        return _instance;
    }

    private CSVTestHandler(String csvFileDir, String csvFileName, String csvSeparator, List<CSVFile.Metadata> tablesMetaData) {
        csvFile = new CSVFile(csvFileDir, csvFileName, csvSeparator, tablesMetaData);
    }

    public int getTableNumberOfRows(String tableName) {

        return csvFile.getTableByName(tableName).getTableSize();

    }

    public int getValueFrequencyOfColumn(String tableName, String columnName, String value) {
        if (csvFile.isTableExistByName(tableName))
            return csvFile.getTableByName(tableName).getValueFrequency(columnName, value);

        return -1;
    }

    public long getTimeStampDuration(String tableName, String columnNameOfTimeStamp) {

        List<CSVRow> tableRows = csvFile.getTableByName(tableName).getRows();
        List<String> column = csvFile.getTableByName(tableName).getColumn(columnNameOfTimeStamp);


        if (column != null && column.size() >= 2) {
            String first = column.stream().min(new TimeStampComparator()).get();
            String last = column.stream().max(new TimeStampComparator()).get();

            return Long.valueOf(last) - Long.valueOf(first);
        }

        return -1;
    }


    public boolean isSortedByColumn(String tableName, String columnName, CompareMethod compareMethod) {

        List<String> column = this.csvFile.getTableByName(tableName).getColumn(columnName);

        List<String> sortedColumn = new ArrayList<>(column);

        sortedColumn.sort(getComparator(compareMethod));

        if (column.equals(sortedColumn)) return true;
        BaseTestUtils.report("the column are not sorted , \nExpected Sort:\n" + sortedColumn.toString(), Reporter.FAIL);
        return false;
    }


    private Comparator<String> getComparator(CompareMethod compareMethod) {
        switch (CompareMethod.getEnumByString(compareMethod.getCompareMethod())) {
            case BIT_BYTE_UNITS:
                return new BitByteUnitsComparator();


            case ALPHABETICAL:
                return new AlphaBeticalComparator();


            case NUMERICAL:
                return new NumericalComparator();


            case HEALTH_SCORE:
                return new HealthScoreComparator();

            case SYSTEM_STATUS:
                return new SystemStatusComparator();

            case IPORVERSIONS:
                return new IpOrVersionsComparator();

            case DATE:
                return new DateComparator();
            default: {
                BaseTestUtils.report("No Comparator with name " + compareMethod, Reporter.FAIL);
                return null;
            }
        }
    }

    /**
     * this method return one row from all the data rows in the table not include the header
     *
     * @param tableName
     * @param index     the index zero is the first row at the data rows , not include the header
     * @return
     */
    public List<String> getRowAsList(String tableName, int index) {
        return this.csvFile.getTableByName(tableName).getRowAsList(index);
    }

    public String getRowAsCSV(String tableName, int index) {
        return this.csvFile.getTableByName(tableName).getRowAsCSV(index);
    }

    private class TimeStampComparator implements Comparator<String> {

        @Override
        public int compare(String time1, String time2) {
            if (time1 == time2) return 0;

            return (int) (Long.valueOf(time1) - Long.valueOf(time2));


        }
    }
}
