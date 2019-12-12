package com.radware.vision.infra.testhandlers.scheduledtasks.enums;

public enum TaskWeekdays {
	
	SUNDAY("Sunday"),
	MONDAY("Monday"),
	TUESDAY("Tuesday"),
	WEDNESDAY("Wednesday"),
	THURSDAY("Thursday"),
	FRIDAY("Friday"),
	SATURDAY("Saturday");
	
	String weekday;
	
	private TaskWeekdays(String weekday) {
		this.weekday = weekday;
	}
	
	public String getWeekday() {
		return this.weekday;
	}
}
