package com.radware.vision.infra.testresthandlers.visionLicense;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.radware.vision.infra.testresthandlers.visionLicense.pojos.BooleanLicensePojo;

import java.io.IOException;

/**
 * By MohamadI
 * @see com.radware.vision.infra.testresthandlers.visionLicense.pojos.BooleanLicensePojo
 * For Licenses that return response to the GET: /mgmt/system/config/item/licenseinfo Request as Follow:
 * "License Name": {
 * "valid": <boolean>
 * }
 * for now only 3 Licenses of this type:
 * 1. vision-reporting-module-AMS (This License was replaced with AVA Attack Capacity License at version 4.30)
 * returns:
 * "vrmAmsLicense": {
 * "valid": <boolean>
 * },
 * <p>
 * 2. vision-AVA-AppWall (New License From version 4.40)
 * returns:
 * "avaAppWallLicense": {
 * "valid": <boolean>
 * },
 * <p>
 * 3.vision-reporting-module-ADC
 * returns:
 * "vrmAdcLicense": {
 * "valid": <boolean>
 * },
 *
 *
 */
public class BooleanLicenseTestHandler extends VisionLicenseTestHandler {

    private BooleanLicensePojo booleanLicensePojo;
    private BooleanLicenseTypes type;

    public BooleanLicenseTestHandler(BooleanLicenseTypes type) throws IOException {
        super();
        this.type = type;
        this.booleanLicensePojo = new BooleanLicensePojo();
        setLicenseInfo();
    }

    @Override
    public String getValue(String key) {
        if (key.equals("valid")) return String.valueOf(this.booleanLicensePojo.isValid());
        throw new IllegalStateException("Unexpected value: " + key);
    }

    private void setLicenseInfo() throws IOException {
        String licenseTypesResponse = sendRequest(requests.get("Vision License Info"));
        JsonParser jsonParser = new JsonParser();
        JsonObject root = jsonParser.parse(licenseTypesResponse).getAsJsonObject();
        boolean licenseInfo = root.get(type.licenseName).getAsJsonObject().get("valid").getAsBoolean();
        this.booleanLicensePojo.setValid(licenseInfo);
    }

    public static enum BooleanLicenseTypes {
        VRM_AMS_LICENSE("vrmAmsLicense"),
        AVA_APPWALL_LICENSE("avaAppWallLicense"),
        VRM_ADC_LICENSE("vrmAdcLicense"),
        DPM_LICENSE("dpmLicense"),
        AVR_LICENSE("avrLicense"),
        APM_LICENSE("apmLicense");

        private String licenseName;

        private BooleanLicenseTypes(String licenseName) {
            this.licenseName = licenseName;
        }

        public String getLicenseName() {
            return this.licenseName;
        }
    }
}
