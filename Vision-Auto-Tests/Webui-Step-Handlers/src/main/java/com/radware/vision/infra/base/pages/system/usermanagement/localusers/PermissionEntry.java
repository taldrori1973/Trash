package com.radware.vision.infra.base.pages.system.usermanagement.localusers;

public class PermissionEntry {
	
	String role;
	String scope;
	
	public PermissionEntry(String role, String scope) {
		setRole(role);
		setScope(scope);
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getScope() {
		return scope;
	}

	public void setScope(String scope) {
		this.scope = scope;
	}
}
