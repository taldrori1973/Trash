package com.radware.vision.restBddTests;


import basejunit.RestTestBase;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.jayway.jsonpath.Option;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.utils.BodyEntry;
import com.radware.vision.vision_project_cli.RootServerCli;
import cucumber.api.java.en.Then;
import net.minidev.json.JSONArray;


import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

public class DPPolicyCpuRestSteps {
    private String script = "while :; do curl -X POST http://localhost:9200/dp-concurrent-connections-*/_update_by_query?wait_for_completion=true -d '{\"query\":{},\"script\":{\"source\":\"ctx._source.timestamp+=1800000L;ctx._source.receivedTimestamp+=1800000L\"}}';sleep 30;done";

    private int minPolicyUtilization = 59;
    private int maxPolicyUtilization = 62;
    private GenericSteps genericSteps = new GenericSteps();

    private void runScript() throws Exception {
        RestTestBase restTestBase = new RestTestBase();
        RootServerCli rootServerCli = new RootServerCli(restTestBase.getRootServerCli().getHost(), restTestBase.getRootServerCli().getUser(), restTestBase.getRootServerCli().getPassword());
        rootServerCli.init();
        //kVision
//        CliOperations.runCommand(rootServerCli, script, 2 * 60 * 1000, false, false, false);
    }

    @Then("^Run Helper Script For DpCpuPolicyUtilization$")
    public void runHelperScript() throws Exception {
        runScript();
    }

    @Then("^Send DpPolicyUtilization Request$")
    public void dpPolicyCpu(List<BodyEntry> bodyEntries) {
        LocalDateTime now = LocalDateTime.now();
        long fromDate = Timestamp.valueOf(now.minusMinutes(2)).getTime();
        long toDate = Timestamp.valueOf(now.plusMinutes(15)).getTime();
        bodyEntries.forEach(n -> {
            switch (n.getJsonPath()) {
                case "$.timeFrame.fromDate":
                    n.setValue(String.valueOf(fromDate));
                    break;
                case "$.timeFrame.toDate":
                    n.setValue(String.valueOf(toDate));
                    break;
            }
        });
        genericSteps.newRequestSpecificationFromFileWithLabel("Vision/DpPolicyUtilization", "Dp Policy Utilization");
        genericSteps.theRequestBodyIs("Object", bodyEntries);
        genericSteps.sendRequest();
    }

    private Object valueOfJsonPath(String value) throws Exception {
        String response = GenericSteps.response.getBody().getBodyAsString();
        DocumentContext documentContext = JsonPath.parse(response);
        documentContext.configuration().addOptions(Option.SUPPRESS_EXCEPTIONS);
        if(documentContext.read(value) == null)
            throw new Exception("there is no data ");
        return documentContext.read(value);
    }

    @Then("^Validate Object \"([^\"]*)\" isEmpty \"([^\"]*)\"$")
    public void validateJsonArrayIsEmpty(String object, boolean isEmpty) throws Exception {
        JSONArray jsonArray = (JSONArray) valueOfJsonPath(object);
        if (jsonArray.isEmpty() != isEmpty)
            BaseTestUtils.report("isEmpty of the object " + object + " return: " + !isEmpty + " ,that's not as expected: " + isEmpty + " ", Reporter.FAIL);
    }

    @Then("^Validate policyUtil for DpPolicyUtilization$")
    public void validatePolicyUtil() throws Exception {
        String policyUtil = (String) valueOfJsonPath("$.data[0].row.policyUtil");
        if (Integer.parseInt(policyUtil) < minPolicyUtilization && Integer.parseInt(policyUtil) > maxPolicyUtilization)
            BaseTestUtils.report(" Wrong policyUtil " + policyUtil + " ", Reporter.FAIL);

    }

    @Then("^Validate totalHits for DpPolicyUtilization$")
    public void validateTotalHits() throws Exception {
        String totalHits = (String) valueOfJsonPath("$.metaData.totalHits");
        if (Integer.parseInt(totalHits) < 1)
            BaseTestUtils.report(" Wrong totalHits: " + totalHits + " ", Reporter.FAIL);
    }

    @Then("^Validate Utilization for puPolicy1 DpCpuUtilization$")
    public void validateUtilization() throws Exception {
        Integer utilization = (Integer) ((JSONArray) valueOfJsonPath("$.devices[0].policies[?(@.name=='puPolicy1')].utilization")).get(0);
        if (utilization < minPolicyUtilization && utilization > maxPolicyUtilization)
            BaseTestUtils.report(" Wrong utilization: " + utilization + " ", Reporter.FAIL);
    }

    @Then("^Validate DeviceUtilization for DpCpuUtilization$")
    public void validateDeviceUtilization() throws Exception {
        Integer actualDeviceUtilization = (Integer) valueOfJsonPath("$.devices[0].deviceUtilization");
        int expectedDeviceUtilization = 0;
        // sum of all utilization in policies
        for (Object utilization : (JSONArray) valueOfJsonPath("$.devices[0].policies..utilization"))
            expectedDeviceUtilization += (Integer) utilization;
        if (expectedDeviceUtilization != (Integer) valueOfJsonPath("$.devices[0].deviceUtilization"))
            BaseTestUtils.report(" The expected DeviceUtilization: " + expectedDeviceUtilization + " is not equal to actual DeviceUtilization " + actualDeviceUtilization + " ", Reporter.FAIL);
    }


}
