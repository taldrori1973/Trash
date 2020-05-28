package com.radware.vision.infra.testresthandlers.visionLicense;

import basejunit.RestTestBase;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import models.RestResponse;
import org.json.simple.parser.ParseException;
import testhandlers.VisionRestApiHandler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public abstract class VisionLicenseTestHandler {
    protected VisionRestApiHandler visionRestApiHandler;

    protected HashMap<String, GenericVisionRestAPI> requests = new HashMap<>();

    protected static RestTestBase restTestBase = new RestTestBase();

    protected String defenseFlowOrmId;

    public VisionLicenseTestHandler() throws NoSuchFieldException {
        this.visionRestApiHandler = new VisionRestApiHandler();
        requests.put("Vision License Info", new GenericVisionRestAPI("Vision/SystemConfigLicense.json", "Vision License Info"));
        requests.put("Attack Capacity License",new GenericVisionRestAPI("Vision/SystemConfigLicense.json", "Attack Capacity License"));
        requests.put("Get Device Tree",new GenericVisionRestAPI("Vision/SystemConfigTree.json", "GET Device Tree"));
        requests.put("Get DefenseFlow OrmId", new GenericVisionRestAPI("Vision/SystemManagement.json", "Get Management Info"));

        setDefenseFlowOrmId();
    }

    private void setDefenseFlowOrmId() {
        RestResponse restResponse = requests.get("Get DefenseFlow OrmId").sendRequest();
        JsonObject json = new JsonParser().parse(restResponse.getBody().getBodyAsString()).getAsJsonObject();
        defenseFlowOrmId = json.get("defenseFlowId").isJsonNull() ? null : json.get("defenseFlowId").getAsString();
        if (defenseFlowOrmId != null && defenseFlowOrmId.isEmpty())
            defenseFlowOrmId = null;

    }

    public abstract String getValue(String key);


    protected String sendRequest(RestRequest restRequest) {
        RestTestBase.visionRestClient.login();
        return (String) visionRestApiHandler.handleRequest(RestTestBase.visionRestClient, restRequest.method, restRequest.request, restRequest.urlParams, restRequest.bodyParams, restRequest.expectedResponse);
    }

    protected List<String> deviceOrmIdListToIpsList(List<String> ormIds) {
        List<String> ips = new ArrayList<>();
        RestResponse restResponse = requests.get("Get Device Tree").sendRequest();
        DocumentContext jsonContext = JsonPath.parse(restResponse);
        String jsonPath = "$..children[?(@.meIdentifier.managedElementID=='%s')][\"managementIp\"]";
        for (String ormId : ormIds) {
            List<String> ipAsList = jsonContext.read(jsonPath.replace("%s", ormId));
            if (ipAsList != null && !ipAsList.isEmpty())
                ips.add(ipAsList.get(0));
            else if (!ormId.equals(defenseFlowOrmId))
                BaseTestUtils.report(String.format("Can't find management ip for ormId=%s at Organization Tree, and it's not a DefenseFlow ID", ormId), Reporter.FAIL);

        }
        return ips;
    }

    protected class RestRequest {
        String request;
        HttpMethodEnum method;
        String urlParams;
        String bodyParams;
        String expectedResponse;

        protected RestRequest(String request, HttpMethodEnum method, String urlParams, String bodyParams, String expectedResponse) {
            this.request = request;
            this.method = method;
            this.urlParams = urlParams;
            this.bodyParams = bodyParams;
            this.expectedResponse = expectedResponse;
        }


    }


    public static VisionLicenseTestHandler createInstanceByType(SupportedLicenseTypes licenseType) throws IOException, ParseException, NoSuchFieldException {
        VisionLicenseTestHandler visionLicenseTestHandler;
        switch (licenseType) {
            case ATTACK_CAPACITY_LICENSE:
                visionLicenseTestHandler = new AttackCapacityLicenseTestHandler();
                break;
            case VRM_AMS_LICENSE:
                visionLicenseTestHandler = new BooleanLicenseTestHandler(BooleanLicenseTestHandler.BooleanLicenseTypes.VRM_AMS_LICENSE);
                break;
            case AVA_APPWALL_LICENSE:
                visionLicenseTestHandler = new BooleanLicenseTestHandler(BooleanLicenseTestHandler.BooleanLicenseTypes.AVA_APPWALL_LICENSE);
                break;
            case VRM_ADC_LICENSE:
                visionLicenseTestHandler = new BooleanLicenseTestHandler(BooleanLicenseTestHandler.BooleanLicenseTypes.VRM_ADC_LICENSE);
                break;
            case AVR_LICENSE:
                visionLicenseTestHandler = new BooleanLicenseTestHandler(BooleanLicenseTestHandler.BooleanLicenseTypes.AVR_LICENSE);
                break;
            case DPM_LICENSE:
                visionLicenseTestHandler = new BooleanLicenseTestHandler(BooleanLicenseTestHandler.BooleanLicenseTypes.DPM_LICENSE);
                break;
            case APM_LICENSE:
                visionLicenseTestHandler = new BooleanLicenseTestHandler(BooleanLicenseTestHandler.BooleanLicenseTypes.APM_LICENSE);
                break;

            default:
                throw new IllegalStateException("Unexpected value: " + licenseType);
        }
        return visionLicenseTestHandler;
    }

    public static enum SupportedLicenseTypes {
        VRM_AMS_LICENSE("vrmAmsLicense"),
        AVA_APPWALL_LICENSE("avaAppWallLicense"),
        VRM_ADC_LICENSE("vrmAdcLicense"),
        ATTACK_CAPACITY_LICENSE("attackCapacityLicense"),
        DPM_LICENSE("dpmLicense"),
        AVR_LICENSE("avrLicense"),
        APM_LICENSE("apmLicense");

        private String licenseType;

        SupportedLicenseTypes(String licenseType) {
            this.licenseType = licenseType;
        }

        public String getLicenseType() {
            return this.licenseType;
        }
    }
}
