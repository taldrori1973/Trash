package com.radware.vision.system.user;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import systemobject.terminal.Prompt;

import java.util.ArrayList;

public class password extends TestBase {
    public static void changeRadwarePassword(RadwareServerCli radwareServerCli, String currentPassword, String newPassword) {
        ArrayList<Prompt> prompts = new ArrayList<>();
        Prompt p = new Prompt();
        p.setPrompt("Current radware password");
        p.setStringToSend(currentPassword);
        p.setCommandEnd(false);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("New password");
        p.setStringToSend(newPassword);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Retype new password");
        p.setStringToSend(newPassword);
        prompts.add(p);

        radwareServerCli.addPrompts(prompts.toArray(new Prompt[0]));

        String cmd = String.format("%s %s", Menu.system().user().password().change().build(), radwareServerCli.getUser());
        CliOperations.runCommand(radwareServerCli, cmd, CliOperations.DEFAULT_TIME_OUT, false, false, true);
        radwareServerCli.setPassword(newPassword);
        //TODO - what is really needed - after session manager development
        sutManager.getClientConfigurations().setPassword(newPassword);
        clientConfigurations.setPassword(newPassword);
        cliConfigurations.setRadwareServerCliPassword(newPassword);
    }
}
