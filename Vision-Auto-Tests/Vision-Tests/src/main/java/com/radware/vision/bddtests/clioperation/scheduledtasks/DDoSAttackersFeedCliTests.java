package com.radware.vision.bddtests.clioperation.scheduledtasks;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.infra.testhandlers.scheduledtasks.DDosFeedTaskHandler;
import cucumber.api.java.en.Then;

public class DDoSAttackersFeedCliTests extends BddCliTestBase {

    @Then("^CLI Validate that Vision was send attackers feed for DefensePro with index (\\d+)$")
    public void verifyValidatingFeedForDefenseProInVisionLog(int index) {
        try {
            String dpMacAddress = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro,index).getMacAddress();
            DDosFeedTaskHandler.verifyRequestingFeedForDefenseProInVisionLog(dpMacAddress,getRestTestBase());
        }catch (Exception e){
            BaseTestUtils.report("Failed to verify attackers feed request: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^CLI Validate that Vision request an attackers feed for DefensePro with index (\\d+)$")
    public void verifyRequestingFeedForDefenseProInVisionLog(int index) {
        try {
            String dpMacAddress = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro,index).getMacAddress();
            DDosFeedTaskHandler.verifyRequestingFeedForDefenseProInVisionLog(dpMacAddress,getRestTestBase());
        }catch (Exception e){
            BaseTestUtils.report("Failed to verify attackers feed request: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^CLI Validate that Vision did not request an attackers feed for DefensePro with index (\\d+)$")
    public void verifyThatNoFeedRequestForDefenseProInVisionLog(int index) {
        try {
            String dpMacAddress = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro,index).getMacAddress();
            DDosFeedTaskHandler.verifyThatNoFeedRequestForDefenseProInVisionLog(dpMacAddress,getRestTestBase());
        }catch (Exception e){
            BaseTestUtils.report("Failed to verify attackers feed request: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

}
