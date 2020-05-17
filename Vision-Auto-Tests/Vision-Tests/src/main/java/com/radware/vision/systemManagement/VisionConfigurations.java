package com.radware.vision.systemManagement;

import com.radware.vision.RestClientsFactory;
import com.radware.vision.systemManagement.controllers.VisionConfigurationsController;
import com.radware.vision.systemManagement.models.ManagementInfo;
import com.radware.vision.tools.LicenseGenerator;
import models.RestResponse;
import models.StatusCode;
import restInterface.client.SessionBasedRestClient;

import static com.radware.vision.utils.SutUtils.*;
import static com.radware.vision.utils.UriUtils.buildUrlFromProtocolAndIp;

public class VisionConfigurations {

    private VisionConfigurationsController visionConfigurationsController = new VisionConfigurationsController();
    private ManagementInfo managementInfo;

    public VisionConfigurations() {
        validateRestConnection();
        this.managementInfo = visionConfigurationsController.getVisionManagementInfoByRest();
    }

    public ManagementInfo getManagementInfo() {
        return managementInfo;
    }

    private void validateRestConnection() {
        String baseUri;
        try {
            String visionMac = null;
            baseUri = buildUrlFromProtocolAndIp(getCurrentVisionRestProtocol(), getCurrentVisionIp());
            String username = getCurrentVisionRestUserName();
            String password = getCurrentVisionRestUserPassword();
            String licenseKey = null;

//          send Login Request
            SessionBasedRestClient connection = RestClientsFactory.getVisionConnection(baseUri, getCurrentVisionRestPort(), username, password, licenseKey);
            RestResponse loginResult = connection.login();

//          if fail : check if it's because the license
            if (loginResult.getStatusCode().equals(StatusCode.PAYMENT_REQUIRED)) {
//              if because the license : get the MAC from response header and send another login request with the license activation
                visionMac = loginResult.getHeaders().getOrDefault("Vision-MAC", null);


                if (visionMac == null)
                    throw new NoSuchFieldException("The Login returns 402 Payment Required and no \"Vision-MAC\" key was found in the response header.");
                else {//send new login request with activation Key
                    licenseKey = LicenseGenerator.generateVisionActivationLicenseKey(visionMac);
                    connection = RestClientsFactory.getVisionConnection(baseUri, null, username, password, licenseKey);
                    loginResult = connection.login();

                    if (!loginResult.getStatusCode().equals(StatusCode.OK)) {
                        throw new RuntimeException(String.format("the Login Fails because of the following error: %s", loginResult.getBody().getBodyAsString()));
                    }
                }
//                    else throw exception
            } else if (!loginResult.getStatusCode().equals(StatusCode.OK)) {
                throw new RuntimeException(String.format("the Login Fails because of the following error: %s", loginResult.getBody().getBodyAsString()));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
