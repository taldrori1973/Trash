package com.radware.vision.bddtests.clioperation.system.upgrade;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.bddtests.clioperation.GeneralSteps;
import com.radware.vision.bddtests.vmoperations.Deploy.Upgrade;
import com.radware.vision.bddtests.vmoperations.VMOperationsSteps;
import com.radware.vision.enums.GlobalProperties;
import com.radware.vision.enums.VisionDeployType;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.vision_handlers.system.upgrade.visionserver.VisionDeployment;
import com.radware.vision.vision_handlers.system.upgrade.visionserver.VisionServer;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.vision_project_cli.RootServerCli;
import com.radware.vision.vision_project_cli.menu.Menu;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.radware.vision.vision_handlers.system.VisionServer.waitForVisionServerServicesToStartHA;
import static com.radware.vision.vision_tests.CliTests.radwareServerCli;
import static com.radware.vision.vision_tests.CliTests.rootServerCli;

public class UpgradeSteps extends BddCliTestBase {


    @When("^Upgrade vision to version \"(.*)\", build \"(.*)\"$")
    public void UpgradeVisionServer(String version, String build) {
        try {
//            VisionServer.upgradeServerFile(getRestTestBase().getRadwareServerCli(), getRestTestBase().getRootServerCli()
//                    , version, build, null, isAPM());
            validateVisionServerServicesUP(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report("Setup Failed changing server to OFFLINE", Reporter.FAIL);
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^validate vision server services is UP$")
    public void validateVisionServerServicesUPStep() {
        try {
            validateVisionServerServicesUP(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^validate vision server services is UP on vision 2$")
    public void validateVisionServerServicesUPStepVision2() {
        try {
            String sourceIP = restTestBase.getVisionServerHA().getHost_2();
            RadwareServerCli radwareServerCli = new RadwareServerCli(sourceIP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
            validateVisionServerServicesUP(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @When("^Upgrade in Parallel,backup&Restore setup$")        /// backup and restore setup
    public static void UpgradeVisionToLatestBuildTwoMachines() {
        try {
            String sourceIP = restTestBase.getVisionServerHA().getHost_2();
            String targetIP = restTestBase.getVisionServer().getHost();
            String build = System.getenv("BUILD");//get build from portal
            if (build == null || build.equals("") || build.equals("0")) build = "";//Latest Build
            UpgradeThread sourceMachineThread = new UpgradeThread(sourceIP, null, build, isAPM());
            sourceMachineThread.start();
            UpgradeThread targetMachineThread = new UpgradeThread(targetIP, null, build, isAPM());
            targetMachineThread.start();
            while (true) {
                if (!sourceMachineThread.isAlive() && !targetMachineThread.isAlive())
                    break;
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    @When("^CLI validate Vision Services UP$")
    public void CliValidateVisionServerServicesUP() {
        try {
            validateVisionServerServicesUP(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static boolean isAPM() {
        try {
            rootServerCli.connect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        CliOperations.runCommand(rootServerCli, "df -h | grep apm | grep /vz/private | wc -l", 5 * 60 * 1000);
        return !CliOperations.lastRow.equals("0");
    }

    public static void validateVisionServerServicesUP(RadwareServerCli serverCli) throws Exception {
        try {
            serverCli.disconnect();
            serverCli.connect();
            boolean isVisionUp = waitForVisionServerServicesToStartHA(serverCli, 40 * 60 * 1000);
            if (!isVisionUp)
                BaseTestUtils.report("Not all services are up till timeout.", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            RootServerCli rootServerCli = restTestBase.getRootServerCli();
            if (!InvokeUtils.isConnectionOpen(rootServerCli)) rootServerCli.connect();
        }
    }

    /**
     * try to upgrade to a non-supported version
     */
    @Then("^Upgrade to non-supported version$")
    public void upgradeToAnOldVersion() {
        try {
            String version = VMOperationsSteps.readVisionVersionFromPomFile();
            String build = System.getenv("BUILD");//get build from portal
            if (build == null || build.equals("") || build.equals("0")) build = "";//Latest Build

            upgradeToNonSupportedVersion(version, build, isAPM());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Will try to upgrade to a non-supported version by changing server's build properties file
     *
     * @param versionNumber - Desired vision version
     * @param buildNumber   - Desired build number (null or "" will use latest successful build)
     * @param isApm         - True if server is APM else false
     */
    private void upgradeToNonSupportedVersion(String versionNumber, String buildNumber, boolean isApm) {
//        VisionDeployment visionDeployment;
//        if (isApm)
//            visionDeployment = new VisionDeployment(VisionDeployType.UPGRADE_APM, versionNumber, buildNumber);
//        else
//            visionDeployment = new VisionDeployment(VisionDeployType.UPGRADE, versionNumber, buildNumber);
//        String fileLocation = visionDeployment.getVisionDeploymentURL();
//        String fileName = visionDeployment.getVisionDeploymentFileName();
        Upgrade upgrade = new Upgrade(true, isAPM(), null, null, "master", "vision-snapshot-local");
        String[] notSupportedVersion = upgrade.getNonSupportedVersion();

        String[] path = upgrade.getBuildFileInfo().getPath().toString().split("/");
        String fileName = path[path.length - 1];

        try {
            /* Change version to unsupported one */
            InvokeUtils.invokeCommand(null, "/bin/cp /opt/radware/mgt-server/build.properties /opt/radware/storage/",
                    rootServerCli, GlobalProperties.THIRTY_SECONDS, false, false, true);

            String ChangeMajorVersion = String.format("sed -i 's/buildMajorVersion: .*$/buildMajorVersion: %s/g' /opt/radware/mgt-server/build.properties", notSupportedVersion[0]);
            InvokeUtils.invokeCommand(null, ChangeMajorVersion, rootServerCli, GlobalProperties.THIRTY_SECONDS, false, false, true);

            String changeMinorVersion = String.format("sed -i 's/buildMinorVersion: .*$/buildMinorVersion: %s/g' /opt/radware/mgt-server/build.properties", notSupportedVersion[1]);
            InvokeUtils.invokeCommand(null, changeMinorVersion, rootServerCli, GlobalProperties.THIRTY_SECONDS, false, false, true);
            BaseTestUtils.report("Setting Server property file to version: " + String.format("%s.%s.%s", notSupportedVersion[0], notSupportedVersion[1], notSupportedVersion[2]), Reporter.PASS_NOR_FAIL);
            VisionServer.downloadUpgradeFile(rootServerCli, upgrade.getBuildFileInfo().getDownloadUri().toString());
            String upgradePassword = "";
            radwareServerCli.setUpgradePassword(upgradePassword);
            radwareServerCli.setBeginningTheAPSoluteVisionUpgradeProcessEndsCommand(false);

            long responseTimeOut = 10 * 60 * 1000;
            /* Run the system upgrade command */
            InvokeUtils.invokeCommand(null, Menu.system().upgrade().full().build() + " " + fileName,
                    radwareServerCli, responseTimeOut, false, false, true);
            ArrayList<String> output = radwareServerCli.getCmdOutput();
            String errorMessage = String.format("Upgrade from source version \\d+.\\d+.\\d+.\\d+ to version %s is not supported.", versionNumber);
            Pattern pattern = Pattern.compile(errorMessage);
            Matcher matcher = pattern.matcher(output.toString());
            if (matcher.find() &&
                    output.toString().contains("Failed to upgrade") &&
                    output.toString().contains("The APSolute Vision upgrade process failed.")) {
                BaseTestUtils.report("Installation of un-supported version Passed.", Reporter.PASS);
            } else
                BaseTestUtils.report("Installation of un-supported version Failed. Actual output:" + output, Reporter.FAIL);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            try {
                /* Revert to the original */
                InvokeUtils.invokeCommand(null, "/bin/cp /opt/radware/storage/build.properties /opt/radware/mgt-server/ ",
                        rootServerCli, GlobalProperties.THIRTY_SECONDS, false, false, true);
                /* Delete all upgrade files */
                InvokeUtils.invokeCommand(null, "rm -f /uploads/temp/Upgrade*",
                        rootServerCli, GlobalProperties.THIRTY_SECONDS, false, false, true);
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }
    }

    @Given("^Upgrade to future version$")
    public void upgradeToFutureVersion() {
        try {
            String version = VMOperationsSteps.readVisionVersionFromPomFile();
            String build = "";
            build = BaseTestUtils.getRuntimeProperty("BUILD", build);
            if (build == null || build.equals("") || build.equals("0")) build = "";//Latest Build

            upgradeToTheNextBuild(version, build, isAPM());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

    private void upgradeToTheNextBuild(String version, String build, boolean isApm) throws Exception {
//        VisionDeployment visionDeployment;
//        VisionDeployType deployType = isApm ? VisionDeployType.UPGRADE_APM : VisionDeployType.UPGRADE;

//        visionDeployment = new VisionDeployment(deployType, version, build);

//        VMOperationsSteps vmOperationsSteps = new VMOperationsSteps();
//        UpgradeSteps upgradeSteps = new UpgradeSteps();
        Upgrade upgrade = new Upgrade(true, isAPM(), build, null, "master", "vision-snapshot-local");
        String buildUnderTest = upgrade.getBuild();
        if (upgrade.isSetupNeeded) {
            BaseTestUtils.report("Upgrading to latest build: " + buildUnderTest,
                    Reporter.PASS_NOR_FAIL);
//            upgradeSteps.UpgradeVisionServer(version, buildUnderTest);
            upgrade.deploy();
            BaseTestUtils.report("Server is ready for future upgrade", Reporter.PASS_NOR_FAIL);
        }
        GeneralSteps.clearAllLogs();
//        VMOperationsSteps.newInstance().updateVersionVar();
        upgrade = new Upgrade(true, isAPM(), null, null, "master", "vision-snapshot-local");
//        visionDeployment = new VisionDeployment(deployType, version, "");
        String nextBuild = upgrade.getBuild();
        ;
        BaseTestUtils.report(String.format("Going to upgrade from build %s to %s", buildUnderTest, nextBuild),
                Reporter.PASS_NOR_FAIL);
//        upgradeSteps.UpgradeVisionServer(version, visionDeployment.getBuild());
        upgrade.deploy();
    }
}
