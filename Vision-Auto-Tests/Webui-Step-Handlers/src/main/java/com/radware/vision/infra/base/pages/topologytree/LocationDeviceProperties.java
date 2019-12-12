package com.radware.vision.infra.base.pages.topologytree;

import com.radware.automation.webui.widgets.impl.WebUIDropdown;

public class LocationDeviceProperties extends DeviceProperties {
	
	public LocationDeviceProperties() {
		super("Device.ConnectionInfoWithLocation.xml");
	}
	
	public LocationDeviceProperties(String deviceDriverFilename) {
		super(deviceDriverFilename);
	}
	
	public void setLocation(String location) {
		WebUIDropdown locationCombo = (WebUIDropdown)container.getDropdown(locationComboName);
		locationCombo.selectOptionByText(location);
	}
}
