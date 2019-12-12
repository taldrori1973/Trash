package com.radware.vision.bddtests.defensepro.dpoperation;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.base.pages.defensepro.HAStatus;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.DefencePro.DPClusterManageHandler;
import com.radware.vision.infra.testhandlers.DefencePro.dpOperations.DPOperationsHandler;
import com.radware.vision.infra.testhandlers.DefencePro.enums.DPHaDeviceStatus;
import com.radware.vision.infra.testhandlers.DefencePro.enums.SignatureTypes;
import com.radware.vision.infra.testhandlers.DefencePro.enums.UpdateFromSource;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.testresthandlers.DefenseProRESTHandler;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import testhandlers.Device;

import java.awt.*;
import java.util.HashMap;

import static com.radware.vision.infra.testhandlers.DefencePro.dpOperations.DPOperationsHandler.printYellowMessage;

public class DPOperationsTests extends BddUITestBase {

    public DPOperationsTests() throws Exception {
    }

    @When("^UI Update security signatures for DefensePro number (\\d+)$")
    public void updateSecuritySignatures(int dpIndex) throws AWTException {
        try {
            DeviceInfo deviceInfoPrimary = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, dpIndex);
            setDeviceName(deviceInfoPrimary.getDeviceName());
            HashMap<String, String> testProperties = new HashMap<>();
            //////////////////////
            WebUIUtils.widgetsContainer = null;
            if (deviceInfoPrimary.getDeviceIp() == null) {
                updateNavigationParser(Device.getDeviceIp(getVisionRestClient(), getDeviceName()));
            } else {
                updateNavigationParser(deviceInfoPrimary.getDeviceIp());
                setDeviceName(deviceInfoPrimary.getDeviceIp());
            }
            testProperties.put("deviceName", deviceInfoPrimary.getDeviceName());
            testProperties.put("deviceIp", deviceInfoPrimary.getDeviceIp());
            testProperties.put("parentTree", TopologyTreeTabs.SitesAndClusters.getTopologyTreeTab().toString());
            testProperties.put("deviceState", String.valueOf(DeviceState.Lock));
            /////////////////////
            RBACHandlerBase.expectedResultRBAC = true;
            testProperties.put("signatureType", SignatureTypes.RADWARE_SIGNATURES.getType());
            testProperties.put("updateFromSource", UpdateFromSource.UPDATE_FROM_RADWARE.getSource());
            testProperties.put("fileDownloadPath", "");//C:\Users\stanislava\Downloads\
            testProperties.put("fileName", "");

            if (!DPOperationsHandler.updateSecuritySignatures(getVisionRestClient(), testProperties)) {
                WebUIUtils.generateAndReportScreenshot();
                BaseTestUtils.report("update Security Signatures operation may have been executed incorrectly :", Reporter.FAIL);
            }
            printYellowMessage();
        } catch (Exception e) {
            WebUIUtils.generateAndReportScreenshot();
            BaseTestUtils.report("update Security Signatures operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI verify dpHaDeviceStatus \"([^\"]*)\" with device index (\\d+)$")
    public void verifyDPHaStatus(DPHaDeviceStatus dpHaDeviceStatus, String deviceIndex) {
        try {
            DeviceInfo deviceInfoPrimary = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, Integer.parseInt(deviceIndex));
            if (!DPClusterManageHandler.verifyDeviceHaStatus(deviceInfoPrimary.getDeviceName(), dpHaDeviceStatus)) {
                BaseTestUtils.report("Device: " + deviceInfoPrimary.getDeviceName() + " " + "has different status than: " + dpHaDeviceStatus.getStatus(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to switchover between DP Cluster members: " + getDeviceName() + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI verify dp Cluster device \"([^\"]*)\" with device index (\\d+) by haStatus \"(Primary|Secondary)\"$")
    public void verifyClusterSecondaryDevice(String clusterName, String deviceIndex, HAStatus haStatus) throws Exception {
        try {
            DeviceInfo deviceInfoPrimary = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, Integer.parseInt(deviceIndex));
            if (!DPClusterManageHandler.isDpDeviceMember(clusterName, deviceInfoPrimary.getDeviceName(), haStatus)) {
                BaseTestUtils.report("Secondary DP member was not found: " + deviceInfoPrimary.getDeviceName() + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Secondary DP member was not found: " + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI dp Cluster Switchover \"([^\"]*)\"$")
    public void dpClusterSwitchover(String deviceName) throws Exception {
        try {
            setDeviceName(deviceName);
            DPClusterManageHandler.dpClusterSwitchover(getDeviceName());
        } catch (Exception e) {
            BaseTestUtils.report("Failed to switchover between DP Cluster members: " + getDeviceName() + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @When("^Change Platform Type of DefensePro by IP \"([^\"]*)\" to \"([^\"]*)\"$")
    public void changePlatformTypeOfDefenseProByIPTo(String defenseProIp, String newPlatformType) {

        String deviceMac = DefenseProRESTHandler.getMacByIp(defenseProIp);
        String sqlCommand = String.format("mysql -prad123 vision_ng -e \"update hardware set platform_type='%s' where base_mac_addr='%s'\\G\"", newPlatformType, deviceMac);
        CliOperations.runCommand(restTestBase.getRootServerCli(), sqlCommand);

    }

}
