package com.radware.vision.bddtests.clioperation.menu.net.physicalInterface;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.base.VisionCliTestBase;
import com.radware.vision.net.PhysicalInterface;
import com.radware.vision.root.RootVerifications;
import com.radware.vision.test_parameters.Duplex;
import com.radware.vision.test_parameters.OnOff;
import cucumber.api.java.en.When;

public class NetPhysicalInterfaceSteps extends VisionCliTestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
    
    @When("^CLI Net Physical Interface Set$")
    public void netPhysicalInterfaceSet() throws Exception{
        try{
            PhysicalInterface.verifyPortsAppear(new String[]{"G1","G2","G3"}, radwareServerCli);
            PhysicalInterface.netPhysicalInterfaceSet("G2", 10, null, OnOff.OFF, radwareServerCli);
            PhysicalInterface.verifyPortParameters("G2", 10, null, OnOff.OFF, radwareServerCli);
            PhysicalInterface.netPhysicalInterfaceSet("G2", -1, Duplex.HALF, null, radwareServerCli);
            PhysicalInterface.verifyPortParameters("G2", -1, Duplex.HALF, null, radwareServerCli);
            PhysicalInterface.netPhysicalInterfaceSet("G3", 100, Duplex.HALF, OnOff.OFF, radwareServerCli);
            PhysicalInterface.verifyPortParameters("G3", 100, Duplex.HALF, OnOff.OFF, radwareServerCli);
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Speed", "Speed: 10Mb/s", rootServerCli);
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Duplex", "Duplex: Half", rootServerCli);
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Auto-negotiation", "Auto-negotiation: off", rootServerCli);
            PhysicalInterface.netPhysicalInterfaceSet("G2", -1, null, OnOff.ON, radwareServerCli);
            PhysicalInterface.netPhysicalInterfaceSet("G3", -1, null, OnOff.ON, radwareServerCli);
            PhysicalInterface.verifyPortParameters("G2", 1000, Duplex.FULL, OnOff.ON, radwareServerCli);
            PhysicalInterface.verifyPortParameters("G3", 1000, Duplex.FULL, OnOff.ON, radwareServerCli);
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G3 | grep Speed", "Speed: 1000Mb/s", rootServerCli);
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G3 | grep Duplex", "Duplex: Full", rootServerCli);
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G3 | grep Auto-negotiation", "Auto-negotiation: on", rootServerCli);
        }catch(Exception e){
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    @When("^CLI Net Physical Interface Sub Menu Test$")
    public void netPhysicalInterfaceSubMenuTest() throws Exception {
        PhysicalInterface.netPhysicalInterfaceSubMenuTest(radwareServerCli);
    }


    @When("^CLI Net Physical-Interface Get$")
    public void netPhysicalInterfaceGet() throws Exception {
        try{

            PhysicalInterface.verifyPortsAppear(new String[]{"G1","G2","G3"}, radwareServerCli);
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Speed", "Speed: 10000Mb/s", rootServerCli);
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Duplex", "Duplex: Full", rootServerCli);
            RootVerifications.verifyLinuxOSParamsViaRootText("ethtool G2 | grep Auto-negotiation", "Auto-negotiation: off", rootServerCli);

        }catch(Exception e){
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();

    }
}
