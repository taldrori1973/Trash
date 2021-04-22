package com.radware.vision.bddtests.ReportsForensicsAlerts;


import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;

import java.util.Map;

public interface ReportsForensicsAlertsInterface {
    void create(String name,String negative, Map<String, String> map) throws Exception;

    void validate(RootServerCli rootServerCli, String name, Map<String, String> map)throws Exception;

    void edit(String viewBase, Map<String, String> map) throws Exception;

    void delete(String name) throws Exception;
}
