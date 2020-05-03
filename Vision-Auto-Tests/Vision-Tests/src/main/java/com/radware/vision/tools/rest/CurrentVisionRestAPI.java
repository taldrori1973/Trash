package com.radware.vision.tools.rest;

import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.base.TestBase;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import com.radware.vision.utils.UriUtils;
import lombok.Getter;
import models.RestRequestSpecification;
import models.RestResponse;

import static com.radware.vision.utils.SutUtils.*;

public class CurrentVisionRestAPI {

    @Getter
    private RestRequestSpecification restRequestSpecification;
    private GenericVisionRestAPI genericVisionRestAPI;
    private static ClientConfigurationDto clientConfigurationDto = TestBase.getSutManager().getClientConfigurations();

    public CurrentVisionRestAPI(String requestFilePath, String requestLabel) throws NoSuchFieldException {
        this(requestFilePath, requestLabel, Integer.parseInt(clientConfigurationDto.getRestConnectionDefaultPort()));
    }

    public CurrentVisionRestAPI(String requestFilePath, String requestLabel, Integer port) throws NoSuchFieldException {
        String baseUri = UriUtils.buildUrlFromProtocolAndIp(getCurrentVisionRestProtocol(), getCurrentVisionIp());
        String username = getCurrentVisionRestUserName();
        String password = getCurrentVisionRestUserPassword();
        String licenseKey = null;
        this.genericVisionRestAPI = new GenericVisionRestAPI(baseUri, port, username, password, null, requestFilePath, requestLabel);
        this.restRequestSpecification = this.genericVisionRestAPI.getRestRequestSpecification();
    }


    public RestResponse sendRequest() {
        return this.genericVisionRestAPI.sendRequest();
    }
}
