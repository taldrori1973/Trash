package com.radware.vision.infra.base.pages.defensepro;

import com.radware.restcore.utils.enums.DeviceType;

public class DpClusterEntity {
	
	String lockState;
	DeviceType deviceType;
	String deviceName;
	String ipAddress;
	String lockedbyUser;
	HAStatus haStatus;
    DeviceStatus status;
	
	public DpClusterEntity(String lockState,
	DeviceType deviceType,
	String deviceName,
	String ipAddress,
	String lockedbyUser,
    HAStatus haStatus,
    DeviceStatus status)
	{
		this.lockState = lockState;
		this.deviceType = deviceType;
		this.deviceName = deviceName;
		this.ipAddress = ipAddress;
		this.lockedbyUser = lockedbyUser;
		this.haStatus = haStatus;
        this.status = status;
	}

	public String getLockState() {
		return lockState;
	}

	public void setLockState(String lockState) {
		this.lockState = lockState;
	}

	public DeviceType getDeviceType() {
		return deviceType;
	}

	public void setDeviceType(DeviceType deviceType) {
		this.deviceType = deviceType;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public String getLockedbyUser() {
		return lockedbyUser;
	}

	public void setLockedbyUser(String lockedbyUser) {
		this.lockedbyUser = lockedbyUser;
	}

	public HAStatus getHaStatus() {
		return haStatus;
	}

	public void setHaStatus(HAStatus haStatus) {
		this.haStatus = haStatus;
	}

    public DeviceStatus getStatus() {
        return status;
    }

    public void setStatus(DeviceStatus status) {
        this.status = status;
    }
}
