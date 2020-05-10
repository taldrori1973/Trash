package com.radware.vision.automation.DatabaseStepHandlers.mariaDB;

import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionSingleton;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.VisionDBSchema;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import static java.lang.String.format;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 5/11/2020
 * Time: 12:29 AM
 */
public class GenericCRUD {
    private static JDBCConnectionSingleton jdbcConnection = JDBCConnectionSingleton.getInstance();

    public static <T> T getOneValue(VisionDBSchema schema, String columnName, String tableName, String where) throws Exception {

        Connection dbConnection = jdbcConnection.getDBConnection(schema);
        Statement statement = dbConnection.createStatement();
        ResultSet resultSet = statement.executeQuery(format("SELECT %s FROM %s WHERE %s;", columnName, tableName, where));
        resultSet.last();
        if (resultSet.getRow() == 0) throw new Exception("No rows was found with the condition you provide.");
        if (resultSet.getRow() > 1) throw new Exception("The condition you provide returns more than one row.");
        T result = (T) resultSet.getObject(1);

        return result;
    }
}
