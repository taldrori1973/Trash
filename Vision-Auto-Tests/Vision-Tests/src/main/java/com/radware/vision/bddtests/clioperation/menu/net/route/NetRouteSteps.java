package com.radware.vision.bddtests.clioperation.menu.net.route;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.vision_handlers.common.InvokeCommon;
import com.radware.vision.vision_handlers.net.Ip;
import com.radware.vision.vision_handlers.net.Route;
import com.radware.vision.vision_project_cli.menu.Menu;
import cucumber.api.java.en.When;


public class NetRouteSteps extends BddCliTestBase {

    /**
     * Run net route test for port G2 and G3
     */
    @When("^CLI Net Route Get$")
    public void netRouteGet() {
        try {
            afterMethod();
            String commandToExecute = "net route delete 8.8.8.0 255.255.255.0 172.17.1.2";
            CliOperations.runCommand(restTestBase.getRadwareServerCli(), commandToExecute);
            commandToExecute = "net route delete 23.23.23.23 255.255.255.0 4.4.4.2";
            CliOperations.runCommand(restTestBase.getRadwareServerCli(), commandToExecute);
            String[] interfaces = new String[]{"G3", "G2"};
            for (String iface : interfaces) {
                Ip.setNetIp("4.4.4.0", "255.255.255.0", iface, restTestBase.getRadwareServerCli());
                Route.getRouteTable("4.4.4.0", "255.255.255.0", null, iface, restTestBase.getRadwareServerCli());
                Route.getRouteTable("0.0.0.0", null, "172.17.1.1", null, restTestBase.getRadwareServerCli());
                Route.setNewNetRoute("8.8.8.0", "255.255.255.0", "172.17.1.2", null, restTestBase.getRadwareServerCli());
                Route.getRouteTable("8.8.8.0", "255.255.255.0", "172.17.1.2", null, restTestBase.getRadwareServerCli());
                Route.setRouteHost("23.23.23.23", "4.4.4.2", null, restTestBase.getRadwareServerCli());
                Route.getRouteTable("23.23.23.23", null, "4.4.4.2", null, restTestBase.getRadwareServerCli());
                Route.verifyRouteTableWithRootUser(restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
                Route.routeDelete("8.8.8.0", "255.255.255.0", "172.17.1.2", null, restTestBase.getRadwareServerCli());
                Route.routeDelete("23.23.23.23", "255.255.255.255", "4.4.4.2", null, restTestBase.getRadwareServerCli());
                Ip.ipDelete(iface, restTestBase.getRadwareServerCli());
                Route.verifyRouteTableWithRootUser(restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
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
     * @throws Exception
     */
    @When("^CLI Net Route Set Net$")
    public void routeSetNet() throws Exception {
        afterMethod();
        String[] interfaces = new String[]{"G3", "G2"};
        for (String iface : interfaces) {
            Ip.setNetIp("4.4.4.4", "255.255.255.0", iface, restTestBase.getRadwareServerCli());
            Route.setNewNetRoute("8.8.8.0", "255.255.255.0", "4.4.4.2", null, restTestBase.getRadwareServerCli());
            Route.getRouteTable("8.8.8.0", "255.255.255.0", "4.4.4.2", null, restTestBase.getRadwareServerCli());
            Route.routeDelete("8.8.8.0", "255.255.255.0", "4.4.4.2 ", null, restTestBase.getRadwareServerCli());
        }
        afterMethod();
    }

    /**
     * Set new net ip for G3
     * Set route host for 23.23.23.23
     * Verify line with destination 23.23.23.23.23 appears
     */
    @When("^CLI Net Route Set Host$")
    public void routeSetHost() throws Exception {
        afterMethod();
        Ip.setNetIp("4.4.4.0", "255.255.255.0", "G3", restTestBase.getRadwareServerCli());
        Route.setRouteHost("23.23.23.23", "4.4.4.3", null, restTestBase.getRadwareServerCli());
        Route.getRouteTable("23.23.23.23", null, "4.4.4.3", null, restTestBase.getRadwareServerCli());
        afterMethod();
    }

    /**
     * Test ' net route set ' cmd sub menu
     *
     * @throws Exception
     */
    @When("^CLI Route Set Sub Menu Test$")
    public void routeSetSubMenuTest() throws Exception {

        InvokeCommon.checkSubMenu(restTestBase.getRadwareServerCli(), Menu.net().route().set().build(), Route.NET_ROUTE_SET_SUB_MENU);
    }

    /**
     * Test ' net route ' cmd sub menu
     *
     * @throws Exception
     */
    @When("^CLI Route Sub Menu Test$")
    public void routeSubMenuTest() throws Exception {

        InvokeCommon.checkSubMenu(restTestBase.getRadwareServerCli(), Menu.net().route().build(), Route.NET_ROUTE_SUB_MENU);
    }

    /**
     * Delete the route ip and after check this with the list
     */
    @When("^CLI Net Route Delete$")
    public void netRouteDelete() throws Exception {
        afterMethod();
        String[] interfaces = new String[]{"G2", "G3"};
        for (String iface : interfaces) {

            Ip.setNetIp("4.4.4.4", "255.255.255.0", iface, restTestBase.getRadwareServerCli());

            Route.setNewNetRoute("7.7.7.0", "255.255.255.0", "4.4.4.1", iface, restTestBase.getRadwareServerCli());

            Route.getRouteTable("7.7.7.0", "255.255.255.0", "4.4.4.1", iface, restTestBase.getRadwareServerCli());

            Route.routeDelete("7.7.7.0", "255.255.255.0", "4.4.4.1", iface, restTestBase.getRadwareServerCli());

            Route.getRouteTableNotExist("7.7.7.0", "255.255.255.0", "4.4.4.1", iface, restTestBase.getRadwareServerCli());

            Route.setRouteHost("23.23.23.23", "4.4.4.3", iface, restTestBase.getRadwareServerCli());

            Route.getRouteTable("23.23.23.23", "255.255.255.255", "4.4.4.3", iface, restTestBase.getRadwareServerCli());

            Route.routeDelete("23.23.23.23", "255.255.255.255", "4.4.4.3", iface, restTestBase.getRadwareServerCli());

            Route.getRouteTableNotExist("23.23.23.23", "255.255.255.255", "4.4.4.3", iface, restTestBase.getRadwareServerCli());

            Route.verifyRouteTableWithRootUser(restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
        }
        afterMethod();

    }


    public void afterMethod() {
        try {
            Ip.ipDelete("G2", restTestBase.getRadwareServerCli());
            Ip.ipDelete("G3", restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }


}
