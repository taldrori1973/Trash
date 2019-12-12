package com.radware.vision.tests.rbac.DefensePro.configuration.setup;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup.RBACDefenseProReportingSettingsTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.infra.testhandlers.rbac.enums.ViewBaseTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProReportingSettingsTableActionTests extends RBACTestBase {

    BaseTableActions syslogTableAction = BaseTableActions.NEW;
    BaseTableActions signalingTableAction = BaseTableActions.NEW;
    ViewBaseTableActions dataReportingDestinationsTableAction = ViewBaseTableActions.NEW;


    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify Syslog Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "syslogTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySyslogDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("syslogTableAction", syslogTableAction.getTableAction().toString());

            if (!(RBACDefenseProReportingSettingsTableActionHandler.verifySyslogTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + syslogTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify Syslog Disabled Table Action failed: " + syslogTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Signaling Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "signalingTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySignalingDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("signalingTableAction", signalingTableAction.getTableAction().toString());

            if (!(RBACDefenseProReportingSettingsTableActionHandler.verifySignalingTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + signalingTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify Signaling Disabled Table Action failed: " + signalingTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify DataReportingDestinations Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "dataReportingDestinationsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyDataReportingDestinationsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("dataReportingDestinationsTableAction", dataReportingDestinationsTableAction.getTableAction().toString());

            if (!(RBACDefenseProReportingSettingsTableActionHandler.verifyDataReportingDestinationsTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + dataReportingDestinationsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify DataReportingDestinations Disabled Table Action failed: " + dataReportingDestinationsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getSyslogTableAction() {
        return syslogTableAction;
    }

    public void setSyslogTableAction(BaseTableActions syslogTableAction) {
        this.syslogTableAction = syslogTableAction;
    }

    public BaseTableActions getSignalingTableAction() {
        return signalingTableAction;
    }

    public void setSignalingTableAction(BaseTableActions signalingTableAction) {
        this.signalingTableAction = signalingTableAction;
    }

    public ViewBaseTableActions getDataReportingDestinationsTableAction() {
        return dataReportingDestinationsTableAction;
    }

    public void setDataReportingDestinationsTableAction(ViewBaseTableActions dataReportingDestinationsTableAction) {
        this.dataReportingDestinationsTableAction = dataReportingDestinationsTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }
}
