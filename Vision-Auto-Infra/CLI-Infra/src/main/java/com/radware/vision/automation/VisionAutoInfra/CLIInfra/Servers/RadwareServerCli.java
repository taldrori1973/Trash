package com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers;

import jsystem.extensions.analyzers.text.GetTextCounter;
import systemobject.terminal.Prompt;
import java.util.ArrayList;

public class RadwareServerCli extends ServerCliBase {

    private String dnsServerIp;
    private ArrayList<Prompt> newPromptObjects = new ArrayList<Prompt>();
    private String upgradePassword;
    private boolean isBeginningTheAPSoluteVisionUpgradeProcessEndsCommand = true;
    private String yOrn = "y";

    public RadwareServerCli() {
        super();
    }

    public RadwareServerCli(String host, String user, String password) {
        super(host, user, password);
    }


    @Override
    public void init() throws Exception {
        super.init();
    }

    public void close() {
        super.close();
    }

    @Override
    public Prompt[] getPrompts() {
        ArrayList<Prompt> prompts = new ArrayList<Prompt>();
        Prompt p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("$ ");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("$");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("(?<!sftp)(?<!ctrl-c)(?<!\")(?<!ALTEON)> ");
        p.setRegularExpression(true);
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("]:");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("login as: ");
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("s' password: ");
        p.setStringToSend(getPassword());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("New password:\\s*");
        p.setRegularExpression(true);
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Retype new password:\\s*");
        p.setCommandEnd(true);
        p.setRegularExpression(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("'s password: ");
        p.setCommandEnd(true);
        p.setRegularExpression(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Continue with the restore operation? (Y/N)");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Please enter SQL query:");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("vision login: ");
        p.setCommandEnd(true);
        prompts.add(p);

        // For System Clean Operation
        p = new Prompt();
        p.setPrompt("The system will log out in 5 seconds");
        p.setCommandEnd(true);
        prompts.add(p);

        // For New SSH host
        p = new Prompt();
        p.setPrompt("Are you sure you want to continue connecting (yes/no)? ");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Are you sure you want to continue connecting (yes/no/[fingerprint])?");
        p.setStringToSend("yes");
        p.setCommandEnd(false);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Please type the.*server password:\\s*");
        p.setRegularExpression(true);
        p.setCommandEnd(true);
        prompts.add(p);

        // For Start server in Debug Mode
        p = new Prompt();
        p.setPrompt("Do you want to shutdown server machine firewall (Y/y/N/n) ?");
        p.setStringToSend("y");
        p.setCommandEnd(true);
        prompts.add(p);

        // For Upgrade Server
        p = new Prompt();
        p.setPrompt("Enter the upgrade password: ");
        p.setStringToSend(this.upgradePassword);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("You are about to upgrade the APSolute Vision system. Continue? [y/N]");
        p.setStringToSend("Y");
        p.setCommandEnd(false);
        p.setAddEnter(false);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Are you sure you want to delete this backup (Y/N)");
        p.setStringToSend("Y");
        p.setCommandEnd(false);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Continue with the restore operation? (Y/N)");
        p.setStringToSend("Y");
        p.setCommandEnd(false);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Starting APSolute Vision server upgrade from version \\d+.\\d+.\\d+ to version \\d+.\\d+.\\d+.");
        p.setRegularExpression(true);
        p.setCommandEnd(true);
        p.setDontWaitForScrollEnd(true);
        prompts.add(p);

//        p = new Prompt();
//        p.setPrompt("Installing system requirements");
//        p.setRegularExpression(true);
//        p.setCommandEnd(true);
//        p.setDontWaitForScrollEnd(true);
//        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Are you sure you want to continue with the reboot anyway? (y/N)");
        p.setStringToSend("y");
        p.setCommandEnd(false);
        p.setAddEnter(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Confirm to clear the access list? (y/n)");
        p.setStringToSend("y");
        p.setCommandEnd(false);
        p.setAddEnter(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Sleeping 30 seconds before reboot.");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Setting the NTP requires restarting the APSolute Vision server. Restart? (y/n)");
        p.setStringToSend(this.yOrn);
        p.setCommandEnd(false);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("This will start the LLS service. Continue? (y/n)");
        p.setStringToSend(this.yOrn);
        p.setCommandEnd(false);
        prompts.add(p);

        //Keep the simple prompts AFTER last to avoid catching them first
        p = new Prompt();
        p.setPrompt("Continue? (y/N)?");
        p.setStringToSend(this.yOrn);
        p.setCommandEnd(false);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("The system is going down for reboot NOW!");
        p.setCommandEnd(true);
        prompts.add(p);

        prompts.addAll(newPromptObjects);

        return prompts.toArray(new Prompt[prompts.size()]);
    }

    public String getStringCounter(String key) {

        GetTextCounter counter = new GetTextCounter(key);
        analyze(counter);
        return counter.getCounter();
    }

    public String getDnsServerIp() {
        return dnsServerIp;
    }

    public void setDnsServerIp(String dnsServerIp) {
        this.dnsServerIp = dnsServerIp;
    }

    public void setUpgradePassword(String upgradePassword) {
        this.upgradePassword = upgradePassword;
    }

    public void setBeginningTheAPSoluteVisionUpgradeProcessEndsCommand(boolean beginningTheAPSoluteVisionUpgradeProcessEndsCommand) {
        isBeginningTheAPSoluteVisionUpgradeProcessEndsCommand = beginningTheAPSoluteVisionUpgradeProcessEndsCommand;
    }

    public void setyOrn(String yOrn) {
        this.yOrn = yOrn;
    }
}
