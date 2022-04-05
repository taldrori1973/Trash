package com.radware.vision.tools.rest;

import com.radware.vision.restAPI.GenericVisionRestAPI;
import com.radware.vision.utils.SutUtils;
import com.radware.vision.utils.UriUtils;
import lombok.Getter;
import models.RestRequestSpecification;
import models.RestResponse;

import static com.radware.vision.utils.SutUtils.*;

public class CurrentVisionRestAPI {

    @Getter
    private RestRequestSpecification restRequestSpecification;
    private GenericVisionRestAPI genericVisionRestAPI;

    public CurrentVisionRestAPI(String requestFilePath, String requestLabel) throws NoSuchFieldException {
        String baseUri = UriUtils.buildUrlFromProtocolAndIp(getCurrentVisionRestProtocol(), getCurrentVisionIp());
        Integer port = SutUtils.getCurrentVisionRestPort();
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
