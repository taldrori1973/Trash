package com.radware.vision.infra.testresthandlers;

import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.infra.testhandlers.BaseHandler;
import testhandlers.VisionRestApiHandler;

public class DefenseFlowRestHandler {

    public static String addOrGetPo(HttpMethodEnum method, String urlField, String bodyField, String expectedResult) {
        String result;

        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        result = (String) visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), method,
                "DefenseFlow->Add New PO", urlField, bodyField, expectedResult);
        return result;
    }

}
