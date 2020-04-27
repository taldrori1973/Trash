package com.radware.vision.infra.testhandlers.cli;

import com.radware.automation.tools.cli.ServerCliBase;

/**
 * Created by MoaadA on 1/6/2019.
 */
public class FilesHandler {

    public void scp(String srcPath, ServerCliBase srcMachine, ServerCliBase destMachine, String destPath) {
//kVision
//        CliOperations.runCommand(srcMachine, "scp -r " + srcPath + " " + destMachine.getUser() + "@" + destMachine.getHost() + ":" + destPath, 5 * 1000);
//        if (CliOperations.lastOutput.contains("Are you sure you want to continue connecting (yes/no)?"))
//            CliOperations.runCommand(srcMachine, "yes", 5 * 1000);
//        if (CliOperations.lastOutput.contains("password"))
//            CliOperations.runCommand(srcMachine, destMachine.getPassword(), 10 * 1000);
    }
}
