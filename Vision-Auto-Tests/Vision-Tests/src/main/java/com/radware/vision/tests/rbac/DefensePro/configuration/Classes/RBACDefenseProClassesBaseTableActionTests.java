package com.radware.vision.tests.rbac.DefensePro.configuration.Classes;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.Classes.RBACDefenseProClassesBaseTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ViewBaseTableActions;
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
public class RBACDefenseProClassesBaseTableActionTests extends RBACTestBase {

    BaseTableActions networksTableAction = BaseTableActions.NEW;
    ViewBaseTableActions physicalPortsTableAction = ViewBaseTableActions.NEW;
    BaseTableActions vlanTagsTableAction = BaseTableActions.NEW;
    ViewBaseTableActions macAddressesTableAction = ViewBaseTableActions.NEW;
    ViewBaseTableActions applicationsTableAction = ViewBaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify Networks Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "networksTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyNetworksDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("networksTableAction", networksTableAction.getTableAction().toString());

            if (!(RBACDefenseProClassesBaseTableActionHandler.verifyNetworksTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + networksTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Networks Disabled Table Action failed: " + networksTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify PhysicalPorts Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "physicalPortsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPhysicalPortsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("physicalPortsTableAction", physicalPortsTableAction.getTableAction().toString());

            if (!(RBACDefenseProClassesBaseTableActionHandler.verifyPhysicalPortsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + physicalPortsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PhysicalPorts Disabled Table Action failed: " + physicalPortsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify VLANTags Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "vlanTagsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyVLANTagsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("vlanTagsTableAction", vlanTagsTableAction.getTableAction().toString());

            if (!(RBACDefenseProClassesBaseTableActionHandler.verifyVLANTagsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + vlanTagsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify VLANTags Disabled Table Action failed: " + vlanTagsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Applications Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "applicationsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyApplicationsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("applicationsTableAction", applicationsTableAction.getTableAction().toString());

            if (!(RBACDefenseProClassesBaseTableActionHandler.verifyApplicationsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + applicationsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Applications Disabled Table Action failed: " + applicationsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify MACAddresses Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "macAddressesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyMACAddressesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("macAddressesTableAction", macAddressesTableAction.getTableAction().toString());

            if (!(RBACDefenseProClassesBaseTableActionHandler.verifyMACAddressesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + macAddressesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify MACAddresses Disabled Table Action failed: " + macAddressesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getNetworksTableAction() {
        return networksTableAction;
    }

    public void setNetworksTableAction(BaseTableActions networksTableAction) {
        this.networksTableAction = networksTableAction;
    }

    public ViewBaseTableActions getPhysicalPortsTableAction() {
        return physicalPortsTableAction;
    }

    public void setPhysicalPortsTableAction(ViewBaseTableActions physicalPortsTableAction) {
        this.physicalPortsTableAction = physicalPortsTableAction;
    }

    public BaseTableActions getVlanTagsTableAction() {
        return vlanTagsTableAction;
    }

    public void setVlanTagsTableAction(BaseTableActions vlanTagsTableAction) {
        this.vlanTagsTableAction = vlanTagsTableAction;
    }

    public ViewBaseTableActions getMacAddressesTableAction() {
        return macAddressesTableAction;
    }

    public void setMacAddressesTableAction(ViewBaseTableActions macAddressesTableAction) {
        this.macAddressesTableAction = macAddressesTableAction;
    }

    public ViewBaseTableActions getApplicationsTableAction() {
        return applicationsTableAction;
    }

    public void setApplicationsTableAction(ViewBaseTableActions applicationsTableAction) {
        this.applicationsTableAction = applicationsTableAction;
    }


}
