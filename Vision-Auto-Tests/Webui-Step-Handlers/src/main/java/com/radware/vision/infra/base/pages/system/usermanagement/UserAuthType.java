package com.radware.vision.infra.base.pages.system.usermanagement;

public enum UserAuthType {
	
	RADIUS("RADIUS"),
	LOCAL("Local"),
	TACACS("TACACS");
	
	private UserAuthType(String authType) {
		this.authType = authType;
	}
	
	private String authType;

	public String getAuthType() {
		return authType;
	}
}
