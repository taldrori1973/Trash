package com.radware.vision.infra.visionDatabase.jdbc;

import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

public class JDBCConnectionSingleton {
    private static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DB_USER_NAME = "root";
    private static final String DB_PASSWORD = "rad123";
    private static final String SERVER_USER_NAME = "root";
    private static final String SERVER_PASSWORD = "radware";
    private static String DB_URL_PATTERN = "jdbc:mysql://localhost:%s/%s";

    private int localPort;
    private Session session;
    private boolean privilegesGranted;
    private SUTManager sutManager;
    private String host;
    private Map<VisionDBSchema, Connection> openConnections;

    private static JDBCConnectionSingleton _instance = new JDBCConnectionSingleton();

    private JDBCConnectionSingleton() {
        super();
        this.sutManager = SUTManagerImpl.getInstance();
        this.host = sutManager.getClientConfigurations().getHostIp();
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
//            if (!privilegesGranted) grantAllPrivilegesToConnectDP();
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


    private void grantAllPrivilegesToConnectDP() {
//        kVision
//          CliOperations.runCommand(restTestBase.getRootServerCli(),
//                "mysql -uroot -prad123 -e \"grant all on *.* to 'root'@'" + host + "' identified by 'rad123'\"");
//          privilegesGranted = true;
    }

    private void connectSshSession() throws JSchException {
        Properties properties = new Properties();
        properties.put("StrictHostKeyChecking", "no");
        JSch jsch = new JSch();
        session = jsch.getSession(SERVER_USER_NAME, host, 22);
        session.setPassword(SERVER_PASSWORD);
        session.setConfig(properties);
        session.connect();
        localPort = session.setPortForwardingL(0, host, 3306);
    }

    private Connection createSchemaConnection(VisionDBSchema schema) throws ClassNotFoundException, IllegalAccessException, InstantiationException, SQLException {
        Connection connection = null;
        Class.forName(JDBC_DRIVER).newInstance();
        String url = String.format(DB_URL_PATTERN, localPort, schema.toString().toLowerCase());
        connection = DriverManager.getConnection(url, DB_USER_NAME, DB_PASSWORD);
        return connection;
    }

}
