package com.radware.vision.bddtests.clioperation.scheduledtasks;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.testhandlers.scheduledtasks.DDosFeedTaskHandler;
import cucumber.api.java.en.Then;

public class DDoSAttackersFeedCliTests extends TestBase {

    @Then("^CLI Validate that Vision was send attackers feed for DefensePro with index (\\w+)$")
    public void verifyValidatingFeedForDefenseProInVisionLog(String deviceSetId) {
        try {
//            kVision add get device mac address
//            String dpMacAddress = sutManager.getTreeDeviceManagement(deviceSetId).get().getMacAddress();
//            DDosFeedTaskHandler.verifyRequestingFeedForDefenseProInVisionLog(dpMacAddress,restTestBase);
        }catch (Exception e){
            BaseTestUtils.report("Failed to verify attackers feed request: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^CLI Validate that Vision request an attackers feed for DefensePro with index (\\w+)$")
    public void verifyRequestingFeedForDefenseProInVisionLog(String deviceSetId) {
        try {
//            kVision add get device mac address
//            String dpMacAddress = sutManager.getTreeDeviceManagement(deviceSetId).get().getMacAddress();
//            DDosFeedTaskHandler.verifyRequestingFeedForDefenseProInVisionLog(dpMacAddress,restTestBase);
        }catch (Exception e){
            BaseTestUtils.report("Failed to verify attackers feed request: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^CLI Validate that Vision did not request an attackers feed for DefensePro with index (\\w+)$")
    public void verifyThatNoFeedRequestForDefenseProInVisionLog(String deviceSetId) {
        try {
//            kVision add get device mac address
//            String dpMacAddress = sutManager.getTreeDeviceManagement(deviceSetId).get().getMacAddress();
//            DDosFeedTaskHandler.verifyThatNoFeedRequestForDefenseProInVisionLog(dpMacAddress,restTestBase);
        }catch (Exception e){
            BaseTestUtils.report("Failed to verify attackers feed request: " + e.getMessage(), Reporter.FAIL);
        }
    }

}
