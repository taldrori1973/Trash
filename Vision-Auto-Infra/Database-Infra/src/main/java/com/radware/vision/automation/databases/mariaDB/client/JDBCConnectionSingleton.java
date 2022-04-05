package com.radware.vision.automation.databases.mariaDB.client;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;


public class JDBCConnectionSingleton {
    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static String DB_URL_PATTERN = "jdbc:mysql://%s:%s/%s";

    private int localPort;
    private Session session;
    private String host;
    private String dbUserNme;
    private String dbPassword;
    private String serverUserName;
    private String serverPassword;
    private Map<VisionDBSchema, Connection> openConnections;
    private static JDBCConnectionSingleton _instance = new JDBCConnectionSingleton();

    private JDBCConnectionSingleton() {
        super();
        this.host = SUTManagerImpl.getInstance().getClientConfigurations().getHostIp();
        this.dbUserNme = SUTManagerImpl.getInstance().getClientConfigurations().getSqlDbConnectionUsername();
        this.dbPassword = SUTManagerImpl.getInstance().getClientConfigurations().getSqlDbConnectionPassword();
        this.serverUserName = SUTManagerImpl.getInstance().getCliConfigurations().getRootServerCliUserName();
        this.serverPassword = SUTManagerImpl.getInstance().getCliConfigurations().getRootServerCliPassword();
        this.openConnections = new HashMap();
    }

    public static JDBCConnectionSingleton getInstance() {
        return _instance;
    }

    public Connection getDBConnection(VisionDBSchema schema) throws JDBCConnectionException {
        if (openConnections.containsKey(schema)) {
            Connection currentConnection = openConnections.get(schema);
            if (isConnectionStillUp(currentConnection)) return currentConnection;
            openConnections.remove(schema);
        }

        try {
            if (this.session == null || !this.session.isConnected()) connectSshSession();
            Connection newConnection = createSchemaConnection(schema);
            this.openConnections.put(schema, newConnection);
            return openConnections.get(schema);

        } catch (JSchException | InstantiationException | SQLException | IllegalAccessException | ClassNotFoundException e) {
            throw new JDBCConnectionException(e.getMessage());
        }
    }

    private boolean isConnectionStillUp(Connection connection) {
        Statement statement = null;
        try {
            statement = connection.createStatement();
            ResultSet result = statement.executeQuery("SELECT 1");
            if (result.next() && result.getInt(1) == 1) return true;
        } catch (SQLException e) {
            return false;
        }
        return false;
    }

    public void closeAllConnections() {
        try {
            for (VisionDBSchema conn : this.openConnections.keySet()) {
                openConnections.get(conn).close();
            }
            this.openConnections.clear();
            this.session.disconnect();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void connectSshSession() throws JSchException {
        Properties properties = new Properties();
        properties.put("StrictHostKeyChecking", "no");
        JSch jsch = new JSch();
        session = jsch.getSession(serverUserName, host, 22);
        session.setPassword(serverPassword);
        session.setConfig(properties);
        session.connect();
        localPort = Integer.parseInt(SUTManagerImpl.getInstance().getClientConfigurations().getSqlDbConnectionDefaultPort());
    }

    private Connection createSchemaConnection(VisionDBSchema schema) throws ClassNotFoundException, IllegalAccessException, InstantiationException, SQLException {
        Connection connection = null;
        Class.forName(JDBC_DRIVER).newInstance();
        String url = String.format(DB_URL_PATTERN, host, localPort, schema.toString().toLowerCase());
        connection = DriverManager.getConnection(url, dbUserNme, dbPassword);
        return connection;
    }

}
