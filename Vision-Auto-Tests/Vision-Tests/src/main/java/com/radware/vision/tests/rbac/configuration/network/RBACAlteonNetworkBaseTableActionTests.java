package com.radware.vision.tests.rbac.configuration.network;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.network.RBACAlteonNetworkBaseTableActionHandler;
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
public class RBACAlteonNetworkBaseTableActionTests extends RBACTestBase {

    BaseTableActions proxyIPTableAction = BaseTableActions.NEW;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify ProxyIP Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "managementNetwork", "parentTree", "proxyIPTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyProxyIPDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("proxyIPTableAction", proxyIPTableAction.getTableAction().toString());
            testProperties.put("managementNetwork", managementNetwork.getNetwork().toString());

            if (!(RBACAlteonNetworkBaseTableActionHandler.verifyProxyIPTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + proxyIPTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify ProxyIP Disabled Table Action failed: " + proxyIPTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getProxyIPTableAction() {
        return proxyIPTableAction;
    }

    public void setProxyIPTableAction(BaseTableActions proxyIPTableAction) {
        this.proxyIPTableAction = proxyIPTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

}
