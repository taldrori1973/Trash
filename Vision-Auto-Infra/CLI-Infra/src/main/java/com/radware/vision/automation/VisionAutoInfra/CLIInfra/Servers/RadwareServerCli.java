package com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.utils.RegexUtils;
import jsystem.extensions.analyzers.text.GetTextCounter;
import systemobject.terminal.Prompt;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


public class RadwareServerCli extends ServerCliBase {

    protected String addedPrompts;
    private String dnsServerIp;
    private ArrayList<Prompt> newPromptObjects = new ArrayList<Prompt>();
    private String upgradePassword;
    private boolean isBeginningTheAPSoluteVisionUpgradeProcessEndsCommand = true;

    public RadwareServerCli() {
        super();
    }

    public RadwareServerCli(String host, String user, String password) {
        super(host, user, password);
    }


    @Override
    public void init() throws Exception {
//        BaseTestUtils.report("Init RadwareServerCli",Reporter.PASS_NOR_FAIL);
        super.init();
//        if (isConnectOnInit() && !CliTests.isFirstTimeScenario) {
//            InvokeUtils.invokeCommand(null, "", this);
//        }
//        BaseTestUtils.reporter.stopLevel();
    }

    public void close() {
        super.close();
    }

    public String getOutputStr() throws Exception {
        String s = RegexUtils.getGroupsWithPattern("\\n(.*)", getTestAgainstObject().toString()).get(0);
        return s;

    }

    private void addNewPrompts(String addedPrompts) {
        List<Prompt> prompts = new ArrayList<Prompt>();
        List<String> promptsTextList = Arrays.asList(addedPrompts.split(","));

        try {
            for (String currentPromptText : promptsTextList) {
                Prompt p = new Prompt();
                p.setPrompt(currentPromptText);
                p.setCommandEnd(true);
                prompts.add(p);
            }
            newPromptObjects.addAll(prompts);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to add new prompts: " + Arrays.asList(addedPrompts), Reporter.WARNING);
        }
    }

    public void clearAddedPrompts() {
        if (newPromptObjects != null) {
            newPromptObjects.clear();
        }
    }


    @Override
    public Prompt[] getPrompts() {
        ArrayList<Prompt> prompts = new ArrayList<Prompt>();
//        BaseTestUtils.reporter.report("********************" + getUser() + " " + getPassword());
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

        // For User Password Change Radware
        p = new Prompt();
        p.setPrompt("Current radware password:");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Password:");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Current root password:");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Current radware password:");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("New UNIX password: ");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Retype new UNIX password: ");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("New password:\\s*");
        p.setRegularExpression(true);
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Re-type new password:");
        p.setCommandEnd(true);
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
        p.setPrompt("Please type the.*server password:\\s*");
        p.setRegularExpression(true);
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter the upgrade password:");
        p.setStringToSend(this.upgradePassword);
        prompts.add(p);

        // For Start server in Debug Mode
        p = new Prompt();
        p.setPrompt("Do you want to shutdown server machine firewall (Y/y/N/n) ?");
        p.setStringToSend("y");
        p.setCommandEnd(true);
        prompts.add(p);

        // For Upgrade Server
        p = new Prompt();
        p.setPrompt("Please enter the upgrade password: ");
        p.setStringToSend("y");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("You are about to upgrade the APSolute Vision system. Continue? [Y/n]");
        p.setStringToSend("Y");
        p.setCommandEnd(false);
        p.setAddEnter(false);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Continue with the upgrade anyway? [y/n]");
//        p.setPrompt("The APSolute Vision upgrade process has identified that the virtual machine hosting APSolute Vision has less than \\d+ GB RAM. Radware recommends increasing the APSolute Vision RAM to at least \\d+ GB before starting the upgrade. Continue with the upgrade anyway? [Y/n]");
        p.setStringToSend("y");
        p.setCommandEnd(false);
        p.setAddEnter(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Validation succeeded. Starting upgrade process");
        p.setDontWaitForScrollEnd(true);
        p.setCommandEnd(true);
        prompts.add(p);

        /* Relevant till Vision version 4.60 and after that relevant for 32G of memory*/
        p = new Prompt();
        p.setPrompt("Validations completed.");
        p.setDontWaitForScrollEnd(true);
        p.setCommandEnd(true);
        prompts.add(p);


        //Keep the simple prompts AFTER last to avoid catching them first
        p = new Prompt();
        p.setPrompt("(Y/N)");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("(y/n)");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("(y/n):");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("(yes/no)?");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("(Y/N)?");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("[y/N]?");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("[Y/n]");
        p.setCommandEnd(true);
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

    public void sendCommand(String command) throws Exception {
        InvokeUtils.invokeCommand(null, command, this);
        BaseTestUtils.reporter.report(getTestAgainstObject().toString());
    }


    public String getDnsServerIp() {
        return dnsServerIp;
    }

    public void setDnsServerIp(String dnsServerIp) {
        this.dnsServerIp = dnsServerIp;
    }

    public String getAddedPrompts() {
        return addedPrompts;
    }

    public void setAddedPrompts(String addedPrompts) {
        this.addedPrompts = addedPrompts;
        addNewPrompts(this.addedPrompts);
    }

    public void setUpgradePassword(String upgradePassword) {
        this.upgradePassword = upgradePassword;
    }

    public void setBeginningTheAPSoluteVisionUpgradeProcessEndsCommand(boolean beginningTheAPSoluteVisionUpgradeProcessEndsCommand) {
        isBeginningTheAPSoluteVisionUpgradeProcessEndsCommand = beginningTheAPSoluteVisionUpgradeProcessEndsCommand;
    }

}
