package com.radware.vision.tests.rbac.DefensePro.monitoring.operationalStatus;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.monitoring.operationalStatus.RBACDefenseProOperationalStatusBaseTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.PortsAndTrunksTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 10/2/2014.
 */
public class RBACDefenseProOperationalStatusBaseTableActionTests extends RBACTestBase {

    PortsAndTrunksTableActions portsAndTrunksTableAction = PortsAndTrunksTableActions.VIEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify PortsAndTrunks Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "portsAndTrunksTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPortsAndTrunksDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("portsAndTrunksTableAction", portsAndTrunksTableAction.getTableAction().toString());

            if (!(RBACDefenseProOperationalStatusBaseTableActionHandler.verifyPortsAndTrunksTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + portsAndTrunksTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PortsAndTrunks Disabled Table Action failed: " + portsAndTrunksTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }



    public PortsAndTrunksTableActions getPortsAndTrunksTableAction() {
        return portsAndTrunksTableAction;
    }

    public void setPortsAndTrunksTableAction(PortsAndTrunksTableActions portsAndTrunksTableAction) {
        this.portsAndTrunksTableAction = portsAndTrunksTableAction;
    }

}
