package com.radware.vision.base;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.RuntimePropertiesEnum;
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
            String clearString = "";
            for (int i = 0; i < 60; i++) {
                clearString += "\b";
            }
            CliOperations.runCommand(radwareServerCli, clearString, 2* 2000,true,true,
                    true, null, true, true);
            CliOperations.runCommand(rootServerCli, clearString, 2 * 2000, true, true,
                    true, null, true, true);

            if (doTheVisionLabRestart) {
                CliOperations.runCommand(radwareServerCli, "", 6000, true);
                if (radwareServerCli.getTestAgainstObject().toString().endsWith("$ ")) {
                    CliOperations.runCommand(radwareServerCli, Menu.system().database().access().revoke().build() + " all");
                    CliOperations.runCommand(radwareServerCli, "y");
                }
                doTheVisionLabRestart = false;
            }

            if (BaseTestUtils.getBooleanRuntimeProperty(RuntimePropertiesEnum.ADD_AUTO_RESULT.name(), RuntimePropertiesEnum.ADD_AUTO_RESULT.getDefaultValue())) {
//                ReportResultEntity report = new ReportResultEntity().withtestID("").withName(this.getName()).withDescription(getFailCause()).withStatus(this.isPassAccordingToFlags()).withUID(UUID.randomUUID().toString());
//                resultsManager.addResult(report);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            radwareServerCli.cleanCliBuffer();
            rootServerCli.cleanCliBuffer();
        }
    }

}
