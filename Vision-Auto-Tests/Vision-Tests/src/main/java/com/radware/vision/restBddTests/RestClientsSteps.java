package com.radware.vision.restBddTests;


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

import static com.radware.automation.tools.basetest.BaseTestUtils.report;
import static com.radware.automation.tools.basetest.Reporter.FAIL;
import static java.util.Objects.isNull;
import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.apache.commons.lang3.StringUtils.isEmpty;

public class RestClientsSteps extends BddRestTestBase {


    @Given("^That Current Vision(:? HA)? is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?(?: With (Activation))?$")
    public void thatCurrentVisionIsLoggedIn(String isHA, String username, String password, String activation) throws Exception {

        String licenseKey = null;
        RadwareServerCli radwareServerCli = null;

        String baseUri = isNull(isHA) ?
                UriUtils.buildUrlFromProtocolAndIp(SutManager.getCurrentVisionRestProtocol(), SutManager.getCurrentVisionIp()) :
                UriUtils.buildUrlFromProtocolAndIp(SutManager.getCurrentVisionRestProtocol(), SutManager.getCurrentVisionHAIp());


        if (isNull(username) ^ isNull(password))
            report("Username and Password both should be given or no one of them.", FAIL);
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
            report(result.getErrorMessage(), FAIL);
    }


    @Given("^That Vision with IP \"([^\"]*)\"(?: and Port (\\d+))?(?: and Protocol \"([^\"]*)\")? is Logged In With Username \"([^\"]*)\" and Password \"([^\"]*)\"(?: With (Activation))?$")
    public void thatVisionWithIPAndPortIsLoggedInWithUsernameAndPassword(String ip, Integer port, String protocol, String username, String password, String activation) throws Throwable {

        String licenseKey = null;
        RadwareServerCli radwareServerCli = null;

        if (isNull(ip) || isEmpty(ip) || isBlank(ip)) {
            report("Should Provide legal Ip", FAIL);
        }
        if (isNull(username) || isEmpty(username) || isBlank(username) ||
                isNull(password) || isEmpty(password) || isBlank(password)) {
            report("Should Provide legal username and password", FAIL);
        }

        if (isNull(protocol)) protocol = "HTTPS";
        String baseUri = UriUtils.buildUrlFromProtocolAndIp(protocol, ip);

        try {
            if (!isNull(activation)) {
                radwareServerCli = (RadwareServerCli) getRestTestBase().getRadwareServerCli().clone();

                radwareServerCli.setHost(ip);
                radwareServerCli.setUser(username);
                radwareServerCli.setPassword(password);

                licenseKey = LicenseManagementHandler.generateLicense(radwareServerCli, LicenseKeys.VISION_ACTIVATION.getLicenseKeys());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        RestStepResult result = RestClientsStepsHandler.genericVisionLogIn(baseUri, port, username, password, licenseKey);

        if (result.getStatus().equals(RestStepResult.Status.FAILED))
            report(result.getErrorMessage(), FAIL);


    }

    @Given("^That Device (Alteon|AppWall) With SUT Number (\\d+) is Logged In$")
    public void thatDeviceAlteonAppWallWithSUTNumberNumberIsLoggedIn(SUTDeviceType sutDeviceType, Integer deviceNumber) {

    }

    @Given("^That Current On Vision VDirect is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?$")
    public void thatCurrentOnVisionVDirectIsLoggedInWithUsernameAndPassword(String username, String password) {


    }


}
