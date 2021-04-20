package com.radware.vision.bddtests.clioperation.menu.system.snmp;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.vision_handlers.system.snmp.SnmpHandler;
import cucumber.api.java.en.Then;


public class SnmpSteps extends TestBase {


    @Then("^CLI System Snmp Community Add$")
    public void snmpCommunityAdd() {

        SnmpHandler.snmpCommunityAddValidation(restTestBase.getRadwareServerCli());

    }


    @Then("^CLI System Snmp Community Delete$")
    public void snmpCommunityDelete() {
        SnmpHandler.snmpCommunityDeleteValidation(restTestBase.getRadwareServerCli());
    }


    @Then("^CLI System Snmp Community List$")
    public void snmpCommunityList() {
        SnmpHandler.snmpCommunityListValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI System Snmp \"(Start|Stop)\"$")
    public void snmpStatus(String operation) {

        if (operation.equals("Stop")) {
            SnmpHandler.snmpStopValidation(restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
        } else if (operation.equals("Start")) {
            SnmpHandler.snmpStartValidation(restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
        } else {
            BaseTestUtils.report(operation + "is not supported here!", Reporter.FAIL);
        }

    }

    @Then("^CLI Service iptables restart$")
    public void iptablesServiceRestart() {
        SnmpHandler.iptablesServiceRestartValidation(restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
    }

    @Then("^CLI System Snmp Initial Status$")
        public void snmpStatusInitial() {
        SnmpHandler.snmpStop(restTestBase.getRadwareServerCli(), false);
        SnmpHandler.snmpStart(restTestBase.getRadwareServerCli(), true);
        SnmpHandler.snmpStatusInitialValidation(restTestBase.getRootServerCli());
    }

    @Then("^CLI System Snmp Status - \"(Started|Stopped)\"$")
    public void snmpStatusOperation(String operation) {
        if (operation.equalsIgnoreCase("Started")) {
            SnmpHandler.snmpStatusStartedValidation(restTestBase.getRadwareServerCli());
        }
        else
            {
                if (operation.equals("Stopped")) {
                    SnmpHandler.snmpStatusStoppedValidation(restTestBase.getRadwareServerCli());
                } else {
                    BaseTestUtils.report(operation + " is not supported here!", Reporter.FAIL);
                }
            }

    }

    @Then("^CLI System Snmp Help$")
    public void helpSnmp() {
        SnmpHandler.helpSnmpValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI Help - System Snmp Community$")
    public void helpSnmpCommunity() {
        SnmpHandler.helpSnmpCommunityValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI Help - System Snmp Community Add$")
    public void helpSnmpCommunityAdd() {
        SnmpHandler.helpSnmpCommunityValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI Help - System Snmp Community Delete$")
    public void helpSnmpCommunityDelete() {
        SnmpHandler.helpSnmpCommunityDeleteValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI Help - System Snmp Community List$")
    public void helpSnmpCommunityList() {
        SnmpHandler.helpSnmpCommunityListValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI Help - System Snmp Trap$")
    public void helpSnmpTrap() {
        SnmpHandler.helpSnmpTrapValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI Help - System Snmp Trap Target$")
    public void helpSnmpTrapTarget() {
        SnmpHandler.helpSnmpTrapTargetValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI Help - System Snmp Trap Target Add$")
    public void helpSnmpTrapTargetAdd() {
        SnmpHandler.helpSnmpTrapTargetAddValidation (restTestBase.getRadwareServerCli());
    }

    @Then("^CLI Help - System Snmp Trap Target Delete$")
    public void helpSnmpTrapTargetDelete() {
        SnmpHandler.helpSnmpTrapTargetDeleteValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI Help - System Snmp Trap Target List$")
    public void helpSnmpTrapTargetList() {
        SnmpHandler.helpSnmpTrapTargetListValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI System Snmp Trap Target list - Empty Initial$")
    public void snmpTrapTargetAddEmptyIitial() {
        SnmpHandler.snmpTrapTargetAddEmptyInitialValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI System Snmp Trap Target add & list - Custom port$")
    public void snmpTrapTargetAddAndListCustomPort() {
        SnmpHandler.snmpTrapTargetAddAndListCustomPortValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI System Snmp Trap Target add & list - Default port$")
    public void snmpTrapTargetAddAndListDefaultPort() {
        SnmpHandler.snmpTrapTargetAddAndListDefaultPortValidation(restTestBase.getRadwareServerCli());
    }

    @Then("^CLI System Snmp Trap Target delete$")
    public void snmpTrapTargetDelete() {
        SnmpHandler.snmpTrapTargetDeleteValidation(restTestBase.getRadwareServerCli());
    }




}
