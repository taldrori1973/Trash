package com.radware.vision.bddtests.databases;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.Operators.Comparator;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.automation.databases.mariaDB.GenericCRUD;
import com.radware.vision.automation.databases.mariaDB.client.JDBCConnectionException;
import com.radware.vision.automation.databases.mariaDB.client.VisionDBSchema;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.utils.StepsParametersUtils;
import cucumber.api.java.en.Then;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/10/2020
 * Time: 5:22 PM
 */
public class MySQLSteps extends VisionUITestBase {


    public MySQLSteps() throws Exception {
    }

    @Then("^MYSQL Validate Single Value by SELECT \"([^\"]*)\" Column FROM \"([^\"]*)\" Schema and \"([^\"]*)\" Table WHERE \"([^\"]*)\" ([^\"]*) (.*)$")
    public void mysqlValidateSingleValueBySELECTColumnFROMSchemaAndTableWHEREEQUALS(String columnName, VisionDBSchema schema, String tableName, String whereCondition, OperatorsEnum operation, String value) {
        try {
            boolean result = true;

            if (columnName.isEmpty() || tableName.isEmpty())
                BaseTestUtils.report("Column Name or Table Name is Empty", Reporter.FAIL);

            Object resultValue = GenericCRUD.selectSingleValue(schema, columnName, tableName, whereCondition);
            Object expectedValue = StepsParametersUtils.valueOf(value);

            if (resultValue != null && expectedValue != null) {

                if (!resultValue.getClass().equals(expectedValue.getClass()))
                    BaseTestUtils.report("The Expected and Actual Values not From the same type", Reporter.FAIL);

                if (resultValue instanceof String && expectedValue instanceof String)
                    result = Comparator.compareResults(expectedValue.toString(), resultValue.toString(), operation, null);
                else if (resultValue != expectedValue) {
                    result = false;
                    Comparator.failureMessage = "Actual \"" + resultValue + "\" is not equal to \"" + expectedValue + "\"";
                }
                if (!result)
                    BaseTestUtils.report(
                            Comparator.failureMessage, Reporter.FAIL);
            } else if (resultValue != null ^ expectedValue != null) {

                Object expectedToReport = expectedValue instanceof String ? "\"" + expectedValue + "\"" : expectedValue;
                Object actualToReport = resultValue instanceof String ? "\"" + resultValue + "\"" : resultValue;
                BaseTestUtils.report(
                        "One Value is Null and the other not null \n Expected Value: " + expectedToReport + " Actual Value: " + actualToReport, Reporter.FAIL)
                ;
            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }


    @Then("^MYSQL UPDATE \"([^\"]*)\" Table in \"([^\"]*)\" Schema SET \"([^\"]*)\" Column Value as (.*) WHERE \"([^\"]*)\"(?: And VALIDATE (\\d+) Records Was Updated)?$")
    public void mysqlUPDATETableInSchemaSETColumnValueAsWhere(String tableName, VisionDBSchema schema, String columnName, String value, String whereCondition, Integer expectedRowsToUpdate) {
        try {
            Object valueToSet = StepsParametersUtils.valueOf(value);
            int rowsUpdated = GenericCRUD.updateSingleValue(schema, tableName, whereCondition, columnName, valueToSet);
            if (expectedRowsToUpdate != null) {
                if (rowsUpdated != expectedRowsToUpdate)
                    BaseTestUtils.report(String.format("The Expected number of records to be updated is %d but actual records updated is %d", expectedRowsToUpdate, rowsUpdated), Reporter.FAIL);
            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @Then("^MYSQL UPDATE \"([^\"]*)\" Table in \"([^\"]*)\" Schema SET The Following Columns Values WHERE \"([^\"]*)\"(?: And VALIDATE (\\d+) Records Was Updated)?$")
    public void mysqlUPDATETableInSchemaSETTheFollowingColumnsValuesWhereAndValidateRecordsWasUpdated(String tableName, VisionDBSchema schema, String whereCondition, Integer expectedRowsToUpdate, Map<String, String> newValues) {
        try {
            Map<String, Object> valuesToUpdate = new HashMap<>();
            newValues.forEach((key, value) -> valuesToUpdate.put(key, StepsParametersUtils.valueOf(value)));
            int rowsUpdated = GenericCRUD.updateGroupOfValues(schema, tableName, whereCondition, valuesToUpdate);

            if (expectedRowsToUpdate != null) {
                if (rowsUpdated != expectedRowsToUpdate)
                    BaseTestUtils.report(String.format("The Expected number of records to be updated is %d but actual records updated is %d", expectedRowsToUpdate, rowsUpdated), Reporter.FAIL);
            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @Then("^MYSQL DELETE FROM \"([^\"]*)\" Table in \"([^\"]*)\" Schema WHERE \"([^\"]*)\"(?: And VALIDATE (\\d+) Records Was Deleted)?$")
    public void mysqlDELETEFROMTableInSchemaWHEREAndValidateRecordsWasUpdated(String tableName, VisionDBSchema schema, String whereCondition, Integer expectedRowsToUpdate) {
        try {
            int rowsUpdated = GenericCRUD.deleteRecords(schema, tableName, whereCondition);
            if (expectedRowsToUpdate != null) {
                if (rowsUpdated != expectedRowsToUpdate)
                    BaseTestUtils.report(String.format("The Expected number of records to be deleted is %d but actual records deleted is %d", expectedRowsToUpdate, rowsUpdated), Reporter.FAIL);
            }

        } catch (JDBCConnectionException | SQLException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^MYSQL Validate Number of Records FROM \"([^\"]*)\" Table in \"([^\"]*)\" Schema WHERE \"([^\"]*)\" Condition Applies ([^\"]*) (\\d+)$")
    public void validateNumberOfRecords(String tableName, VisionDBSchema schema, String whereCondition, OperatorsEnum operation, Integer expectedNumberOfRecords) {
        try {
            JsonNode result;
            if (whereCondition == null || whereCondition.isEmpty())
                result = GenericCRUD.selectAllTable(schema, tableName);
            else
                result = GenericCRUD.selectTable(schema, tableName, whereCondition);

            Integer tableSize = result.size();

            boolean compareResult = Comparator.compareResults(expectedNumberOfRecords.toString(), tableSize.toString(), operation, 0);
            if (!compareResult) BaseTestUtils.report(Comparator.failureMessage, Reporter.FAIL);

        } catch (SQLException | JDBCConnectionException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^MYSQL Validate The Time by SELECT \"([^\"]*)\" Column FROM \"([^\"]*)\" Schema and \"([^\"]*)\" Table WHERE \"([^\"]*)\" Close to (\\d+)$")
    public void validateTimeCloseTo(String columnName, VisionDBSchema schema, String tableName, String whereCondition, Integer closeTo) {
//      This Step Was refactored from com.radware.vision.bddtests.scheduledtasks.ScheduledTaskCommonTests.validateTime

        try {
            Timestamp value = GenericCRUD.selectSingleValue(schema, columnName, tableName, whereCondition);
            LocalDateTime outputDate = value.toLocalDateTime();
            outputDate = outputDate.plusHours(3);
            LocalDateTime current = LocalDateTime.now();
            double time = Duration.between(current, outputDate).toMinutes() / (60.0);
            if ((time < (closeTo - 0.1) || time > (closeTo + 0.1)))
                BaseTestUtils.report("the " + time + " is not close to " + closeTo + " ", Reporter.FAIL);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);

        }
    }

    @Then("^MYSQL Validate \"([^\"]*)\" Variable Value ([^\"]*) \"([^\"]*)\"$")
    public void validateVariables(String variableName, OperatorsEnum operatorsEnum, String expected) {
        try {
            String sqlVariable = GenericCRUD.getSQLVariable(variableName);
            boolean result = Comparator.compareResults(expected, sqlVariable, operatorsEnum, null);
            if (!result) BaseTestUtils.report(Comparator.failureMessage, Reporter.FAIL);
        } catch (JDBCConnectionException | SQLException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


}