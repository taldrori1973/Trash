package com.radware.vision.infra.testresthandlers;

import basejunit.RestTestBase;
import com.radware.restcore.VisionRestClient;
import org.json.JSONObject;

import static com.radware.restcore.utils.enums.HttpMethodEnum.GET;
import static com.radware.restcore.utils.enums.HttpMethodEnum.PUT;

public class RestSettingHandler {

    public RestSettingHandler()
    {
        RestTestBase restTestBase = new RestTestBase();
        try{restTestBase.init();}catch (Exception e){}
        visionRestClient = restTestBase.visionRestClient;
    }
    public VisionRestClient visionRestClient;


    public void changeEmailConfigurationToEnableOrDisable(String isEnable) {
        Boolean enable = isEnable.equalsIgnoreCase("enable");
        if(isEmailConfigurationIsEnabled() != enable)
        {
            BasicRestOperationsHandler.visionRestApiRequest(visionRestClient, PUT, "SettingApis\\APSolute Vision Analytics Setting_Apis\\EmailReportingConfigurations->isEnable", "",enable.toString(),"\"status\":\"ok\"");
        }
    }

    public boolean isEmailConfigurationIsEnabled() {
        Object result = BasicRestOperationsHandler.visionRestApiRequest(visionRestClient, GET, "SettingApis\\APSolute Vision Analytics Setting_Apis\\EmailReportingConfigurations->isEnable");
        JSONObject jResult = new JSONObject(result.toString());
        return(jResult.getBoolean("vrmEnabled"));
    }
}
