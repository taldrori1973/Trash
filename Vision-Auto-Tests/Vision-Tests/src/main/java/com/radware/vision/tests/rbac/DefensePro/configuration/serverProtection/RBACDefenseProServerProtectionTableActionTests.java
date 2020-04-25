package com.radware.vision.tests.rbac.DefensePro.configuration.serverProtection;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.serverProtection.RBACDefenseProServerProtectionTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ExportBaseTableActions;
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
public class RBACDefenseProServerProtectionTableActionTests extends RBACTestBase {

    BaseTableActions serverCrackingProfilesTableAction = BaseTableActions.NEW;
    ExportBaseTableActions serverProtectionPoliciesTableAction = ExportBaseTableActions.NEW;
    ViewTableActions serverCrackingProtectionsTableAction = ViewTableActions.VIEW;
    BaseTableActions httpFloodProfilesTableAction = BaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify ServerProtectionPolicies Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "serverProtectionPoliciesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyServerProtectionPoliciesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("serverProtectionPoliciesTableAction", serverProtectionPoliciesTableAction.getTableAction().toString());

            if (!(RBACDefenseProServerProtectionTableActionHandler.verifyServerProtectionPoliciesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + serverProtectionPoliciesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ServerProtectionPolicies Disabled Table Action failed: " + serverProtectionPoliciesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ServerCrackingProfiles Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "serverCrackingProfilesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyServerCrackingProfilesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("serverCrackingProfilesTableAction", serverCrackingProfilesTableAction.getTableAction().toString());

            if (!(RBACDefenseProServerProtectionTableActionHandler.verifyServerCrackingProfilesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + serverCrackingProfilesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ServerCrackingProfiles Disabled Table Action failed: " + serverCrackingProfilesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ServerCrackingProtections Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "serverCrackingProtectionsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyServerCrackingProtectionsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("serverCrackingProtectionsTableAction", serverCrackingProtectionsTableAction.getTableAction().toString());

            if (!(RBACDefenseProServerProtectionTableActionHandler.verifyServerCrackingProtectionsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + serverCrackingProtectionsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ServerCrackingProtections Disabled Table Action failed: " + serverCrackingProtectionsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify HTTPFloodProfiles Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "httpFloodProfilesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyHTTPFloodProfilesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("httpFloodProfilesTableAction", httpFloodProfilesTableAction.getTableAction().toString());

            if (!(RBACDefenseProServerProtectionTableActionHandler.verifyHTTPFloodProfilesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + httpFloodProfilesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify HTTPFloodProfiles Disabled Table Action failed: " + httpFloodProfilesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getServerCrackingProfilesTableAction() {
        return serverCrackingProfilesTableAction;
    }

    public void setServerCrackingProfilesTableAction(BaseTableActions serverCrackingProfilesTableAction) {
        this.serverCrackingProfilesTableAction = serverCrackingProfilesTableAction;
    }

    public ExportBaseTableActions getServerProtectionPoliciesTableAction() {
        return serverProtectionPoliciesTableAction;
    }

    public void setServerProtectionPoliciesTableAction(ExportBaseTableActions serverProtectionPoliciesTableAction) {
        this.serverProtectionPoliciesTableAction = serverProtectionPoliciesTableAction;
    }

    public ViewTableActions getServerCrackingProtectionsTableAction() {
        return serverCrackingProtectionsTableAction;
    }

    public void setServerCrackingProtectionsTableAction(ViewTableActions serverCrackingProtectionsTableAction) {
        this.serverCrackingProtectionsTableAction = serverCrackingProtectionsTableAction;
    }

    public BaseTableActions getHttpFloodProfilesTableAction() {
        return httpFloodProfilesTableAction;
    }

    public void setHttpFloodProfilesTableAction(BaseTableActions httpFloodProfilesTableAction) {
        this.httpFloodProfilesTableAction = httpFloodProfilesTableAction;
    }

}
