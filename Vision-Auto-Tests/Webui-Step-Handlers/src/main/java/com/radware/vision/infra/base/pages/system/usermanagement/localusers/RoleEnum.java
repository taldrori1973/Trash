package com.radware.vision.infra.base.pages.system.usermanagement.localusers;

public enum RoleEnum {
	ADC_ADMINISTRATOR("ADC Administrator"),
	ADC_OPERATOR("ADC Operator"),
	ADC_Certificate_Administrator("ADC+Certificate Administrator"),
	ADMINISTRATOR("Administrtaor"),
	CERTIFICATE_ADMINISTRATOR("Certificate Administrator"),
	DEVICE_ADMINISTRATOR("Device Administrator"),
	DEVICE_CONFIGURATOR("Device Configurator"),
	DEVICE_OPERATOR("Device Operator"),
	DEVICE_VIEWER("Device Viewer"),
	SECURITY_ADMINISTRATOR("Security Administrator"),
	SECURITY_MONITOR("Security Monitor"),
	USER_ADMINISTRATOR("User Administrator"),
	VISION_ADMINISTRATOR("Vision Administrator"),
	VISION_REPORTER("Vision Reporter");
	
	private String roleName;
	
	private RoleEnum(String role) {
		this.roleName = role;
	}
	
	public String toString() {
		return this.roleName;
	}
}
