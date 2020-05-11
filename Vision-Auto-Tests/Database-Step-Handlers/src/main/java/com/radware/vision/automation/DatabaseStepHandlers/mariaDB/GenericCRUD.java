package com.radware.vision.automation.DatabaseStepHandlers.mariaDB;

import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionSingleton;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.VisionDBSchema;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.lang.String.format;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 5/11/2020
 * Time: 12:29 AM
 */
public class GenericCRUD {
    private static JDBCConnectionSingleton jdbcConnection = JDBCConnectionSingleton.getInstance();

    public static <T> T readSingleValue(VisionDBSchema schema, String columnName, String tableName, String where) throws Exception {

        Connection dbConnection = jdbcConnection.getDBConnection(schema);
        Statement statement = dbConnection.createStatement();
        ResultSet resultSet = statement.executeQuery(format("SELECT %s FROM %s WHERE %s;", columnName, tableName, where));
        resultSet.last();
        if (resultSet.getRow() == 0) throw new Exception("No rows was found with the condition you provide.");
        if (resultSet.getRow() > 1) throw new Exception("The condition you provide returns more than one row.");
        T result = (T) resultSet.getObject(1);

        return result;
    }

    public static void updateSingleValue(VisionDBSchema schema, String tableName, String where, String columnName, Object newValue) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put(columnName, newValue);
        updateGroupOfValues(schema, tableName, where, map);
    }

    public static void updateGroupOfValues(VisionDBSchema schema, String tableName, String where, Map<String, Object> values) throws Exception {

        Connection dbConnection = jdbcConnection.getDBConnection(schema);
        Statement statement = dbConnection.createStatement();
        List<String> updateValues = new ArrayList<>();
        values.forEach((key, value) -> updateValues.add(format("%s=%s", key, valueOfByType(value))));
        String updateQuery = String.join(",", updateValues);
        String query = format("UPDATE %s SET %s WHERE %s;", tableName, updateQuery, where);
        int i = statement.executeUpdate(query);
    }

    private static String valueOfByType(Object value) {
        if (value instanceof String) return format("'%s'", value);
        return value.toString();
    }
}
