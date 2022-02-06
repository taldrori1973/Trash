package com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers;
import systemobject.terminal.Prompt;
import java.util.ArrayList;

public class LinuxFileServer extends ServerCliBase {

    private String gwMacAddress;

    public LinuxFileServer() {
        super();
    }

    public LinuxFileServer(String host, String user, String password) {
        super(host, user, password);
    }


    public LinuxFileServer(String host, String user, String password, String gwMacAddress) {
        super(host, user, password);
        this.gwMacAddress = gwMacAddress;
    }

    public String getGwMacAddress()
    {
        return this.gwMacAddress;
    }

    @Override
    public void init() throws Exception {
//		BaseTestUtils.reporter.startLevel("Init LinuxFileServer");
        super.init();
//        BaseTestUtils.reporter.stopLevel();
    }

    public void close() {
        super.close();
    }


    @Override
    public Prompt[] getPrompts() {
        ArrayList<Prompt> prompts = new ArrayList<Prompt>();
        Prompt p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("# ");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("$ ");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("login as: ");
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("User:.*");
        p.setRegularExpression(true);
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Password:.*");
        p.setRegularExpression(true);
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("s' password: ");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("password: ");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("mysql>");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("(yes/no)?");
        p.setCommandEnd(true);
        prompts.add(p);


        p = new Prompt();
        p.setPrompt("(yes/no)? ");
        p.setCommandEnd(true);
        prompts.add(p);

        // DefensePro Login - new prompt added
        p = new Prompt();
        p.setPrompt("DefensePro#");
        p.setCommandEnd(true);
        prompts.add(p);

        // DefensePro Reboot - new prompt added
        p = new Prompt();
        p.setPrompt("(y/n)[n]:");
        p.setCommandEnd(true);
        prompts.add(p);


        return prompts.toArray(new Prompt[prompts.size()]);
    }


}