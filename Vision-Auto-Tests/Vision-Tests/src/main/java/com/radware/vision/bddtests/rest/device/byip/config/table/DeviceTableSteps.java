package com.radware.vision.bddtests.rest.device.byip.config.table;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.VisionRestClient;
import com.radware.utils.device.DeviceTableUtils;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddRestTestBase;
import cucumber.api.java.en.When;

public class DeviceTableSteps extends BddRestTestBase {
    @When("^REST Create table row on \"(.*)\" (\\d+) table name \"(.*)\" fields \"(.*)\" values \"(.*)\"$")
    public void createTableRow(SUTDeviceType deviceType, int deviceIndex, String tableName, String fields, String values) {
        String deviceIp = "";
        try{
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceTableUtils.createTableRow(visionRestClient, deviceIp, tableName, fields, values);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "createTableRow may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST edit table row on \"(.*)\" (\\d+) table name \"(.*)\" fields \"(.*)\" values \"(.*)\"$")
    public void editTableRow(SUTDeviceType deviceType, int deviceIndex, String tableName, String fields, String values) {
        String deviceIp = "";
        try{
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceTableUtils.editTableRow(visionRestClient, deviceIp, tableName, fields, values);

        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "editTableRow may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST get table row on \"(.*)\" (\\d+) table name \"(.*)\" row index (\\d+) query \"(.*)\"$")
    public void getTableRow(SUTDeviceType deviceType, int deviceIndex, String tableName, int rowIndex, String query) {
        String deviceIp = "";
        try{
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceTableUtils.getTableRow(visionRestClient, deviceIp, tableName, Integer.toString(rowIndex), query);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "getTableRow may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST delete table row on \"(.*)\" (\\d+) table name \"(.*)\" row index (\\d+)$")
    public void deleteTableRow(SUTDeviceType deviceType, int deviceIndex, String tableName, int rowIndex) {
        String deviceIp = "";
        try{
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceTableUtils.deleteTableRow(visionRestClient, deviceIp, tableName, Integer.toString(rowIndex));
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "deleteTableRow may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }
}
