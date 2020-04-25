package com.radware.vision.tests.rbac.DefensePro.configuration.accessControl;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.accessControl.RBACDefenseProACLPolicyTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
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
public class RBACDefenseProACLPolicyTableActionTests extends RBACTestBase {

    BaseTableActions modifyPolicyTableAction = BaseTableActions.NEW;
    ViewTableActions activePolicyTableAction = ViewTableActions.VIEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify ModifyPolicy Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "modifyPolicyTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyModifyPolicyDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("modifyPolicyTableAction", modifyPolicyTableAction.getTableAction().toString());

            if (!(RBACDefenseProACLPolicyTableActionHandler.verifyModifyPolicyTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + modifyPolicyTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ModifyPolicy Disabled Table Action failed: " + modifyPolicyTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ActivePolicy Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "activePolicyTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyActivePolicyDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("activePolicyTableAction", activePolicyTableAction.getTableAction().toString());

            if (!(RBACDefenseProACLPolicyTableActionHandler.verifyActivePolicyTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + activePolicyTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ActivePolicy Disabled Table Action failed: " + activePolicyTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getModifyPolicyTableAction() {
        return modifyPolicyTableAction;
    }

    public void setModifyPolicyTableAction(BaseTableActions modifyPolicyTableAction) {
        this.modifyPolicyTableAction = modifyPolicyTableAction;
    }

    public ViewTableActions getActivePolicyTableAction() {
        return activePolicyTableAction;
    }

    public void setActivePolicyTableAction(ViewTableActions activePolicyTableAction) {
        this.activePolicyTableAction = activePolicyTableAction;
    }

}
