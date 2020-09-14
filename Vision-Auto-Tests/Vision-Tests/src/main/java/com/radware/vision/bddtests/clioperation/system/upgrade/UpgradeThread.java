package com.radware.vision.bddtests.clioperation.system.upgrade;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.bddtests.clioperation.FileSteps;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.vision_handlers.system.upgrade.visionserver.VisionServer;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.vision_project_cli.RootServerCli;
import com.radware.vision.bddtests.vmoperations.VMOperationsSteps;
import enums.SUTEntryType;

import static com.radware.vision.base.WebUITestBase.restTestBase;

public class UpgradeThread extends Thread {
    public String IP;
    public String build;
    private RadwareServerCli RadwareServerCli;
    private RootServerCli RootServerCli;
    private String versionNumber;
    private boolean isAPM;

    UpgradeThread(String IP, String upgradePassword, String buildNumber, boolean isAPM) throws Exception {
        this.IP = IP;
        this.build = buildNumber;
        RadwareServerCli = new RadwareServerCli(IP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
        RootServerCli = new RootServerCli(IP, restTestBase.getRootServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
        VMOperationsSteps readFromSUT = new VMOperationsSteps();
        this.versionNumber = readFromSUT.readVisionVersionFromPomFile();
        this.isAPM = isAPM;
    }

    @Override
    public void run() {
        try {
            RadwareServerCli.init();
            RootServerCli.init();
            BaseTestUtils.report("Upgrading server:" + RootServerCli.getHost(), Reporter.PASS_NOR_FAIL);
            VisionServer.upgradeServerFile(RadwareServerCli, RootServerCli, versionNumber, build, null, isAPM);
            BaseTestUtils.report("Waiting for services on server:" + RootServerCli.getHost(), Reporter.PASS_NOR_FAIL);
            com.radware.vision.vision_handlers.system.VisionServer.waitForVisionServerServicesToStartHA(RadwareServerCli, 20 * 60 * 1000);
            FileSteps f = new FileSteps();
            f.scp("/home/radware/Scripts/restore_radware_user_stand_alone.sh", SUTEntryType.GENERIC_LINUX_SERVER, SUTEntryType.ROOT_SERVER_CLI, "/");
            CliOperations.runCommand(RootServerCli, "yes | /restore_radware_user_stand_alone.sh", CliOperations.DEFAULT_TIME_OUT);
            CliOperations.runCommand(RootServerCli, "/usr/sbin/ntpdate -u europe.pool.ntp.org", 2 * 60 * 1000);
        } catch (InterruptedException e) {
            BaseTestUtils.report("Thread interrupted.", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }
}
