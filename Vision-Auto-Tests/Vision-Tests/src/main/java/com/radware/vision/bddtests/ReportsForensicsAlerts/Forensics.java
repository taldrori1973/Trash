package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.radware.vision.vision_project_cli.RootServerCli;

import java.util.Map;

public class Forensics extends ReportsForensicsAlertsAbstract {
    @Override
    protected String getType() {
        return "Forensics";
    }

    @Override
    public void create(String name, String negative, Map<String, String> map) throws Exception {

    }

    @Override
    public void validate(RootServerCli rootServerCli, String name, Map<String, String> map) throws Exception {

    }

    @Override
    public void edit(String viewBase, Map<String, String> map) throws Exception {

    }
}
