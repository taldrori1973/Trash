package com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers;

import ch.ethz.ssh2.log.Logger;
//import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.vision_tests.CliTests;
import jsystem.extensions.analyzers.text.GetTextCounter;
import org.apache.tika.utils.RegexUtils;
import systemobject.terminal.Prompt;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

public class RadwareServerCli extends ServerCliBase {
    protected String addedPrompts;
    private String dnsServerIp;
    private ArrayList<Prompt> newPromptObjects = new ArrayList();
    private String upgradePassword;
    private boolean isBeginningTheAPSoluteVisionUpgradeProcessEndsCommand = true;

    public RadwareServerCli() {
    }

    public RadwareServerCli(String host, String user, String password) {
        super(host, user, password);
    }

    public void init() throws Exception {
//        BaseTestUtils.reporter.startLevel("Init RadwareServerCli");
        super.init();
        if (this.isConnectOnInit() && !CliTests.isFirstTimeScenario) {
            InvokeUtils.invokeCommand((Logger)null, "", this);
        }

//        BaseTestUtils.reporter.stopLevel();
    }

    public void close() {
        super.close();
    }

//    public String getOutputStr() throws Exception {
//        String s = (String) RegexUtils.getGroupsWithPattern("\\n(.*)", this.getTestAgainstObject().toString()).get(0);
//        return s;
//    }

    private void addNewPrompts(String addedPrompts) {
        List<Prompt> prompts = new ArrayList();
        List promptsTextList = Arrays.asList(addedPrompts.split(","));

        try {
            Iterator var4 = promptsTextList.iterator();

            while(var4.hasNext()) {
                String currentPromptText = (String)var4.next();
                Prompt p = new Prompt();
                p.setPrompt(currentPromptText);
                p.setCommandEnd(true);
                prompts.add(p);
            }

            this.newPromptObjects.addAll(prompts);
        } catch (Exception var7) {
//            BaseTestUtils.report("Failed to add new prompts: " + Arrays.asList(addedPrompts), 2);
        }

    }

    public void clearAddedPrompts() {
        if (this.newPromptObjects != null) {
            this.newPromptObjects.clear();
        }

    }

    public Prompt[] getPrompts() {
        ArrayList<Prompt> prompts = new ArrayList();
//        BaseTestUtils.reporter.report("********************" + this.getUser() + " " + this.getPassword());
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
        p.setStringToSend(this.getUser());
        prompts.add(p);
        p = new Prompt();
        p.setPrompt("s' password: ");
        p.setStringToSend(this.getPassword());
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
        p = new Prompt();
        p.setPrompt("The system will log out in 5 seconds");
        p.setCommandEnd(true);
        prompts.add(p);
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
        p = new Prompt();
        p.setPrompt("Do you want to shutdown server machine firewall (Y/y/N/n) ?");
        p.setStringToSend("y");
        p.setCommandEnd(true);
        prompts.add(p);
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
        p.setPrompt("Beginning the APSolute Vision upgrade process");
        p.setCommandEnd(this.isBeginningTheAPSoluteVisionUpgradeProcessEndsCommand);
        prompts.add(p);
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
        prompts.addAll(this.newPromptObjects);
        return (Prompt[])prompts.toArray(new Prompt[prompts.size()]);
    }

    public String getStringCounter(String key) {
        GetTextCounter counter = new GetTextCounter(key);
        this.analyze(counter);
        return counter.getCounter();
    }

    public void sendCommand(String command) throws Exception {
        InvokeUtils.invokeCommand((Logger)null, command, this);
//        BaseTestUtils.reporter.report(this.getTestAgainstObject().toString());
    }

    public String getDnsServerIp() {
        return this.dnsServerIp;
    }

    public void setDnsServerIp(String dnsServerIp) {
        this.dnsServerIp = dnsServerIp;
    }

    public String getAddedPrompts() {
        return this.addedPrompts;
    }

    public void setAddedPrompts(String addedPrompts) {
        this.addedPrompts = addedPrompts;
        this.addNewPrompts(this.addedPrompts);
    }

    public void setUpgradePassword(String upgradePassword) {
        this.upgradePassword = upgradePassword;
    }

    public void setBeginningTheAPSoluteVisionUpgradeProcessEndsCommand(boolean beginningTheAPSoluteVisionUpgradeProcessEndsCommand) {
        this.isBeginningTheAPSoluteVisionUpgradeProcessEndsCommand = beginningTheAPSoluteVisionUpgradeProcessEndsCommand;
    }
}