package com.radware.vision.infra.testresthandlers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.VisionRestClient;
import com.radware.restcore.utils.enums.DeviceType;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.automation.tools.exceptions.vision.topologytree.TopologyTreeDeviceNotExistException;
import com.radware.vision.infra.testhandlers.BaseHandler;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import testhandlers.Device;
import testhandlers.VisionRestApiHandler;

import java.util.ArrayList;
import java.util.List;

public class TopologyTreeRestHandler {

    public static void deleteDeviceByManagementIp(VisionRestClient visionRestClient, String deviceIp) {
        try {
            Device.deleteDeviceByManagementIp(visionRestClient, deviceIp);
        } catch (Exception e) {
            if (e instanceof TopologyTreeDeviceNotExistException) {
                BaseTestUtils.report("Skip deleting device: " + deviceIp + ", device not exist in the topology tree.", Reporter.PASS);
            } else {
                BaseTestUtils.report("Failed to Delete device: " + deviceIp, e);
            }
        }

    }

    public static void addDeviceToTopologyTree(String deviceType, String deviceName, String deviceIp, String site, List<Data> optionalValues) {

        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();


        String parentOrmID = getParentOrmID(site);
        if (parentOrmID == null) return;


        String bodyParams = buildBodyParams(deviceType, deviceName, deviceIp, parentOrmID, optionalValues);
        Object result = null;
        try {
            result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.POST,
                    "Device Tree->Add New Device", null, bodyParams, null);
        } catch (IllegalStateException e) {
            if(e.getMessage().contains("already exists, please use a different IP Address"))
                return;
            BaseTestUtils.report(String.format("Failed to add %s device.\nException Message:\n%s", deviceName, e.getMessage()), 1);
        }

        if (result == null || result.toString().contains("\"status\":\"error\""))
            BaseTestUtils.report(String.format("Failed to add %s device:\n%s", deviceName, result), 1);


        //Sync after Add
        try {
            result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.POST,
                    "Device Tree->Sync Device", deviceIp, null, null);
        } catch (IllegalStateException e) {
//            BaseTestUtils.report(String.format("Failed to Synchronize %s device.\nException Message:\n%s", deviceName,e.getMessage()), 1);
        }

//        if (result == null ||result.toString().contains("\"status\":\"error\""))
//            BaseTestUtils.report(String.format("Failed to Synchronize %s device:\n%s", deviceName,result), 1);

    }

    public static void addSiteToTopologyTree(String siteName, String site) {

        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();


        String parentOrmID = getParentOrmID(site);
        if (parentOrmID == null) return;


        String bodyParams = "";
        bodyParams = bodyParams.concat("parentOrmID=" + parentOrmID).concat(",name=" + siteName);
        Object result = null;
        try {
            result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.POST,
                    "Device Tree->Add Site", null, bodyParams, null);
        } catch (IllegalStateException e) {
            if(e.getMessage().contains("Node name in the tree must be unique"))
                return;
            BaseTestUtils.report(String.format("Failed to add %s site.\nException Message:\n%s", siteName, e.getMessage()), 1);
        }

        if (result == null || result.toString().contains("\"status\":\"error\""))
            BaseTestUtils.report(String.format("Failed to add %s site:\n%s", siteName, result), 1);



    }

    private static String getParentOrmID(String site) {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();


        Object result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.GET,
                "Device Tree->Site Data", site, null, null);

        if (result.toString().contains("\"status\": \"error\"")) {
            BaseTestUtils.report(String.format("There is no site with name %s", site), 1);
            return null;
        }

        JSONParser jsonParser = new JSONParser();
        JSONObject response;
        try {
            response = (JSONObject) jsonParser.parse(result.toString());
            return response.get("ormID").toString();
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static String buildBodyParams(String deviceType, String deviceName, String deviceIp, String parentOrmID, List<Data> optionalValues) {

        String bodyParams = "";
        bodyParams = bodyParams.concat("type=" + deviceType).concat(",deviceName=" + deviceName).concat(",managementIp=" + deviceIp).concat(",parentOrmID=" + parentOrmID);
        for (Data entry : optionalValues) {
            bodyParams = bodyParams.concat("," + entry.attribute + "=" + entry.value);
        }
        return bodyParams;

    }

    public static void updateDeviceScalar(String scalarName, String request, String deviceIp, String newValue) {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

        String deviceOrmID = getDeviceOrmID(deviceIp);
        if (deviceOrmID == null) return;
        Object result = "";
        try {
            result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.PUT,
                    request, null, "ormID=" + deviceOrmID + "," + scalarName + "=" + newValue, null);
        } catch (IllegalStateException e) {
            BaseTestUtils.report(String.format("Can't Update Scalar %s.\nException Message:\n%s", scalarName, e.getMessage()), 1);
        }
        if (result.toString().contains("\"status\": \"error\""))
            BaseTestUtils.report(String.format("Can't Update Scalar %s\n%s", scalarName, result), 1);

        //Sync after Add
        try {
            result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.POST,
                    "Device Tree->Sync Device", deviceIp, null, null);
        } catch (IllegalStateException e) {
        }
    }


    private static String getDeviceOrmID(String deviceIp) {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        Object result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.GET,
                "Device Tree->Device Data", deviceIp, null, null);

        if (result.toString().contains("\"status\": \"error\"")) {
            BaseTestUtils.report(String.format("There is no device with Ip %s", deviceIp), 1);
            return null;
        }

        JSONParser jsonParser = new JSONParser();
        JSONObject response;
        try {
            response = (JSONObject) jsonParser.parse(result.toString());
            return response.get("ormID").toString();
        } catch (ParseException e) {
            e.printStackTrace();
        }


        return null;

    }

    public static String getDeviceName(String deviceIp) {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        Object result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.GET,
                "Device Tree->Device Data", deviceIp, null, null);

        if (result.toString().contains("\"status\": \"error\"")) {
            BaseTestUtils.report(String.format("There is no device with Ip %s", deviceIp), 1);
            return null;
        }

        JSONParser jsonParser = new JSONParser();
        JSONObject response;
        try {
            response = (JSONObject) jsonParser.parse(result.toString());
            return response.get("name").toString();
        } catch (ParseException e) {
            e.printStackTrace();
        }


        return null;

    }

    public static void deleteDeviceByIp(VisionRestClient visionRestClient, String deviceIp) {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        String deviceOrmID = null;
        try {
            deviceOrmID = getDeviceOrmID(deviceIp);
        } catch (IllegalStateException e) {
            if(e.getMessage().contains("M_00734: There is no device with name " + deviceIp + " configured in APSolute Vision."))
                return;
        }
        Object result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.DELETE,
                "Device Tree->Delete Device", deviceOrmID, null, null);

        if (result.toString().contains("\"status\": \"error\"")) {
            BaseTestUtils.report(String.format("Can't Delete The Device  %s", deviceIp), 1);
        }
    }

    public static List<String> getListOfDevicesIPsByDeviceType(DeviceType deviceType) {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        Object result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.GET,
                "Device Tree->Get Devices By Type", deviceType.getDeviceType().toLowerCase(), null, null);

        List<String> devicesIPs = new ArrayList<>();
        JSONParser jsonParser = new JSONParser();
        try {
            JSONArray jsonArray = (JSONArray) jsonParser.parse(result.toString());
            for (Object object : jsonArray) {
                JSONObject device = (JSONObject) object;
                devicesIPs.add(device.get("managementIp").toString());
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return devicesIPs;
    }

    public static class Data {
        public String attribute;
        public String value;

    }
}
