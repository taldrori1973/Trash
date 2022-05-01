package com.radware.vision.bddtests.Migration;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import systemobject.terminal.Prompt;

import java.util.ArrayList;

public class CVisionExportScriptPrompts extends ServerCliBase {

    String remoteHost;

    public CVisionExportScriptPrompts(String host, String user, String password, String remoteHost)
    {
        super(host,user,password);
        this.remoteHost = remoteHost;
    }

    @Override
    public Prompt[] getPrompts() {
        ArrayList<Prompt> prompts = new ArrayList<>();
        Prompt p = new Prompt();
        p.setPrompt("Do you want to export Elasticsearch data? (yes/no):");
        p.setStringToSend("yes");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Do you want to export Configuration data? (yes/no):");
        p.setStringToSend("yes");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Do you want to export data to remote location? (yes/no):");
        p.setStringToSend("yes");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter remote host address (*):");
        p.setStringToSend(getRemoteHost());
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter remote NFS share (Default: /var/lib/docker/mnt/nfs_share):");
        p.setStringToSend("/var/lib/docker/mnt/nfs_share");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter relative path for Elasticsearch data (Default: cvision/data-export/elasticsearch):");
        p.setStringToSend("cvision/data-export/elasticsearch");
        prompts.add(p);

        p = new Prompt();
        p.setPrompt("Enter relative path for Configuration data (Default: cvision/data-export/config):");
        p.setStringToSend("cvision/data-export/config");
        prompts.add(p);

        p = new Prompt();
        p.setCommandEnd(true);
        p.setPrompt("# ");
        prompts.add(p);

        return prompts.toArray(new Prompt[prompts.size()]);
    }

    public String getRemoteHost() {
        return remoteHost;
    }

    public void setRemoteHost(String remoteHost) {
        this.remoteHost = remoteHost;
    }

}