package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts;

import com.radware.vision.vision_project_cli.RootServerCli;
import org.json.JSONObject;

import java.util.Map;

public interface ReportsForensicsAlertsInterface {
    void create(String viewBase, Map<String, String> map) throws Exception;

    void validate(RootServerCli rootServerCli, String reportName, Map<String, String> map);

    void edit(String viewBase, Map<String, String> map) throws Exception;

    void delete();
}
