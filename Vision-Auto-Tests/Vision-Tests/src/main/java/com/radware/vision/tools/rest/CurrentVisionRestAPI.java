package com.radware.vision.tools.rest;

import com.radware.vision.base.TestBase;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import com.radware.vision.restBddTests.utils.UriUtils;
import lombok.Getter;
import models.RestRequestSpecification;
import models.RestResponse;

import static com.radware.vision.restBddTests.utils.SutUtils.*;

public class CurrentVisionRestAPI {

    @Getter
    private RestRequestSpecification restRequestSpecification;
    private GenericVisionRestAPI genericVisionRestAPI;

    public CurrentVisionRestAPI(String requestFilePath, String requestLabel) throws NoSuchFieldException {
        this(requestFilePath, requestLabel, Integer.parseInt(TestBase.getSutManager().getVisionConfigurations().getRestConnectionDefaultPort()));
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
