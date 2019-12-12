package com.radware.vision.infra.testhandlers.system.deviceResources.sevicesubscriptions;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.system.deviceresources.devicesubscriptions.DeviceSubscriptions;
import com.radware.vision.infra.testresthandlers.BasicRestOperationsHandler;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import testhandlers.VisionRestApiHandler;

import static com.radware.vision.infra.testhandlers.BaseHandler.restTestBase;

public class DeviceSubscriptionsHandler {

    public static boolean checkIfDeviceSubscriptionsTableColumnExists(String columnName) {
        DeviceSubscriptions deviceSubscriptions = openDeviceSubscriptionsMenu();
        WebUITable table = deviceSubscriptions.getDeviceSubscriptionsTable();
        int columnIndex = table.getColIndex(columnName);
        if (columnIndex != -1) {
            return true;
        }
        return false;
    }

    public static boolean checkDeviceSubscriptionsTableCell(String deviceName, String columnName, String expectedValue) {
        DeviceSubscriptions deviceSubscriptions = openDeviceSubscriptionsMenu();
        WebUITable table = deviceSubscriptions.getDeviceSubscriptionsTable();
        int rowIndex = table.getRowIndex("Device Name", deviceName);
        int columnIndex = table.getColIndex(columnName);
        String actualValue = table.getCellValue(rowIndex, columnIndex);
        if (actualValue.equals(expectedValue)) {
            return true;
        }
        return false;
    }

    private static DeviceSubscriptions openDeviceSubscriptionsMenu() {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        return menuPane.openSystemDeviceResources().deviceSubscriptionsMenu();
    }

    public static boolean checkDeviceBlackListContainSrcnetwork(String deviceName, SUTDeviceType deviceType, String srcNetwork) throws Exception {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        restTestBase.getVisionRestClient().login("radware", "radware", "", 1);
        Object result = visionRestApiHandler.handleRequest(restTestBase.getVisionRestClient(), HttpMethodEnum.GET,
                "DefensePro->" + "ALL black List", deviceName, null, null);
        if (result.toString().contains("\"status\": \"error\"")) {
            BaseTestUtils.report(String.format("There is no " + deviceType.toString() + " with ip %s", deviceName), Reporter.FAIL);
        }
        JSONParser jsonParser = new JSONParser();
        JSONObject jsonResult;
        jsonResult = (JSONObject) jsonParser.parse(result.toString());
        jsonResult.get("rsNewBlackListTable");
        for (Object js : (JSONArray) jsonResult.get("rsNewBlackListTable")) {
            if (((JSONObject) js).get("rsNewBlackListSrcNetwork").toString().equalsIgnoreCase(srcNetwork)) {
                return true;
            }
        }
        return false;

    }

    public static long DeviceBlackListNumberOfRows(String deviceName, SUTDeviceType deviceType) throws Exception {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        restTestBase.getVisionRestClient().login("radware", "radware", "", 1);
        Object result = visionRestApiHandler.handleRequest(restTestBase.getVisionRestClient(), HttpMethodEnum.GET,
                "DefensePro->" + "ALL black List", deviceName, null, null);
        if (result.toString().contains("\"status\": \"error\"")) {
            BaseTestUtils.report(String.format("There is no " + deviceType.toString() + " with ip %s", deviceName), Reporter.FAIL);
        }
        JSONParser jsonParser = new JSONParser();
        JSONObject jsonResult;
        jsonResult = (JSONObject) jsonParser.parse(result.toString());
        JSONArray blackList = (JSONArray) jsonResult.get("rsNewBlackListTable");
        return blackList.size();


    }

    public static void clearBlackList(String deviceName, SUTDeviceType deviceType) throws Exception {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        restTestBase.getVisionRestClient().login("radware", "radware", "", 1);
        Object result = visionRestApiHandler.handleRequest(restTestBase.getVisionRestClient(), HttpMethodEnum.GET,
                "DefensePro->" + "ALL black List", deviceName, null, null);
        if (result.toString().contains("\"status\": \"error\"")) {
            BaseTestUtils.report(String.format("There is no " + deviceType.toString() + " with ip %s", deviceName), Reporter.FAIL);
        }
        JSONParser jsonParser = new JSONParser();
        JSONObject jsonResult;
        jsonResult = (JSONObject) jsonParser.parse(result.toString());

        jsonResult.get("rsNewBlackListTable");
        restTestBase.getVisionRestClient().login("radware", "radware", "", 1);
        BasicRestOperationsHandler.genericRestApiRequest(restTestBase.getVisionRestClient().getDeviceIp(), null,
                HttpMethodEnum.POST, "DPM_Dashboard->lock", deviceName, null, null);
        for (Object js : (JSONArray) jsonResult.get("rsNewBlackListTable")) {
            String recordName = ((JSONObject) js).get("rsNewBlackListName").toString();
            try {
                BasicRestOperationsHandler.genericRestApiRequest(restTestBase.getVisionRestClient().getDeviceIp(), null,
                        HttpMethodEnum.DELETE, "DefensePro->black List", deviceName + "|" + recordName, null, null);
            }catch (Exception e){
                BaseTestUtils.report("the entry not found " + recordName + " ", Reporter.FAIL);
            }
            }
    }
}
