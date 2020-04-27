package com.radware.vision.infra.testhandlers.csv.model;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class CSVFile {


    private List<Metadata> tablesMetaData;
    private List<CSVTable> tables;
    private String csvFileDir;
    private String csvFileName;
    private String command;
    private String csvSeparator;

    private List<String> EmptyTableMessages = new ArrayList<>(Arrays.asList("NO DATA FOR SELECTED DATA SOURCE"));

    public CSVFile(String csvFileDir, String csvFileName, String csvSeparator, List<Metadata> tablesMetaData) {
        this.csvFileDir = csvFileDir;
        this.csvFileName = csvFileName;
        this.csvSeparator = csvSeparator;
        this.tablesMetaData = tablesMetaData;
        this.command = "cat \"" + csvFileDir + csvFileName + "\"";
        parseCSVToTables();
    }

    private void parseCSVToTables() {
//          kVision
//             RestTestBase restTestBase = new RestTestBase();
        this.tables = new ArrayList<>();

//      kVision
//        CliOperations.runCommand(restTestBase.getRootServerCli(), "tail -c 1 \"" + csvFileDir + csvFileName + "\"");
//        if (!CliOperations.lastOutput.split("\r\n")[1].equals(""))
//            CliOperations.runCommand(restTestBase.getRootServerCli(), "echo \"\" >>  \"" + csvFileDir + csvFileName + "\"");
//        CliOperations.runCommand(restTestBase.getRootServerCli(), this.command);

        List<String> csvContent = Arrays.asList(CliOperations.lastOutput.split("\r\n"));
        //The following cloned because can't remove or change csvContent because Arrays.asList return final occurrences.
        List<String> csvContent_Cloned = new ArrayList<>(csvContent);
        csvContent_Cloned.remove(0); // the first index contains the command
        csvContent_Cloned.remove(csvContent_Cloned.size() - 1);

        int lastIndexFound = -1;
        for (Metadata tableData : tablesMetaData) {

            if (tableData.header == null) tableData.header = "";

            //find the header in csvContent_Cloned
            List<String> listToSearch = csvContent_Cloned.subList(lastIndexFound + 1, csvContent_Cloned.size());
            int startIndex;
            if (!tableData.header.equals(""))
                startIndex = listToSearch.indexOf(tableData.header);
            else startIndex = findFirstNoDataMessage(listToSearch);

            if (startIndex == -1) BaseTestUtils.report(tableData.header + " is not exist in csv file", Reporter.FAIL);
            else {
                tableData.headerRowNumber = startIndex + lastIndexFound + 1;
                lastIndexFound = startIndex + lastIndexFound + 1;
            }
        }


        for (int i = 0; i < tablesMetaData.size(); i++) {
            Metadata tableMetaData = tablesMetaData.get(i);
            CSVTable csvTable;

            if (tableMetaData.header == null || tableMetaData.header.equals("")) {
                csvTable = new CSVTable(tableMetaData.header, this.csvSeparator, tableMetaData.tableName, null);

            } else {
                List<String> tableRows;
                if (i == (tablesMetaData.size() - 1)) {
                    tableRows = csvContent_Cloned.subList(tableMetaData.headerRowNumber, csvContent_Cloned.size());
                } else {
                    tableRows = csvContent_Cloned.subList(tableMetaData.headerRowNumber, tablesMetaData.get(i + 1).headerRowNumber);
                }


                List<String> tableRowsClone = new ArrayList<>(tableRows);


                tableRowsClone.removeIf(row -> row.equals("") || row.matches(",*") || row.matches("\\s*") ||
                        row.split(csvSeparator).length != tableRows.get(0).split(csvSeparator).length);

                if (tableRowsClone.size() > 1)
                    csvTable = new CSVTable(tableRows.get(0), this.csvSeparator, tableMetaData.tableName, tableRowsClone.subList(1, tableRowsClone.size()));

                else csvTable = new CSVTable(tableRows.get(0), this.csvSeparator, tableMetaData.tableName, null);

            }
            this.tables.add(csvTable);

        }


    }

    private int findFirstNoDataMessage(List<String> listToSearch) {
        int firstIndex = listToSearch.size();
        for (String msg : EmptyTableMessages) {
            int found_index = listToSearch.indexOf(msg);

            if (found_index < firstIndex) firstIndex = found_index;
        }
        if (firstIndex == listToSearch.size()) {
            BaseTestUtils.report("No Empty Table Message was Found", Reporter.FAIL);
            return -1;
        }
        return firstIndex;
    }

    public String getCsvFileDir() {
        return csvFileDir;
    }

    public String getCsvFileName() {
        return csvFileName;
    }

    public String getCsvSeparator() {
        return csvSeparator;
    }


    public CSVTable getTableByName(String tableName) {
        if (isTableExistByName(tableName))
            return tables.stream().filter(table -> table.getTableName().equals(tableName)).findFirst().get();
        BaseTestUtils.report(tableName + " is not found", Reporter.FAIL);
        return null;
    }


    public boolean isTableExistByName(String tableName) {
        return tables.stream().filter(table -> table.getTableName().equals(tableName)).findFirst().isPresent();

    }

    public static class Metadata implements Comparable<Metadata> {
        String tableName;
        String header;
        int headerRowNumber;

        public Metadata(String tableName, String header) {
            this.tableName = tableName;
            this.header = header;
        }

        @Override
        public int compareTo(Metadata otherTable) {
            return this.headerRowNumber - otherTable.headerRowNumber;
        }
    }

    public enum EmptyTableMessages {

        NO_DATA_FOR_SELECTED_DATA_SOURCE("NO DATA FOR SELECTED DATA SOURCE");

        private String message;

        private EmptyTableMessages(String message) {
            this.message = message;
        }

        public String getMessage() {
            return this.message;
        }
    }
}
