package com.radware.vision.tests.rbac.DefensePro.configuration.setup;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup.RBACDefenseProAdvancedParametersTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
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
public class RBACDefenseProAdvancedParametersTableActionTests extends RBACTestBase {

    BaseTableActions eventSchedulerTableAction = BaseTableActions.NEW;
    EditTableActions outOfPathTableAction = EditTableActions.EDIT;


    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify OutOfPath Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "outOfPathTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOutOfPathDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("outOfPathTableAction", outOfPathTableAction.getTableAction().toString());

            if (!(RBACDefenseProAdvancedParametersTableActionHandler.verifyOutOfPathTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + outOfPathTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify OutOfPath Disabled Table Action failed: " + outOfPathTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify EventScheduler Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "eventSchedulerTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyEventSchedulerDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("eventSchedulerTableAction", eventSchedulerTableAction.getTableAction().toString());

            if (!(RBACDefenseProAdvancedParametersTableActionHandler.verifyEventSchedulerTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + eventSchedulerTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify EventScheduler Disabled Table Action failed: " + eventSchedulerTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }



    public BaseTableActions getEventSchedulerTableAction() {
        return eventSchedulerTableAction;
    }

    public void setEventSchedulerTableAction(BaseTableActions eventSchedulerTableAction) {
        this.eventSchedulerTableAction = eventSchedulerTableAction;
    }

    public EditTableActions getOutOfPathTableAction() {
        return outOfPathTableAction;
    }

    public void setOutOfPathTableAction(EditTableActions outOfPathTableAction) {
        this.outOfPathTableAction = outOfPathTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }
}
