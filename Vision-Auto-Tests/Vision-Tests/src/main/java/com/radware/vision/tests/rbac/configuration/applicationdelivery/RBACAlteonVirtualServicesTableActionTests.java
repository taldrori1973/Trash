package com.radware.vision.tests.rbac.configuration.applicationdelivery;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery.RBACAlteonVirtualServicesTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.*;
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
public class RBACAlteonVirtualServicesTableActionTests extends RBACTestBase {

    BaseTableActions realServersTableAction = BaseTableActions.NEW;
    BaseTableActions serverGroupsTableAction = BaseTableActions.NEW;
    BaseTableActions virtualServersTableAction = BaseTableActions.NEW;
    EditTableActions virtualServicesOfSelectedVirtualServerTableAction = EditTableActions.EDIT;
    ViewTableActions contentBasedRulesOfSelectedVirtualServiceTableAction = ViewTableActions.VIEW;

    ContentClassesTableActions contentClassesTableAction = ContentClassesTableActions.NEW;
    ViewBaseTableActions httpMethodsTableAction = ViewBaseTableActions.NEW;
    BaseTableActions healthCheckTableAction = BaseTableActions.NEW;
    AppShapeTableActions appShapeTableAction = AppShapeTableActions.EXPORT;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify realServers Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "realServersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyRealServersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("realServersTableAction", realServersTableAction.getTableAction().toString());

            if (!(RBACAlteonVirtualServicesTableActionHandler.verifyRealServersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + realServersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify RealServers Disabled Table Action failed: " + realServersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ServerGroups Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "serverGroupsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyServerGroupsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("serverGroupsTableAction", serverGroupsTableAction.getTableAction().toString());

            if (!(RBACAlteonVirtualServicesTableActionHandler.verifyServerGroupsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + serverGroupsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ServerGroups Disabled Table Action failed: " + serverGroupsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify VirtualServers Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "serverGroupsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyVirtualServersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("virtualServersTableAction", virtualServersTableAction.getTableAction().toString());

            if (!(RBACAlteonVirtualServicesTableActionHandler.verifyVirtualServersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + virtualServersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify VirtualServers Disabled Table Action failed: " + virtualServersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify VirtualServicesOfSelectedVirtualServer Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "virtualServicesOfSelectedVirtualServerTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyVirtualServicesOfSelectedVirtualServerDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("virtualServicesOfSelectedVirtualServerTableAction", virtualServicesOfSelectedVirtualServerTableAction.getTableAction().toString());

            if (!(RBACAlteonVirtualServicesTableActionHandler.verifyVirtualServicesOfSelectedVirtualServerTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + virtualServicesOfSelectedVirtualServerTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify VirtualServicesOfSelectedVirtualServer Disabled Table Action failed: " + virtualServicesOfSelectedVirtualServerTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ContentBasedRulesOfSelectedVirtualService Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "contentBasedRulesOfSelectedVirtualServiceTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyContentBasedRulesOfSelectedVirtualServiceDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("contentBasedRulesOfSelectedVirtualServiceTableAction", contentBasedRulesOfSelectedVirtualServiceTableAction.getTableAction().toString());

            if (!(RBACAlteonVirtualServicesTableActionHandler.verifyContentBasedRulesOfSelectedVirtualServiceTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + contentBasedRulesOfSelectedVirtualServiceTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ContentBasedRulesOfSelectedVirtualService Disabled Table Action failed: " + contentBasedRulesOfSelectedVirtualServiceTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    //===============
    @Test
    @TestProperties(name = "verify ContentClasses Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "contentClassesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyContentClassesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("contentClassesTableAction", contentClassesTableAction.getTableAction().toString());

            if (!(RBACAlteonVirtualServicesTableActionHandler.verifyContentClassesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + contentClassesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ContentClasses Disabled Table Action failed: " + contentClassesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify HTTPMethods Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "httpMethodsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyHTTPMethodsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("httpMethodsTableAction", httpMethodsTableAction.getTableAction().toString());

            if (!(RBACAlteonVirtualServicesTableActionHandler.verifyHTTPMethodsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + httpMethodsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify HTTPMethods Disabled Table Action failed: " + httpMethodsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify HealthCheck Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "healthCheckTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyHealthCheckDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("healthCheckTableAction", healthCheckTableAction.getTableAction().toString());

            if (!(RBACAlteonVirtualServicesTableActionHandler.verifyHealthCheckTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + healthCheckTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify HealthCheck Disabled Table Action failed: " + healthCheckTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify AppShape Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "appShapeTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyAppShapeDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("appShapeTableAction", appShapeTableAction.getTableAction().toString());

            if (!(RBACAlteonVirtualServicesTableActionHandler.verifyAppShapeTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + appShapeTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify AppShape Disabled Table Action failed: " + appShapeTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }



    public BaseTableActions getRealServersTableAction() {
        return realServersTableAction;
    }

    public void setRealServersTableAction(BaseTableActions realServersTableAction) {
        this.realServersTableAction = realServersTableAction;
    }

    public BaseTableActions getServerGroupsTableAction() {
        return serverGroupsTableAction;
    }

    public void setServerGroupsTableAction(BaseTableActions serverGroupsTableAction) {
        this.serverGroupsTableAction = serverGroupsTableAction;
    }

    public BaseTableActions getVirtualServersTableAction() {
        return virtualServersTableAction;
    }

    public void setVirtualServersTableAction(BaseTableActions virtualServersTableAction) {
        this.virtualServersTableAction = virtualServersTableAction;
    }

    public EditTableActions getVirtualServicesOfSelectedVirtualServerTableAction() {
        return virtualServicesOfSelectedVirtualServerTableAction;
    }

    public void setVirtualServicesOfSelectedVirtualServerTableAction(EditTableActions virtualServicesOfSelectedVirtualServerTableAction) {
        this.virtualServicesOfSelectedVirtualServerTableAction = virtualServicesOfSelectedVirtualServerTableAction;
    }

    public ViewTableActions getContentBasedRulesOfSelectedVirtualServiceTableAction() {
        return contentBasedRulesOfSelectedVirtualServiceTableAction;
    }

    public void setContentBasedRulesOfSelectedVirtualServiceTableAction(ViewTableActions contentBasedRulesOfSelectedVirtualServiceTableAction) {
        this.contentBasedRulesOfSelectedVirtualServiceTableAction = contentBasedRulesOfSelectedVirtualServiceTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

    public ContentClassesTableActions getContentClassesTableAction() {
        return contentClassesTableAction;
    }

    public void setContentClassesTableAction(ContentClassesTableActions contentClassesTableAction) {
        this.contentClassesTableAction = contentClassesTableAction;
    }

    public ViewBaseTableActions getHttpMethodsTableAction() {
        return httpMethodsTableAction;
    }

    public void setHttpMethodsTableAction(ViewBaseTableActions httpMethodsTableAction) {
        this.httpMethodsTableAction = httpMethodsTableAction;
    }

    public BaseTableActions getHealthCheckTableAction() {
        return healthCheckTableAction;
    }

    public void setHealthCheckTableAction(BaseTableActions healthCheckTableAction) {
        this.healthCheckTableAction = healthCheckTableAction;
    }

    public AppShapeTableActions getAppShapeTableAction() {
        return appShapeTableAction;
    }

    public void setAppShapeTableAction(AppShapeTableActions appShapeTableAction) {
        this.appShapeTableAction = appShapeTableAction;
    }
}
