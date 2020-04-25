package com.radware.vision.tests.Alteon.Configuration.System;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.PerformanceMonitoringHandler;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by konstantinr on 6/3/2015.
 */
public class PerformanceMonitoringTests extends AlteonTestBase {
    String port;
    GeneralEnums.State state = GeneralEnums.State.DISABLE;

    @Test
    @TestProperties(name = "Set Performance Monitoring Settings" , paramsInclude = {"qcTestId", "deviceState", "deviceIp","deviceName", "parentTree",
           "state", "port"} )
    public void setPerformanceMonitoringSettings()throws IOException {
        try{
            testProperties.put("port", port);
            PerformanceMonitoringHandler.setPerformanceMonitoringsettings(testProperties, state);
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }


    public HashMap<String, String> getTestProperties() {
        return testProperties;
    }

    public void setTestProperties(HashMap<String, String> testProperties) {
        this.testProperties = testProperties;
    }

    public String getPort() {
        return port;
    }

    @ParameterProperties(description = "Valid range: 0...10000")
    public void setPort(String port) {
        this.port = port;
    }

    public GeneralEnums.State getState() {
        return state;
    }

    public void setState(GeneralEnums.State state) {
        this.state = state;
    }

}