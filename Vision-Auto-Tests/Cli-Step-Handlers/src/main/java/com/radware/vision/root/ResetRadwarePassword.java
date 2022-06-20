package com.radware.vision.root;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;

import java.util.Optional;

public class ResetRadwarePassword extends TestBase {

    public static void resetRadwareUserPassword()  {
        try {
            Optional<RootServerCli> rootServerCliOpt = serversManagement.getRootServerCLI();
            if (!rootServerCliOpt.isPresent()) {
                throw new Exception("Root Server Not found!");
            }

            CliOperations.runCommand(rootServerCliOpt.get(), "restore_radware_user_password", CliOperations.DEFAULT_TIME_OUT);
            CliOperations.verifyLastOutputByRegex("The radware user password was successfully changed.", rootServerCliOpt.get());

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

}
