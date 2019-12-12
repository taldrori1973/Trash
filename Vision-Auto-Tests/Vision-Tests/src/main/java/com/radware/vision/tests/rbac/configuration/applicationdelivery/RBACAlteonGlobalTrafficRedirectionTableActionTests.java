package com.radware.vision.tests.rbac.configuration.applicationdelivery;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery.RBACAlteonGlobalTrafficRedirectionTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.AddDeleteTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ImportBaseTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonGlobalTrafficRedirectionTableActionTests extends RBACTestBase {

    BaseTableActions remoteSitesTableAction = BaseTableActions.NEW;
    BaseTableActions siteSelectionRulesTableAction = BaseTableActions.NEW;
    BaseTableActions networksTableAction = BaseTableActions.NEW;
    AddDeleteTableActions dnsSECTableAction = AddDeleteTableActions.NEW;
    ImportBaseTableActions keyRepositoryTableAction = ImportBaseTableActions.NEW;
    BaseTableActions zoneToKeyAssociationTableAction = BaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify RemoteSites  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "remoteSitesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyRemoteSitesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("remoteSitesTableAction", remoteSitesTableAction.getTableAction().toString());

            if (!(RBACAlteonGlobalTrafficRedirectionTableActionHandler.verifyRemoteSitesTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + remoteSitesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify RemoteSites Disabled Table Action failed: " + remoteSitesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SiteSelectionRules  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "siteSelectionRulesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySiteSelectionRulesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("siteSelectionRulesTableAction", siteSelectionRulesTableAction.getTableAction().toString());

            if (!(RBACAlteonGlobalTrafficRedirectionTableActionHandler.verifySiteSelectionRulesTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + siteSelectionRulesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SiteSelectionRules Disabled Table Action failed: " + siteSelectionRulesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Networks  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "networksTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyNetworksDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("networksTableAction", networksTableAction.getTableAction().toString());

            if (!(RBACAlteonGlobalTrafficRedirectionTableActionHandler.verifyNetworksTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + networksTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify Networks Disabled Table Action failed: " + networksTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify DNSSEC  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "dnsSECTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyDNSSECDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("dnsSECTableAction", dnsSECTableAction.getTableAction().toString());

            if (!(RBACAlteonGlobalTrafficRedirectionTableActionHandler.verifyDNSSECTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + dnsSECTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify DNSSEC Disabled Table Action failed: " + dnsSECTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify KeyRepository  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "keyRepositoryTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyKeyRepositoryDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("keyRepositoryTableAction", keyRepositoryTableAction.getTableAction().toString());

            if (!(RBACAlteonGlobalTrafficRedirectionTableActionHandler.verifyKeyRepositoryTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + keyRepositoryTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify RemoteSites Disabled Table Action failed: " + keyRepositoryTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ZoneToKeyAssociation  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "zoneToKeyAssociationTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyZoneToKeyAssociationDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("zoneToKeyAssociationTableAction", zoneToKeyAssociationTableAction.getTableAction().toString());

            if (!(RBACAlteonGlobalTrafficRedirectionTableActionHandler.verifyZoneToKeyAssociationTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + zoneToKeyAssociationTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify ZoneToKeyAssociation Disabled Table Action failed: " + zoneToKeyAssociationTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getSiteSelectionRulesTableAction() {
        return siteSelectionRulesTableAction;
    }

    public void setSiteSelectionRulesTableAction(BaseTableActions siteSelectionRulesTableAction) {
        this.siteSelectionRulesTableAction = siteSelectionRulesTableAction;
    }

    public AddDeleteTableActions getDnsSECTableAction() {
        return dnsSECTableAction;
    }

    public void setDnsSECTableAction(AddDeleteTableActions dnsSECTableAction) {
        this.dnsSECTableAction = dnsSECTableAction;
    }

    public BaseTableActions getZoneToKeyAssociationTableAction() {
        return zoneToKeyAssociationTableAction;
    }

    public void setZoneToKeyAssociationTableAction(BaseTableActions zoneToKeyAssociationTableAction) {
        this.zoneToKeyAssociationTableAction = zoneToKeyAssociationTableAction;
    }

    public ImportBaseTableActions getKeyRepositoryTableAction() {
        return keyRepositoryTableAction;
    }

    public void setKeyRepositoryTableAction(ImportBaseTableActions keyRepositoryTableAction) {
        keyRepositoryTableAction = keyRepositoryTableAction;
    }

    public BaseTableActions getNetworksTableAction() {
        return networksTableAction;
    }

    public void setNetworksTableAction(BaseTableActions networksTableAction) {
        this.networksTableAction = networksTableAction;
    }

    public BaseTableActions getRemoteSitesTableAction() {
        return remoteSitesTableAction;
    }

    public void setRemoteSitesTableAction(BaseTableActions remoteSitesTableAction) {
        this.remoteSitesTableAction = remoteSitesTableAction;
    }
}
