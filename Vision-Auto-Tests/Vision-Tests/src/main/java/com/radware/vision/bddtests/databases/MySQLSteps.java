package com.radware.vision.bddtests.databases;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.Operators.Comparator;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.GenericCRUD;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionException;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.VisionDBSchema;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.utils.StepsParametersUtils;
import cucumber.api.java.en.Then;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/10/2020
 * Time: 5:22 PM
 */
public class MySQLSteps extends WebUITestBase {


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
            } else if (rowsUpdated == 0)
                BaseTestUtils.report("0 records was updated", Reporter.FAIL);

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
            } else if (rowsUpdated == 0)
                BaseTestUtils.report("0 records was updated", Reporter.FAIL);

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
            } else if (rowsUpdated == 0)
                BaseTestUtils.report("0 records was updated", Reporter.FAIL);

        } catch (JDBCConnectionException | SQLException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
    @Then("^MYSQL Validate Number of Records FROM \"([^\"]*)\" Table in \"([^\"]*)\" Schema WHERE \"([^\"]*)\" ([^\"]*) (\\d+)$")
    public void validateNumberofRecords(String tableName, VisionDBSchema schema, String whereCondition,OperatorsEnum operation, Integer expectedNumberOfRecords){

    }

}
