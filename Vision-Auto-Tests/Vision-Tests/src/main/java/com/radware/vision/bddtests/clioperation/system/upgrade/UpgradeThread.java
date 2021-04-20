package com.radware.vision.bddtests.clioperation.system.upgrade;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.systemManagement.serversManagement.ServersManagement;
import com.radware.vision.bddtests.clioperation.FileSteps;
import com.radware.vision.bddtests.vmoperations.Deploy.Upgrade;
import com.radware.vision.bddtests.vmoperations.VMOperationsSteps;

import static com.radware.vision.base.VisionUITestBase.restTestBase;

public class UpgradeThread extends Thread {
    public String IP;
    public String build;
    public RadwareServerCli radwareServerCli;
    public RootServerCli rootServerCli;
    private String versionNumber;
    private boolean isAPM;

    UpgradeThread(String IP, String upgradePassword, String buildNumber, boolean isAPM) throws Exception {
        this.IP = IP;
        this.build = buildNumber;
        radwareServerCli = new RadwareServerCli(IP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
        rootServerCli = new RootServerCli(IP, restTestBase.getRootServerCli().getUser(), restTestBase.getRootServerCli().getPassword());
        this.versionNumber = VMOperationsSteps.readVisionVersionFromPomFile();
        this.isAPM = isAPM;
    }

    @Override
    public void run() {
        try {
            radwareServerCli.init();
            rootServerCli.init();
            BaseTestUtils.report("Upgrading server:" + rootServerCli.getHost(), Reporter.PASS_NOR_FAIL);
//            VisionServer.upgradeServerFile(radwareServerCli, rootServerCli, versionNumber, build, null, isAPM);
            BaseTestUtils.report("Waiting for services on server:" + rootServerCli.getHost(), Reporter.PASS_NOR_FAIL);
            com.radware.vision.vision_handlers.system.VisionServer.waitForVisionServerServicesToStartHA(radwareServerCli, 20 * 60 * 1000);

            CliOperations.runCommand(rootServerCli, "\"yes|restore_radware_user_password\"", 15 * 1000);
            radwareServerCli.init();
            rootServerCli.init();
            BaseTestUtils.report("Upgrading server:" + rootServerCli.getHost(), Reporter.PASS_NOR_FAIL);
            Upgrade upgrade = new Upgrade(true, null, radwareServerCli, rootServerCli);
            upgrade.deploy();
            BaseTestUtils.report("Waiting for services on server:" + rootServerCli.getHost(), Reporter.PASS_NOR_FAIL);
            com.radware.vision.vision_handlers.system.VisionServer.waitForVisionServerServicesToStartHA(radwareServerCli, 20 * 60 * 1000);
            FileSteps f = new FileSteps();
            f.scp("/home/radware/Scripts/restore_radware_user_stand_alone.sh", ServersManagement.ServerIds.LINUX_FILE_SERVER,
                    ServersManagement.ServerIds.ROOT_SERVER_CLI, "/");
            CliOperations.runCommand(rootServerCli, "yes | /restore_radware_user_stand_alone.sh", CliOperations.DEFAULT_TIME_OUT);
            CliOperations.runCommand(rootServerCli, "/usr/sbin/ntpdate -u europe.pool.ntp.org", 2 * 60 * 1000);
        } catch (InterruptedException e) {
            BaseTestUtils.report("Thread interrupted.", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
