package com.radware.vision.restBddTests;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import cucumber.api.java.en.Given;
import testhandlers.vision.system.generalSettings.LicenseManagementHandler;
import testhandlers.vision.system.generalSettings.enums.LicenseKeys;

import static com.radware.vision.base.WebUITestBase.getRestTestBase;
import static java.util.Objects.isNull;

public class RestClientsSteps {


    @Given("^That Current Vision(:? HA)? is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?(?: With (Activation))?$")
    public void thatCurrentVisionIsLoggedIn(String isHA, String username, String password, String activation) {

        String licenseKey;
        if (isNull(username) ^ isNull(password))
            BaseTestUtils.report("Username and Password both should be given or no one of them.", Reporter.FAIL);
        try {
            if (!isNull(activation))
                licenseKey = LicenseManagementHandler.generateLicense(getRestTestBase().getRadwareServerCli(), LicenseKeys.VISION_ACTIVATION.getLicenseKeys());

            if (!isNull(username) && !isNull(activation)) {
//          login with user name and password and activation
            } else {//or username and password is null Or activation is null Or Both
                if (isNull(username) && isNull(activation)) {
//                login without activation with default user name and password
                } else if (isNull(username)) {
//                login with activation without user name and password
                } else {
//            login without activation and  credentials
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    @Given("^That Current Vision HA is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?$")
    public void thatCurrentVisionHAIsLoggedIn() {

    }

    @Given("^That Vision with IP \"([^\"]*)\" and Port (\\d+) is Logged In With Username \"([^\"]*)\" and Password \"([^\"]*)\"(?: With (Activation))?$")
    public void thatVisionWithIPAndPortIsLoggedInWithUsernameAndPassword(String ip, Integer port, String username, String password) throws Throwable {


    }

    @Given("^That Device (Alteon|AppWall) With SUT Number (\\d+) is Logged In$")
    public void thatDeviceAlteonAppWallWithSUTNumberNumberIsLoggedIn(SUTDeviceType sutDeviceType, Integer deviceNumber) {

    }

    @Given("^That Current On Vision VDirect is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?$")
    public void thatCurrentOnVisionVDirectIsLoggedInWithUsernameAndPassword(String username, String password) {


    }


}
