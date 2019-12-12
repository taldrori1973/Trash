package com.radware.vision.tests.rbac.DefensePro.configuration.networkProtection;

import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection.RBACDefenseProConnectionPPSLimitProfilesTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import com.radware.automation.tools.basetest.Reporter;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProConnectionPPSLimitProfilesTableActionTests extends RBACTestBase {

    BaseTableActions connectionPPSLimitProfilesTableAction = BaseTableActions.NEW;
    BaseTableActions connectionPPSLimitProtectionsTableAction = BaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify ConnectionPPSLimitProfiles Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "connectionPPSLimitProfilesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyConnectionPPSLimitProfilesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("connectionPPSLimitProfilesTableAction", connectionPPSLimitProfilesTableAction.getTableAction().toString());

            if (!(RBACDefenseProConnectionPPSLimitProfilesTableActionHandler.verifyConnectionPPSLimitProfilesTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + connectionPPSLimitProfilesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify ConnectionPPSLimitProfiles Disabled Table Action failed: " + connectionPPSLimitProfilesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ConnectionPPSLimitProtections Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "connectionPPSLimitProtectionsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyConnectionPPSLimitProtectionsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("connectionPPSLimitProtectionsTableAction", connectionPPSLimitProtectionsTableAction.getTableAction().toString());

            if (!(RBACDefenseProConnectionPPSLimitProfilesTableActionHandler.verifyConnectionPPSLimitProtectionsTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + connectionPPSLimitProtectionsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify ConnectionPPSLimitProtections Disabled Table Action failed: " + connectionPPSLimitProtectionsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getConnectionPPSLimitProfilesTableAction() {
        return connectionPPSLimitProfilesTableAction;
    }

    public void setConnectionPPSLimitProfilesTableAction(BaseTableActions connectionPPSLimitProfilesTableAction) {
        this.connectionPPSLimitProfilesTableAction = connectionPPSLimitProfilesTableAction;
    }

    public BaseTableActions getConnectionPPSLimitProtectionsTableAction() {
        return connectionPPSLimitProtectionsTableAction;
    }

    public void setConnectionPPSLimitProtectionsTableAction(BaseTableActions connectionPPSLimitProtectionsTableAction) {
        this.connectionPPSLimitProtectionsTableAction = connectionPPSLimitProtectionsTableAction;
    }

}
