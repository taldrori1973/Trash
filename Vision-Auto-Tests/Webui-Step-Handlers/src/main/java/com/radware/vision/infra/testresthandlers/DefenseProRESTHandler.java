package com.radware.vision.infra.testresthandlers;

import basejunit.RestTestBase;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.utils.DeviceUtils;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.vrm.VRMHandler;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import testhandlers.VisionRestApiHandler;

import java.util.ArrayList;
import java.util.List;

import static com.radware.vision.infra.testhandlers.BaseHandler.devicesManager;

public class DefenseProRESTHandler {


    public static String updatePolicies(String deviceIP) {
        String result;

        lockDevice(deviceIP);
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.POST,
                "DefensePro->Update Policies", deviceIP, null, null);

        unlockDevice(deviceIP);
        return result;
    }

    public static String fetchPolicies() {
        String result;
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.POST,
                "DefensePro->Fetch Policies", null, null, null);


        return result;
    }

    public static void addNewPolicy(String policyName, String dpIp) {
        lockDevice(dpIp);

        if (isPolicyExist(policyName, dpIp)) return;


        String result;
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

        result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(),
                HttpMethodEnum.POST, "DefensePro->Add New Policy", dpIp + "|" + policyName, "rsIDSNewRulesName=" + policyName, null);

        unlockDevice(dpIp);
        if (!result.contains("\"status\" : \"ok\"")) {
            BaseTestUtils.report(result, Reporter.FAIL);
        }

        updatePolicies(dpIp);
    }

    public static void deletePolicy(String policyName, List<VRMHandler.DpDeviceFilter> entries) {


        entries.forEach(entry -> {
            String dpIp = null;
            try {
                if (entry.index == null) {
                    throw new Exception("Index entry is empty please enter it!");
                }
                dpIp = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, entry.index).getDeviceIp();

            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), e);
            }
            lockDevice(dpIp);

            if (!isPolicyExist(policyName, dpIp)) return;


            String result;
            VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

            result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(),
                    HttpMethodEnum.DELETE, "DefensePro->Delete Policy", dpIp + "|" + policyName, null, null);


            unlockDevice(dpIp);
            if (!result.contains("\"status\" : \"ok\"")) {
                BaseTestUtils.report(result, Reporter.FAIL);
            }

            updatePolicies(dpIp);
        });
    }



    public static void addNewPolicy(String policyName, List<VRMHandler.DpDeviceFilter> entries) {

        entries.forEach(entry -> {
            String dpIp = null;
            try {
                if (entry.index == null) {
                    throw new Exception("Index entry is empty please enter it!");
                }
                dpIp = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, entry.index).getDeviceIp();

            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), e);
            }
            lockDevice(dpIp);

            if (isPolicyExist(policyName, dpIp)) return;


            String result;
            VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

            result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(),
                    HttpMethodEnum.POST, "DefensePro->Add New Policy", dpIp + "|" + policyName, "rsIDSNewRulesName=" + policyName, null);

            unlockDevice(dpIp);
            if (!result.contains("\"status\" : \"ok\"")) {
                BaseTestUtils.report(result, Reporter.FAIL);
            }

            updatePolicies(dpIp);
        });
    }

    public static void deletePolicy(String policyName, String dpIp) {
        lockDevice(dpIp);

        if (!isPolicyExist(policyName, dpIp)) return;


        String result;
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

        result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(),
                HttpMethodEnum.DELETE,"DefensePro->Delete Policy", dpIp + "|" + policyName, null, null);


        unlockDevice(dpIp);
        if (!result.contains("\"status\" : \"ok\"")) {
            BaseTestUtils.report(result, Reporter.FAIL);
        }

        updatePolicies(dpIp);
    }

    public static void addNewProfileToPolicyToIP(String rule, String profile, String policyName, String dpIp) throws Exception {

        lockDevice(dpIp);
        if (!isPolicyExist(policyName, dpIp)) throw new Exception("No policy with name " + policyName + " in DP with IP " + dpIp);
        if (isProfileExist(policyName, dpIp, profile, rule))return;
        String result;
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

        result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(),
                HttpMethodEnum.PUT, "DefensePro->Add New profile", dpIp + "|" + policyName, "rsIDSNewRulesName=" + policyName + ",rsIDSNewRulesProfileHttpsflood=" + rule, null);

        unlockDevice(dpIp);
        if (!result.contains("\"status\" : \"ok\"")) {
            BaseTestUtils.report(result, Reporter.FAIL);
        }

        updatePolicies(dpIp);

    }



    public static void blockCountry(String deviceIp, String policyName, String countryCode, String time) {
        lockDevice(deviceIp);
        String result;
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

        result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(),
                HttpMethodEnum.POST, "DefensePro->Block Country", deviceIp + "|" + policyName + "|" + countryCode, "blockTimeBySeconds=" + time, null);
        unlockDevice(deviceIp);

        if (!result.contains("{ \"status\" : \"ok\" }"))
            BaseTestUtils.report(result, Reporter.FAIL);


    }

    public static void releaseBlocksForAllCountries(String deviceIp, String policyName) {
        lockDevice(deviceIp);

        List<String> blockedCountries = getAllBlockedCountries(deviceIp, policyName);
        unlockDevice(deviceIp);

        for (String country : blockedCountries) {
            releaseBlockedCountry(deviceIp, policyName, country);
        }


    }

    public static void releaseBlockedCountry(String deviceIp, String policyName, String countryCode) {
        lockDevice(deviceIp);
        String result;
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

        result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(),
                HttpMethodEnum.DELETE, "DefensePro->Release Blocked Country", deviceIp + "|" + policyName + "|" + countryCode, null, null);
        unlockDevice(deviceIp);

        if (!result.contains("{ \"status\" : \"ok\" }"))
            BaseTestUtils.report(result, Reporter.FAIL);


    }


    public static List<String> getAllBlockedCountries(String deviceIp, String policyName) {
        String result;
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

        result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(),
                HttpMethodEnum.GET, "DefensePro->Get All Blocked Countries", deviceIp + "|" + policyName, null, null);

        if (!result.contains("\"status\": \"Success\""))
            BaseTestUtils.report(result, Reporter.FAIL);

        DocumentContext jsonContext = JsonPath.parse(result);
        List<String> countries = jsonContext.read("$..['country']");

        List<String> countriesResult = new ArrayList<>();
        for (String country : countries) {
            if (country.contains("\"") || country.contains("\'"))
                country = country.replaceAll("[\"|\']", "");
            countriesResult.add(country);
        }


        return countriesResult;
    }


    private static boolean isProfileExist(String policyName, String dpIp, String profile, String rule) {
        String result;
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

        result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(),
                HttpMethodEnum.GET, "DefensePro->Profiles Names", dpIp + "|" + policyName, null, null);


        JSONParser parser = new JSONParser();
        try {
            if (((JSONObject)(((JSONArray)(((JSONObject) parser.parse(result)).get("rsIDSNewRulesTable"))).get(0))).get("rsIDSNewRules" + profile) != null)
                if (((JSONObject)(((JSONArray)(((JSONObject) parser.parse(result)).get("rsIDSNewRulesTable"))).get(0))).get("rsIDSNewRules" + profile).toString().equals(rule))
                    return true;

        } catch (ParseException e) {
            BaseTestUtils.report("Error of Parsing JSON Reponse", Reporter.FAIL);
        }

        return false;
    }

    private static boolean isPolicyExist(String policyName, String dpIp) {
        String result;
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

        result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(),
                HttpMethodEnum.GET, "DefensePro->Rules Names", dpIp, null, null);


        JSONParser parser = new JSONParser();
        try {
            JSONArray response = (JSONArray) ((JSONObject) parser.parse(result)).get("rsIDSNewRulesTable");

            for (Object object : response) {
                JSONObject currentObject = (JSONObject) object;
                if (currentObject.get("rsIDSNewRulesName").toString().equals(policyName)) return true;
            }

        } catch (ParseException e) {
            BaseTestUtils.report("Error of Parsing JSON Reponse", Reporter.FAIL);
        }

        return false;
    }

    private static void lockDevice(String deviceIp) {
        String result;

        result = DeviceUtils.lockCommand(BaseHandler.restTestBase.getVisionRestClient(), deviceIp);

        if (!result.contains("\"status\":\"ok\""))
            BaseTestUtils.report(result, Reporter.FAIL);
    }

    private static void unlockDevice(String deviceIp) {
        String result;

        result = DeviceUtils.unlockCommand(BaseHandler.restTestBase.getVisionRestClient(), deviceIp);

        if (!result.contains("\"status\":\"ok\""))
            BaseTestUtils.report(result, Reporter.FAIL);
    }


    public static String getMacByIp(String ip) {

        RestTestBase.visionRestClient.login();
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();

        String result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(),
                HttpMethodEnum.GET, "Device Tree->Get Tree", null, null, null);

        DocumentContext jsonContext = JsonPath.parse(result);
        String jsonPath = "$..children[?(@.managementIp=='" + ip + "')][\"baseMacAddress\"]";
        return ((List<String>) jsonContext.read(jsonPath)).get(0);


    }
}
