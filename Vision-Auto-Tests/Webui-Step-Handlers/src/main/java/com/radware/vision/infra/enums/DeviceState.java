package com.radware.vision.infra.enums;

public enum DeviceState {
    Lock("lock"),
    UnLock("unlock");

    private String deviceState;
		
		private DeviceState(String deviceState) {
			this.deviceState = deviceState;
		}
		
		public String getDeviceState() {
			return this.deviceState;
		}

}
