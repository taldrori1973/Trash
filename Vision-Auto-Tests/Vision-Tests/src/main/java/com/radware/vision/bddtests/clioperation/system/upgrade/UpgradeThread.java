package com.radware.vision.bddtests.clioperation.system.upgrade;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.vmoperations.VMOperationsSteps;
import com.radware.vision.automation.systemManagement.serversManagement.ServersManagement;

public class UpgradeThread extends Thread {
    public String IP;
    public String build;
    private final RadwareServerCli radwareServerCli;
    private final RootServerCli rootServerCli;
    private final String versionNumber;
    private final boolean isAPM;

    UpgradeThread(String IP,String upgradePassword,String buildNumber, boolean isAPM) throws Exception {
        this.IP = IP;
        this.build = buildNumber;
        ServersManagement serversManagement = TestBase.getServersManagement();
        radwareServerCli = serversManagement.getRadwareServerCli().get();
        rootServerCli = serversManagement.getRootServerCLI().get();
        VMOperationsSteps readFromSUT = new VMOperationsSteps();
        this.versionNumber = readFromSUT.readVisionVersionFromPomFile();
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
        } catch (InterruptedException e) {
            BaseTestUtils.report("Thread interrupted.", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
