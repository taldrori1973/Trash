package com.radware.vision.tests.tcpdump;

import com.radware.automation.tools.utils.StringUtils;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.utils.tcpdump.TcpdumpUtils;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import com.radware.automation.tools.basetest.Reporter;
import org.junit.Test;
/**
 * Created by AviH on 11/04/2016.
 */
public class TcpdumpTests extends WebUITestBase {

    String tcpdumpCommand;
    String tcpDumpDelayedCommand;
    long timeInterval;
    String expectedValues;
    long timeIntervalThreshold;
    int expectedTextCount;
    String deviceIp;
    HttpMethodEnum requestType = HttpMethodEnum.PUT;
    String urlBasic;
    String body;
    String basicTcpDumpTimeout = "timeout 60 ";

    @Test
    @TestProperties(name = "Tcpdump Interval Validation", paramsInclude = { "qcTestId", "tcpdumpCommand", "timeInterval", "timeIntervalThreshold" })
    public void tcpdumpIntervalValidation() throws Exception {
        try {
            TcpdumpUtils.runTcpdumpInterval(tcpdumpCommand, timeInterval, timeIntervalThreshold, getRestTestBase().getRootServerCli());
        } catch (Exception e) {
            report.report("Tcpdump interval validation: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Tcpdump Interval Validation following vision-device event execution", paramsInclude = { "qcTestId", "requestType", "tcpDumpDelayedCommand", "timeInterval", "timeIntervalThreshold", "deviceIp", "urlBasic", "body"})
    public void tcpdumpVisionDeviceIntervalValidation() throws Exception {
        try {
            TcpdumpUtils.validateTcpdumpVisionDeviceEventsInterval(basicTcpDumpTimeout.concat(tcpDumpDelayedCommand), timeInterval, timeIntervalThreshold, getRestTestBase().getRootServerCli(), getVisionRestClient(), deviceIp, requestType, urlBasic, body);
        } catch (Exception e) {
            report.report("Tcpdump interval validation: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Tcpdump Count Validation following vision-device event execution", paramsInclude = { "qcTestId", "requestType", "tcpDumpDelayedCommand", "expectedTextCount", "expectedValues", "timeInterval", "timeIntervalThreshold", "deviceIp", "urlBasic", "body"})
    public void tcpdumpVisionDeviceCountValidation() throws Exception {
        try {
            TcpdumpUtils.validateTcpdumpVisionDeviceEventsCount(basicTcpDumpTimeout.concat(tcpDumpDelayedCommand), getRestTestBase().getRootServerCli(), getVisionRestClient(), deviceIp, requestType, urlBasic, body, expectedValues, expectedTextCount);
        } catch (Exception e) {
            report.report("Tcpdump interval validation: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Tcpdump Values Validation", paramsInclude = { "qcTestId", "tcpdumpCommand", "expectedValues" })
    public void tcpdumpValuesValidation() throws Exception {
        try {
            TcpdumpUtils.runTcpdumpValues(tcpdumpCommand, expectedValues.split(","), getRestTestBase().getRootServerCli());
        } catch (Exception e) {
            report.report("Tcpdump values validation: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Tcpdump Values Validation following vision-device event execution", paramsInclude = { "qcTestId", "requestType", "tcpDumpDelayedCommand", "expectedValues", "deviceIp", "urlBasic", "body"})
    public void tcpdumpVIsionDeviceValuesValidation() throws Exception {
        try {
            TcpdumpUtils.validateVisionDeviceEvent(basicTcpDumpTimeout.concat(tcpDumpDelayedCommand), expectedValues.split(","), getRestTestBase().getRootServerCli(), getRestTestBase().getVisionRestClient(), deviceIp, requestType, urlBasic, body);
        } catch (Exception e) {
            report.report("Tcpdump values validation: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public String getTcpdumpCommand() { return tcpdumpCommand; }
    public void setTcpdumpCommand(String tcpdumpCommand) { this.tcpdumpCommand = tcpdumpCommand; }

    public String getTimeInterval() { return String.valueOf(timeInterval); }
    @ParameterProperties(description = "Specify the Time Interval in second")
    public void setTimeInterval(String timeInterval) {
        if(timeInterval != null) {
            this.timeInterval = Integer.valueOf(StringUtils.fixNumeric(timeInterval));
        }
    }

    public String getExpectedValues() { return expectedValues; }
    @ParameterProperties(description = "Specify list of Expected Values. Fields must be separated by <,>.")
    public void setExpectedValues(String expectedValues) { this.expectedValues = expectedValues; }

    public String getTimeIntervalThreshold() {
        return String.valueOf(timeIntervalThreshold);
    }
    @ParameterProperties(description = "Specify the Threshold to be used while Interval Validations.")
    public void setTimeIntervalThreshold(String timeIntervalThreshold) {
        if(timeIntervalThreshold != null) {
            this.timeIntervalThreshold = Integer.valueOf(StringUtils.fixNumeric(timeIntervalThreshold));
        }
    }

    public String getDeviceIp() {
        return deviceIp;
    }
    @ParameterProperties(description = "leave Empty in case Vision operation to be executed.")
    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public HttpMethodEnum getRequestType() {
        return requestType;
    }
    @ParameterProperties(description = "Specify the request type.")
    public void setRequestType(HttpMethodEnum requestType) {
        this.requestType = requestType;
    }

    public String getUrlBasic() {
        return urlBasic;
    }
    @ParameterProperties(description = "Specify the URL not including the initial address part. f.e. <mgmt/device/byip/172.16.22.26/config>")
    public void setUrlBasic(String urlBasic) {
        this.urlBasic = urlBasic;
    }

    public String getBody() {
        return body;
    }
    @ParameterProperties(description = "Specify the request body.")
    public void setBody(String body) {
        this.body = body;
    }

    public String getTcpDumpDelayedCommand() {
        return tcpDumpDelayedCommand;
    }
    @ParameterProperties(description = "Specify trpDump command to run. Initial timeout of 30 sec will be added automatically!")
    public void setTcpDumpDelayedCommand(String tcpDumpDelayedCommand) {
        this.tcpDumpDelayedCommand = tcpDumpDelayedCommand;
    }

    public String getExpectedTextCount() {
        return String.valueOf(expectedTextCount);
    }

    public void setExpectedTextCount(String expectedTextCount) {
        if(expectedTextCount != null) {
            this.expectedTextCount = Integer.valueOf(StringUtils.fixNumeric(expectedTextCount));
        }
    }
}
