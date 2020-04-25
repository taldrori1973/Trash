package com.radware.vision.bddtests.clioperation.menu.net.physicalInterface;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.test_parameters.Duplex;
import com.radware.vision.test_parameters.OnOff;
import com.radware.vision.vision_handlers.common.InvokeCommon;
import com.radware.vision.vision_handlers.net.PhysicalInterface;
import com.radware.vision.vision_handlers.root.RootVerifications;
import com.radware.vision.vision_project_cli.menu.Menu;
import cucumber.api.java.en.When;

public class NetPhysicalInterfaceSteps extends BddCliTestBase {

    @When("^CLI Net Physical Interface Set$")
    public void netPhysicalInterfaceSet() throws Exception{
        try{
            PhysicalInterface.verifyPortsAppear(new String[]{"G1","G2","G3"}, restTestBase.getRadwareServerCli());
            PhysicalInterface.netPhysicalInterfaceSet("G2", 10, null, OnOff.OFF, restTestBase.getRadwareServerCli());
            PhysicalInterface.verifyPortParameters("G2", 10, null, OnOff.OFF, restTestBase.getRadwareServerCli());
            PhysicalInterface.netPhysicalInterfaceSet("G2", -1, Duplex.HALF, null, restTestBase.getRadwareServerCli());
            PhysicalInterface.verifyPortParameters("G2", -1, Duplex.HALF, null, restTestBase.getRadwareServerCli());
            PhysicalInterface.netPhysicalInterfaceSet("G3", 100, Duplex.HALF, OnOff.OFF, restTestBase.getRadwareServerCli());
            PhysicalInterface.verifyPortParameters("G3", 100, Duplex.HALF, OnOff.OFF, restTestBase.getRadwareServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Speed", "Speed: 10Mb/s", restTestBase.getRootServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Duplex", "Duplex: Half", restTestBase.getRootServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Auto-negotiation", "Auto-negotiation: off", restTestBase.getRootServerCli());
            PhysicalInterface.netPhysicalInterfaceSet("G2", -1, null, OnOff.ON, restTestBase.getRadwareServerCli());
            PhysicalInterface.netPhysicalInterfaceSet("G3", -1, null, OnOff.ON, restTestBase.getRadwareServerCli());
            PhysicalInterface.verifyPortParameters("G2", 1000, Duplex.FULL, OnOff.ON, restTestBase.getRadwareServerCli());
            PhysicalInterface.verifyPortParameters("G3", 1000, Duplex.FULL, OnOff.ON, restTestBase.getRadwareServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G3 | grep Speed", "Speed: 1000Mb/s", restTestBase.getRootServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G3 | grep Duplex", "Duplex: Full", restTestBase.getRootServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G3 | grep Auto-negotiation", "Auto-negotiation: on", restTestBase.getRootServerCli());
        }catch(Exception e){
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        cliAfterMethodMain();
    }

    @When("^CLI Net Physical Interface Sub Menu Test$")
    public void netPhysicalInterfaceSubMenuTest() throws Exception {
        InvokeCommon.checkSubMenu(restTestBase.getRadwareServerCli(), Menu.net().physicalInterface().build(), PhysicalInterface.NET_PHYSICAL_INTERFACE_SUB_MENU);
    }


    @When("^CLI Net Physical-Interface Get$")
    public void netPhysicalInterfaceGet() throws Exception {
        try{

            PhysicalInterface.verifyPortsAppear(new String[]{"G1","G2","G3"}, restTestBase.getRadwareServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Speed", "Speed: 10000Mb/s", restTestBase.getRootServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Duplex", "Duplex: Full", restTestBase.getRootServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Auto-negotiation", "Auto-negotiation: off", restTestBase.getRootServerCli());

        }catch(Exception e){
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        cliAfterMethodMain();

    }
}
