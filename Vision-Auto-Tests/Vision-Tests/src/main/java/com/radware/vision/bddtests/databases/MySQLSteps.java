package com.radware.vision.bddtests.databases;

import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.VisionDBSchema;
import com.radware.vision.base.WebUITestBase;
import cucumber.api.java.en.Then;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/10/2020
 * Time: 5:22 PM
 */
public class MySQLSteps extends WebUITestBase {
    @Then("^MYSQL Validate Single Value by SELECT \"([^\"]*)\" Column FROM \"([^\"]*)\" Schema and \"([^\"]*)\" Table WHERE \"([^\"]*)\" EQUALS \"([^\"]*)\"$")
    public void mysqlValidateSingleValueBySELECTColumnFROMSchemaAndTableWHEREEQUALS(String columnName, VisionDBSchema schema, String tableName, String whereCondition, String value) throws Throwable {
    }
}
