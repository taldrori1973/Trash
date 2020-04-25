package com.radware.vision.tests.rbac.configuration.network;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.network.RBACAlteonBandwidthManagementTableActionHandler;
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
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonBandwidthManagementTableActionTests extends RBACTestBase {

    BaseTableActions trafficPoliciesTableAction = BaseTableActions.NEW;
    BaseTableActions trafficContractsTableAction = BaseTableActions.NEW;
    BaseTableActions contractGroupsTableAction = BaseTableActions.NEW;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify TrafficPolicies Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "trafficPoliciesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyTrafficPoliciesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("trafficPoliciesTableAction", trafficPoliciesTableAction.getTableAction().toString());

            if (!(RBACAlteonBandwidthManagementTableActionHandler.verifyTrafficPoliciesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + trafficPoliciesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify TrafficPolicies Disabled Table Action failed: " + trafficPoliciesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify TrafficContracts Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "trafficContractsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyTrafficContractsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("trafficContractsTableAction", trafficContractsTableAction.getTableAction().toString());

            if (!(RBACAlteonBandwidthManagementTableActionHandler.verifyTrafficContractsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + trafficContractsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify TrafficContracts Disabled Table Action failed: " + trafficContractsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ContractGroups Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "trafficPoliciesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyContractGroupsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("contractGroupsTableAction", contractGroupsTableAction.getTableAction().toString());

            if (!(RBACAlteonBandwidthManagementTableActionHandler.verifyContractGroupsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + contractGroupsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ContractGroups Disabled Table Action failed: " + contractGroupsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getTrafficPoliciesTableAction() {
        return trafficPoliciesTableAction;
    }

    public void setTrafficPoliciesTableAction(BaseTableActions trafficPoliciesTableAction) {
        this.trafficPoliciesTableAction = trafficPoliciesTableAction;
    }

    public BaseTableActions getTrafficContractsTableAction() {
        return trafficContractsTableAction;
    }

    public void setTrafficContractsTableAction(BaseTableActions trafficContractsTableAction) {
        this.trafficContractsTableAction = trafficContractsTableAction;
    }

    public BaseTableActions getContractGroupsTableAction() {
        return contractGroupsTableAction;
    }

    public void setContractGroupsTableAction(BaseTableActions contractGroupsTableAction) {
        this.contractGroupsTableAction = contractGroupsTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

}
