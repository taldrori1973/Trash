package com.radware.vision.tests.rbac.configuration.network;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.network.RBACAlteonLayer3TableActionHandler;
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
public class RBACAlteonLayer3TableActionTests extends RBACTestBase {

    BaseTableActions ipInterfacesTableAction = BaseTableActions.NEW;
    BaseTableActions gatewaysTableAction = BaseTableActions.NEW;
    ViewBaseTableActions staticRoutesTableAction = ViewBaseTableActions.NEW;
    BaseTableActions peersTableAction = BaseTableActions.NEW;
    BaseTableActions aggregationsTableAction = BaseTableActions.NEW;

    BaseTableActions ospfAreasTableAction = BaseTableActions.NEW;
    BaseTableActions ospfInterfacesTableAction = BaseTableActions.NEW;
    BaseTableActions ospfHostsTableAction = BaseTableActions.NEW;
    EditDeleteTableActions ospfVirtualLinksTableAction = EditDeleteTableActions.EDIT;
    BaseTableActions ospfSummaryRangesTableAction = BaseTableActions.NEW;
    BaseTableActions ospfMD5KeyTableAction = BaseTableActions.NEW;

    BaseTableActions ospfV3AreasTableAction = BaseTableActions.NEW;
    BaseTableActions ospfV3InterfacesTableAction = BaseTableActions.NEW;
    BaseTableActions ospfV3HostsTableAction = BaseTableActions.NEW;
    EditDeleteTableActions ospfV3VirtualLinksTableAction = EditDeleteTableActions.EDIT;
    BaseTableActions ospfV3SummaryRangesTableAction = BaseTableActions.NEW;

    BaseTableActions networkFiltersTableAction = BaseTableActions.NEW;
    BaseTableActions routeMapsTableAction = BaseTableActions.NEW;
    BaseTableActions staticARPTableAction = BaseTableActions.NEW;
    AddEditTableActions ripInterfacesTableAction = AddEditTableActions.EDIT;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify IPInterfaces Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ipInterfacesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyIPInterfacesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ipInterfacesTableAction", ipInterfacesTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyIPInterfacesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ipInterfacesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify IPInterfaces Disabled Table Action failed: " + ipInterfacesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Gateways Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "gatewaysTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyGatewaysDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("gatewaysTableAction", gatewaysTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyGatewaysTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + gatewaysTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Gateways Disabled Table Action failed: " + gatewaysTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify StaticRoutes Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "managementNetwork", "parentTree", "staticRoutesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyStaticRoutesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("staticRoutesTableAction", staticRoutesTableAction.getTableAction().toString());
            testProperties.put("managementNetwork", managementNetwork.getNetwork().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyStaticRoutesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + staticRoutesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify StaticRoutes Disabled Table Action failed: " + staticRoutesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Peers Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "peersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPeersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("peersTableAction", peersTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyPeersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + peersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Peers Disabled Table Action failed: " + peersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Aggregations Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "aggregationsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyAggregationsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("aggregationsTableAction", aggregationsTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyAggregationsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + aggregationsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Aggregations Disabled Table Action failed: " + aggregationsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }
    //======================= OSPF ==================

    @Test
    @TestProperties(name = "verify OSPFAreas Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ospfAreasTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOSPFAreasDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ospfAreasTableAction", ospfAreasTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyOSPFAreasTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ospfAreasTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OSPFAreas Disabled Table Action failed: " + ospfAreasTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify OSPFInterfaces Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ospfInterfacesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOSPFInterfacesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ospfInterfacesTableAction", ospfInterfacesTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyOSPFInterfacesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ospfInterfacesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OSPFInterfaces Disabled Table Action failed: " + ospfInterfacesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify OSPFHosts Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ospfHostsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOSPFHostsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ospfHostsTableAction", ospfHostsTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyOSPFHostsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ospfHostsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OSPFHosts Disabled Table Action failed: " + ospfHostsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify OSPFVirtualLinks Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ospfVirtualLinksTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOSPFVirtualLinksDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ospfVirtualLinksTableAction", ospfVirtualLinksTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyOSPFVirtualLinksTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ospfVirtualLinksTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OSPFVirtualLinks Disabled Table Action failed: " + ospfVirtualLinksTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify OSPFSummaryRanges Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ospfSummaryRangesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOSPFSummaryRangesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ospfSummaryRangesTableAction", ospfSummaryRangesTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyOSPFSummeryRangesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ospfSummaryRangesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OSPFSummaryRanges Disabled Table Action failed: " + ospfSummaryRangesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify OSPFMD5Key Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ospfMD5KeyTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOSPFMD5KeyDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ospfMD5KeyTableAction", ospfMD5KeyTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyOSPFMD5KeyTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ospfMD5KeyTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OSPFMD5Key Disabled Table Action failed: " + ospfMD5KeyTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

//======================= OSPFv3 ==================

    @Test
    @TestProperties(name = "verify OSPFv3Areas Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ospfV3AreasTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOSPFv3AreasDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ospfV3AreasTableAction", ospfV3AreasTableAction.getTableAction());

            if (!(RBACAlteonLayer3TableActionHandler.verifyOSPFV3AreasTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ospfV3AreasTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OSPFv3Areas Disabled Table Action failed: " + ospfV3AreasTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify OSPFv3Interfaces Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ospfV3InterfacesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOSPFv3InterfacesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ospfV3InterfacesTableAction", ospfV3InterfacesTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyOSPFV3InterfacesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ospfV3InterfacesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OSPFv3Interfaces Disabled Table Action failed: " + ospfV3InterfacesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify OSPFv3Hosts Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ospfV3HostsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOSPFv3HostsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ospfV3HostsTableAction", ospfV3HostsTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyOSPFV3HostsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ospfV3HostsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OSPFv3Hosts Disabled Table Action failed: " + ospfV3HostsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify OSPFv3VirtualLinks Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ospfV3VirtualLinksTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOSPFv3VirtualLinksDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ospfV3VirtualLinksTableAction", ospfV3VirtualLinksTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyOSPFV3VirtualLinksTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ospfV3VirtualLinksTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OSPFv3VirtualLinks Disabled Table Action failed: " + ospfV3VirtualLinksTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify OSPFv3SummaryRanges Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ospfV3SummaryRangesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyOSPFv3SummaryRangesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ospfV3SummaryRangesTableAction", ospfV3SummaryRangesTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyOSPFV3SummeryRangesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ospfV3SummaryRangesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify OSPFSv3ummaryRanges Disabled Table Action failed: " + ospfV3SummaryRangesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    //==============
    @Test
    @TestProperties(name = "verify RIPInterfaces Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "ripInterfacesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyRIPInterfacesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ripInterfacesTableAction", ripInterfacesTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyRIPInterfacesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ripInterfacesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify RIPInterfaces Disabled Table Action failed: " + ripInterfacesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify NetworkFilters Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "networkFiltersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyNetworkFiltersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("networkFiltersTableAction", networkFiltersTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyNetworkFiltersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + networkFiltersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify NetworkFilters Disabled Table Action failed: " + networkFiltersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify RouteMaps Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "routeMapsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyRouteMapsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("routeMapsTableAction", routeMapsTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyRouteMapsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + routeMapsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify RouteMaps Disabled Table Action failed: " + routeMapsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify StaticARP Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "staticARPTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyStaticARPDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("staticARPTableAction", staticARPTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer3TableActionHandler.verifyStaticARPTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + staticARPTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify StaticARP Disabled Table Action failed: " + staticARPTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getIpInterfacesTableAction() {
        return ipInterfacesTableAction;
    }

    public void setIpInterfacesTableAction(BaseTableActions ipInterfacesTableAction) {
        this.ipInterfacesTableAction = ipInterfacesTableAction;
    }

    public BaseTableActions getGatewaysTableAction() {
        return gatewaysTableAction;
    }

    public void setGatewaysTableAction(BaseTableActions gatewaysTableAction) {
        this.gatewaysTableAction = gatewaysTableAction;
    }

    public ViewBaseTableActions getStaticRoutesTableAction() {
        return staticRoutesTableAction;
    }

    public void setStaticRoutesTableAction(ViewBaseTableActions staticRoutesTableAction) {
        this.staticRoutesTableAction = staticRoutesTableAction;
    }

    public BaseTableActions getPeersTableAction() {
        return peersTableAction;
    }

    public void setPeersTableAction(BaseTableActions peersTableAction) {
        this.peersTableAction = peersTableAction;
    }

    public BaseTableActions getAggregationsTableAction() {
        return aggregationsTableAction;
    }

    public void setAggregationsTableAction(BaseTableActions aggregationsTableAction) {
        this.aggregationsTableAction = aggregationsTableAction;
    }

    public BaseTableActions getOspfAreasTableAction() {
        return ospfAreasTableAction;
    }

    public void setOspfAreasTableAction(BaseTableActions ospfAreasTableAction) {
        this.ospfAreasTableAction = ospfAreasTableAction;
    }

    public BaseTableActions getOspfInterfacesTableAction() {
        return ospfInterfacesTableAction;
    }

    public void setOspfInterfacesTableAction(BaseTableActions ospfInterfacesTableAction) {
        this.ospfInterfacesTableAction = ospfInterfacesTableAction;
    }

    public BaseTableActions getOspfHostsTableAction() {
        return ospfHostsTableAction;
    }

    public void setOspfHostsTableAction(BaseTableActions ospfHostsTableAction) {
        this.ospfHostsTableAction = ospfHostsTableAction;
    }

    public EditDeleteTableActions getOspfVirtualLinksTableAction() {
        return ospfVirtualLinksTableAction;
    }

    public void setOspfVirtualLinksTableAction(EditDeleteTableActions ospfVirtualLinksTableAction) {
        this.ospfVirtualLinksTableAction = ospfVirtualLinksTableAction;
    }

    public BaseTableActions getOspfSummaryRangesTableAction() {
        return ospfSummaryRangesTableAction;
    }

    public void setOspfSummaryRangesTableAction(BaseTableActions ospfSummaryRangesTableAction) {
        this.ospfSummaryRangesTableAction = ospfSummaryRangesTableAction;
    }

    public BaseTableActions getOspfMD5KeyTableAction() {
        return ospfMD5KeyTableAction;
    }

    public void setOspfMD5KeyTableAction(BaseTableActions ospfMD5KeyTableAction) {
        this.ospfMD5KeyTableAction = ospfMD5KeyTableAction;
    }

    public BaseTableActions getOspfV3AreasTableAction() {
        return ospfV3AreasTableAction;
    }

    public void setOspfV3AreasTableAction(BaseTableActions ospfV3AreasTableAction) {
        this.ospfV3AreasTableAction = ospfV3AreasTableAction;
    }

    public BaseTableActions getOspfV3InterfacesTableAction() {
        return ospfV3InterfacesTableAction;
    }

    public void setOspfV3InterfacesTableAction(BaseTableActions ospfV3InterfacesTableAction) {
        this.ospfV3InterfacesTableAction = ospfV3InterfacesTableAction;
    }

    public BaseTableActions getOspfV3HostsTableAction() {
        return ospfV3HostsTableAction;
    }

    public void setOspfV3HostsTableAction(BaseTableActions ospfV3HostsTableAction) {
        this.ospfV3HostsTableAction = ospfV3HostsTableAction;
    }

    public EditDeleteTableActions getOspfV3VirtualLinksTableAction() {
        return ospfV3VirtualLinksTableAction;
    }

    public void setOspfV3VirtualLinksTableAction(EditDeleteTableActions ospfV3VirtualLinksTableAction) {
        this.ospfV3VirtualLinksTableAction = ospfV3VirtualLinksTableAction;
    }

    public BaseTableActions getOspfV3SummaryRangesTableAction() {
        return ospfV3SummaryRangesTableAction;
    }

    public void setOspfV3SummaryRangesTableAction(BaseTableActions ospfV3SummaryRangesTableAction) {
        this.ospfV3SummaryRangesTableAction = ospfV3SummaryRangesTableAction;
    }

    public BaseTableActions getNetworkFiltersTableAction() {
        return networkFiltersTableAction;
    }

    public void setNetworkFiltersTableAction(BaseTableActions networkFiltersTableAction) {
        this.networkFiltersTableAction = networkFiltersTableAction;
    }

    public BaseTableActions getRouteMapsTableAction() {
        return routeMapsTableAction;
    }

    public void setRouteMapsTableAction(BaseTableActions routeMapsTableAction) {
        this.routeMapsTableAction = routeMapsTableAction;
    }

    public BaseTableActions getStaticARPTableAction() {
        return staticARPTableAction;
    }

    public void setStaticARPTableAction(BaseTableActions staticARPTableAction) {
        this.staticARPTableAction = staticARPTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

}
