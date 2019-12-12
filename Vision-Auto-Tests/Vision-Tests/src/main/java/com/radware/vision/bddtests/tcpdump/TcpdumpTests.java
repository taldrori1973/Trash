package com.radware.vision.bddtests.tcpdump;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.infra.utils.tcpdump.TcpdumpUtils;
import cucumber.api.java.en.Then;

public class TcpdumpTests extends BddRestTestBase {

    String basicTcpDumpTimeout = "timeout 60 ";
    HttpMethodEnum requestType = HttpMethodEnum.PUT;
    String urlByIp = "mgmt/device/byip/deviceIP/config";
    String deviceIpString = "deviceIP";


    @Then("^CLI tcpDump Interval Validation with command \"(.*)\" by Interval \"(.*)\" with Threshold \"(.*)\"$")
    public void tcpDumpIntervalValidation(String tcpDumpCommand, long timeInterval, long timeIntervalThreshold) throws Exception {
        try {
            TcpdumpUtils.runTcpdumpInterval(tcpDumpCommand, timeInterval, timeIntervalThreshold, restTestBase.getRootServerCli());
        } catch (Exception e) {
            BaseTestUtils.report("Tcpdump interval validation: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^CLI tcpDump Values Validation with command\"(.*)\" by Values \"(.*)\"$")
    public void tcpDumpValuesValidation(String tcpdumpCommand, String expectedValues) throws Exception {
        try {
            TcpdumpUtils.runTcpdumpValues(tcpdumpCommand, expectedValues.split(","), getRestTestBase().getRootServerCli());
        } catch (Exception e) {
            BaseTestUtils.report("Tcpdump values validation: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^CLI tcpDump Values Validation following vision-device event execution by command \"(.*)\" by expectedValues \"(.*)\" by deviceIp \"(.*)\" by body \"(.*)\"$")
    public void tcpDumpVisionDeviceValuesValidation(String tcpDumpDelayedCommand, String expectedValues, String deviceIp, String body) throws Exception {
        try {
            String urlBasic = urlByIp.replace(deviceIpString, deviceIp);
            TcpdumpUtils.validateVisionDeviceEvent(basicTcpDumpTimeout.concat(tcpDumpDelayedCommand), expectedValues.split(","), getRestTestBase().getRootServerCli(), getRestTestBase().getVisionRestClient(), deviceIp, requestType, urlBasic, body);
        } catch (Exception e) {
            BaseTestUtils.report("Tcpdump values validation: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }
}
