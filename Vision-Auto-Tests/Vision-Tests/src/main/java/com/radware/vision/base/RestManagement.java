package com.radware.vision.base;

import basejunit.RestTestBase;
import com.radware.automation.bdd.reporter.BddReporterManager;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.licensekeys.LicenseRepository;
import com.radware.automation.tools.reports.RallyTestReporter;
import com.radware.restcore.GenericRestClient;
import com.radware.restcore.RestBasicConsts;
import com.radware.restcore.VisionRestClient;
import com.radware.restcore.utils.enums.ExpectedHttpCodes;
import com.radware.vision.vision_tests.CliTests;
import jsystem.framework.report.Reporter;
import systemobjects.VisionLab;

public class RestManagement extends RestTestBase {
    public void init() throws Exception {
//        BaseTestUtils.knownBug(ScenarioHelpers.getRunnerTest(this));
//        try {
//            BddReporterManager.overrideJSystemSut();
//            cliTests = new CliTests();
//            cliTests.readSutObjects();
//        } catch (Exception e) {
//            BaseTestUtils.report("There was issue with reading visionCli: " + e.getMessage(), Reporter.FAIL);
//        }

//        try {
//            visionlab = (VisionLab) system.getSystemObject("visionLab");
//        } catch (Exception e) {
//            BaseTestUtils.report("There was issue with reading visionLab " + e.getMessage(), Reporter.FAIL);
//        }
//        if (visionServer == null)
//            visionServer = visionlab.visionServer;
//
//        if (visionVMs == null)
//            visionVMs = visionlab.visionVMs;
//
//        genericLinuxServer = visionlab.genericLinuxServer;
//        mysqlServer = visionlab.mysqlClientCli;
        String hostIp = TestBase.getSutManager().getClientConfigurations().getHostIp();
        String licenseKey = LicenseRepository.getInstance().getLicenseByProject(visionlab.getTestProject());
//            if (visionServer != null) {
        visionRestClient = new VisionRestClient(hostIp, licenseKey, RestBasicConsts.RestProtocol.HTTPS);
        visionRestClient.setExpectedStatusCode(ExpectedHttpCodes.OK.getStatusCodes());
        visionRestClient.setIgnoreResponseCodeValidation(ignoreRestResponseValidation);

        genericRestClient = new GenericRestClient(visionServer.getHost(), licenseKey, visionServer.getProtocolEnum());
        genericRestClient.setExpectedStatusCode(ExpectedHttpCodes.OK.getStatusCodes());
        genericRestClient.setIgnoreResponseCodeValidation(ignoreRestResponseValidation);

//            apmRestClient = new ApmRestClient(visionServer.getHost(), licenseKey, visionServer.getProtocolEnum());
//            BaseTestUtils.reporter.addProperty("Build", getRootServerCli().getBuildNumber());
//            BaseTestUtils.reporter.addProperty("Version", getRootServerCli().getVersionNumebr());
//            BaseTestUtils.reporter.addProperty("qcTestId", qcTestId);
//            initReporter();
//            if (rallyTestReporter == null) {
//                rallyTestReporter = new RallyTestReporter();
//                rallyTestReporter.init(getRootServerCli().getVersionNumebr(), "ReST", getRootServerCli().getBuildNumber());
//            }
//            }


    }
}
