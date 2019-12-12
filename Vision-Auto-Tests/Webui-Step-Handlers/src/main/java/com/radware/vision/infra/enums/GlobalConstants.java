package com.radware.vision.infra.enums;

public enum GlobalConstants {
	
	CLIENT_DEVICE_DRIVERS_OUTPUT_FOLDER("/clientdevicedrivers/client/configuration/screens"),
	CLIENT_NAVIGATION_OUTPUT_FOLDER("/clientdevicedrivers/client"),
	CLIENT_SERVER_HIERARCHY_OUTPUT_FOLDER("/clientdevicedrivers/server");
	
	String value;
	
	GlobalConstants(String value) {
		this.value = value;
	}
	
	public String getValue() {
		return this.value;
	}
}
