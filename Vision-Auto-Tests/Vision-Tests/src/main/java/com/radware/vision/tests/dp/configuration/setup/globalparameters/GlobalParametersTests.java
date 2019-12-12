package com.radware.vision.tests.dp.configuration.setup.globalparameters;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.DefencePro.dpConfiguration.setup.globalparameters.GlobalParametersHandler;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by moaada on 7/25/2017.
 */
public class GlobalParametersTests extends WebUITestBase {

    String location;


    @Test
    @TestProperties(name = "Set Global Parameters location", paramsInclude = {"deviceName", "location"})
    public void setLocation() throws TargetWebElementNotFoundException {

        GlobalParametersHandler.updateLocation(location, getDeviceName());
        if (GlobalParametersHandler.getLocation(getDeviceName()).equals(location)) {
            report.report("location set to : " + location, Reporter.PASS);
        } else {

            report.report("Failed to set location to " + location, Reporter.FAIL);
        }
    }


    public String getLocation() {
        return location;
    }

    @ParameterProperties(description = "insert location value")
    public void setLocation(String location) {
        this.location = location;
    }
}
