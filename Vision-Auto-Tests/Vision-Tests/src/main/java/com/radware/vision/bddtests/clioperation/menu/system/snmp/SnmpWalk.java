package com.radware.vision.bddtests.clioperation.menu.system.snmp;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.cli.ServerCliBase;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.vision_project_cli.RootServerCli;
import com.radware.vision.vision_tests.CliTests;
import cucumber.api.java.en.When;
import enums.SUTEntryType;


/**
 * created by Ameer
 * <p>
 * checking snmpwalk command
 * run command from  genericLinuxServer after that check result if there is an inside file from rootServerCli
 */
public class SnmpWalk extends BddCliTestBase {
    private int failedCounter;

    /**
     * snmpwalk test
     *
     * @param OIDType from CLI-IODs folder under debugIds folder
     *                example for OIDType -> (User || Total || System).
     * @param file    name of file it take results from.
     * @param host    machine ip (optional).
     */
    @When("^CLI snmpwalk Validate \"([^\"]*)\" with \"([^\"]*)\"(?: with host \"(.*)\")?$")
    public void cliSnmpwalkValidateCPUUtilizationReflex(String file, String OIDType, String host) {
        RadwareServerCli radwareServerCli = restTestBase.getRadwareServerCli();
        RootServerCli rootServerCli = restTestBase.getRootServerCli();
        if (host == null) {
            host = restTestBase.getRadwareServerCli().getHost();
            if(!host.matches("(\\d+)\\.(\\d+)\\.(\\d+)\\.(\\d+)"))
                host = "'" + "udp6:" + host + "'";
        }
       else if (!host.equals(restTestBase.getRadwareServerCli().getHost())) {
            try {
                if(!host.matches("(\\d+)\\.(\\d+)\\.(\\d+)\\.(\\d+)"))
                    host = "'" + "udp6:" + host + "'";
                radwareServerCli = new RadwareServerCli(host, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRootServerCli().getPassword());
                radwareServerCli.init();
                rootServerCli = new RootServerCli(host, restTestBase.getRootServerCli().getUser(), restTestBase.getRootServerCli().getPassword());
                rootServerCli.init();
            } catch (Exception e) {
                BaseTestUtils.report("Failed to build with host: " + host + " " + parseExceptionBody(e), Reporter.FAIL);
            }
        }
        file = file.toLowerCase();
        String lowerCaseOIdtype = OIDType.toLowerCase();
        BddUITestBase.initDataDebugIds();
        VisionDebugIdsManager.setLabel("OID." + file + "." + OIDType);
        String oid = VisionDebugIdsManager.getDataDebugId();
        preCondition(radwareServerCli);
        String sutEntryType = "genericLinuxServer";
        String commandToExecute = String.format("snmpwalk -v 2c -c public %s %s| grep -o '\".*\"' |tr -d '\"'", host, oid);
        failedCounter = 0;
        String failedException = "";
        /* 1. */
        CliOperations.runCommand(getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(sutEntryType)), commandToExecute);
        String lastRow1 = CliOperations.lastRow;
        /* 2. */
        String rootCommand = String.format("cat /opt/radware/storage/maintenance/hw_monitoring/%s.txt", file);
        CliOperations.runCommand(rootServerCli, rootCommand);
        /* validate */
        try {
            CliOperations.verifyLastOutputByRegex(lowerCaseOIdtype);
            CliOperations.verifyLastOutputByRegexWithoutFail(lastRow1);
        } catch (Exception e) {
            failedCounter++;
            failedException = e.getMessage();
        }
        /* pass */
        if (failedCounter == 0) return;

        //            run from genericLinux
        CliOperations.runCommand(getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(sutEntryType)), commandToExecute);
        String lastRaw2 = CliOperations.lastRow;

        if (lastRow1.equals(lastRaw2) && failedCounter > 0) {
            failedCounter = 0;
            /* reverse */
            int snmpWalkRuns = 10;
            for (int i = 0; i < snmpWalkRuns; i++) {
                CliOperations.runCommand(rootServerCli, rootCommand);
                String lastOutput = CliOperations.lastOutput;

                CliOperations.runCommand(getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(sutEntryType)), commandToExecute);
                String lastRow = CliOperations.lastRow;

                try {
                    CliOperations.verifyLastOutputByRegexWithOutput(lowerCaseOIdtype, lastOutput);
                    CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(lastRow, lastOutput);
                } catch (Exception e) {
                    failedCounter++;
                    failedException = e.getMessage();
                }
                if (failedCounter == i) {
                    break;
                }
            }
            if (failedCounter > snmpWalkRuns - 1) {
                failedCounter = 0;
                BaseTestUtils.report("Failed After Running Snmpwalk " + snmpWalkRuns + " times cause : " + failedException + " ", Reporter.FAIL);
            }
            /*        */
        } else if (!lastRow1.equals(lastRaw2)) {
            cliSnmpwalkValidateCPUUtilizationReflex(file, OIDType, host);
        }

    }


    /**
     * just run snmpwalk command
     *
     * @param OIDType from CLI-IODs folder under debugIds folder
     *                example for OIDType -> (cpu.utilization.User || cpu.utilization.Total || cpu.utilization.System)
     * @param host    machine ip (optional).
     */
    @When("^CLI run snmpwalk command \"([^\"]*)\"(?: with host \"(.*)\")?$")
    public void runSnmpwalkCommand(String OIDType, String host) {
        RadwareServerCli radwareServerCli = restTestBase.getRadwareServerCli();
        if (host == null) {
            host = CliTests.radwareServerCli.getHost();
            if(!host.matches("(\\d+)\\.(\\d+)\\.(\\d+)\\.(\\d+)"))
                host = "'" + "udp6:" + host + "'";
        }
        BddUITestBase.initDataDebugIds();
        VisionDebugIdsManager.setLabel("OID." + OIDType);
        String oid = VisionDebugIdsManager.getDataDebugId();
        String commandToExecute = String.format("snmpwalk -v 2c -c public %s %s| grep -o '\".*\"' |tr -d '\"'", host, oid);
        String sutEntryType = "genericLinuxServer";
        preCondition(radwareServerCli);
        try {
            CliOperations.runCommand(getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(sutEntryType)), commandToExecute);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + sutEntryType + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    private void preCondition(ServerCliBase radwareServer) {
        String startSnmp = "system snmp service start";
        CliOperations.runCommand(radwareServer, startSnmp);
        String addCommunity = "system snmp community add public";
        CliOperations.runCommand(radwareServer, addCommunity);
    }


}
