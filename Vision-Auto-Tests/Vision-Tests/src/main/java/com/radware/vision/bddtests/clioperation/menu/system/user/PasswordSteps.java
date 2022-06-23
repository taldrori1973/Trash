package com.radware.vision.bddtests.clioperation.menu.system.user;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.base.VisionCliTestBase;
import com.radware.vision.system.user.password;
import cucumber.api.java.en.Given;

public class PasswordSteps extends VisionCliTestBase {
    private RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().isPresent() ?
            serversManagement.getRadwareServerCli().get() : null;

    @Given("^CLI Operations - system user password change \"(.*)\"$")
    public void changeRadwarePassword(String newPassword) {
        String currentPassword = radwareServerCli.getPassword();
        password.changeRadwarePassword(radwareServerCli, currentPassword, newPassword);
    }

}
