package com.radware.vision.bddtests;

import com.radware.automation.bdd.reporter.BddReporterManager;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.base.WebUITestBase;
import cucumber.api.Scenario;
import cucumber.api.java.After;
import cucumber.api.java.Before;

public class BddHooks extends WebUITestBase {
    @Before
    public void beforeScenario(Scenario scenario) {
        try {
            BddReporterManager.initReport(scenario,false);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Init", e);
        }
    }

    @After
    public void afterScenario() {
        publishBddResults_new();
//        publishBddResults();
    }
}
