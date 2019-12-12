package com.radware.vision.bddtests.VRM;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.CompareMethod;
import com.radware.vision.infra.testhandlers.csv.CSVTestHandler;
import com.radware.vision.infra.testhandlers.csv.model.CSVFile;
import cucumber.api.java.en.Then;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class CSVReportSteps extends BddUITestBase {


    public CSVReportSteps() throws Exception {
    }

    @Then("^CSV Read CSV File \"([^\"]*)\"(?: from \"([^\"]*)\" Directory)?(?: with CSV Separator \"([^\"]*)\")?$")
    public void csvReadCSVFileFromDirectoryWithCSVSeparator(String fileName, String fileDir, String separator, List<CSVFile.Metadata> metaDataList) {
        if (fileDir == null) fileDir = "/opt/radware/mgt-server/third-party/tomcat/bin/";
        if (separator == null) separator = ",";

        CSVTestHandler csvTestHandler = CSVTestHandler.getInstance(fileDir, fileName, separator, metaDataList);

    }

    @Then("^CSV Validate \"([^\"]*)\" Table Size Equals to (\\d+)$")
    public void csvValidateTableSizeEqualsToNumber(String tableName, int expectedSize) {
        CSVTestHandler csvTestHandler = CSVTestHandler.getInstance();

        if (csvTestHandler.getTableNumberOfRows(tableName) != expectedSize) {
            BaseTestUtils.report(tableName + " Table Actual Size is " + csvTestHandler.getTableNumberOfRows(tableName) + " and the Expected Size is " + expectedSize, Reporter.FAIL);
        }

    }

    @Then("^CSV Validate Row Number (\\d+) at \"([^\"]*)\" Table Equals to \"(.*)\" Regex$")
    public void csvValidateRowNumberAtTableEqualsTo(int rowNumber, String tableName, String expectedRow) {
        CSVTestHandler csvTestHandler = CSVTestHandler.getInstance();
        String expectedRowForErrorLog = expectedRow;
        expectedRow = "^".concat(expectedRow).concat("$");
        Pattern pattern = Pattern.compile(expectedRow);
        String actualRow = csvTestHandler.getRowAsCSV(tableName, rowNumber);
        Matcher matcher = pattern.matcher(actualRow);

//        if (!actualRow.equals(expectedRow))
        if (!matcher.matches())
            BaseTestUtils.report(String.format("Row Number %d at Table \"%s\" Equals to \"%s\" , The Expected Row Value is \"%s\""
                    , rowNumber, tableName, actualRow, expectedRowForErrorLog), Reporter.FAIL);
    }

    @Then("^CSV Validate Column \"([^\"]*)\" at \"([^\"]*)\" Table is Sorted \"(BIT_BYTE_UNITS|ALPHABETICAL|NUMERICAL|IPORVERSIONS|DATE)\"$")
    public void csvValidateColumnAtTableIsSorted(String columnName, String tableName, String method) {

        CSVTestHandler csvTestHandler = CSVTestHandler.getInstance();

        csvTestHandler.isSortedByColumn(tableName, columnName, CompareMethod.getEnumByString(method));
    }

    @Then("^CSV Validate Value Frequency Under \"([^\"]*)\" Column at \"([^\"]*)\" Table$")
    public void csvValidateValueFrequencyUnderColumnAtTable(String columnName, String tableName, Map<String, Integer> frequency) {
        CSVTestHandler csvTestHandler = CSVTestHandler.getInstance();

        List<String> errorMessage = new ArrayList<>();

        for (Map.Entry<String, Integer> entry : frequency.entrySet()) {
            int actual;
            if ((actual = csvTestHandler.getValueFrequencyOfColumn(tableName, columnName, entry.getKey())) != entry.getValue())
                errorMessage.add(String.format("The value \"%s\" appear %d times , but expected to appear %d times at table \"%s\", Column \"%s\"",
                        entry.getKey(), actual, entry.getValue(), tableName, columnName));
        }

        if (!errorMessage.isEmpty())
            BaseTestUtils.report("Some Values Frequency not as expected \n" + errorMessage.toString(), Reporter.FAIL);

    }
}









