package com.radware.vision.infra.enums;

public enum ClusterAssociatedMgmtPorts {
	
	MNG1("MNG-1"),
	MNG2("MNG-2"),
	MNG1MNG2("MNG1+MNG2");
	
	String port = "";
	
	private ClusterAssociatedMgmtPorts(String port) {
		this.port = port;
	}
	
	public String getPort() {
		return this.port;
	}
}
