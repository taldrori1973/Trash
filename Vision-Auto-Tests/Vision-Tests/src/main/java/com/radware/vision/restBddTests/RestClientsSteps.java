package com.radware.vision.restBddTests;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.RestStepResult;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.restTestHandler.RestClientsStepsHandler;
import com.radware.vision.utils.UriUtils;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import cucumber.api.java.en.Given;
import testhandlers.vision.system.generalSettings.LicenseManagementHandler;
import testhandlers.vision.system.generalSettings.enums.LicenseKeys;

import java.util.Optional;

import static com.radware.automation.tools.basetest.Reporter.FAIL;
import static com.radware.vision.utils.SutUtils.*;
import static com.radware.vision.utils.UriUtils.buildUrlFromProtocolAndIp;
import static java.util.Objects.isNull;
import static org.apache.commons.lang3.StringUtils.isBlank;
import static org.apache.commons.lang3.StringUtils.isEmpty;

public class RestClientsSteps extends BddRestTestBase {


    @Given("^That Current Vision(?: (HA))? is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?(?: With (Activation))?$")
    public static void thatCurrentVisionIsLoggedIn(String isHA, String username, String password, String activation) throws Exception {

        String licenseKey = null;
        RadwareServerCli radwareServerCli = null;

        String baseUri = isNull(isHA) ?
                buildUrlFromProtocolAndIp(getCurrentVisionRestProtocol(), getCurrentVisionIp()) :
                buildUrlFromProtocolAndIp(getCurrentVisionRestProtocol(), getCurrentVisionHAIp());


        if (isNull(username) ^ isNull(password))
            BaseTestUtils.report("Username and Password both should be given or no one of them.", FAIL);
        try {
            if (!isNull(activation))
                if (isNull(isHA)) {
                    radwareServerCli = getRestTestBase().getRadwareServerCli();
                } else {
                    radwareServerCli = (RadwareServerCli) getRestTestBase().getRadwareServerCli().clone();
                    radwareServerCli.setHost(getCurrentVisionHAIp());
                }
            licenseKey = LicenseManagementHandler.generateLicense(radwareServerCli, LicenseKeys.VISION_ACTIVATION.getLicenseKeys());
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (isNull(username)) {
            username = getCurrentVisionRestUserName();
            password = getCurrentVisionRestUserPassword();
        }

        RestStepResult result = RestClientsStepsHandler.genericVisionLogIn(baseUri, getCurrentVisionRestPort(), username, password, licenseKey);

        if (result.getStatus().equals(RestStepResult.Status.FAILED))
            BaseTestUtils.report(result.getMessage(), FAIL);
    }


    @Given("^That Vision with IP \"([^\"]*)\"(?: and Port (\\d+))?(?: and Protocol \"([^\"]*)\")? is Logged In With Username \"([^\"]*)\" and Password \"([^\"]*)\"(?: With (Activation))?$")
    public void thatVisionWithIPAndPortIsLoggedInWithUsernameAndPassword(String ip, Integer port, String protocol, String username, String password, String activation) throws Throwable {

        String licenseKey = null;
        RadwareServerCli radwareServerCli = null;

        if (isNull(ip) || isEmpty(ip) || isBlank(ip)) {
            BaseTestUtils.report("Should Provide legal Ip", FAIL);
        }
        if (isNull(username) || isEmpty(username) || isBlank(username) ||
                isNull(password) || isEmpty(password) || isBlank(password)) {
            BaseTestUtils.report("Should Provide legal username and password", FAIL);
        }

        if (isNull(protocol)) protocol = "HTTPS";
        String baseUri = buildUrlFromProtocolAndIp(protocol, ip);

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
            BaseTestUtils.report(result.getMessage(), FAIL);


    }

    @Given("^That Device (Alteon|AppWall) With SetId \"([^\"]*)\" is Logged In$")
    public void thatDeviceAlteonAppWallWithSUTNumberNumberIsLoggedIn(String deviceType, String setId) throws Exception {
        if (isNull(deviceType) || (!deviceType.equalsIgnoreCase("alteon") && !deviceType.equalsIgnoreCase("appwall"))) {
            BaseTestUtils.report("The Device Type should be Alteon Or AppWall", FAIL);
        }

        if (isNull(setId)) BaseTestUtils.report("No device number was provided", FAIL);

        Optional<TreeDeviceManagementDto> deviceManagementOpt = getDeviceManagement(setId);

        if (!deviceManagementOpt.isPresent())
            BaseTestUtils.report(String.format("No device with setId \"%s\" was found", setId), FAIL);
        TreeDeviceManagementDto deviceManagement = deviceManagementOpt.get();


        String baseUri = buildUrlFromProtocolAndIp("https", deviceManagement.getManagementIp());
        String username = deviceManagement.getHttpsUsername();
        String password = deviceManagement.getHttpsPassword();


        RestStepResult result = RestClientsStepsHandler.alteonAppWallLogin(deviceType, baseUri, null, username, password);

        if (result.getStatus().equals(RestStepResult.Status.FAILED))
            BaseTestUtils.report(result.getMessage(), FAIL);
    }


    @Given("^That Device (Alteon|AppWall) with IP \"([^\"]*)\"(?: and Port (\\d+))?(?: and Protocol \"([^\"]*)\")? is Logged In With Username \"([^\"]*)\" and Password \"([^\"]*)\"$")
    public void thatDeviceAlteonAppWallWithIPAndPortAndProtocolIsLoggedInWithUsernameAndPassword(SUTDeviceType sutDeviceType, String ip, Integer port, String protocol, String username, String password) throws Throwable {
        if (isNull(sutDeviceType) || (!sutDeviceType.equals(SUTDeviceType.Alteon) && !sutDeviceType.equals(SUTDeviceType.AppWall))) {
            BaseTestUtils.report("The Device Type should be Alteon Or AppWall", FAIL);
        }
        if (isNull(ip) || isEmpty(ip) || isBlank(ip)) {
            BaseTestUtils.report("Should Provide legal Ip", FAIL);
        }
        if (isNull(username) || isEmpty(username) || isBlank(username) ||
                isNull(password) || isEmpty(password) || isBlank(password)) {
            BaseTestUtils.report("Should Provide legal username and password", FAIL);
        }

        if (isNull(protocol)) protocol = "HTTPS";

        String baseUri = buildUrlFromProtocolAndIp(protocol, ip);


        RestStepResult result = RestClientsStepsHandler.alteonAppWallLogin(sutDeviceType.getDeviceType(), baseUri, port, username, password);

        if (result.getStatus().equals(RestStepResult.Status.FAILED))
            BaseTestUtils.report(result.getMessage(), FAIL);

    }

    @Given("^That Current On-Vision VDirect(?: with Port (\\d+))?(?: and with protocol \"([^\"]*)\")? is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?$")
    public void thatCurrentOnVisionVDirectIsLoggedInWithUsernameAndPassword(Integer port, String protocol, String username, String password) throws NoSuchFieldException {

        if (isNull(username) ^ isNull(password)) {
            BaseTestUtils.report("Username and Password both should be given or no one of them.", FAIL);
        }

        if (isNull(protocol)) protocol = getCurrentVisionRestProtocol();
        String baseUri = buildUrlFromProtocolAndIp(protocol, getCurrentVisionIp());
        if (isNull(username)) {
            username = getCurrentVisionRestUserName();
            password = getCurrentVisionRestUserPassword();
        }
        RestStepResult result = RestClientsStepsHandler.onVisionVDirectLogin(baseUri, port, username, password);
        if (result.getStatus().equals(RestStepResult.Status.FAILED))
            BaseTestUtils.report(result.getMessage(), FAIL);

    }


    @Given("^That Defense Flow Device from SUT File is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?$")
    public void thatDefenseFlowIsLoggedInWithUsernameAndPassword(String username, String password) throws Exception {
//       kVision - defenseFlow
//        Should be Change to get the data from SUT Utils
//        defenseFlowDevice DF = (defenseFlowDevice) system.getSystemObject("defenseFlowDevice");
//        if (isNull(username) ^ isNull(password)) {
//            report("Username and Password both should be given or no one of them.", FAIL);
//        }
//        if (isNull(username)) {
//            username = DF.username;
//            password = DF.password;
//        }
//        String baseUri = UriUtils.buildUrlFromProtocolAndIp("https", DF.deviceIp);
//        Integer port = null;
//        RestStepResult result = RestClientsStepsHandler.defenseFlowLogin(baseUri, port, username, password);
//        if (result.getStatus().equals(RestStepResult.Status.FAILED))
//            report(result.getMessage(), FAIL);

    }

    @Given("^That Defense Flow With Ip \"([^\"]*)\" And Port (\\d+) is Connected without Authentication$")
    public void thatDefenseFlowWithIpAndPortIsConnectedWithoutAuthentication(String defenseFlowIp, int defenseFlowPort) {
        RestClientsStepsHandler.switchToNoAuthClient(UriUtils.buildUrlFromProtocolAndIp("https", defenseFlowIp), defenseFlowPort);
    }
}
