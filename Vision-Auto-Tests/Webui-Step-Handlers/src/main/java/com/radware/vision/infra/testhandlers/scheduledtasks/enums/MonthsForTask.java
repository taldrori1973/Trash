package com.radware.vision.infra.testhandlers.scheduledtasks.enums;

public enum MonthsForTask {
	
	January("January"),
	February("February"),
	March("March"),
	April("April"),
	May("May"),
	June("June"),
	July("July"),
	August("August"),
	September("September"),
	October("October"),
	November("November"),
	December("December");
	
	String month;
	
	private MonthsForTask(String month) {
		this.month = month;
	}
	
	public String getRunType() {
		return this.month;
	}
}
