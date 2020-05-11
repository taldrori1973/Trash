package com.radware.vision.automation.DatabaseStepHandlers.mariaDB;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionException;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionSingleton;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.VisionDBSchema;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import static java.lang.String.format;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 5/11/2020
 * Time: 12:29 AM
 */
public class GenericCRUD {
    private static JDBCConnectionSingleton jdbcConnection = JDBCConnectionSingleton.getInstance();

    /**
     * @param schema     Table Database Schema from {@link VisionDBSchema}
     * @param columnName The column name of the value to be returned
     * @param tableName  The table name
     * @param where      the condition where to search for the row , in this method the condition should return one row to return single value
     * @param <T>        Generic Result Type
     * @return One value which is the under column name of the row that returned from the where
     * @throws Exception
     */
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

    public static void readAll(VisionDBSchema schema, String tableName, String where, String... columns) throws SQLException, JDBCConnectionException {
        Connection dbConnection = jdbcConnection.getDBConnection(schema);
        try (Statement statement = dbConnection.createStatement()) {
            String queryColumns = "*";
            if (columns != null && columns.length > 0) queryColumns = String.join(",", columns);
            ResultSet resultSet = statement.executeQuery("select * from vision_license;");

            List<Map<String, Object>> mapList = new ArrayList<>();

            while (resultSet.next()) {
                int columnCount = resultSet.getMetaData().getColumnCount();
                Map<String, Object> map = new LinkedHashMap<>();
                for (int i = 1; i <= columnCount; i++)
                    map.put(resultSet.getMetaData().getColumnName(i), resultSet.getObject(i));
                mapList.add(map);
            }

            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.valueToTree(mapList);
        }

    }

    public static int updateSingleValue(VisionDBSchema schema, String tableName, String where, String columnName, Object newValue) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put(columnName, newValue);
        return updateGroupOfValues(schema, tableName, where, map);
    }

    public static int updateGroupOfValues(VisionDBSchema schema, String tableName, String where, Map<String, Object> values) throws Exception {

        Connection dbConnection = jdbcConnection.getDBConnection(schema);
        Statement statement = dbConnection.createStatement();
        List<String> updateValues = new ArrayList<>();
        values.forEach((key, value) -> updateValues.add(format("%s=%s", key, valueOfByType(value))));
        String updateQuery = String.join(",", updateValues);
        String query = format("UPDATE %s SET %s WHERE %s;", tableName, updateQuery, where);
        return statement.executeUpdate(query);
    }

    public static int deleteRecords(VisionDBSchema schema, String tableName, String where) throws JDBCConnectionException, SQLException {
        Connection dbConnection = jdbcConnection.getDBConnection(schema);
        Statement statement = dbConnection.createStatement();
        String query = format("DELETE FROM %s WHERE %s; ", tableName, where);
        return statement.executeUpdate(query);
    }

    public static int insertRecord(VisionDBSchema schema, String tableName, LinkedHashMap<String, Object> record) throws SQLException, JDBCConnectionException {

        Connection dbConnection = jdbcConnection.getDBConnection(schema);

        List<String> columnsArray = new ArrayList<>(record.keySet());
        List<String> valuesArray = new ArrayList<>();

        record.values().forEach(value -> valuesArray.add(valueOfByType(value)));


        String columns = format("(%s)", String.join(",", columnsArray));
        String values = format("(%s)", String.join(",", valuesArray));

        String query = format("insert into %s %s values %s;", tableName, columns, values);
        Statement statement = dbConnection.createStatement();
        return statement.executeUpdate(query);
    }

    private static String valueOfByType(Object value) {
        if (value == null) return null;
        if (value instanceof String) return format("'%s'", value);
        return value.toString();
    }
}
