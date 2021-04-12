package com.radware.vision.bddtests.clioperation.menu.system.config_sync;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.cli.LinuxFileServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.bddtests.GenericSteps;
import com.radware.vision.bddtests.basicoperations.BasicOperationsSteps;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.testhandlers.EmailHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.cli.highavailability.HAHandler;
import com.radware.vision.utils.SutUtils;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import cucumber.api.java.en.Then;
import enums.SUTEntryType;

public class ConfigSyncFailureSteps extends VisionUITestBase {

    public ConfigSyncFailureSteps() throws Exception {
    }

    @Then("^CLI Verify Config Sync Failure Mail(?: \"(.*)\" password for radware.com \"(.*)\")?$")
    public void mailFailure(String mail, String password) {
        if (mail != null) {
            if (mail.split("@")[1].equalsIgnoreCase("radware.com")) {
                failureRadwareMailValidate(mail, password);
            } else if (mail.split("@")[1].equalsIgnoreCase("cli.local")) {
                failureCliMailValidate(mail);
            } else {
                BaseTestUtils.report(mail + " is not supported here! use ...@radware.com or ...@cli.local ", Reporter.FAIL);
            }
        } else {
            failureCliMailValidate(mail);
//            failureRadwareMailValidate(mail, password);
        }
    }


    private void failureRadwareMailValidate(String mail, String password) {
        int sec = 1000;
        if (mail == null || mail.equalsIgnoreCase("automation.vision1@radware.com")) {
            mail = "automation.vision1@radware.com";
            password = "Qwerty1!";
        }

        int interval1 = 10;
        int interval2 = 1;
        String content = "This email is being sent to notify you of a critical situation in a configuration-synchronization pair of APSolute Vision server instances. Warning: The standby APSolute Vision server instance failed to receive 1 configuration-synchronization messages. This could indicate a failure of the active APSolute Vision server instance. To ensure the continuous operation of APSolute Vision, you can manually fail over to the standby APSolute Vision server instance. For details, refer to the APSolute Vision User Guide, or contact Radware Technical Support.";
        String subject = "Alert on APSolute Vision Redundancy Potential Failure";

        EmailHandler emailHandler = new EmailHandler(mail, password);
        try {
            /* this for peer = host2*/
            String peerHost = restTestBase.getVisionServerHA().getHost_2();
            RadwareServerCli peerServerCli = new RadwareServerCli(peerHost, SutUtils.getCurrentVisionRestUserName(), SutUtils.getCurrentVisionRestUserPassword());
            peerServerCli.init();
            /* **********************/
            HAHandler.setConfigSyncMode(restTestBase.getRadwareServerCli(), "active", 1000 * sec, "YES");
//            system config-sync peer set host2
            HAHandler.setConfigSyncPeer(restTestBase.getRadwareServerCli(), peerHost, restTestBase.getVisionServerHA());
//            system config-sync interval set 10
            HAHandler.setConfigSyncInterval(restTestBase.getRadwareServerCli(), interval1);

            HAHandler.setConfigSyncMode(peerServerCli, "standby", 1000 * sec, "YES");
//           system config-sync peer set host1
            HAHandler.setConfigSyncPeer(peerServerCli, restTestBase.getRadwareServerCli().getHost(), restTestBase.getVisionServerHA());
//           system config-sync interval set 1
            HAHandler.setConfigSyncInterval(peerServerCli, interval2);
//           kVision
//            CliOperations.runCommand(peerServerCli, "system config-sync mail_recipients set " + mail);
            int missedSyncs = 1;
//           kVision
//            CliOperations.runCommand(peerServerCli, "system config-sync missed_syncs set " + missedSyncs);

            String smtpAddress = "176.200.120.120";
            configMailViaUi(smtpAddress, "APSolute Vision");

//           system config-sync manual
            HAHandler.manualSync(restTestBase.getRadwareServerCli());
            emailHandler.verifyLastUnreadEmail(null, subject, content, null, 180);
            missedSyncs = 0;
//           kVision
//            CliOperations.runCommand(peerServerCli, "system config-sync missed_syncs set " + missedSyncs);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    private void failureCliMailValidate(String mail) {

        int sec = 1000;
        if (mail == null) {
            mail = "automation.vision1@cli.local";
        }

        int interval1 = 10;
        int interval2 = 1;
        String content = "This email is being sent to notify you of a critical situation in a configuration-synchronization pair of APSolute Vision server instances.\r\n" +
                "Warning: The standby APSolute Vision server instance failed to receive 1 configuration-synchronization messages.\r\n" +
                "This could indicate a failure of the active APSolute Vision server instance.\r\n" +
                "To ensure the continuous operation of APSolute Vision, you can manually fail over to the standby APSolute Vision server instance. For details, refer to the APSolute Vision User Guide, or contact Radware Technical Support.";
        String subject = "Alert on APSolute Vision Redundancy Potential Failure";
        String mailPath = "/var/mail/cliuser";

        try {
            String sutEntryType = "genericLinuxServer";
//            172.17.164.10
            LinuxFileServer rootGenericLinuxServerCli = new LinuxFileServer(getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(sutEntryType)).getHost(), "root", "radware");
            rootGenericLinuxServerCli.init();
//            delete cliuser file
            String delCliuser = "rm " + mailPath;
//           kVision
//            CliOperations.runCommand(rootGenericLinuxServerCli, delCliuser);
            /* this for peer = host2*/
            String peerHost = restTestBase.getVisionServerHA().getHost_2();
            RadwareServerCli peerServerCli = new RadwareServerCli(peerHost, SutUtils.getCurrentVisionRestUserName(), SutUtils.getCurrentVisionRestUserPassword());
            peerServerCli.init();
            /* **********************/
            HAHandler.setConfigSyncMode(restTestBase.getRadwareServerCli(), "active", 1000 * sec, "YES");
//           system config-sync peer set host2
            HAHandler.setConfigSyncPeer(restTestBase.getRadwareServerCli(), peerHost, restTestBase.getVisionServerHA());
//            system config-sync interval set 10
            HAHandler.setConfigSyncInterval(restTestBase.getRadwareServerCli(), interval1);

//            HAHandler.setConfigSyncMode(peerServerCli, "standby", 1000 * sec, "YES");
            HAHandler.setConfigSyncModeWithoutServices(peerServerCli, "standby", 1000 * sec, "YES");
//            system config-sync peer set host1
            HAHandler.setConfigSyncPeer(peerServerCli, restTestBase.getRadwareServerCli().getHost(), restTestBase.getVisionServerHA());
//            system config-sync interval set 1
            HAHandler.setConfigSyncInterval(peerServerCli, interval2);
//           kVision
//            CliOperations.runCommand(peerServerCli, "system config-sync mail_recipients set " + mail);
            int missedSyncs = 1;
//           kVision
//            CliOperations.runCommand(peerServerCli, "system config-sync missed_syncs set " + missedSyncs);
            String smtpAddress = "172.17.164.10";
            configMailViaUi(smtpAddress, "APSolute Vision");

//           system config-sync manual
            HAHandler.manualSync(restTestBase.getRadwareServerCli());

            BasicOperationsHandler.delay(60);
            String commandToExecuteInGenericLinux = "cat " + mailPath;
            int failedCounter = 0;
            String failedException = "";
            for (int i = 0; i < 3; i++) {
//               kVision
//                CliOperations.runCommand(rootGenericLinuxServerCli, commandToExecuteInGenericLinux);
//                CliOperations.verifyLastOutputByRegex(content);
//                CliOperations.verifyLastOutputByRegex(subject);
                try {
                    CliOperations.verifyLastOutputByRegexWithoutFail(content);
                    CliOperations.verifyLastOutputByRegexWithoutFail(subject);
                } catch (Exception e) {
                    failedCounter++;
                    failedException = e.getMessage();
                }
                if (failedCounter == i) {
                    break;
                }

                if (i == 2 && failedCounter != 0) {
                    missedSyncs = 0;
//                   kVision
//                    CliOperations.runCommand(peerServerCli, "system config-sync missed_syncs set " + missedSyncs);
                    BaseTestUtils.report(failedException, Reporter.FAIL);
                }
                BasicOperationsHandler.delay(60);
            }
//            to stop mail sending
            missedSyncs = 0;
//           kVision
//            CliOperations.runCommand(peerServerCli, "system config-sync missed_syncs set " + missedSyncs);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    private void configMailViaUi(String serverAdress, String apSoluteVision) {
        BasicOperationsSteps basicOperationsSteps;
        GenericSteps genericSteps;
        try {
            basicOperationsSteps = new BasicOperationsSteps();
            genericSteps = new GenericSteps();
            basicOperationsSteps.login("radware", "radware", "");
            basicOperationsSteps.goToVision();
            String path = "System->General Settings->Alert Settings->Alert Browser";
            WebUIVisionBasePage.navigateToPage(path);
            genericSteps.uiSSlInspectionDoOperation("select", "Email Reporting Configuration", "");
            genericSteps.uiSetCheckboxWithExtensionTo("Enable", "", true);
            genericSteps.uiSetTextFieldTo("SMTP Server Address",null, serverAdress, false);
            genericSteps.uiSetTextFieldTo("From Header", null,apSoluteVision, false);
            genericSteps.uiSetCheckboxWithExtensionTo("Enable", "", false);
            BasicOperationsHandler.clickButton("Submit", "");
            basicOperationsSteps.logout();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


}

