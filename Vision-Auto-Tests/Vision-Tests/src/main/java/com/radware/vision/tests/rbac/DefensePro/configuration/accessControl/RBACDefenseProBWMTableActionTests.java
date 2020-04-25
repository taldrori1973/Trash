package com.radware.vision.tests.rbac.DefensePro.configuration.accessControl;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.accessControl.RBACDefenseProBWMTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ViewTableActions;
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
public class RBACDefenseProBWMTableActionTests extends RBACTestBase {

    BaseTableActions modifyPoliciesTableAction = BaseTableActions.NEW;
    ViewTableActions activePoliciesTableAction = ViewTableActions.VIEW;
    EditTableActions portsBandwidthTableTableAction = EditTableActions.EDIT;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify ModifyPolicies Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "modifyPoliciesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyModifyPoliciesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("modifyPoliciesTableAction", modifyPoliciesTableAction.getTableAction().toString());

            if (!(RBACDefenseProBWMTableActionHandler.verifyModifyPoliciesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + modifyPoliciesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ModifyPolicies Disabled Table Action failed: " + modifyPoliciesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ActivePolicies Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "activePoliciesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyActivePoliciesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("activePoliciesTableAction", activePoliciesTableAction.getTableAction().toString());

            if (!(RBACDefenseProBWMTableActionHandler.verifyActivePoliciesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + activePoliciesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ActivePolicies Disabled Table Action failed: " + activePoliciesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify PortsBandwidthTable Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "portsBandwidthTableTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPortsBandwidthTableDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("portsBandwidthTableTableAction", portsBandwidthTableTableAction.getTableAction().toString());

            if (!(RBACDefenseProBWMTableActionHandler.verifyPortsBandwidthTableTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + portsBandwidthTableTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PortsBandwidthTable Disabled Table Action failed: " + portsBandwidthTableTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getModifyPoliciesTableAction() {
        return modifyPoliciesTableAction;
    }

    public void setModifyPoliciesTableAction(BaseTableActions modifyPoliciesTableAction) {
        this.modifyPoliciesTableAction = modifyPoliciesTableAction;
    }

    public ViewTableActions getActivePoliciesTableAction() {
        return activePoliciesTableAction;
    }

    public void setActivePoliciesTableAction(ViewTableActions activePoliciesTableAction) {
        this.activePoliciesTableAction = activePoliciesTableAction;
    }

    public EditTableActions getPortsBandwidthTableTableAction() {
        return portsBandwidthTableTableAction;
    }

    public void setPortsBandwidthTableTableAction(EditTableActions portsBandwidthTableTableAction) {
        this.portsBandwidthTableTableAction = portsBandwidthTableTableAction;
    }

}
