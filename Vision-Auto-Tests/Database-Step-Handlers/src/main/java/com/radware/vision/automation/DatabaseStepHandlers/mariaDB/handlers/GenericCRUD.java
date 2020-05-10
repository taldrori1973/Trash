package com.radware.vision.automation.DatabaseStepHandlers.mariaDB.handlers;

import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionException;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionSingleton;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.VisionDBSchema;

import java.sql.Connection;
import java.util.Optional;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 5/11/2020
 * Time: 12:13 AM
 */
public class GenericCRUD {

    private static JDBCConnectionSingleton connection = JDBCConnectionSingleton.getInstance();

    public <T> Optional<T> selectOneValue(String columnName, String fromTable, String where, VisionDBSchema schema) throws JDBCConnectionException {
        Connection schemaConnection = connection.getDBConnection(schema);
        return null;
    }
}
