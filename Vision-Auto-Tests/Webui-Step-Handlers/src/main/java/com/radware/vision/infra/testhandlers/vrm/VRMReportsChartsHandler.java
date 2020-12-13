package com.radware.vision.infra.testhandlers.vrm;

import com.radware.jsonparsers.impl.JsonUtils;
import org.json.JSONObject;
import java.util.Map;

public class VRMReportsChartsHandler extends VRMHandler {

    JSONObject jsonResult;
    public VRMReportsChartsHandler(JSONObject jsonResult)
    {
     this.jsonResult = jsonResult;
    }
    public Map getSessionStorage(String chart) {
        return JsonUtils.getJsonMap(new JSONObject(jsonResult.get(chart).toString()));
    }


}
