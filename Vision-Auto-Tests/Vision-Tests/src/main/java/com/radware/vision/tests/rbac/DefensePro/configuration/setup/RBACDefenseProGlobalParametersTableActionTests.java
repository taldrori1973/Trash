package com.radware.vision.tests.rbac.DefensePro.configuration.setup;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup.RBACDefenseProGlobalParametersTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.CertificatesTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/29/2014.
 */
public class RBACDefenseProGlobalParametersTableActionTests extends RBACTestBase {

    CertificatesTableActions certificatesTableAction = CertificatesTableActions.NEW;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify Certificates Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "certificatesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyCertificatesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("certificatesTableAction", certificatesTableAction.getTableAction().toString());

            if (!(RBACDefenseProGlobalParametersTableActionHandler.verifyCertificatesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + certificatesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Certificates Disabled Table Action failed: " + certificatesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public CertificatesTableActions getCertificatesTableAction() {
        return certificatesTableAction;
    }

    public void setCertificatesTableAction(CertificatesTableActions certificatesTableAction) {
        this.certificatesTableAction = certificatesTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }
}
