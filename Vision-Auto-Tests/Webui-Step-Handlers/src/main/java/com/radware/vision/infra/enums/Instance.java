package com.radware.vision.infra.enums;

public enum Instance {
	ZERO("0"),
	ONE("1");
	
	private String instance;
	
	private Instance(String instance) {
		this.instance = instance;
	}
	
	public String getInstance() {
		return this.instance;
	}
}
