package com.radware.vision.bddtests.clioperation.system.upgrade;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.Deploy.VisionServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.clioperation.GeneralSteps;
import com.radware.vision.bddtests.vmoperations.Deploy.Upgrade;
import com.radware.vision.bddtests.vmoperations.VMOperationsSteps;
import com.radware.vision.thirdPartyAPIs.jFrog.JFrogAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.models.JFrogFileModel;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.radware.vision.vision_handlers.system.VisionServer.waitForVisionServerServicesToStartHA;

public class UpgradeSteps extends TestBase {


    @When("^Upgrade vision to version \"(.*)\", build \"(.*)\"$")
    public void UpgradeVisionServer(String version, String build) {
        try {
            validateVisionServerServicesUP(serversManagement.getRadwareServerCli().get());
        } catch (Exception e) {
            BaseTestUtils.report("Setup Failed changing server to OFFLINE", Reporter.FAIL);
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^validate vision server services is UP$")
    public void validateVisionServerServicesUPStep() {
        try {
            validateVisionServerServicesUP(serversManagement.getRadwareServerCli().get());
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

            RadwareServerCli radwareSource = new RadwareServerCli(sourceIP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
            RootServerCli rootSource = new RootServerCli(sourceIP, restTestBase.getRootServerCli().getUser(), restTestBase.getRootServerCli().getPassword());

            RadwareServerCli radwareTarget = new RadwareServerCli(targetIP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
            RootServerCli rootTarget = new RootServerCli(targetIP, restTestBase.getRootServerCli().getUser(), restTestBase.getRootServerCli().getPassword());

            Upgrade upgradeSource = new Upgrade(true, null, radwareSource, rootSource);
            Upgrade upgradeTarget = new Upgrade(true, null, radwareTarget, rootTarget);
            UpgradeThread sourceMachineThread = new UpgradeThread(sourceIP, null, build, isAPM());
            UpgradeThread targetMachineThread = new UpgradeThread(targetIP, null, build, isAPM());

            if (upgradeSource.isSetupNeeded) {
                sourceMachineThread.start();
            }
            if (upgradeTarget.isSetupNeeded) {
                targetMachineThread.start();
            }
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
            validateVisionServerServicesUP(serversManagement.getRadwareServerCli().get());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static boolean isAPM() {
        ServerCliBase rootServerCli = serversManagement.getRootServerCLI().get();
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
            RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
            if (!rootServerCli.isServerConnected()) rootServerCli.connect();
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

            upgradeToNonSupportedVersion(version);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Will try to upgrade to a non-supported version by changing server's build properties file
     *
     * @param versionNumber - Desired vision version
     */
    private void upgradeToNonSupportedVersion(String versionNumber) {
        RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
        RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
        Upgrade upgrade = new Upgrade(true, null, radwareServerCli, rootServerCli);
        String[] notSupportedVersion = upgrade.getNonSupportedVersion();

        String[] path = upgrade.getBuildFileInfo().getPath().toString().split("/");
        String fileName = path[path.length - 1];

        try {
            /* Change version to unsupported one */
            CliOperations.runCommand(rootServerCli, "/bin/cp /opt/radware/mgt-server/build.properties /opt/radware/storage/",
                    CliOperations.DEFAULT_TIME_OUT, false, false, true);

            String ChangeMajorVersion = String.format("sed -i 's/buildMajorVersion: .*$/buildMajorVersion: %s/g' /opt/radware/mgt-server/build.properties", notSupportedVersion[0]);
            CliOperations.runCommand(rootServerCli, ChangeMajorVersion, CliOperations.DEFAULT_TIME_OUT, false, false, true);

            String changeMinorVersion = String.format("sed -i 's/buildMinorVersion: .*$/buildMinorVersion: %s/g' /opt/radware/mgt-server/build.properties", notSupportedVersion[1]);
            CliOperations.runCommand(rootServerCli, changeMinorVersion, CliOperations.DEFAULT_TIME_OUT, false, false, true);
            BaseTestUtils.report("Setting Server property file to version: " + String.format("%s.%s.%s", notSupportedVersion[0], notSupportedVersion[1], notSupportedVersion[2]), Reporter.PASS_NOR_FAIL);
            VisionServer.downloadUpgradeFile(rootServerCli, upgrade.getBuildFileInfo().getDownloadUri().toString());
            String upgradePassword = "";
            radwareServerCli.setUpgradePassword(upgradePassword);
            radwareServerCli.setBeginningTheAPSoluteVisionUpgradeProcessEndsCommand(false);

            int responseTimeOut = 10 * 60 * 1000;
            /* Run the system upgrade command */
            CliOperations.runCommand(radwareServerCli, Menu.system().upgrade().full().build() + " " + fileName,
                    responseTimeOut, false, false, true);
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
                CliOperations.runCommand(rootServerCli, "/bin/cp /opt/radware/storage/build.properties /opt/radware/mgt-server/ ",
                        CliOperations.DEFAULT_TIME_OUT, false, false, true);
                /* Delete all upgrade files */
                CliOperations.runCommand(rootServerCli, "rm -f /uploads/temp/Upgrade*",
                        CliOperations.DEFAULT_TIME_OUT, false, false, true);
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

            upgradeToTheNextBuild(build);
            VMOperationsSteps.updateVersionVar();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

    private void upgradeToTheNextBuild(String build) {
        RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
        RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
        Upgrade upgrade = new Upgrade(true, build, radwareServerCli, rootServerCli);
        String buildUnderTest = upgrade.getBuild();
        if (upgrade.isSetupNeeded) {
            BaseTestUtils.report("Upgrading to latest build: " + buildUnderTest,
                    Reporter.PASS_NOR_FAIL);
            upgrade.deploy();

            BaseTestUtils.report("Server is ready for future upgrade", Reporter.PASS_NOR_FAIL);
        }
        GeneralSteps.clearAllLogs();
        upgrade = new Upgrade(true, null, radwareServerCli, rootServerCli);
        //Force upgrade to make sure another upgrade will occur.
        upgrade.isSetupNeeded = true;
        String nextBuild = upgrade.getBuild();

        BaseTestUtils.report(String.format("Going to upgrade from build %s to %s", buildUnderTest, nextBuild),
                Reporter.PASS_NOR_FAIL);
        upgrade.deploy();
    }

    public void UpgradeVisionServerFromOldVersion(String version) {
        try {
            FileType upgradeType = isAPM() ? FileType.UPGRADE_APM : FileType.UPGRADE;
            JFrogFileModel buildFileInfo = JFrogAPI.getBuildFromOldVersion(upgradeType, version);
            String[] path = buildFileInfo.getPath().toString().split("/");
            RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
            RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
            VisionServer.upgradeServerFile(radwareServerCli, rootServerCli
                    , null, path[path.length - 1], buildFileInfo.getDownloadUri().toString());
            validateVisionServerServicesUP(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Setup Failed changing server to OFFLINE", Reporter.FAIL);
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
