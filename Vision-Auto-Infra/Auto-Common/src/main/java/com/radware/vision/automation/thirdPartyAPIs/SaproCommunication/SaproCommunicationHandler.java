package com.radware.vision.automation.thirdPartyAPIs.SaproCommunication;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.sapcnsl.api.SaproCommunication;
import com.sapcnsl.api.SaproCommunicationFactory;
import com.sapcnsl.api.returntypes.CommandMessage;
import com.sapcnsl.api.returntypes.DirectoryData;
import com.sapcnsl.exception.SaproException;

import java.util.List;
import java.util.concurrent.TimeUnit;

public class SaproCommunicationHandler {
    private final String mapDirectoryName;
    private final String xmlFullPath;
    private final String varFullPath;
    private final String cmfFullPath;
    private final SaproCommunication saproObj;
    private final String inetAddress;
    private final int port;

    private static SaproCommunicationHandler saproCommunicationHandler = null;

    public SaproCommunicationHandler() {
        SaproCommunicationFactory factoryObj = SaproCommunicationFactory.sessionFactory;
        this.saproObj = factoryObj.getNewSession();
        this.saproObj.setNewVersion(true);
        this.inetAddress = "172.17.166.8";
        this.port = 2100;
        mapDirectoryName = "/opt/sapro/map/";
        xmlFullPath = "/opt/sapro/xml/";
        varFullPath = "/opt/sapro/var/";
        cmfFullPath = "/opt/sapro/cmf/";
    }

    public static SaproCommunicationHandler getInstance()
    {
        if(saproCommunicationHandler == null)
            saproCommunicationHandler = new SaproCommunicationHandler();

        return saproCommunicationHandler;
    }

    /**
     * Connection to the SimpleAgentPro Server
     */
    private void initConnect() {
        try {
            System.out.println("Sapro connecting to " + this.inetAddress + " with port " + this.port);
            // if saproSocket is not null and saproSocket is connected
            if (saproObj.initConnection(this.inetAddress, this.port)) {
                System.out.println("connection succeeded");
            } else {
                BaseTestUtils.reporter.report("failed to connect - sapro Socket is null / not connected", Reporter.FAIL);
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
            System.out.println("Sapro disconnecting to " + this.inetAddress + " with port " + this.port);
            saproObj.closeConnection();
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * @param mapName  - the name of the map (not full name)
     * @param devNames - list of all devices that need to be started
     *                 if dev is already on - nothing will change
     *                 if dev is off - start dev and also start (if necessary) the map which dev belongs to
     */
    public void startDevicesFromMap(String mapName, String... devNames) {
        try {
            this.initConnect();
            // startMap(mapName);
            mapName = this.getFullMapName(mapName);
//            List<MapListInfo> l = saproObj.getMapListFromServer();
            for (String devName : devNames) {
                System.out.println("Starting device " + devName + " from " + mapName);
                CommandMessage start = saproObj.sendStartCmdToDevice(mapName, devName);
                System.out.println(start.getMessage());
            }
            this.closeConnect();
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * @param mapName  - the name of the map (not full name)
     * @param devNames - array of all devices that need to be started
     */
//    public void stopDevicesFromMap(String mapName, List<String> devNames) {
    public void stopDevicesFromMap(String mapName, String... devNames) {
        try {
            this.initConnect();
            mapName = this.getFullMapName(mapName);
            for (String devName : devNames) {
                CommandMessage stop = saproObj.sendStopCmdToDevice(mapName, devName);
                System.out.println(stop.getMessage());
            }
            this.closeConnect();
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
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
            System.out.println(start.getMessage());
            this.closeConnect();
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
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
            System.out.println(stop.getMessage());
            this.closeConnect();
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * @param mapName - the name of the map (not full name)
     *                in order to start all map's devices - make sure map is off, then starting the map leads to start all its devices
     */
    public void startAllDevicesFromMap(String mapName) {
        this.stopMap(mapName);
        this.startMap(mapName);
    }

    /**
     * @param mapName - the name of the map (not full name)
     *                in order to stop all map's devices - make sure map is on, then stopping the map leads to stop all its devices
     */
    public void stopAllDevicesFromMap(String mapName) {
        this.startMap(mapName);
        this.stopMap(mapName);
    }

    /**
     * @param mapName    - the name of the map (not full name)
     * @param deviceName - the name of the device
     * @param newXmlFile - the full path of new xml modeling file we want to reload
     *                   Using tcl command 'SA_reload_xmlmodfile' to reload the new xml file
     *                   The new file is playing only during runtime
     */
    public void reloadXmlFile(String mapName, String deviceName, String newXmlFile) {
        try {
            // making sure the device is on:
            this.startDevicesFromMap(mapName, deviceName);
            this.initConnect();
            CommandMessage reload = saproObj.sendTclCmdToDevice(this.getFullMapName(mapName), deviceName, "SA_reload_xmlmodfile " + this.xmlFullPath + newXmlFile);
            System.out.println(reload.getMessage());
            this.closeConnect();
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public void reloadVarFile(String mapName, String deviceName, String newVarFile, String newCmfFile) {
        try {
            // making sure the device is on:
            this.startDevicesFromMap(mapName, deviceName);
            this.initConnect();
            CommandMessage reload = saproObj.sendTclCmdToDevice(this.getFullMapName(mapName), deviceName, "SA_reloadvar " + this.varFullPath + newVarFile + " " + this.cmfFullPath + newCmfFile);
            System.out.println(reload.getMessage());
            this.closeConnect();
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public void refresh() throws SaproException {
        saproObj.getStatsFromMap("/opt/sapro/map/Danny.map");
    }

    public void modifyDeviceParameters(String mapName, String... devNames){
        try{
            Integer secondToWait = 2;
            this.stopDevicesFromMap(mapName, devNames);
            saproObj.initConnection("172.17.166.8", 2100);
            //saproObj.setNewVersion(false);
            mapName = this.getFullMapName(mapName);
            for (String devName : devNames) {
                CommandMessage delDevMsg = saproObj.sendDelDevCmdToMap(mapName,devName);
                System.out.println(delDevMsg.getMessage());
                try {
                    TimeUnit.SECONDS.sleep(secondToWait);
                }catch (InterruptedException e) {
                    BaseTestUtils.report("Interrupted while Sleeping: " + e.getMessage(), Reporter.FAIL);
                }
            }
            CommandMessage addDevMsg=saproObj.sendAddDevCmdToMap(mapName,"/opt/sapro/map/newdev.map");
            System.out.println(addDevMsg.getMessage());
            try {
                TimeUnit.SECONDS.sleep(secondToWait);
            }catch (InterruptedException e) {
                BaseTestUtils.report("Interrupted while Sleeping: " + e.getMessage(), Reporter.FAIL);
            }

            saproObj.closeConnection();
        }catch (SaproException e){
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * @param mapName gets all files from mapDirectoryName and use mapName as filter
     *                NOTE - assuming there is already connection with the server
     * @return full map name if there is match between mapName to one of the maps
     */
    private String getFullMapName(String mapName) {
        try {
            String mapPath = mapName + ".map";
            List<DirectoryData> list = saproObj.listFiles(mapDirectoryName, mapName);
            for (DirectoryData map : list) {
                if (mapPath.equals(map.getFileName())) {
                    return mapDirectoryName + mapPath;
                }
            }
        } catch (SaproException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        BaseTestUtils.report(mapName + " is not registered with the server " + inetAddress, Reporter.FAIL);
        return null;
    }
}
