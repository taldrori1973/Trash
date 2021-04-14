package com.radware.vision.infra.utils.tcpdump;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;

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
            CliOperations.runCommand(cli, tcpDumpCommand, 30 * 60 * 1000, true);
            outputs = cli.getCmdOutput();

        }catch(Exception e){
            throw new RuntimeException("Error at tcpdump values utils: " + e.getMessage());
        }
    }

    public ArrayList<String> getTcpDumpOutputs(){
        return outputs;
    }

}
