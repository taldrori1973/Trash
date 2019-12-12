package com.radware.vision.infra.enums;

public enum DeviceStatusEnum {
	
	UP("Up"),
	DOWN("Down"),
	UP_OR_MAINTENANCE("Up or Maintenance"),
	OFFLINE("Offline"),
	UNKNOWN("Unknown"),
	MAINTENANCE("Maintenance");
	
	String deviceStatus;
	
	private DeviceStatusEnum(String deviceStatus) {
		this.deviceStatus = deviceStatus;
	}
	
	public String getStatus() {
		return this.deviceStatus;
	}

	public static DeviceStatusEnum getDeviceStatusEnum(String deviceStatus){
		switch (deviceStatus){
			case "Up":
				return UP;
			case "Down":
				return DOWN;
			case "Up or Maintenance":
				return UP_OR_MAINTENANCE;
			case "Offline":
				return OFFLINE;
			case "Unknown":
				return UNKNOWN;
			case "Maintenance":
				return MAINTENANCE;
		}
		return null;
	}
}
