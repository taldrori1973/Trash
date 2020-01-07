package com.radware.vision.restBddTests;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.RestStepResult;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.restBddTests.utils.SutManager;
import com.radware.vision.restTestHandler.Auth.RestClientsStepsHandler;
import com.radware.vision.utils.UriUtils;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import cucumber.api.java.en.Given;
import testhandlers.vision.system.generalSettings.LicenseManagementHandler;
import testhandlers.vision.system.generalSettings.enums.LicenseKeys;

import static java.util.Objects.isNull;

public class RestClientsSteps extends BddRestTestBase {


    @Given("^That Current Vision(:? HA)? is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?(?: With (Activation))?$")
    public void thatCurrentVisionIsLoggedIn(String isHA, String username, String password, String activation) throws Exception {

        String licenseKey = null;
        RadwareServerCli radwareServerCli = null;

        String baseUri = isNull(isHA) ?
                UriUtils.buildUrlFromProtocolAndIp(SutManager.getCurrentVisionRestProtocol(), SutManager.getCurrentVisionIp()) :
                UriUtils.buildUrlFromProtocolAndIp(SutManager.getCurrentVisionRestProtocol(), SutManager.getCurrentVisionHAIp());


        if (isNull(username) ^ isNull(password))
            BaseTestUtils.report("Username and Password both should be given or no one of them.", Reporter.FAIL);
        try {
            if (!isNull(activation))
                if (isNull(isHA)) {
                    radwareServerCli = getRestTestBase().getRadwareServerCli();
                } else {
                    radwareServerCli = (RadwareServerCli) getRestTestBase().getRadwareServerCli().clone();
                    radwareServerCli.setHost(SutManager.getCurrentVisionHAIp());
                }
            licenseKey = LicenseManagementHandler.generateLicense(radwareServerCli, LicenseKeys.VISION_ACTIVATION.getLicenseKeys());
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (isNull(username)) {
            username = SutManager.getCurrentVisionRestUserName();
            password = SutManager.getCurrentVisionRestUserPassword();
        }

        RestStepResult result = RestClientsStepsHandler.currentVisionLogIn(baseUri, username, password, licenseKey);

        if (result.getStatus().equals(RestStepResult.Status.FAILED))
            BaseTestUtils.report(result.getErrorMessage(), Reporter.FAIL);
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
