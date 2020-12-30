package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.radware.automation.tools.utils.FileUtils;
import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class ReportsDefinitions {

    public Map<String, JSONObject> definitions = new HashMap<>();
    public ReportsDefinitions()
    {}

        public JSONObject getJsonDefinition(String reportName) {
        JSONParser jsonParser = new JSONParser();
        try (FileReader reader = new FileReader(FileUtils.getAbsoluteProjectPath()+ "src" + File.separator + "main" + File.separator + "java" + File.separator + "com" + File.separator + "radware" + File.separator + "vision" + File.separator + "bddtests" + File.separator + "ReportsForensicsAlerts" + File.separator + "reportDefeinitions.json"))
        {
            Object obj = jsonParser.parse(reader);
            JSONArray reportsDefinitions = (JSONArray) obj;
            return new JSONObject (reportsDefinitions.stream().filter(object-> new JSONObject(object.toString()).getString("reportName").equalsIgnoreCase(reportName)).findFirst().get().toString());

        } catch (FileNotFoundException ignored) {} catch (IOException | ParseException e) {
            e.printStackTrace();
        }
        return null;
    }
}
