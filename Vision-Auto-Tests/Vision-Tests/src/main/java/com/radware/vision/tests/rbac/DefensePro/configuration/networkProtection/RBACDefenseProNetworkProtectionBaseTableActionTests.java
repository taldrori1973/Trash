package com.radware.vision.tests.rbac.DefensePro.configuration.networkProtection;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection.RBACDefenseProNetworkProtectionBaseTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ExportBaseTableActions;
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
public class RBACDefenseProNetworkProtectionBaseTableActionTests extends RBACTestBase {

    BaseTableActions bdosProfilesTableAction = BaseTableActions.NEW;
    ExportBaseTableActions networkProtectionPoliciesTableAction = ExportBaseTableActions.NEW;
    BaseTableActions dnsProtectionProfilesTableAction = BaseTableActions.NEW;
    BaseTableActions outOfStateProtectionProfilesTableAction = BaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify NetworkProtectionPolicies Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "networkProtectionPoliciesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyNetworkProtectionPoliciesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("networkProtectionPoliciesTableAction", networkProtectionPoliciesTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkProtectionBaseTableActionHandler.verifyNetworkProtectionPoliciesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + networkProtectionPoliciesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify NetworkProtectionPolicies Disabled Table Action failed: " + networkProtectionPoliciesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify BDoSProfiles Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "bdosProfilesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyBDoSProfilesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("bdosProfilesTableAction", bdosProfilesTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkProtectionBaseTableActionHandler.verifyBDoSProfilesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + bdosProfilesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify BDoSProfiles Disabled Table Action failed: " + bdosProfilesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify OutOfStateProtectionProfiles Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "outOfStateProtectionProfilesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOutOutOfStateProtectionProfilesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("outOfStateProtectionProfilesTableAction", outOfStateProtectionProfilesTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkProtectionBaseTableActionHandler.verifyOutOfStateProtectionProfilesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + outOfStateProtectionProfilesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OutOfStateProtectionProfiles Disabled Table Action failed: " + outOfStateProtectionProfilesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify DNSProtectionProfiles Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "dnsProtectionProfilesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyDNSProtectionProfilesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("dnsProtectionProfilesTableAction", dnsProtectionProfilesTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkProtectionBaseTableActionHandler.verifyDNSProtectionProfilesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + dnsProtectionProfilesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify DNSProtectionProfiles Disabled Table Action failed: " + dnsProtectionProfilesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getBdosProfilesTableAction() {
        return bdosProfilesTableAction;
    }

    public void setBdosProfilesTableAction(BaseTableActions bdosProfilesTableAction) {
        this.bdosProfilesTableAction = bdosProfilesTableAction;
    }

    public ExportBaseTableActions getNetworkProtectionPoliciesTableAction() {
        return networkProtectionPoliciesTableAction;
    }

    public void setNetworkProtectionPoliciesTableAction(ExportBaseTableActions networkProtectionPoliciesTableAction) {
        this.networkProtectionPoliciesTableAction = networkProtectionPoliciesTableAction;
    }

    public BaseTableActions getDnsProtectionProfilesTableAction() {
        return dnsProtectionProfilesTableAction;
    }

    public void setDnsProtectionProfilesTableAction(BaseTableActions dnsProtectionProfilesTableAction) {
        this.dnsProtectionProfilesTableAction = dnsProtectionProfilesTableAction;
    }

    public BaseTableActions getOutOfStateProtectionProfilesTableAction() {
        return outOfStateProtectionProfilesTableAction;
    }

    public void setOutOfStateProtectionProfilesTableAction(BaseTableActions outOfStateProtectionProfilesTableAction) {
        this.outOfStateProtectionProfilesTableAction = outOfStateProtectionProfilesTableAction;
    }

}
