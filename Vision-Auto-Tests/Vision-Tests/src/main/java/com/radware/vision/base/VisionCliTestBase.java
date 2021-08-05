package com.radware.vision.base;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.vision_project_cli.menu.Menu;

import java.io.IOException;

public abstract class VisionCliTestBase extends TestBase {

    protected boolean doTheVisionLabRestart = false;

    public void afterMethod() throws IOException {
        RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
        RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
        try {
            // Clear any remaining commands on the output (In case of a 'Help text' command)
            StringBuilder clearString = new StringBuilder();
            for (int i = 0; i < 60; i++) {
                clearString.append("\b");
            }
            CliOperations.runCommand(radwareServerCli, clearString.toString(), 2* 2000,true,true,
                    true, null, true, true);
            CliOperations.runCommand(rootServerCli, clearString.toString(), 2 * 2000, true, true,
                    true, null, true, true);

            if (doTheVisionLabRestart) {
                CliOperations.runCommand(radwareServerCli, "", 6000, true);
                if (radwareServerCli.getTestAgainstObject().toString().endsWith("$ ")) {
                    CliOperations.runCommand(radwareServerCli, Menu.system().database().access().revoke().build() + " all");
                    CliOperations.runCommand(radwareServerCli, "y");
                }
                doTheVisionLabRestart = false;
            }

        } catch (Exception e) {
            BaseTestUtils.report(" Test after method " + e.getMessage(), Reporter.FAIL);
        } finally {
            radwareServerCli.cleanCliBuffer();
            rootServerCli.cleanCliBuffer();
        }
    }

}
