package com.radware.vision.automation.AutoUtils.vision_handlers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.cli.ServerCliBase;
import com.radware.automation.tools.utils.InvokeUtils;
import jsystem.extensions.analyzers.text.GetTextCounter;
import systemobject.terminal.Prompt;


import java.util.ArrayList;

/**
 * @author Hadar Elbaz
 */

public class VisionRadwareFirstTime extends ServerCliBase {

    String netMask;
    String gateway;
    String primaryDns;
    String physicalManagement;
    String vmName;
    String ip;

    ServerCliBase vm;

    public VisionRadwareFirstTime() {
    }

    @Override
    public void init() throws Exception {
        super.init();

    }

    public void close() {
        super.close();
    }


    public boolean waitForConnection(long timeout, long waitBetweenRetries) {
        long startTime = System.currentTimeMillis();
        try {
            setConnectRetries(1);
            while (((startTime + timeout) > System.currentTimeMillis())) {
                try {
                    connect();
                    try {
                        Thread.sleep(waitBetweenRetries);
                    } catch (InterruptedException ie) {
                        //  Ignore
                    }
                    return true;
                } catch (Exception e) {
                    continue;
                }
            }
        } finally {
            setConnectRetries(3);
        }
        return false;
    }

    public void setConnectionidleTimeout(long timeout) {
        setMaxIdleTime(timeout);
    }

    @Override
    public Prompt[] getPrompts() {
        ArrayList<Prompt> prompts = new ArrayList<Prompt>();
        Prompt p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("$ ");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("# ");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("> ");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt(">");
        prompts.add(p);

        // For root commands - Deployment Phase End testing
        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("~]# ");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt(")#");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("login as: ");
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("vision login: ");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("s' password: ");
        p.setStringToSend(getPassword());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("IP Address: ");
        p.setStringToSend(getIp());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("IP address: ");
        p.setStringToSend(getIp());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Netmask: ");
        p.setStringToSend(getNetMask());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Gateway: ");
        p.setStringToSend(getGateway());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Primary DNS Server: ");
        p.setStringToSend(getPrimaryDns());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Secondary DNS Server: ");
        p.setStringToSend("");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Physical Management Interface \\[G1 G2 G3\\]  \\(Active links on:.*\\): ");
        p.setRegularExpression(true);
        p.setStringToSend(getPhysicalManagement());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Physical Management Interface \\[G3 G5 G7\\]  \\(Active links on:.*\\): ");
        p.setRegularExpression(true);
        p.setStringToSend(getPhysicalManagement());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Apply these settings [y/N]? ");
        p.setStringToSend("y");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Do you want to change the root user password [y/N]?");
        p.setStringToSend("n");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("[y/N]? ");
        p.setCommandEnd(true);
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("(Y/N)");
        p.setCommandEnd(true);
        prompts.add(p);


        p = new Prompt();
        p.setPrompt("Continue? [yes/no]");
        p.setStringToSend("yes");
        prompts.add(p);


        p = new Prompt();
        p.setPrompt("vision.radware login: ");
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("vision.radware.localdomain login: ");
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("vision.radware.localdomain.localdomain.localdomain login: ");
        p.setStringToSend(getUser());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Password: ");
        p.setStringToSend(getVm().getPassword());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Password :");
        p.setStringToSend("PASS");
        prompts.add(p);


        return prompts.toArray(new Prompt[prompts.size()]);
    }

    public String getStringCounter(String key) throws Exception {

        GetTextCounter counter = new GetTextCounter(key);
        analyze(counter);
        return counter.getCounter();
    }

    public void sendCommand(String command) throws Exception {
        InvokeUtils.invokeCommand(null, command, this);
        BaseTestUtils.reporter.report(getTestAgainstObject().toString());
    }

    public String getNetMask() {
        return netMask;
    }

    public void setNetMask(String netMask) {
        this.netMask = netMask;
    }

    public String getGateway() {
        return gateway;
    }

    public void setGateway(String gateway) {
        this.gateway = gateway;
    }

    public String getPrimaryDns() {
        return primaryDns;
    }

    public void setPrimaryDns(String primaryDns) {
        this.primaryDns = primaryDns;
    }

    public String getPhysicalManagement() {
        return physicalManagement;
    }

    public String getVmName() {
        return vmName;
    }


    public void setPhysicalManagement(String physicalManagement) {
        this.physicalManagement = physicalManagement;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public void setVmName(String vmName) {
        this.vmName = vmName;
    }


    public ServerCliBase getVm() {
        if (vm == null)
            vm = new ServerCliBase(getIp(), "radware", "radware");

        return vm;
    }

    public void setTerminalAndCliEqualNull() {
        terminal = null;
        cli = null;
    }

    public void changeCommandToSendForPrompt(String promptString, String promptCommand) {
        Prompt p = new Prompt();
        p.setPrompt(promptString);
        for (Prompt prompt : terminal.getPrompts()) {
            if (prompt.equals(p)) {
                prompt.setStringToSend(promptCommand);
                return;
            }
        }
        terminal.addPrompt(p);
        p.setStringToSend(promptString);
    }
}