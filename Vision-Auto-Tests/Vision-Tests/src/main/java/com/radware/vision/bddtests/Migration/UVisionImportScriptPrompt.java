package com.radware.vision.bddtests.Migration;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import systemobject.terminal.Prompt;

import java.util.ArrayList;

public class UVisionImportScriptPrompt extends ServerCliBase {

    String ip, pairIP, setupImport, continueImport;

    public UVisionImportScriptPrompt(String hostIp, String userName, String password, String pairIP, String setupImport, String continueImport)
    {
        super(hostIp, userName, password);
        this.pairIP = pairIP;
        this.setupImport = setupImport;
        this.continueImport = continueImport;
    }

    @Override
    public Prompt[] getPrompts() {
        ArrayList<Prompt> prompts = new ArrayList<>();
        Prompt p = new Prompt();
        p.setPrompt("Setup automated data import from existing vision (Should be done only once)? (yes/no):");
        p.setStringToSend(getSetupImport());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter IP address of your existing vision:");
        p.setStringToSend(getPairIP());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Continue to data import? (yes/no):");
        p.setStringToSend(getContinueImport());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Import Configuration Data? (yes/no):");
        p.setStringToSend("yes");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Import Elasticsearch Data? (yes/no)");
        p.setStringToSend("yes");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Is your data located on a remote machine? (yes/no):");
        p.setStringToSend("no");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter path to configuration data (Default: /var/lib/docker/mnt/nfs_share/cvision/data-export/config):");
        p.setStringToSend("/var/lib/docker/mnt/nfs_share/cvision/data-export/config");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter path to elasticsearch data (Default: /var/lib/docker/mnt/nfs_share/cvision/data-export/elasticsearch):");
        p.setStringToSend("/var/lib/docker/mnt/nfs_share/cvision/data-export/elasticsearch");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("# ");
        prompts.add(p);

        return prompts.toArray(new Prompt[prompts.size()]);
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getPairIP() {
        return pairIP;
    }

    public void setPairIP(String pairIP) {
        this.pairIP = pairIP;
    }

    public String getSetupImport() {
        return setupImport;
    }

    public void setSetupImport(String setupImport) {
        this.setupImport = setupImport;
    }

    public String getContinueImport() {
        return continueImport;
    }

    public void setContinueImport(String continueImport) {
        this.continueImport = continueImport;
    }

}