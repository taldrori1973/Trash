package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.radware.vision.automation.base.TestBase;
import com.radware.vision.automation.invocation.InvokeMethod;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ReportsDefinitionsSimulators extends ReportsDefinitions {
    public final static HashMap<String, String> selections = new HashMap<>();
    private final HashMap<String, String> variables = new HashMap<>();

    static {
        selections.put("Application", "{\\\"name\\\":\\\"$[Prefix]$_$[IPHex]$:$[Port]$\\\",\\\"applicationId\\\":\\\"$[Prefix]$_$[IPHex]$:$[Port]$\\\",\\\"deviceIds\\\":[\\\"324058c999f5de7a67b1ead5$[IPHex]$\\\"],\\\"selected\\\":true,\\\"enabled\\\":true,\\\"deviceType\\\":\\\"Alteon\\\",\\\"devicesCount\\\":1}");
        selections.put("SystemAndNetwork", "{\\\"deviceName\\\":\\\"$[DeviceName]$\\\",\\\"deviceIP\\\":\\\"$[DeviceIP]$\\\",\\\"deviceID\\\":\\\"2c9124e665802253016580715eec0033\\\",\\\"softwareVersion\\\":\\\"32.4.0.0\\\",\\\"formFactor\\\":\\\"Standalone\\\",\\\"deviceType\\\":\\\"Alteon\\\",\\\"deviceStatus\\\":\\\"Up\\\",\\\"site\\\":\\\"Alteons_for_DPM-Fakes\\\",\\\"platform\\\":\\\"7220\\\",\\\"externalID\\\":\\\"324058c999f5de7a67b1ead5$[IPHex]$\\\",\\\"timeStamp\\\":\\\"0\\\",\\\"haState\\\":\\\"MASTER\\\",\\\"name\\\":\\\"$[DeviceName]$\\\",\\\"selected\\\":true,\\\"enabled\\\":true}");
    }

    public ReportsDefinitionsSimulators(String simulator)
    {
        String[] vars = simulator.split(",");
        for (String var:vars
             ) {
            String[] varVal = var.split("=");
            variables.put(varVal[0], varVal[1]);
        }
    }

    @Override
    public JSONObject getJsonDefinition(String reportName) {
        JSONObject jsonObject = super.getJsonDefinition(reportName);
        if(variables.size() > 0)
            addJSONData(jsonObject,
                    "Object:templates#Array:0#Object:scope#Array",
                    getSelection(detectScope(jsonObject)));
        return jsonObject;
    }

    private String getSelection(String selection)
    {
        String selectionValue = selections.get(selection);
        Pattern p = Pattern.compile("\\$\\[.*?\\]\\$");
        Matcher m = p.matcher(selectionValue);
        while(m.find()){
            String b =  m.group();
            String var = b.substring(2, b.length()-2);
            selectionValue = selectionValue.replaceAll(String.format("\\$\\[%s\\]\\$",var),getValue(var));
        }
        return selectionValue;
    }

    private String detectScope(JSONObject jsonObject)
    {
        switch (jsonObject.get("reportName").toString())
        {
            case "ADC Applications Report Definition": return "Application";
            case "ADC System and Network Report Definition": return "SystemAndNetwork";
        }
        return null;
    }

    private String getValue(String var)
    {
        if(variables.containsKey(var))
            return variables.get(var);

        switch (var)
        {
            case "IPHex": return (String) InvokeMethod.invokeMethodFromText(String.format("#convertIpToHexa(%s);", variables.get("SetID")));
            case "DeviceName":
            case "DeviceIP": return TestBase.getSutManager().getTreeDeviceManagement(variables.get("SetID")).get().getManagementIp();
        }
        return null;
    }

    private Object addJSONData(Object object, String path, String data) {
        String[] splitPath = path.split("#", 2);
        String[] typeValue = splitPath[0].split(":");
        Object o;

        switch (typeValue[0]) {
            case "Object":
                JSONObject jsonObject = (JSONObject) object;
                o = (splitPath.length>1)?
                        addJSONData(jsonObject.get(typeValue[1]), splitPath[1], data):
                        data;
                jsonObject.put(typeValue[1], o);
                break;
            case "Array":
                JSONArray jsonArray = (JSONArray) object;
                o = (splitPath.length>1)?
                        addJSONData(jsonArray.get(Integer.parseInt(typeValue[1])), splitPath[1], data):
                        data;
                if(splitPath.length>1)jsonArray.put(Integer.parseInt(typeValue[1]),o); else jsonArray.put(o);
                break;
        }

        return object;
    }
}
