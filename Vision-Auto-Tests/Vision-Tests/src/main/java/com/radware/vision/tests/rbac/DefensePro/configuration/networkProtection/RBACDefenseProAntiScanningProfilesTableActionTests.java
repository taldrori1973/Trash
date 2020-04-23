package com.radware.vision.tests.rbac.DefensePro.configuration.networkProtection;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection.RBACDefenseProAntiScanningProfilesTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ViewBaseTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProAntiScanningProfilesTableActionTests extends RBACTestBase {

    BaseTableActions antiScanningProfilesTableAction = BaseTableActions.NEW;
    ViewBaseTableActions antiScanningTrustedPortsTableAction = ViewBaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify AntiScanningProfiles Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "antiScanningProfilesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyAntiScanningProfilesDisabledTableAction() {

        try {
            testProperties.put("antiScanningProfilesTableAction", antiScanningProfilesTableAction.getTableAction().toString());

            if (!(RBACDefenseProAntiScanningProfilesTableActionHandler.verifyAntiScanningProfilesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + antiScanningProfilesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify AntiScanningProfiles Disabled Table Action failed: " + antiScanningProfilesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify AntiScanningTrustedPorts Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "antiScanningTrustedPortsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyAntiScanningTrustedPortsDisabledTableAction() throws IOException {

        try {
            testProperties.put("antiScanningTrustedPortsTableAction", antiScanningTrustedPortsTableAction.getTableAction().toString());

            if (!(RBACDefenseProAntiScanningProfilesTableActionHandler.verifyAntiScanningTrustedPortsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + antiScanningTrustedPortsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify AntiScanningTrustedPorts Disabled Table Action failed: " + antiScanningTrustedPortsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    public BaseTableActions getAntiScanningProfilesTableAction() {
        return antiScanningProfilesTableAction;
    }

    public void setAntiScanningProfilesTableAction(BaseTableActions antiScanningProfilesTableAction) {
        this.antiScanningProfilesTableAction = antiScanningProfilesTableAction;
    }

    public ViewBaseTableActions getAntiScanningTrustedPortsTableAction() {
        return antiScanningTrustedPortsTableAction;
    }

    public void setAntiScanningTrustedPortsTableAction(ViewBaseTableActions antiScanningTrustedPortsTableAction) {
        this.antiScanningTrustedPortsTableAction = antiScanningTrustedPortsTableAction;
    }

}
