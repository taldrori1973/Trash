package com.radware.vision.bddtests.visionsettings.system.deviceResources;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.visionsettings.VisionSettingsBase;
import com.radware.vision.infra.testhandlers.system.deviceResources.sevicesubscriptions.DeviceSubscriptionsHandler;
import cucumber.api.java.en.Then;
import org.json.simple.parser.ParseException;


public class DeviceSubscriptionsTests extends VisionSettingsBase {
    public DeviceSubscriptionsTests() throws Exception {
    }

    @Then("^UI Validate \"(.*)\" column exists in device subscriptions table$")
    public void openERTActiveDDoSFeed(String columnName) {
        try {
            if (!DeviceSubscriptionsHandler.checkIfDeviceSubscriptionsTableColumnExists(columnName)) {
                throw new Exception(columnName + " column not exist in subscriptions table.");
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to check column existence: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI Validate \"(.*)\" device with index (\\d+) subscription contains \"(.*)\" equals to \"(.*)\"$")
    public void checkDeviceSubscriptionsTableCell(SUTDeviceType deviceType, int deviceIndex, String columnName, String expectedValue) {
        try {
            String deviceName = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            if (!DeviceSubscriptionsHandler.checkDeviceSubscriptionsTableCell(deviceName, columnName, expectedValue)) {
                throw new Exception("Cell value not as expected: " + expectedValue);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to check subscriptions table cell value : " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI Validate \"(.*)\" device with index (\\d+) BlackList, contains SrcNetwork:\"(.*)\"$")
    public void checkDeviceBlackList(SUTDeviceType deviceType, int deviceIndex, String srcNetwork) {
        try {
            String deviceName = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            if (DeviceSubscriptionsHandler.checkDeviceBlackListContainSrcnetwork(deviceName, deviceType, srcNetwork))
                BaseTestUtils.report("SrcNetwork:" + srcNetwork + " found", Reporter.PASS);
            else
                BaseTestUtils.report("SrcNetwork:" + srcNetwork + " NOT found", Reporter.FAIL);

        }
        catch (ParseException e) {
            e.printStackTrace();
            BaseTestUtils.report("FAILED to Read BlackList in Json", Reporter.FAIL);
        }
        catch (Exception e) {
            BaseTestUtils.report("FAILED to get SrcNetwork from DP", Reporter.FAIL);

        }
    }
    @Then("^UI Validate \"(.*)\" device with index (\\d+) BlackList Number of Rows, contains (\\d+) rows$")
    public void checkDeviceBlackListNumberOfRows(SUTDeviceType deviceType, int deviceIndex, long numOfRows) {
        try {
            String deviceName = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            long blackListSize = DeviceSubscriptionsHandler.DeviceBlackListNumberOfRows(deviceName,deviceType);
            if (blackListSize < 0)
                throw new Exception("Error in reading blackList of device:" + deviceName);
            if (blackListSize >= numOfRows)
                BaseTestUtils.report("BlackList has: " + blackListSize + ". More than Expected: " + numOfRows, Reporter.PASS);
            else
                BaseTestUtils.report("BlackList has: " + blackListSize + ". Less than Expected: " + numOfRows, Reporter.FAIL);

        }
        catch (ParseException e) {
            e.printStackTrace();
            BaseTestUtils.report("FAILED to Read BlackList in Json", Reporter.FAIL);
        }
        catch (Exception e) {
            BaseTestUtils.report("FAILED to get SrcNetwork from DP", Reporter.FAIL);

        }

    }

    @Then("^UI Clear blackList from \"(.*)\" device with index (\\d+)$")
    public void clearBlackList(SUTDeviceType deviceType, int deviceIndex) {
        try {
            String deviceIP = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            DeviceSubscriptionsHandler.clearBlackList(deviceIP,deviceType);
        }
        catch (ParseException e) {
            e.printStackTrace();
            BaseTestUtils.report("FAILED in Json parsing", Reporter.FAIL);
        }
        catch (Exception e) {
            BaseTestUtils.report("FAILED in clearing blackList.", Reporter.FAIL);

        }

    }




}



