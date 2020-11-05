package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts;

import com.radware.vision.vision_project_cli.RootServerCli;

import java.util.Map;

public interface ReportsForensicsAlertsInterface {
    void create(String name, Map<String, String> map) throws Exception;

    void validate(RootServerCli rootServerCli, String name, Map<String, String> map)throws Exception;

    void edit(String viewBase, Map<String, String> map) throws Exception;

    void delete();
}
