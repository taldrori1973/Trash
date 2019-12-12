package com.radware.vision.infra.testhandlers.scheduledtasks.enums;

public enum ProtocolType {
	FTP("FTP"),
	SCP("SCP"),
	SFTP("SFTP"),
	SSH("SSH");
	
	String protocolType;
	
	private ProtocolType(String protocolType) {
		this.protocolType = protocolType;
	}
	
	public String getProtocolType() {
		return this.protocolType;
	}
}