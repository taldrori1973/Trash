package com.radware.vision.bddtests;

import com.radware.automation.bdd.reporter.BddReporterManager;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.automation.base.TestBase;
import cucumber.api.Scenario;
import cucumber.api.java.After;
import cucumber.api.java.Before;

public class BddHooks {
    private static TestBase testBase = null;

    public BddHooks() throws Exception {
    }

    private TestBase getTestBase() {
        if (testBase == null) {
            testBase = new TestBase() {
                @Override
                public void publishBddResults() {
                    super.publishBddResults();
                }
            };
        }
        return testBase;
    }

    @Before
    public void beforeScenario(Scenario scenario) {
        try {
            BddReporterManager.initReport(scenario, false);
            testBase = getTestBase();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Init", e);
        }
    }
    @After
    public void afterScenario() {
        testBase.publishBddResults();
    }
}
