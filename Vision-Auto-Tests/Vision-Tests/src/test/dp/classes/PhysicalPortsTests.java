package com.radware.vision.tests.dp.classes;

import com.radware.automation.webui.webpages.dp.configuration.classes.physicalports.PhysicalPorts;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class PhysicalPortsTests extends DpTestBase{



	private String physicalPortsGroupName;
	private String inboundPort;
	
	@Test
    @TestProperties(name = "Create Physical Ports Class", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "physicalPortsGroupName", "inboundPort"})
    public void createPhysicalPortsClass() {
		PhysicalPorts pp = dpUtils.dpProduct.mConfiguration().mClasses().mPhysicalPorts();
		pp.openPage();
		pp.addPhysicalPort();
		pp.selectInboundPort(inboundPort);
		pp.setPhysicalPortsGroupName(physicalPortsGroupName);
		pp.submit();

	}

	
	@Test
    @TestProperties(name = "Delete PhysicalPorts Class", paramsInclude = {"qcTestId", "defenceProVersion", "deviceName", "physicalPortsGroupName"})
    public void deletePhysicalPortsClass() {
		
		PhysicalPorts pp = dpUtils.dpProduct.mConfiguration().mClasses().mPhysicalPorts();
		pp.openPage();
		pp.deletePhysicalPortByKeyValue("Physical Ports Group Name", physicalPortsGroupName);
	}

	
	public void setPhysicalPortsGroupName(String physicalPortsGroupName) {
		this.physicalPortsGroupName = physicalPortsGroupName;
	}
	public String getPhysicalPortsGroupName() {
		return physicalPortsGroupName;
	}
	public void setInboundPort(String inboundPort) {
		this.inboundPort = inboundPort;
	}
	public String getInboundPort() {
		return inboundPort;
	}
	
	
	
	
}
