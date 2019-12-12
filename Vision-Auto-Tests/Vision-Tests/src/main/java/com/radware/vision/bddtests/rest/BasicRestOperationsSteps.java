package com.radware.vision.bddtests.rest;

import basejunit.RestTestBase;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.restcore.utils.enums.HTTPStatusCodes;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.infra.testresthandlers.BasicRestOperationsHandler;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.vision_project_cli.RootServerCli;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import testhandlers.VisionRestApiHandler;
import testhandlers.vision.system.UserManagement.UserManagementSettingsHandler;
import testhandlers.vision.system.UserManagement.enums.UserManagementSettingsKeys;
import testhandlers.vision.system.generalSettings.*;
import testhandlers.vision.system.generalSettings.enums.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.radware.vision.infra.testresthandlers.BasicRestOperationsHandler.visionRestApiBuilder;


public class BasicRestOperationsSteps extends BddRestTestBase {
    /**
     * @param username - user
     * @param password - password
     */

    @When("^REST Login with user \"([^\"]*)\" and password \"([^\"]*)\"$")
    public void restLoginWithUserAndPassword(String username, String password) {
        restTestBase.getVisionRestClient().login(username, password, "", 1);
        if (restTestBase.getVisionRestClient().isLogged(username))
            restTestBase.getVisionServer().setRestUsername(username);
    }

    /**
     * @param username - user
     * @param password - password
     */
    @Given("^REST Login with activation with user \"(.*)\" and password \"(.*)\"$")
    public void loginWithActivation(String username, String password) {
        try {
            String licenseKey;
            licenseKey = LicenseManagementHandler.generateLicense(getRestTestBase().getRadwareServerCli(), LicenseKeys.VISION_ACTIVATION.getLicenseKeys());
            getRestTestBase().getVisionRestClient().login(username, password, licenseKey, 1);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to rest login with activation " + e.getMessage() + " StackTrace : " + ExceptionUtils.getStackFrames(e).toString(), Reporter.FAIL);
        }
    }

    /**
     * @param method         - HttpMethodEnum ENUM (GET|PUT|POST|PATCH|DELETE|DELETE_WITH_BODY
     * @param port           - Optional in case not defended will be equal to 80)
     * @param request        - request
     * @param urlParams      - for multi use "|" as a delimiter  -optional
     * @param bodyParams     - for multi use "|" as a delimiter -optional
     * @param expectedResult - Optional
     */
    @Then("^REST Generic API Request \"([^\"]*)\"(?: with port (\\d+))? for \"([^\"]*)\"(?: url params \"([^\"]*)\")?(?: Body params \"([^\"]*)\")?(?: Expected result \"([^\"]*)\")?$")
    public void genericRESTApi(HttpMethodEnum method, Integer port, String request, String urlParams, String bodyParams, String expectedResult) {
        BasicRestOperationsHandler.genericRestApiRequest(restTestBase.getVisionRestClient().getDeviceIp(), port, method, request, urlParams, bodyParams, expectedResult);
        if (restTestBase.getVisionRestClient().getLastHttpStatusCode() != HTTPStatusCodes.OK.getCode())
            BaseTestUtils.report("", Reporter.FAIL);
    }

    @Then("^REST Customized API Request \"([^\"]*)\"(?: with port (\\d+))? for \"([^\"]*)\"(?: on device \"([^\"]*)\" with index \"([^\"]*)\" url params \"([^\"]*)\")?(?: Body params \"([^\"]*)\")?(?: Expected result \"([^\"]*)\")?$")
    public void customizedRESTApi(HttpMethodEnum method, Integer port, String request, SUTDeviceType deviceType, Integer deviceIndex, String urlParams, String bodyParams, String expectedResult) throws Exception {
        String deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
        urlParams = deviceIp + "|" + urlParams;
        genericRESTApi(HttpMethodEnum.POST, port, "DPM_Dashboard->lock", deviceIp, null, expectedResult);
        genericRESTApi(method, port, request, urlParams, bodyParams, expectedResult);
    }

    /**
     * @param method         - HttpMethodEnum ENUM (GET|PUT|POST|PATCH|DELETE|DELETE_WITH_BODY
     * @param request        - request
     * @param urlField       - for multi use "|" as a delimiter  -optional
     * @param bodyFields     - for multi use "|" as a delimiter -optional
     * @param expectedResult - Optional
     */
    @Then("^REST Vision API Request \"([^\"]*)\" for \"([^\"]*)\"(?: \"([^\"]*)\")?(?: and Body fields \"([^\"]*)\")?(?: Expected result \"([^\"]*)\")?$")
    public void visionRESTApi(HttpMethodEnum method, String request, String urlField, String bodyFields, String expectedResult) {
        BasicRestOperationsHandler.visionRestApiRequest(restTestBase.getVisionRestClient(), method, request, urlField, bodyFields, expectedResult);
    }

//    @Then("^REST Vision DELETE License Request \"(.*)\"$")
    public void deleteLicenses(String feature_name) {
        CliOperations.runCommand(restTestBase.getRootServerCli(), String.format("mysql -u root -prad123 vision_ng -e \"select row_id from vision_license where license_str like '%%%s%%'\\G\" | tail -1 | awk '{print $2}'", feature_name));
        String licenseRawID = CliOperations.lastRow;
        //if last row contains part of the sent command, no such license exists
        if (!licenseRawID.contains("{print $2}"))
            BasicRestOperationsHandler.visionRestApiRequest(restTestBase.getVisionRestClient(), HttpMethodEnum.DELETE, "License", licenseRawID, null, null);
    }


    /**
     * @param licensePrefix - such as ->
     *                      vision-demo
     *                      vision-RTU96  --> To Add Manage More Devices
     *                      vision-perfreporter --> AVR license
     *                      vision-security-reporter --> DPM License
     *                      vision-reporting-module-AMS  --> AMS License
     */
//    @Given("^REST Vision Install License Request \"([^\"]*)\"(?: from date \"([+|-]\\d+[d|M|Y])\" to date \"([+|-]\\d+[d|M|Y])\")?$")
    public void installLicenses(String licensePrefix, String fromDate, String toDate) {
        try {
            String licenseKey;
            String expectedResult = "ok";
            String licensePrefixWithoutDate = licensePrefix;
            if (licensePrefix.contains("vision-RTU") || Pattern.matches("vision-AVA-.*-attack-capacity", licensePrefix))
                expectedResult = "successfully installed";
            if (fromDate != null && toDate != null) {
                licensePrefix = licensePrefix + "-" + addDateToLicensePrefix(fromDate) + "-" + addDateToLicensePrefix(toDate);
            }
            if (needToInstall(licensePrefix, licensePrefixWithoutDate) || licensePrefixWithoutDate.contains("vision-AVA-AppWall")) {
                licenseKey = LicenseManagementHandler.generateLicense(getRestTestBase().getRadwareServerCli(), licensePrefix);
                if (licensePrefixWithoutDate.startsWith("vision-activation")) {
                    getRestTestBase().getVisionRestClient().login("radware", "radware", licenseKey, 1);
                } else {
                    BasicRestOperationsHandler.visionRestApiRequest(restTestBase.getVisionRestClient(), HttpMethodEnum.POST, "License", null, licenseKey, expectedResult);
                }
            } else {
                BaseTestUtils.report("The license with prefix " + licensePrefix + " has been installed", Reporter.PASS);
            }

        } catch (Exception e) {
            BaseTestUtils.report("Failed to install license: " + licensePrefix + " Reason : " + e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * This method deletes license by those cases
     * - if the added license with date:
     * the method delete a license with same prefix but not with the same start&expire date
     * - if the added license without date:
     * the method delete a license with the same licenseName that attached with date
     *
     * @param licensePrefix            - License type
     * @param licensePrefixWithoutDate - License string without the date range
     * @return - true if license removed or does not exist
     */
    private boolean needToInstall(String licensePrefix, String licensePrefixWithoutDate) {
        boolean needToInstall = false;
        Pattern MY_PATTERN = Pattern.compile("(vision-(RTU|AVA|)(\\d{0,3}(?:VA)?))");
        Matcher m = MY_PATTERN.matcher(licensePrefix);
        if (m.find()) {
            switch (m.group(2)) {
                case "RTU":
                case "AVA":
                    if (LicenseManagementHandler.isInstalled(getRestTestBase().getVisionRestClient(), "vision-" + m.group(2) + m.group(3))) {
                        if (!isInstalledBasedOnDate(licensePrefix, licensePrefixWithoutDate)) {
                            deleteLicenses("vision-" + m.group(2) + m.group(3));
                            needToInstall = true;
                        } else {
                            break;
                        }

                    } else
                        needToInstall = true;
                    break;
                case "": {
                    if (LicenseManagementHandler.isInstalled(getRestTestBase().getVisionRestClient(), licensePrefixWithoutDate)) {

                        if (!isInstalledBasedOnDate(licensePrefix, licensePrefixWithoutDate)) {
                            deleteLicenses(licensePrefixWithoutDate);
                            needToInstall = true;
                        }
                    } else {
                        needToInstall = true;
                    }
                }
            }
        }
        return needToInstall;
    }

    private boolean isInstalledBasedOnDate(String targetLicensePrefix, String targetLicensePrefixWithoutDate) {
        Pattern MY_PATTERN = Pattern.compile("((\\d{2}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\d{4})-(\\d{2}(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\\d{4}))");
        for (String visionLicense : LicenseManagementHandler.getLicenses(getRestTestBase().getVisionRestClient())) {
            if (visionLicense.startsWith(targetLicensePrefixWithoutDate)) {
                Matcher targetLicenseMatcher = MY_PATTERN.matcher(targetLicensePrefix);
                boolean targetLicenseIsFind = targetLicenseMatcher.find();
                Matcher visionLicenseMatcher = MY_PATTERN.matcher(visionLicense);
                boolean visionLicenseIsFind = visionLicenseMatcher.find();
                if (targetLicenseIsFind && visionLicenseIsFind) {
                    return (targetLicenseMatcher.group(0).equals(visionLicenseMatcher.group(0)));
                } else if (!targetLicenseIsFind && !visionLicenseIsFind) {
                    return true;
                }
            }
        }
        return false;
    }

    private String addDateToLicensePrefix(String date) {
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("ddMMMyyyy");
        LocalDateTime fromLocalDate = TimeUtils.getAddedDate(date);
        return fromLocalDate.format(inputFormatter);
    }

    /**
     * @param paramToRetrieve - key to look for
     * @param expectedValue   - Optional: Expected result
     */
    @Then("^REST get Basic Parameters \"([^\"]*)\"(?: Expected result \"([^\"]*)\")?$")
    public void getBasicParameters(String paramToRetrieve, String expectedValue) {
        try {
            expectedValue = expectedValue == null ? "" : expectedValue;
            retrievedParamValue = BasicParametersHandler.getBasicParameterByKey(getVisionRestClient(), BasicParametersKeys.getBasicParametersKeysEnum(paramToRetrieve));
            if (!expectedValue.equals("") && !expectedValue.equals(getRetrievedParamValue())) {
                RestTestBase.report.report("The retrievedParamValue: " + paramToRetrieve + " " + " is not as expected." + expectedValue, Reporter.FAIL);
            }
        } catch (Exception e) {
            RestTestBase.report.report("GET following basicParameter: " + paramToRetrieve + " " + " request may not have been executed properly.", parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * @param paramToRetrieve - key to look for
     * @param expectedValue   - Optional: Expected result
     */
    @Then("^REST get Connectivity Parameters \"([^\"]*)\"(?: Expected result \"([^\"]*)\")?$")
    public void getConnectivityParameters(String paramToRetrieve, String expectedValue) {
        try {
            expectedValue = expectedValue == null ? "" : expectedValue;
            retrievedParamValue = ConnectivityHandler.getConnectivityParameterByKey(getVisionRestClient(), ConnectivityKeys.getConnectivityKeysEnum(paramToRetrieve));
            if (!expectedValue.equals("") && !expectedValue.equals(retrievedParamValue)) {
                RestTestBase.report.report("The retrievedParam: " + paramToRetrieve + " " + " is not as expected." + expectedValue + ", the retrievedParamValue is: " + retrievedParamValue, Reporter.FAIL);
            }
        } catch (Exception e) {
            RestTestBase.report.report("GET following connectivity parameter: " + paramToRetrieve + " " + " request may not have been executed properly.", parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * @param paramToRetrieve - key to look for
     * @param expectedValue   - Optional: Expected result
     */
    @Then("^REST get Monitoring Parameters \"([^\"]*)\"(?: Expected result \"([^\"]*)\")?$")
    public void getMonitoringParameters(String paramToRetrieve, String expectedValue) {
        try {
            expectedValue = expectedValue == null ? "" : expectedValue;
            retrievedParamValue = MonitoringHandler.getMonitoringByKey(getVisionRestClient(), MonitoringKeys.getMonitoringKeysEnum(paramToRetrieve));
            if (!expectedValue.equals("") && !expectedValue.equals(retrievedParamValue)) {
                RestTestBase.report.report("The retrievedParam: " + paramToRetrieve + " " + " is not as expected." + expectedValue + ", the retrievedParamValue is: " + retrievedParamValue, Reporter.FAIL);
            }
        } catch (Exception e) {
            RestTestBase.report.report("GET following Monitoring parameter: " + paramToRetrieve + " " + " request may not have been executed properly.", parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * @param paramToRetrieve - key to look for
     * @param expectedValue   - Optional: Expected result
     */
    @Then("^REST get APSolute Vision Reporter Parameters \"([^\"]*)\"(?: Expected result \"([^\"]*)\")?$")
    public void getAPSoluteVisionReporterParameters(String paramToRetrieve, String expectedValue) {
        try {
            expectedValue = expectedValue == null ? "" : expectedValue;
            retrievedParamValue = APSoluteVisionReporterHandler.getAPSoluteVisionReporterByKey(getVisionRestClient(), APSoluteVisionReporterKeys.getAPSoluteVisionReporterKeysEnum(paramToRetrieve));
            if (!expectedValue.equals("") && !expectedValue.equals(retrievedParamValue)) {
                RestTestBase.report.report("The retrievedParam: " + paramToRetrieve + " " + " is not as expected." + expectedValue + ", the retrievedParamValue is: " + retrievedParamValue, Reporter.FAIL);
            }
        } catch (Exception e) {
            RestTestBase.report.report("GET following APSolute Vision Reporter parameter: " + paramToRetrieve + " " + " request may not have been executed properly.", parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * @param paramToRetrieve - key to look for
     * @param expectedValue   - Optional: Expected result
     */
    @Then("^REST get RadiusSettings Parameters \"([^\"]*)\"(?: Expected result \"([^\"]*)\")?$")
    public void getRadiusSettings(String paramToRetrieve, String expectedValue) {
        try {
            retrievedParamValue = AuthenticationProtocolsHandler.getRadiusSettingsByKey(getVisionRestClient(), RadiusSettingsKeys.getRadiusSettingsKeysEnum(paramToRetrieve));
            if (!expectedValue.equals("") && !expectedValue.equals(retrievedParamValue)) {
                RestTestBase.report.report("The retrievedParamValue: " + retrievedParamValue + " " + " is not as expected." + expectedValue, Reporter.FAIL);
            }
        } catch (Exception e) {
            RestTestBase.report.report("GET following RadiusSettings: " + paramToRetrieve + " " + " request may not have been executed properly.", parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * @param paramToRetrieve - key to look for
     * @param expectedValue   - Optional: Expected result
     */
    @Then("^REST get UserManagement Settings \"([^\"]*)\"(?: Expected result \"([^\"]*)\")?$")
    public void getUserManagementSettings(String paramToRetrieve, String expectedValue) {
        try {
            retrievedParamValue = UserManagementSettingsHandler.getUserManagementSettingsByKey(getVisionRestClient(), UserManagementSettingsKeys.getUserManagementSettingsKeysEnum(paramToRetrieve));
            if (!expectedValue.equals("") && !expectedValue.equals(retrievedParamValue)) {
                RestTestBase.report.report("The retrievedParamValue: " + retrievedParamValue + " " + " is not as expected." + expectedValue, Reporter.FAIL);
            }
        } catch (Exception e) {
            RestTestBase.report.report("GET following Parameter: " + paramToRetrieve + " " + " request may not have been executed properly.", parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * @param paramToRetrieve - key to look for
     * @param expectedValue   - Optional: Expected result
     */
    @Then("^REST get TacacsSettings Parameters \"([^\"]*)\"(?: Expected result \"([^\"]*)\")?$")
    public void getTacacsSettings(String paramToRetrieve, String expectedValue) {
        try {
            retrievedParamValue = AuthenticationProtocolsHandler.getTacacsSettingsByKey(getVisionRestClient(), TacacsSettingsKeys.getTacacsSettingsKeysEnum(paramToRetrieve));
            if (!expectedValue.equals("") && !expectedValue.equals(retrievedParamValue)) {
                RestTestBase.report.report("The retrievedParamValue: " + retrievedParamValue + " " + " is not as expected." + expectedValue, Reporter.FAIL);
            }
        } catch (Exception e) {
            RestTestBase.report.report("GET following basicParameter: " + paramToRetrieve + " " + " request may not have been executed properly.", parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * temporary just until 24/03/19
     */

    @And("^UI Click Button by id \"([^\"]*)\"$")
    public void uiClickButtonById(String id) {
        WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorById(id).getBy()).click();
    }

    @And("^UI Click Button by Class \"([^\"]*)\"$")
    public void uiClickButtonByClass(String className) {
        WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByClass(className).getBy()).click();
    }

    /**
     * this method validate if we delete the activation license and validate if we failed to add expired activation license (by Rest login)
     *
     * @throws Exception in case license generation fails
     */
//    @Given("^REST Vision Install License Request vision-activation with expired date$")
    public void expireActivationLicense() throws Exception {
        String pureActivationLicense = "vision-activation"; // activation license without expired date
        String username = "radware";
        String password = "radware";
        //Generate activation license and add it, after that we delete it
        String pureLicenseKey = LicenseManagementHandler.generateLicense(getRestTestBase().getRadwareServerCli(), pureActivationLicense);
        getRestTestBase().getVisionRestClient().login(username, password, pureLicenseKey, 1);
        deleteLicenses(pureActivationLicense);

        String activationLicenseWithDate = pureActivationLicense + "-" + addDateToLicensePrefix("-4M") + "-" + addDateToLicensePrefix("-1d");// license with date
        try {
            String licenseKey = LicenseManagementHandler.generateLicense(getRestTestBase().getRadwareServerCli(), activationLicenseWithDate);// generate license with date
            getRestTestBase().getVisionRestClient().login(username, password, licenseKey, 1);// add license with expired date by rest login
        } catch (Exception e) {
            //Validation - failed to login with expired date
            getRestTestBase().getVisionRestClient().login(username, password, pureLicenseKey, 1);// here we return the license without date
            BaseTestUtils.report("The user can't login with expired activation license", Reporter.PASS);
            return;
        }
        //login with expired date has succeed, so we should throw error message
        getRestTestBase().getVisionRestClient().login(username, password, pureLicenseKey, 1);// here we return the license without date
        BaseTestUtils.report("The user can login with expired activation license", Reporter.FAIL);
    }

    @Given("^REST Request \"(.*)\" for \"(.*)\"$")
    public void genericRestRequest(HttpMethodEnum method, String request, List<BasicRestOperationsHandler.RestRequestElements> requestEntries) {
        visionRestApiBuilder(method, request, requestEntries);
    }

    /**
     * @param listType  should be black or white
     * @param deviceIp  defensePro ip
     * @param entryName name of list
     */

    @Given("^Rest Delete \"([^\"]*)\" List if exist with defensePro ip \"([^\"]*)\" and name of list \"([^\"]*)\"$")
    public void blackWhiteListDelete(String listType, String deviceIp, String entryName) {
        listType = listType.toLowerCase();
        if (listType.equals("white") || listType.equals("black")) {
            restTestBase.getVisionRestClient().login("radware", "radware", "", 1);
            genericRESTApi(HttpMethodEnum.POST, null, "DPM_Dashboard->lock", deviceIp, null, null);
            try {
                genericRESTApi(HttpMethodEnum.DELETE, null, "DefensePro->" + listType + " List", deviceIp + "|" + entryName, null, null);
            } catch (Exception e) {
                if (e.getMessage().contains("Entry not found")) {
                    BaseTestUtils.report("the entry not found you can add " + entryName + " ", Reporter.PASS);
                } else {
                    BaseTestUtils.report(e.getMessage() + " ", Reporter.FAIL);
                }
            }


        } else {
            BaseTestUtils.report("'" + listType + "' is not supported here ", Reporter.FAIL);
        }
    }

    @Given("^Rest Validate \"([^\"]*)\" List if exist with defensePro ip \"([^\"]*)\" and name of list \"([^\"]*)\"$")
    public void blackWhiteListIfExist(String listType, String deviceIp, String entryName) {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        listType = listType.toLowerCase();
        if (listType.equals("white") || listType.equals("black")) {
            restTestBase.getVisionRestClient().login("radware", "radware", "", 1);
            Object result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.GET,
                    "DefensePro->" + listType + " List", deviceIp + "|" + entryName, null, null);
            if (!result.toString().contains(entryName)) {
                BaseTestUtils.report("the entry :'" + entryName + "' is not found ", Reporter.FAIL);
            }
        } else {
            BaseTestUtils.report("'" + listType + "' is not supported here ", Reporter.FAIL);
        }
    }

    @Given("^Rest Validate BDOS Table DP: ip \"([^\"]*)\" Profile:\"([^\"]*)\" ,Inbound:\"([^\"]*)\", Outbound:\"([^\"]*)\"$")
    public void validateDPInboundOutbound(String IP, String profile, String inbound, String outbound) {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        restTestBase.getVisionRestClient().login("radware", "radware", "", 1);
        Object result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.GET,
                "DefensePro->BDOS Profile Table", IP + "|" + profile, null, null);
        try {
            JSONParser parser = new JSONParser();
            JSONObject jsonResult = (JSONObject) parser.parse((String) result);
            JSONObject ProfileTableJson = (JSONObject) ((JSONArray) jsonResult.get("rsNetFloodProfileTable")).get(0);
            String inboundActual = ProfileTableJson.get("rsNetFloodProfileBandwidthIn").toString();
            String outboundActual = ProfileTableJson.get("rsNetFloodProfileBandwidthOut").toString();
            if (!inbound.equalsIgnoreCase(inboundActual))
                BaseTestUtils.report("The inbound not matched, Actual inbound is: " + inboundActual + ", but the Expedted inbound is: " + inbound, Reporter.FAIL);

            if (!outbound.equalsIgnoreCase(outboundActual))
                BaseTestUtils.report("The inbound not matched, Actual outbound is: " + outboundActual + ", but the Expedted outbound is: " + outbound, Reporter.FAIL);
        } catch (
                ParseException e) {
            BaseTestUtils.report("Error of Parsing JSON Reponse", Reporter.FAIL);
        }
    }

    @Given("^Rest Validate DNS Table DP: ip \"([^\"]*)\" Profile:\"([^\"]*)\" ,QueryRate:\"([^\"]*)\", MaxQPS:\"([^\"]*)\"$")
    public void validateDPQueryRateMaxQPS(String IP, String profile, String queryRate, String maxQPS) {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        restTestBase.getVisionRestClient().login("radware", "radware", "", 1);
        Object result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.GET,
                "DefensePro->DNS Rules Table", IP + "|" + profile, null, null);
        try {
            JSONParser parser = new JSONParser();
            JSONObject jsonResult = (JSONObject) parser.parse((String) result);
            JSONObject ProfileTableDNSJson = (JSONObject) ((JSONArray) jsonResult.get("rsDnsProtProfileTable")).get(0);
            String queryRateActual = ProfileTableDNSJson.get("rsDnsProtProfileExpectedQps").toString();
            String maxQPSActual = ProfileTableDNSJson.get("rsDnsProtProfileMaxAllowQps").toString();
            if (!queryRate.equalsIgnoreCase(queryRateActual))
                BaseTestUtils.report("The inbound not matched, Actual queryRate is: " + queryRateActual + ", but the Expedted queryRate is: " + queryRate, Reporter.FAIL);

            if (!maxQPS.equalsIgnoreCase(maxQPSActual))
                BaseTestUtils.report("The inbound not matched, Actual maxQPS is: " + maxQPSActual + ", but the Expected maxQPS is: " + maxQPS, Reporter.FAIL);

        } catch (
                ParseException e) {
            BaseTestUtils.report("Error of Parsing JSON Response", Reporter.FAIL);
        }
    }

    @Given("^add (\\d+) applications with prefix name \"([^\"]*)\" to appWall ip:\"([^\"]*)\" with timeout (\\d+)$")
    public void addApplicationsToAWDashboard(int loop, String appPrefix, String appWallIp, int timeout) throws Exception {
        RootServerCli rootServerCli = new RootServerCli(restTestBase.getRootServerCli().getHost(), restTestBase.getRootServerCli().getUser(), restTestBase.getRootServerCli().getPassword());
        rootServerCli.init();
        rootServerCli.connect();
        String commandToExecute = "for i in {1.." + loop + "}; do curl -XPOST localhost:9200/aw-web-application/aw-web-application?pretty -H \"Content-Type: application/json\" -d '{\"enrichmentContainer\": { },\"timeStamp\": \"1569429855341\",\"id\": \"" + appWallIp + "%My_Application-'$i'\",\"deviceIp\": \"" + appWallIp + "\",\"webApplication\":\"" + appPrefix + "-'$i'\"}'; done";
        timeout *= 1000;
        CliOperations.runCommand(rootServerCli, commandToExecute, timeout);
    }

    @When("^REST Logout user \"(.*)\"$")
    public void restLogout(String user) {
        if (restTestBase.getVisionRestClient().isLogged(user)) {
            restTestBase.getVisionRestClient().logout(user);
        }
    }

    @Then("^REST Validate existence reports$")
    public void restValidateExistenceReports(List <BasicRestOperationsHandler.ExistenceReport> reports) {
        List <BasicRestOperationsHandler.RestRequestElements> requestEntries = new ArrayList<>();
        requestEntries.add(new BasicRestOperationsHandler.RestRequestElements("Returned status code", "200"));
        BasicRestOperationsHandler.validateExistenceReports(reports, visionRestApiBuilder(HttpMethodEnum.GET, "DefenseFlow->getReports", requestEntries));
    }
}
