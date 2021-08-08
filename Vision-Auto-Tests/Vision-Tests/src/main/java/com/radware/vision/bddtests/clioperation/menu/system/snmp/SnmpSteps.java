package com.radware.vision.bddtests.clioperation.menu.system.snmp;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.system.snmp.SnmpHandler;
import cucumber.api.java.en.Then;


public class SnmpSteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();

    @Then("^CLI System Snmp Community Add$")
    public void snmpCommunityAdd() {

        SnmpHandler.snmpCommunityAddValidation(radwareServerCli);

    }


    @Then("^CLI System Snmp Community Delete$")
    public void snmpCommunityDelete() {
        SnmpHandler.snmpCommunityDeleteValidation(radwareServerCli);
    }


    @Then("^CLI System Snmp Community List$")
    public void snmpCommunityList() {
        SnmpHandler.snmpCommunityListValidation(radwareServerCli);
    }

    @Then("^CLI System Snmp \"(Start|Stop)\"$")
    public void snmpStatus(String operation) {

        if (operation.equals("Stop")) {
            SnmpHandler.snmpStopValidation(radwareServerCli, rootServerCli);
        } else if (operation.equals("Start")) {
            SnmpHandler.snmpStartValidation(radwareServerCli, rootServerCli);
        } else {
            BaseTestUtils.report(operation + "is not supported here!", Reporter.FAIL);
        }

    }

    @Then("^CLI Service iptables restart$")
    public void iptablesServiceRestart() {
        SnmpHandler.iptablesServiceRestartValidation(radwareServerCli, rootServerCli);
    }

    @Then("^CLI System Snmp Initial Status$")
        public void snmpStatusInitial() {
        SnmpHandler.snmpStop(radwareServerCli, false);
        SnmpHandler.snmpStart(radwareServerCli, true);
        SnmpHandler.snmpStatusInitialValidation(radwareServerCli, rootServerCli);
    }

    @Then("^CLI System Snmp Status - \"(Started|Stopped)\"$")
    public void snmpStatusOperation(String operation) {
        if (operation.equalsIgnoreCase("Started")) {
            SnmpHandler.snmpStatusStartedValidation(radwareServerCli);
        }
        else
            {
                if (operation.equals("Stopped")) {
                    SnmpHandler.snmpStatusStoppedValidation(radwareServerCli);
                } else {
                    BaseTestUtils.report(operation + " is not supported here!", Reporter.FAIL);
                }
            }

    }

    @Then("^CLI System Snmp Help$")
    public void helpSnmp() {
        SnmpHandler.helpSnmpValidation(radwareServerCli);
    }

    @Then("^CLI Help - System Snmp Community$")
    public void helpSnmpCommunity() {
        SnmpHandler.helpSnmpCommunityValidation(radwareServerCli);
    }

    @Then("^CLI Help - System Snmp Community Add$")
    public void helpSnmpCommunityAdd() {
        SnmpHandler.helpSnmpCommunityValidation(radwareServerCli);
    }

    @Then("^CLI Help - System Snmp Community Delete$")
    public void helpSnmpCommunityDelete() {
        SnmpHandler.helpSnmpCommunityDeleteValidation(radwareServerCli);
    }

    @Then("^CLI Help - System Snmp Community List$")
    public void helpSnmpCommunityList() {
        SnmpHandler.helpSnmpCommunityListValidation(radwareServerCli);
    }

    @Then("^CLI Help - System Snmp Trap$")
    public void helpSnmpTrap() {
        SnmpHandler.helpSnmpTrapValidation(radwareServerCli);
    }

    @Then("^CLI Help - System Snmp Trap Target$")
    public void helpSnmpTrapTarget() {
        SnmpHandler.helpSnmpTrapTargetValidation(radwareServerCli);
    }

    @Then("^CLI Help - System Snmp Trap Target Add$")
    public void helpSnmpTrapTargetAdd() {
        SnmpHandler.helpSnmpTrapTargetAddValidation (radwareServerCli);
    }

    @Then("^CLI Help - System Snmp Trap Target Delete$")
    public void helpSnmpTrapTargetDelete() {
        SnmpHandler.helpSnmpTrapTargetDeleteValidation(radwareServerCli);
    }

    @Then("^CLI Help - System Snmp Trap Target List$")
    public void helpSnmpTrapTargetList() {
        SnmpHandler.helpSnmpTrapTargetListValidation(radwareServerCli);
    }

    @Then("^CLI System Snmp Trap Target list - Empty Initial$")
    public void snmpTrapTargetAddEmptyIitial() {
        SnmpHandler.snmpTrapTargetAddEmptyInitialValidation(radwareServerCli);
    }

    @Then("^CLI System Snmp Trap Target add & list - Custom port$")
    public void snmpTrapTargetAddAndListCustomPort() {
        SnmpHandler.snmpTrapTargetAddAndListCustomPortValidation(radwareServerCli);
    }

    @Then("^CLI System Snmp Trap Target add & list - Default port$")
    public void snmpTrapTargetAddAndListDefaultPort() {
        SnmpHandler.snmpTrapTargetAddAndListDefaultPortValidation(radwareServerCli);
    }

    @Then("^CLI System Snmp Trap Target delete$")
    public void snmpTrapTargetDelete() {
        SnmpHandler.snmpTrapTargetDeleteValidation(radwareServerCli);
    }




}
