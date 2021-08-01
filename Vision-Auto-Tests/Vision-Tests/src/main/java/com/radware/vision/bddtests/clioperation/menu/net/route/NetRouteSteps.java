package com.radware.vision.bddtests.clioperation.menu.net.route;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.net.Ip;
import com.radware.vision.net.Route;
import com.radware.vision.vision_project_cli.menu.Menu;
import cucumber.api.java.en.When;


public class NetRouteSteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();

    /**
     * Run net route test for port G2 and G3
     */
    @When("^CLI Net Route Get$")
    public void netRouteGet() {
        try {
            afterMethod();
            String commandToExecute = "net route delete 8.8.8.0 255.255.255.0 172.17.1.2";
            String[] interfaces = new String[]{"G3", "G2"};
            for (String iface : interfaces) {
                Ip.setNetIp("4.4.4.0", "255.255.255.0", iface, radwareServerCli);
                Route.getRouteTable("4.4.4.0", "255.255.255.0", null, iface, radwareServerCli);
                Route.getRouteTable("0.0.0.0", null, "172.17.1.1", null, radwareServerCli);
                Route.setNewNetRoute("8.8.8.0", "255.255.255.0", "172.17.1.2", "G3", radwareServerCli);
                Route.getRouteTable("8.8.8.0", "255.255.255.0", "172.17.1.2", null, radwareServerCli);
                Route.setRouteHost("23.23.23.23", "4.4.4.2", "G3", radwareServerCli);
                Route.getRouteTable("23.23.23.23", null, "4.4.4.2", null, radwareServerCli);
                Route.verifyRouteTableWithRootUser(radwareServerCli, rootServerCli);
                Route.routeDelete("8.8.8.0", "255.255.255.0", "172.17.1.2", null, radwareServerCli);
                Route.routeDelete("23.23.23.23", "255.255.255.255", "4.4.4.2", null, radwareServerCli);
                Ip.ipDelete(iface, radwareServerCli);
                Route.verifyRouteTableWithRootUser(radwareServerCli, rootServerCli);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }


    /**
     * Set new net ip for G3
     * Set new net route address
     * Verify route set
     * <p>
     * Set new net ip for G2
     * Set new net route address
     * Verify route set
     *
     * @
     */
    @When("^CLI Net Route Set Net$")
    public void routeSetNet() {
        try {
            afterMethod();
            String[] interfaces = new String[]{"G3", "G2"};
            for (String iface : interfaces) {
                Ip.setNetIp("4.4.4.4", "255.255.255.0", iface, radwareServerCli);
                Route.setNewNetRoute("8.8.8.0", "255.255.255.0", "4.4.4.2", null, radwareServerCli);
                Route.getRouteTable("8.8.8.0", "255.255.255.0", "4.4.4.2", null, radwareServerCli);
                Route.routeDelete("8.8.8.0", "255.255.255.0", "4.4.4.2 ", null, radwareServerCli);
            }
            afterMethod();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Set new net ip for G3
     * Set route host for 23.23.23.23
     * Verify line with destination 23.23.23.23.23 appears
     */
    @When("^CLI Net Route Set Host$")
    public void routeSetHost() {
        try {
            afterMethod();
            Ip.setNetIp("4.4.4.0", "255.255.255.0", "G3", radwareServerCli);
            Route.setRouteHost("23.23.23.23", "4.4.4.3", null, radwareServerCli);
            Route.getRouteTable("23.23.23.23", null, "4.4.4.3", null, radwareServerCli);
            afterMethod();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Test ' net route set ' cmd sub menu
     *
     * @
     */
    @When("^CLI Route Set Sub Menu Test$")
    public void routeSetSubMenuTest() {
        try {
            CliOperations.checkSubMenu(radwareServerCli, Menu.net().route().set().build(), Route.NET_ROUTE_SET_SUB_MENU);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);

        }
    }

    /**
     * Test ' net route ' cmd sub menu
     *
     * @
     */
    @When("^CLI Route Sub Menu Test$")
    public void routeSubMenuTest() {
        try {
            CliOperations.checkSubMenu(radwareServerCli, Menu.net().route().build(), Route.NET_ROUTE_SUB_MENU);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Delete the route ip and after check this with the list
     */
    @When("^CLI Net Route Delete$")
    public void netRouteDelete() {
        try {
            afterMethod();
            String[] interfaces = new String[]{"G2", "G3"};
            for (String iface : interfaces) {

                Ip.setNetIp("4.4.4.4", "255.255.255.0", iface, radwareServerCli);

                Route.setNewNetRoute("7.7.7.0", "255.255.255.0", "4.4.4.1", iface, radwareServerCli);

                Route.getRouteTable("7.7.7.0", "255.255.255.0", "4.4.4.1", iface, radwareServerCli);

                Route.routeDelete("7.7.7.0", "255.255.255.0", "4.4.4.1", iface, radwareServerCli);

                Route.getRouteTableNotExist("7.7.7.0", "255.255.255.0", "4.4.4.1", iface, radwareServerCli);

                Route.setRouteHost("23.23.23.23", "4.4.4.3", iface, radwareServerCli);

                Route.getRouteTable("23.23.23.23", "255.255.255.255", "4.4.4.3", iface, radwareServerCli);

                Route.routeDelete("23.23.23.23", "255.255.255.255", "4.4.4.3", iface, radwareServerCli);

                Route.getRouteTableNotExist("23.23.23.23", "255.255.255.255", "4.4.4.3", iface, radwareServerCli);

                Route.verifyRouteTableWithRootUser(radwareServerCli, rootServerCli);
            }
            afterMethod();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }


    public void afterMethod() {
        try {
            Ip.ipDelete("G2", radwareServerCli);
            Ip.ipDelete("G3", radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }


}
