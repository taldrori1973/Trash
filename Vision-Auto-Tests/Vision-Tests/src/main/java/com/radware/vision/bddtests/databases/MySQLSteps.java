package com.radware.vision.bddtests.databases;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.Operators.Comparator;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.GenericCRUD;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionException;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.VisionDBSchema;
import com.radware.vision.base.WebUITestBase;
import cucumber.api.java.en.Then;
import org.apache.commons.lang3.math.NumberUtils;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/10/2020
 * Time: 5:22 PM
 */
public class MySQLSteps extends WebUITestBase {


    @Then("^MYSQL Validate Single Value by SELECT \"([^\"]*)\" Column FROM \"([^\"]*)\" Schema and \"([^\"]*)\" Table WHERE \"([^\"]*)\" ([^\"]*) \"([^\"]*)\"$")
    public void mysqlValidateSingleValueBySELECTColumnFROMSchemaAndTableWHEREEQUALS(String columnName, VisionDBSchema schema, String tableName, String whereCondition, OperatorsEnum operation, String value) {
        try {
            if (columnName.isEmpty() || tableName.isEmpty())
                BaseTestUtils.report("Column Name or Table Name is Empty", Reporter.FAIL);

            String resultValue = GenericCRUD.selectSingleValue(schema, columnName, tableName, whereCondition).toString();

            boolean result = Comparator.compareResults(value, resultValue, operation, null);
            if (!result)
                BaseTestUtils.report(
                        Comparator.failureMessage, Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @Then("^MYSQL UPDATE \"([^\"]*)\" Table in \"([^\"]*)\" Schema SET \"([^\"]*)\" Column Value as \"([^\"]*)\" Where \"([^\"]*)\"(?: And Validate (\\d+) Records Was Updated)?$")
    public void mysqlUPDATETableInSchemaSETColumnValueAsWhere(String tableName, VisionDBSchema schema, String columnName, String value, String whereCondition, Integer expectedRowsToUpdate) {
        try {
            Object valueToSet = valueOf(value);
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


    @Then("^MYSQL UPDATE \"([^\"]*)\" Table in \"([^\"]*)\" Schema SET The Following Columns Values Where \"([^\"]*)\"(?: And Validate (\\d+) Records Was Updated)?$")
    public void mysqlUPDATETableInSchemaSETTheFollowingColumnsValuesWhereAndValidateRecordsWasUpdated(String tableName, VisionDBSchema schema, String whereCondition, Integer expectedRowsToUpdate, Map<String, String> newValues) {
        try {
            Map<String, Object> valuesToUpdate = new HashMap<>();
            newValues.forEach((key, value) -> valuesToUpdate.put(key, valueOf(value)));
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

    public static Object valueOf(String value) {
        if (value.equalsIgnoreCase("null")) return null;
        if (value.equalsIgnoreCase("true") || value.equalsIgnoreCase("false")) return Boolean.valueOf(value);
        if (NumberUtils.isNumber(value)) return NumberUtils.createNumber(value);
        return value;
    }

    @Then("^MYSQL DELETE FROM \"([^\"]*)\" Table in \"([^\"]*)\" Schema WHERE \"([^\"]*)\" And Validate (\\d+) Records Was Updated$")
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
}
