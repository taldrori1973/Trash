package com.radware.vision;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;

import java.util.Optional;

/**
 * Created by MoaadA on 1/6/2019.
 */
public class FilesHandler {

    public void scp(String srcPath, ServerCliBase srcMachine, ServerCliBase destMachine, String destPath) {
        CliOperations.runCommand(srcMachine, "scp -r " + srcPath + " " + destMachine.getUser() + "@" + destMachine.getHost() + ":" + destPath, 5 * 1000);
        if (CliOperations.lastOutput.contains("Are you sure you want to continue connecting (yes/no)?"))
            CliOperations.runCommand(srcMachine, "yes", 5 * 1000);
        if (CliOperations.lastOutput.contains("password"))
            CliOperations.runCommand(srcMachine, destMachine.getPassword(), 10 * 1000);
    }
}
