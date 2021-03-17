package com.radware.vision.base;

import basejunit.RestTestBase;
import com.radware.restcore.GenericRestClient;
import com.radware.restcore.RestBasicConsts;
import com.radware.restcore.VisionRestClient;
import com.radware.restcore.utils.enums.ExpectedHttpCodes;
import com.radware.vision.automation.base.TestBase;


public class RestManagement extends RestTestBase {
    public void init() throws Exception {
        String hostIp = TestBase.getSutManager().getClientConfigurations().getHostIp();
        visionRestClient = new VisionRestClient(hostIp, null, RestBasicConsts.RestProtocol.HTTPS);
        visionRestClient.setExpectedStatusCode(ExpectedHttpCodes.OK.getStatusCodes());
        visionRestClient.setIgnoreResponseCodeValidation(ignoreRestResponseValidation);

        genericRestClient = new GenericRestClient(hostIp, null, RestBasicConsts.RestProtocol.HTTPS);
        genericRestClient.setExpectedStatusCode(ExpectedHttpCodes.OK.getStatusCodes());
        genericRestClient.setIgnoreResponseCodeValidation(ignoreRestResponseValidation);
    }
}