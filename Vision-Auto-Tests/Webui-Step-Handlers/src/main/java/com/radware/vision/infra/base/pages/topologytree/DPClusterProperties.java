package com.radware.vision.infra.base.pages.topologytree;

import org.openqa.selenium.support.How;

import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.ClusterAssociatedMgmtPorts;

public class DPClusterProperties extends WebUIVisionBasePage {
	
	final String createDPClusterButton = "gwt-debug-ClusterDPs";
	final String breakDPClusterButton = "gwt-debug-BreakClusterDPs";
	
	final String fieldClusterName = "Cluster Name";
	final String fieldPrimaryDevice = "Primary Device";
	final String fieldAssciatedManagementPorts= "Associated Management Ports";
	
	
	public DPClusterProperties() {
		super("Device Properties", "Device.CreateHAPair.xml", false);
		setPageLocatorHow(How.ID);
		setPageLocatorContent(createDPClusterButton);
	}
	
	public void setClusterName(String name) {
		WebUITextField dpClusterName = (WebUITextField)container.getTextField(fieldClusterName);
		dpClusterName.type(name);
	}
	
	public void setPrimaryDevice(String primaryDeviceName) {
		WebUIDropdown dpClusterPrimaryDevice = (WebUIDropdown)container.getDropdown(fieldPrimaryDevice);
		dpClusterPrimaryDevice.selectOptionByText(primaryDeviceName);
	}
	
	public void setAssociatedMgmtPort(ClusterAssociatedMgmtPorts mgmtPort) {
		WebUIDropdown dpClusterMgmtPort = (WebUIDropdown)container.getDropdown(fieldAssciatedManagementPorts);
		dpClusterMgmtPort.selectOptionByText(mgmtPort.getPort());
	}
	
	public void openCreateClusterDialog() {
		setPageLocatorContent(createDPClusterButton);
		openPage();
	}
	
	public void openBreakClusterDialog() {
		setPageLocatorContent(breakDPClusterButton);
		openPage();
	}
}
