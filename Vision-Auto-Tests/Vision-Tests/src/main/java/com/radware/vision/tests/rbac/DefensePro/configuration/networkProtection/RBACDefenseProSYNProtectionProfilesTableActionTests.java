package com.radware.vision.tests.rbac.DefensePro.configuration.networkProtection;

import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection.RBACDefenseProSYNProtectionProfilesTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
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
public class RBACDefenseProSYNProtectionProfilesTableActionTests extends RBACTestBase {

    BaseTableActions synProtectionProfilesTableAction = BaseTableActions.NEW;
    EditTableActions profilesParametersTableAction = EditTableActions.EDIT;
    BaseTableActions synProtectionsTableAction = BaseTableActions.NEW;
    BaseTableActions sslMitigationPoliciesTableAction = BaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify SYNProtectionProfiles Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "synProtectionProfilesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySYNProtectionProfilesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("synProtectionProfilesTableAction", synProtectionProfilesTableAction.getTableAction().toString());

            if (!(RBACDefenseProSYNProtectionProfilesTableActionHandler.verifySYNProtectionProfilesTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + synProtectionProfilesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SYNProtectionProfiles Disabled Table Action failed: " + synProtectionProfilesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SYNProtections Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "synProtectionsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySYNProtectionsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("synProtectionsTableAction", synProtectionsTableAction.getTableAction().toString());

            if (!(RBACDefenseProSYNProtectionProfilesTableActionHandler.verifySYNProtectionsTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + synProtectionsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SYNProtections Disabled Table Action failed: " + synProtectionsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ProfilesParameters Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "profilesParametersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyProfilesParametersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("profilesParametersTableAction", profilesParametersTableAction.getTableAction().toString());

            if (!(RBACDefenseProSYNProtectionProfilesTableActionHandler.verifyProfilesParametersTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + profilesParametersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify ProfilesParameters Disabled Table Action failed: " + profilesParametersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SSLMitigationPolicies Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "sslMitigationPoliciesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySSLMitigationPoliciesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("sslMitigationPoliciesTableAction", sslMitigationPoliciesTableAction.getTableAction().toString());

            if (!(RBACDefenseProSYNProtectionProfilesTableActionHandler.verifySSLMitigationPoliciesTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + sslMitigationPoliciesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SSLMitigationPolicies Disabled Table Action failed: " + sslMitigationPoliciesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    public BaseTableActions getSynProtectionProfilesTableAction() {
        return synProtectionProfilesTableAction;
    }

    public void setSynProtectionProfilesTableAction(BaseTableActions synProtectionProfilesTableAction) {
        this.synProtectionProfilesTableAction = synProtectionProfilesTableAction;
    }

    public EditTableActions getProfilesParametersTableAction() {
        return profilesParametersTableAction;
    }

    public void setProfilesParametersTableAction(EditTableActions profilesParametersTableAction) {
        this.profilesParametersTableAction = profilesParametersTableAction;
    }

    public BaseTableActions getSynProtectionsTableAction() {
        return synProtectionsTableAction;
    }

    public void setSynProtectionsTableAction(BaseTableActions synProtectionsTableAction) {
        this.synProtectionsTableAction = synProtectionsTableAction;
    }

    public BaseTableActions getSslMitigationPoliciesTableAction() {
        return sslMitigationPoliciesTableAction;
    }

    public void setSslMitigationPoliciesTableAction(BaseTableActions sslMitigationPoliciesTableAction) {
        this.sslMitigationPoliciesTableAction = sslMitigationPoliciesTableAction;
    }

}
