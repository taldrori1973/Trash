package com.radware.vision.bddtests.clioperation.menu.system.ntp;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import cucumber.api.java.en.Given;

import static com.radware.vision.automation.Deploy.VisionServer.waitForServerConnection;

public class NtpSteps  extends TestBase {
    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();

    @Given("^CLI Operations - system ntp servers add \"(.*)\"$")
    public void systemNtpServersAdd(String server){
        try {
            radwareServerCli.setyOrn("y");
            CliOperations.runCommand(radwareServerCli, Menu.system().ntp().servers().add().build() + " " + server,
                    CliOperations.DEFAULT_TIME_OUT,true,false,true);
            waitForServerConnection(2700000L, radwareServerCli);
        }
        catch (Exception e){
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI Operations - system ntp servers delete \"(.*)\"$")
    public void systemNtpServersDelete(String server){
        try {
            radwareServerCli.setyOrn("y");
            CliOperations.runCommand(radwareServerCli, Menu.system().ntp().servers().delete().build() + " " + server,
                    CliOperations.DEFAULT_TIME_OUT,true,false,true);
            waitForServerConnection(2700000L, radwareServerCli);
        }
        catch (Exception e){
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI Operations - system ntp service \"(start|stop)\"$")
    public void systemNtpServiceStartStop(String setStatus){
        try {
            radwareServerCli.setyOrn("y");
            String command;
            if(setStatus.equals("start"))
                command = Menu.system().ntp().service().start().build();
            else
                command = Menu.system().ntp().service().stop().build();
            CliOperations.runCommand(radwareServerCli, command,
                    CliOperations.DEFAULT_TIME_OUT,true,false,true);
            waitForServerConnection(2700000L, radwareServerCli);
        }
        catch (Exception e){
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }
}
