package com.radware.vision.automation.DatabaseStepHandlers.mariaDB;

import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionException;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionSingleton;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.VisionDBSchema;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Optional;

import static java.lang.String.format;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 5/11/2020
 * Time: 12:29 AM
 */
public class GenericCRUD {
    private static JDBCConnectionSingleton jdbcConnection = JDBCConnectionSingleton.getInstance();

    public <T> Optional<T> getOneValue(VisionDBSchema schema, String columnName, String tableName, String where) throws JDBCConnectionException, SQLException {
        Connection dbConnection = jdbcConnection.getDBConnection(schema);
        Statement statement = dbConnection.createStatement();
        statement.executeQuery(format("SELECT %s from %s Where %s",columnName,tableName,where));

        return null;
    }
}
