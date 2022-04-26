package com.radware.vision.bddtests.rest;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.vrm.VRMHandler;
import com.radware.vision.automation.invocation.InvokeMethod;
import com.radware.vision.infra.testresthandlers.DefenseProRESTHandler;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.util.List;

public class DefenseProRESTSteps {
    @Then("^REST Update Policies for All DPs$")
    public void restUpdatePoliciesForAllDPs() throws InterruptedException {

        String result = DefenseProRESTHandler.fetchPolicies();
        if (!result.contains("\"status\":\"ok\""))
            BaseTestUtils.report(result, Reporter.FAIL);

        Thread.sleep(30 * 1000);
    }

    @Given("^Rest Add Policy \"([^\"]*)\" To DP \"([^\"]*)\" if Not Exist$")
    public void restAddPolicyToDPIfNotExist(String policyName, String dpIp) {
        if(dpIp.toLowerCase().startsWith("setid"))
            dpIp = (String) InvokeMethod.invokeMethodFromText(String.format("#getSUTValue(%s);", dpIp));
        DefenseProRESTHandler.addNewPolicy(policyName, dpIp);
    }

    @Given("^Rest Add Policy \"([^\"]*)\" To DP if Not Exist$")
    public void restAddPolicyToDPIfNotExist(String policyName, List<VRMHandler.DpDeviceFilter> entries ) {
        DefenseProRESTHandler.addNewPolicy(policyName, entries);
    }



    @Given("^Rest delete Policy \"([^\"]*)\" from DP \"([^\"]*)\" if Exist$")
    public void restDeletePolicyFromDPIfNotExist(String policyName, String dpIp) {
        DefenseProRESTHandler.deletePolicy(policyName, dpIp);
    }

    @Given("^Rest delete Policy \"([^\"]*)\" from DP if Exist$")
    public void restDeletePolicyFromDPIfNotExist(String policyName, List<VRMHandler.DpDeviceFilter> entries) {
        DefenseProRESTHandler.deletePolicy(policyName, entries);
    }

    @Given("^REST delete Policy \"([^\"]*)\" from DP with Set \"([^\"]*)\"$")
    public void restDeletePolicyFromDP(String policyName, String entries) {
        DefenseProRESTHandler.deletePolicyWithSetID(policyName, entries);
    }

    @Then("^REST Release All Blocked Countries of Device IP \"([^\"]*)\" and Policy Name \"([^\"]*)\"$")
    public void restReleaseAllBlockedCountriesOfDeviceIPAndPolicyName(String deviceIp, String policyName) throws Throwable {
        DefenseProRESTHandler.releaseBlocksForAllCountries(deviceIp, policyName);
    }

    @And("^Rest Add new Rule \"([^\"]*)\" in Profile \"([^\"]*)\" to Policy \"([^\"]*)\" to DP \"([^\"]*)\"$")
    public void restAddNewProfileToPolicyToDP(String rule, String profile, String policy, String ip) throws Throwable {
        if(ip.toLowerCase().startsWith("setid"))
            ip = (String) InvokeMethod.invokeMethodFromText(String.format("#getSUTValue(%s);", ip));
       DefenseProRESTHandler.addNewProfileToPolicyToIP(rule, profile, policy, ip);
    }
}
