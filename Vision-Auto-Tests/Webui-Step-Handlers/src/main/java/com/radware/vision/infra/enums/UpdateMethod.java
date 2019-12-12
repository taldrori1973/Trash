package com.radware.vision.infra.enums;

public enum UpdateMethod {
	OverwriteExisistingConfiguration("Overwrite Existing Configuration"),
	AppendToExistingConfiguration("Append to Existing Configuration");
	
	private String method;
	
	private UpdateMethod(String method) {
		this.method = method;
	}
	
	public String getUpdateMethod() {
		return this.method;
	}
}
