package com.radware.vision.tests.rbac.DefensePro.configuration.networkProtection;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection.RBACDefenseProConnectionLimitProfilesTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
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
public class RBACDefenseProConnectionLimitProfilesTableActionTests extends RBACTestBase {

    BaseTableActions connectionLimitProfilesTableAction = BaseTableActions.NEW;
    BaseTableActions connectionLimitProtectionsTableAction = BaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify ConnectionLimitProfiles Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "connectionLimitProfilesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyConnectionLimitProfilesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("connectionLimitProfilesTableAction", connectionLimitProfilesTableAction.getTableAction().toString());

            if (!(RBACDefenseProConnectionLimitProfilesTableActionHandler.verifyConnectionLimitProfilesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + connectionLimitProfilesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ConnectionLimitProfiles Disabled Table Action failed: " + connectionLimitProfilesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ConnectionLimitProtections Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "connectionLimitProtectionsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyConnectionLimitProtectionsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("connectionLimitProtectionsTableAction", connectionLimitProtectionsTableAction.getTableAction().toString());

            if (!(RBACDefenseProConnectionLimitProfilesTableActionHandler.verifyConnectionLimitProtectionsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + connectionLimitProtectionsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ConnectionLimitProtections Disabled Table Action failed: " + connectionLimitProtectionsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getConnectionLimitProfilesTableAction() {
        return connectionLimitProfilesTableAction;
    }

    public void setConnectionLimitProfilesTableAction(BaseTableActions connectionLimitProfilesTableAction) {
        this.connectionLimitProfilesTableAction = connectionLimitProfilesTableAction;
    }

    public BaseTableActions getConnectionLimitProtectionsTableAction() {
        return connectionLimitProtectionsTableAction;
    }

    public void setConnectionLimitProtectionsTableAction(BaseTableActions connectionLimitProtectionsTableAction) {
        this.connectionLimitProtectionsTableAction = connectionLimitProtectionsTableAction;
    }

}
