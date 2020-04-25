package com.radware.vision.tests.rbac.configuration.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.system.RBACAlteonUsersTableActionHandler;
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
public class RBACAlteonUsersTableActionTests extends RBACTestBase {
    BaseTableActions localUsersTableAction = BaseTableActions.NEW;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify Local Users Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "localUsersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyLocalUsersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("localUsersTableAction", localUsersTableAction.getTableAction().toString());

            if (!(RBACAlteonUsersTableActionHandler.verifyLocalUsersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + localUsersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Local Users Disabled Table Action failed: " + localUsersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getLocalUsersTableAction() {
        return localUsersTableAction;
    }

    public void setLocalUsersTableAction(BaseTableActions localUsersTableAction) {
        this.localUsersTableAction = localUsersTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

}
