package com.radware.vision.bddtests.rest.device.byip.config.table;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.VisionRestClient;
import com.radware.utils.device.DeviceTableUtils;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import cucumber.api.java.en.When;

public class DeviceTableSteps extends TestBase {
    @When("^REST Create table row on \"(\\w+)\" table name \"(.*)\" fields \"(.*)\" values \"(.*)\"$")
    public void createTableRow(String deviceSetId, String tableName, String fields, String values) {
        String deviceIp = "";
        try{
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceTableUtils.createTableRow(visionRestClient, deviceIp, tableName, fields, values);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "createTableRow may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST edit table row on \"(\\w+)\" table name \"(.*)\" fields \"(.*)\" values \"(.*)\"$")
    public void editTableRow(String deviceSetId, String tableName, String fields, String values) {
        String deviceIp = "";
        try{
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceTableUtils.editTableRow(visionRestClient, deviceIp, tableName, fields, values);

        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "editTableRow may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST get table row on \"(\\w+)\" table name \"(.*)\" row index (\\d+) query \"(.*)\"$")
    public void getTableRow(String deviceSetId, String tableName, int rowIndex, String query) {
        String deviceIp = "";
        try{
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceTableUtils.getTableRow(visionRestClient, deviceIp, tableName, Integer.toString(rowIndex), query);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "getTableRow may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST delete table row on \"(\\w+)\" table name \"(.*)\" row index (\\d+)$")
    public void deleteTableRow(String deviceSetId, String tableName, int rowIndex) {
        String deviceIp = "";
        try{
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceTableUtils.deleteTableRow(visionRestClient, deviceIp, tableName, Integer.toString(rowIndex));
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "deleteTableRow may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }
}
