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
     * @param where      the condition where to search for the record , in this method the condition should return one record to return single value
     * @param <T>        Generic Result Type
     * @return One value which is under the column name of the record that returned from the where
     * @throws Exception
     */
    public static <T> T selectSingleValue(VisionDBSchema schema, String columnName, String tableName, String where) throws Exception {

        Connection dbConnection = jdbcConnection.getDBConnection(schema);
        Statement statement = dbConnection.createStatement();
        ResultSet resultSet = statement.executeQuery(format("SELECT %s FROM %s WHERE %s;", columnName, tableName, where));
        resultSet.last();
        if (resultSet.getRow() == 0) throw new Exception("No rows was found with the condition you provide.");
        if (resultSet.getRow() > 1) throw new Exception("The condition you provide returns more than one row.");
        T result = (T) resultSet.getObject(1);

        return result;
    }

    /**
     * @param schema    Table Database Schema from {@link VisionDBSchema}
     * @param tableName The table name
     * @param columns   Optional Array of column names that will return as JSON properties , this is the same of values you set after SELECT on SQL Query
     *                  for example :   SELECT columnName1,columnName2
     *                  if no column names was provided is the same as SELECT *
     * @return Returns JSON Array of all the table records with the columns you provided as properties
     * @throws SQLException
     * @throws JDBCConnectionException
     */
    public static JsonNode selectAllTable(VisionDBSchema schema, String tableName, String... columns) throws SQLException, JDBCConnectionException {

        return selectTable(schema, tableName, null, columns);
    }


    /**
     * @param schema    Table Database Schema from {@link VisionDBSchema}
     * @param tableName The table name
     * @param where     The condition for searching specific records , if the "where" is null will return all the records
     * @param columns   Optional Array of column names that will return as JSON properties , this is the same of values you set after SELECT on SQL Query
     *                  for example :   SELECT columnName1,columnName2
     *                  if no column names was provided is the same as SELECT *
     * @return Returns JSON Array of all the table records that apply on the "where" condition with the columns you provided as properties
     * @throws SQLException
     * @throws JDBCConnectionException
     */
    public static JsonNode selectTable(VisionDBSchema schema, String tableName, String where, String... columns) throws SQLException, JDBCConnectionException {
        Connection dbConnection = jdbcConnection.getDBConnection(schema);
        try (Statement statement = dbConnection.createStatement()) {
            String queryColumns = "*";
            if (columns != null && columns.length > 0) queryColumns = String.join(",", columns);

            String query = format("SELECT %s FROM %s WHERE %s;", queryColumns, tableName, where);
            if (where == null || where.isEmpty()) query = format("SELECT %s FROM %s;", queryColumns, tableName);


            ResultSet resultSet = statement.executeQuery(query);

            List<Map<String, Object>> mapList = new ArrayList<>();

            while (resultSet.next()) {
                int columnCount = resultSet.getMetaData().getColumnCount();
                Map<String, Object> map = new LinkedHashMap<>();
                for (int i = 1; i <= columnCount; i++)
                    map.put(resultSet.getMetaData().getColumnName(i), resultSet.getObject(i));
                mapList.add(map);
            }

            ObjectMapper objectMapper = new ObjectMapper();
            return objectMapper.valueToTree(mapList);
        }

    }

    /**
     * Update Single column value, if the where condition apply many records : all these records will updated with same new value
     *
     * @param schema     Table Database Schema from {@link VisionDBSchema}
     * @param tableName  The table name
     * @param where      The condition for searching specific records , if the "where" is null will return all the records
     * @param columnName The column name of the value you want to update
     * @param newValue   The new Value
     * @return Returns number of records that was updated
     * @throws Exception
     */
    public static int updateSingleValue(VisionDBSchema schema, String tableName, String where, String columnName, Object newValue) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put(columnName, newValue);
        return updateGroupOfValues(schema, tableName, where, map);
    }

    /**
     * Update multiple columns values, if the where condition apply many records : all these records will updated with same new value
     *
     * @param schema    Table Database Schema from {@link VisionDBSchema}
     * @param tableName The table name
     * @param where     The condition for searching specific records , if the "where" is null will return all the records
     * @param values    Map of column name and new values that should be updated
     * @return Returns number of records that was updated
     * @throws Exception
     */
    public static int updateGroupOfValues(VisionDBSchema schema, String tableName, String where, Map<String, Object> values) throws Exception {

        Connection dbConnection = jdbcConnection.getDBConnection(schema);
        Statement statement = dbConnection.createStatement();
        List<String> updateValues = new ArrayList<>();
        values.forEach((key, value) -> updateValues.add(format("%s=%s", key, valueOfByType(value))));
        String updateQuery = String.join(",", updateValues);
        String query = format("UPDATE %s SET %s WHERE %s;", tableName, updateQuery, where);
        if (where == null || where.isEmpty()) query = format("UPDATE %s SET %s;", tableName, updateQuery);
        return statement.executeUpdate(query);
    }

    /**
     * Delete one or more records according to the where condition
     *
     * @param schema    Table Database Schema from {@link VisionDBSchema}
     * @param tableName The table name
     * @param where     The condition for searching specific records , if the "where" is null will return all the records
     * @return Returns number of records that was deleted
     * @throws JDBCConnectionException
     * @throws SQLException
     */
    public static int deleteRecords(VisionDBSchema schema, String tableName, String where) throws JDBCConnectionException, SQLException {
        Connection dbConnection = jdbcConnection.getDBConnection(schema);
        Statement statement = dbConnection.createStatement();
        String query = format("DELETE FROM %s WHERE %s; ", tableName, where);
        if (where == null || where.isEmpty()) query = format("DELETE FROM %s;", tableName);
        return statement.executeUpdate(query);
    }


    /**
     * Insert new record to the end of the table
     *
     * @param schema    Table Database Schema from {@link VisionDBSchema}
     * @param tableName The table name
     * @param record    {@link LinkedHashMap} of columns and values to insert as record to the table
     * @return Returns number of records that was Inserted, i.e: 1 if the record was inserted and 0 else
     * @throws SQLException
     * @throws JDBCConnectionException
     */
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

    /**
     * This is private method which accept value as {@link Object} and return String as follows
     *
     * @param value
     * @return      if the Object is null returns null
     *              if the object is String will return String with ('') foe example vision will return as 'vision'
     *              else return the same Object as String
     */
    private static String valueOfByType(Object value) {
        if (value == null) return null;
        if (value instanceof String) return format("'%s'", value);
        return value.toString();
    }
}
