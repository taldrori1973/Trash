//package com.radware.vision.thirdPartyAPIs.SaproCommunication;
//
//import com.radware.automation.tools.basetest.BaseTestUtils;
//import com.radware.automation.tools.basetest.Reporter;
//import com.sapcnsl.api.SaproCommunication;
//import com.sapcnsl.api.SaproCommunicationFactory;
//import com.sapcnsl.api.returntypes.*;
//import com.sapcnsl.exception.SaproException;
//import com.sapcnsl.api.returntypes.MapListInfo;
//
//import java.util.List;
//
//public class SaproCommunicationHandler {
//    private final String mapDirectoryName;
//    private final SaproCommunication saproObj;
//    private final String inetAddress;
//    private final int port;
//
//    public SaproCommunicationHandler() {
//        SaproCommunicationFactory factoryObj = SaproCommunicationFactory.sessionFactory;
//        this.saproObj = factoryObj.getNewSession();
//        this.inetAddress = "172.17.166.8";
//        this.port = 2100;
//        mapDirectoryName = "/opt/sapro/map/";
//    }
//
//
//    /**
//     * Connection to the SimpleAgentPro Server
//     */
//    private void initConnect() {
//        try {
//            BaseTestUtils.report("Sapro connecting to " + this.inetAddress + " with port " + this.port, Reporter.PASS_NOR_FAIL);
//            // if saproSocket is not null and saproSocket is connected
//            if (saproObj.initConnection(this.inetAddress, this.port)) {
//                BaseTestUtils.report("connection succeeded", Reporter.PASS);
//            } else {
//                BaseTestUtils.reporter.report("failed to connect - sapro Socket is null / not connected", Reporter.FAIL);
//            }
//        } catch (SaproException e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }
//    }
//
//    /**
//     * Closes connection
//     */
//    private void closeConnect() {
//        try {
//            BaseTestUtils.report("Sapro disconnecting to " + this.inetAddress + " with port " + this.port, Reporter.PASS_NOR_FAIL);
//            saproObj.closeConnection();
//        } catch (SaproException e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }
//    }
//
//    /**
//     * @param mapName  - the name of the map (not full name)
//     * @param devNames - list of all devices that need to be started
//     *                 if dev is already on - nothing will change
//     *                 if dev is off - start dev and also start (if necessary) the map which dev belongs to
//     */
//    public void startDevicesFromMap(String mapName, List<String> devNames) {
//        try {
//            this.initConnect();
//            mapName = this.getFullMapName(mapName);
//            List<MapListInfo> l = saproObj.getMapListFromServer();
//            for (String devName : devNames) {
//                BaseTestUtils.report("Starting device " + devName + " from " + mapName, Reporter.PASS_NOR_FAIL);
//                CommandMessage start = saproObj.sendStartCmdToDevice(mapName, devName);
//                BaseTestUtils.report(start.getMessage(), Reporter.PASS);
//                this.closeConnect();
//            }
//        } catch (SaproException e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }
//    }
//
//    /**
//     * @param mapName  - the name of the map (not full name)
//     * @param devNames - list of all devices that need to be started
//     *                 if dev is already off - nothing will change, if dev is on - stop dev from given map
//     */
//    public void stopDevicesFromMap(String mapName, List<String> devNames) {
//        try {
//            this.initConnect();
//            mapName = this.getFullMapName(mapName);
//            for (String devName : devNames) {
//                CommandMessage stop = saproObj.sendStopCmdToDevice(mapName, devName);
//                BaseTestUtils.report(stop.getMessage(), Reporter.PASS);
//                this.closeConnect();
//            }
//        } catch (SaproException e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }
//    }
//
//    /**
//     * @param mapName if map is off - running the map will lead to turn on all its devices
//     *                if map is already on - nothing will change
//     */
//    public void startMap(String mapName) {
//        try {
//            this.initConnect();
//            CommandMessage start = saproObj.sendStartCmdToMap(this.getFullMapName(mapName));
//            BaseTestUtils.report(start.getMessage(), Reporter.PASS);
//            this.closeConnect();
//        } catch (SaproException e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }
//    }
//
//    /**
//     * @param mapName if map is on - stopping the map will lead to turn off all its devices
//     *                if map is already off - nothing will change
//     */
//    public void stopMap(String mapName) {
//        try {
//            this.initConnect();
//            CommandMessage stop = saproObj.sendStopCmdToMap(this.getFullMapName(mapName));
//            BaseTestUtils.report(stop.getMessage(), Reporter.PASS);
//            this.closeConnect();
//        } catch (SaproException e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }
//    }
//
//    /**
//     * @param mapName - the name of the map (not full name)
//     *                in order to start all map's devices - make sure map is off, then starting the map leads to start all its devices
//     */
//    public void startAllDevicesFromMap(String mapName) {
//        this.stopMap(mapName);
//        this.startMap(mapName);
//    }
//
//    /**
//     * @param mapName - the name of the map (not full name)
//     *                in order to stop all map's devices - make sure map is on, then stopping the map leads to stop all its devices
//     */
//    public void stopAllDevicesFromMap(String mapName) {
//        this.startMap(mapName);
//        this.stopMap(mapName);
//    }
//
//    /**
//     * @param mapName gets all files from mapDirectoryName and use mapName as filter
//     *                NOTE - assuming there is already connection with the server
//     * @return full map name if there is match between mapName to one of the maps
//     */
//    private String getFullMapName(String mapName) {
//        try {
//            String m = mapName + ".map";
//            List<DirectoryData> list = saproObj.listFiles(mapDirectoryName, mapName);
//            for (DirectoryData map : list) {
//                if (m.equals(map.getFileName())) {
//                    return mapDirectoryName + m;
//                }
//            }
////            List<MapListInfo> mapList = saproObj.getMapDevListFromServer();
////            for (MapListInfo map : mapList) {
////                String[] parts = map.getMapName().split("/");
////                String lastPart = parts[parts.length - 1];
////                String name = lastPart.substring(0, lastPart.indexOf('.'));
////                if (name.equals(mapName)) {
////                    return map.getMapName();
////                }
////            }
//        } catch (SaproException e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }
//        BaseTestUtils.report(mapName + " is not registered with the server " + inetAddress, Reporter.FAIL);
//        return null;
//    }
//
//}
