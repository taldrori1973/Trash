package com.radware.vision.tests.rbac.DefensePro.configuration.Classes;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.Classes.RBACDefenseProServicesTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
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
public class RBACDefenseProServicesTableActionTests extends RBACTestBase {

    BaseTableActions basicFiltersTableAction = BaseTableActions.NEW;
    BaseTableActions andGroupsTableAction = BaseTableActions.NEW;
    BaseTableActions orGroupsTableAction = BaseTableActions.NEW;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify BasicFilters Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "basicFiltersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyBasicFiltersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("basicFiltersTableAction", basicFiltersTableAction.getTableAction().toString());

            if (!(RBACDefenseProServicesTableActionHandler.verifyBasicFiltersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + basicFiltersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify BasicFilters Disabled Table Action failed: " + basicFiltersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ORGroups Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "orGroupsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyORGroupsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("orGroupsTableAction", orGroupsTableAction.getTableAction().toString());

            if (!(RBACDefenseProServicesTableActionHandler.verifyORGroupsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + orGroupsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ORGroups Disabled Table Action failed: " + orGroupsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ANDGroups Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "andGroupsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyANDGroupsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("andGroupsTableAction", andGroupsTableAction.getTableAction().toString());

            if (!(RBACDefenseProServicesTableActionHandler.verifyANDGroupsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + andGroupsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ANDGroups Disabled Table Action failed: " + andGroupsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getBasicFiltersTableAction() {
        return basicFiltersTableAction;
    }

    public void setBasicFiltersTableAction(BaseTableActions basicFiltersTableAction) {
        this.basicFiltersTableAction = basicFiltersTableAction;
    }

    public BaseTableActions getAndGroupsTableAction() {
        return andGroupsTableAction;
    }

    public void setAndGroupsTableAction(BaseTableActions andGroupsTableAction) {
        this.andGroupsTableAction = andGroupsTableAction;
    }

    public BaseTableActions getOrGroupsTableAction() {
        return orGroupsTableAction;
    }

    public void setOrGroupsTableAction(BaseTableActions orGroupsTableAction) {
        this.orGroupsTableAction = orGroupsTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }
}
