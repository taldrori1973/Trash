package com.radware.vision.infra.utils.tcpdump;

import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.vision_project_cli.RootServerCli;

import java.util.ArrayList;

/**
 * Created by stanislava on 8/24/2016.
 */
public class GetTcpDumpOutputThread extends Thread{

    String tcpDumpCommand;
    RootServerCli cli;
    ArrayList<String> outputs = new ArrayList<>();

    public GetTcpDumpOutputThread(String tcpDumpCommand, RootServerCli cli){
        this.tcpDumpCommand = tcpDumpCommand;
        this.cli = cli;
    }

    @Override
    synchronized public void run(){
        try {
            InvokeUtils.invokeCommand(null, tcpDumpCommand, cli, 30 * 60 * 1000, true);
            outputs = cli.getCmdOutput();

        }catch(Exception e){
            throw new RuntimeException("Error at tcpdump values utils: " + e.getMessage());
        }
    }

    public ArrayList<String> getTcpDumpOutputs(){
        return outputs;
    }

}
