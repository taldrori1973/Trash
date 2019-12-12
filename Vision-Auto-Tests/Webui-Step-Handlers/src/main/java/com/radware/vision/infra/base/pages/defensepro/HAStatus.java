package com.radware.vision.infra.base.pages.defensepro;

public enum HAStatus {
	Primary("Primary"),
	Secondary("Secondary");
	
	String haStatus;
	
	private HAStatus(String haStatus) {
		this.haStatus = haStatus;
	}
	
	public String getHaStatus() {
		return  this.haStatus;
	}
}
