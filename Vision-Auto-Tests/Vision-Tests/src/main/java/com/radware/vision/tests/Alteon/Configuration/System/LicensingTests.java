package com.radware.vision.tests.Alteon.Configuration.System;

import com.radware.vision.infra.testhandlers.alteon.configuration.system.LicensingHandler;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.TestProperties;
import com.radware.automation.tools.basetest.Reporter;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by konstantinr on 6/3/2015.
 */
public class LicensingTests extends AlteonTestBase {
    String licenseString;


    @Test
    @TestProperties(name = "Set Licensing String", paramsInclude = {"qcTestId", "deviceState", "deviceIp", "deviceName", "parentTree",
            "state", "licenseString"})
    public void setLicensingString() throws IOException {
        try {
            testProperties.put("licenseString", licenseString);
            LicensingHandler.setLicenseString(testProperties);
        } catch (Exception e) {
            report.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "View Feature Licenses", paramsInclude = {"qcTestId", "deviceState", "deviceIp", "deviceName", "parentTree"})
    public void viewFeatureLicenses() throws IOException {
        try {
            LicensingHandler.viewFeatureLicenses(testProperties);
        } catch (Exception e) {
            report.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "View Capacity Licenses", paramsInclude = {"qcTestId", "deviceState", "deviceIp", "deviceName", "parentTree"})
    public void viewCapacityLicenses() throws IOException {
        try {
            LicensingHandler.viewCapacityLicenses(testProperties);
        } catch (Exception e) {
            report.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "View Last Installed License Strings", paramsInclude = {"qcTestId", "deviceState", "deviceIp", "deviceName", "parentTree"})
    public void viewLastInstalledLicenseStrings() throws IOException {
        try {
            LicensingHandler.viewLastInstalledLicenseStrings(testProperties);
        } catch (Exception e) {
            report.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public HashMap<String, String> getTestProperties() {
        return testProperties;
    }

    public void setTestProperties(HashMap<String, String> testProperties) {
        this.testProperties = testProperties;
    }

    public String getLicenseString() {
        return licenseString;
    }

    public void setLicenseString(String licenseString) {
        this.licenseString = licenseString;
    }

}