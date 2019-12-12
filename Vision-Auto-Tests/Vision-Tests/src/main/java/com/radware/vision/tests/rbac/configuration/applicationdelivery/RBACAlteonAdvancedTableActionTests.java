package com.radware.vision.tests.rbac.configuration.applicationdelivery;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery.RBACAlteonAdvancedTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonAdvancedTableActionTests extends RBACTestBase {

    BaseTableActions inboundLinkLBTableAction = BaseTableActions.NEW;
    BaseTableActions workloadManagerTableAction = BaseTableActions.NEW;
    BaseTableActions serverInitiatedConnectionsTableAction = BaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify InboundLinkLB  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "inboundLinkLBTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyInboundLinkLBDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("inboundLinkLBTableAction", inboundLinkLBTableAction.getTableAction().toString());

            if (!(RBACAlteonAdvancedTableActionHandler.verifyInboundLinkLBTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + inboundLinkLBTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify InboundLinkLB Disabled Table Action failed: " + inboundLinkLBTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify WorkloadManager  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "workloadManagerTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyWorkloadManagerDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("workloadManagerTableAction", workloadManagerTableAction.getTableAction().toString());

            if (!(RBACAlteonAdvancedTableActionHandler.verifyWorkloadManagerTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + workloadManagerTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify WorkloadManager Disabled Table Action failed: " + workloadManagerTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ServerInitiatedConnections  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "serverInitiatedConnectionsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyServerInitiatedConnectionsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("serverInitiatedConnectionsTableAction", serverInitiatedConnectionsTableAction.getTableAction().toString());

            if (!(RBACAlteonAdvancedTableActionHandler.verifyServerInitiatedConnectionsTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + serverInitiatedConnectionsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify ServerInitiatedConnections Disabled Table Action failed: " + serverInitiatedConnectionsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getInboundLinkLBTableAction() {
        return inboundLinkLBTableAction;
    }

    public void setInboundLinkLBTableAction(BaseTableActions inboundLinkLBTableAction) {
        this.inboundLinkLBTableAction = inboundLinkLBTableAction;
    }

    public BaseTableActions getWorkloadManagerTableAction() {
        return workloadManagerTableAction;
    }

    public void setWorkloadManagerTableAction(BaseTableActions workloadManagerTableAction) {
        this.workloadManagerTableAction = workloadManagerTableAction;
    }

    public BaseTableActions getServerInitiatedConnectionsTableAction() {
        return serverInitiatedConnectionsTableAction;
    }

    public void setServerInitiatedConnectionsTableAction(BaseTableActions serverInitiatedConnectionsTableAction) {
        this.serverInitiatedConnectionsTableAction = serverInitiatedConnectionsTableAction;
    }

}
