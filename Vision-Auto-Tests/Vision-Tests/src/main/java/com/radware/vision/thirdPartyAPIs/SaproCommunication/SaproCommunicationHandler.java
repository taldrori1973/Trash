package com.radware.vision.thirdPartyAPIs.SaproCommunication;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.sapcnsl.api.SaproCommunication;
import com.sapcnsl.api.SaproCommunicationFactory;
import com.sapcnsl.api.returntypes.*;
import com.sapcnsl.exception.SaproException;
import com.sapcnsl.api.returntypes.MapListInfo;

import java.util.List;

public class SaproCommunicationHandler {
    SaproCommunication saproObj;
    String inetAddress;
    int port;

    public SaproCommunicationHandler() {
        SaproCommunicationFactory factoryObj = SaproCommunicationFactory.sessionFactory;
        this.saproObj = factoryObj.getNewSession();
        this.inetAddress = "172.17.166.8";
        this.port = 2100;
    }


    /**
     * Connection to the SimpleAgentPro Server
     *
     * @param inetAddress - String representing a server IP address. e.g. xx.xx.xx.xx or www.yahoo.com
     * @param port        - Port number of the server to connect to
     */
    private void initConnect(String inetAddress, int port) {
        try {
            BaseTestUtils.report("Connecting to " + inetAddress + " with port " + port, Reporter.PASS_NOR_FAIL);
            if (saproObj.initConnection(inetAddress, port)) {
                BaseTestUtils.report("connection to " + inetAddress + " succeeded", Reporter.PASS);
            } else {
                BaseTestUtils.reporter.report("failed to connect", Reporter.FAIL);
            }
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Connection to the SimpleAgentPro Server
     */
    private void initConnect() {
        try {
            BaseTestUtils.report("Connecting to " + this.inetAddress + " with port " + this.port, Reporter.PASS_NOR_FAIL);
            if (saproObj.initConnection(this.inetAddress, this.port)) {
                BaseTestUtils.report("connection succeeded", Reporter.PASS);
            } else {
                BaseTestUtils.reporter.report("failed to connect", Reporter.FAIL);
            }
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Closes connection
     */
    private void closeConnect() {
        try {
            saproObj.closeConnection();
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * @param mapName
     * @param devNames - list of all devices that need to be stopped
     *                 if dev is already on - nothing will change
     *                 if dev is off - start dev and also start (if necessary) the map which dev belongs to
     */
    public void startDevFromMap(String mapName, List<String> devNames) {
        try {
            this.initConnect();
            mapName = this.getFullMapName(mapName);
            for (String devName : devNames) {
                BaseTestUtils.report("Starting device " + devName + " from " + mapName, Reporter.PASS_NOR_FAIL);
                CommandMessage start = saproObj.sendStartCmdToDevice(mapName, devName);
                BaseTestUtils.report(start.getMessage(), Reporter.PASS);
            }
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            this.closeConnect();
        }
    }

    /**
     * @param mapName
     * @param devNames - list of all devices that need to be started
     *                 if dev is already off - nothing will change, if dev is on - stop dev from given map
     */
    public void stopDevFromMap(String mapName, List<String> devNames) {
        try {
            this.initConnect();
            mapName = this.getFullMapName(mapName);
            for (String devName : devNames) {
                CommandMessage stop = saproObj.sendStopCmdToDevice(mapName, devName);
                BaseTestUtils.report(stop.getMessage(), Reporter.PASS);
            }
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            this.closeConnect();
        }
    }

    /**
     * @param mapName if map is off - running the map will lead to turn on all its devices
     *                if map is already on - nothing will change
     */
    public void startMap(String mapName) {
        try {
            this.initConnect();
            CommandMessage start = saproObj.sendStartCmdToMap(this.getFullMapName(mapName));
            BaseTestUtils.report(start.getMessage(), Reporter.PASS);
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            this.closeConnect();
        }
    }

    /**
     * @param mapName if map is on - stopping the map will lead to turn off all its devices
     *                if map is already off - nothing will change
     */
    public void stopMap(String mapName) {
        try {
            this.initConnect();
            CommandMessage stop = saproObj.sendStopCmdToMap(this.getFullMapName(mapName));
            BaseTestUtils.report(stop.getMessage(), Reporter.PASS);
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            this.closeConnect();
        }
    }

    /**
     * @param mapName in order to start all map's devices - make sure map is off, then starting the map leads to start all its devices
     */
    public void startAllDevFromMap(String mapName) {
        mapName = this.getFullMapName(mapName);
        this.startMap(mapName);
        this.stopMap(mapName);
    }

    /**
     * @param mapName gets all maps from the server
     * @return full map name if there is match between mapName to one of the maps
     */
    public String getFullMapName(String mapName) {
        try {
            List<MapListInfo> mapList = saproObj.getMapListFromServer();
            for (MapListInfo map : mapList) {
                String[] parts = map.getMapName().split("/");
                String lastPart = parts[parts.length - 1];
                String name = lastPart.substring(0, lastPart.indexOf('.'));
                if (name.equals(mapName)) {
                    return map.getMapName();
                }
            }
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        BaseTestUtils.report("The map " + mapName + " is not registered with the server " + inetAddress, Reporter.FAIL);
        return null;
    }

}
