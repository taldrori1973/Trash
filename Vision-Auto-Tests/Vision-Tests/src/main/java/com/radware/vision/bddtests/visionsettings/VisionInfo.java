package com.radware.vision.bddtests.visionsettings;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import com.radware.vision.restBddTests.utils.UriUtils;
import models.RestRequestSpecification;
import models.RestResponse;
import models.StatusCode;

import static com.radware.automation.tools.basetest.Reporter.FAIL;
import static com.radware.vision.restBddTests.utils.SutUtils.*;
import static com.radware.vision.restBddTests.utils.SutUtils.getCurrentVisionRestUserPassword;

public class VisionInfo {
    private Integer port = null;
    private String username;
    private String password;
    private String licenseKey = null;
    private RestRequestSpecification restRequestSpecification;
    private GenericVisionRestAPI genericVisionRestAPI;
    private String ip;

    private static String visionVersion;
    private static String visionBuild;
    private static String visionBranch;

    public VisionInfo(String ip) {
        updateVisionInfo(ip);
    }

    private void updateVisionInfo(String ip) {
        try {
            this.ip = ip;
            this.username = getCurrentVisionRestUserName();
            this.password = getCurrentVisionRestUserPassword();
            getInfo();
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
    }

    public static String getVisionBuild() {
        return visionBuild;
    }

    public static String getVisionBranch() {
        return visionBranch;
    }

    public static String getVisionVersion() {
        return visionVersion;
    }

    private void getInfo() {
        String filePath = "Vision/SystemManagement.json";
        String requestLabel = "Get Management Info Ex";
        RestResponse response;
        String baseUri = UriUtils.buildUrlFromProtocolAndIp(getCurrentVisionRestProtocol(), ip);

        genericVisionRestAPI = new GenericVisionRestAPI(baseUri, port, username, password, licenseKey, filePath, requestLabel);
        restRequestSpecification = this.genericVisionRestAPI.getRestRequestSpecification();

            response = genericVisionRestAPI.sendRequest();
            if (response == null)//server is down or not connected
                return;
            //an old version that do not support branch
            if (response.getStatusCode().equals(StatusCode.INTERNAL_SERVER_ERROR) &&
                    response.getBody().getBodyAsJsonNode().get().findValue("message").toString().contains("Illegal item path")) {
                requestLabel = "Get Management Info";
                genericVisionRestAPI = new GenericVisionRestAPI(baseUri, port, username, password, null, filePath, requestLabel);
            }
            response = genericVisionRestAPI.sendRequest();
            if (!response.getStatusCode().equals(StatusCode.OK)) {
                BaseTestUtils.report(response.getStatusCode().toString(), FAIL);
            }
            String serverSoftwareVersion = response.getBody().getBodyAsJsonNode().get().findValue("serverSoftwareVersion").asText();
            String[] aServerSoftwareVersion = serverSoftwareVersion.split(" ");

            visionVersion = aServerSoftwareVersion[0];
            visionBuild = aServerSoftwareVersion[1];
            if (response.getBody().getBodyAsJsonNode().get().has("branch"))
                visionBranch = response.getBody().getBodyAsJsonNode().get().findValue("branch").asText();
    }
}
