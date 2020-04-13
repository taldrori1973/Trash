package com.radware.vision.automation.AutoUtils.SUT.repositories;

import com.radware.vision.automation.AutoUtils.SUT.enums.DeviceType;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Devices;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

public class DevicesRepository {

    private Devices devices;

    public Optional<Device> findDeviceById(String deviceId) {

        Optional<Device> deviceFound = devices.getTreeDevices().getAppWalls().stream().filter(device -> deviceId.equals(device.getDeviceId())).findFirst();
        if (deviceFound.isPresent()) return deviceFound;

        deviceFound = devices.getTreeDevices().getDefensePros().stream().filter(device -> deviceId.equals(device.getDeviceId())).findFirst();
        if (deviceFound.isPresent()) return deviceFound;


        deviceFound = devices.getTreeDevices().getLinkProofs().stream().filter(device -> deviceId.equals(device.getDeviceId())).findFirst();
        if (deviceFound.isPresent()) return deviceFound;

        deviceFound = devices.getTreeDevices().getAlteons().stream().filter(device -> deviceId.equals(device.getDeviceId())).findFirst();
        if (deviceFound.isPresent()) return deviceFound;

        deviceFound = devices.getNonTreeDevices().getDefenseFlows().stream().filter(device -> deviceId.equals(device.getDeviceId())).findFirst();
        return deviceFound;

    }

    public List<Device> findDevicesByType(DeviceType deviceType) {
        switch (deviceType) {
            case ALTEON:
                return devices.getTreeDevices().getAlteons();
            case LINK_PROOF:
                return devices.getTreeDevices().getLinkProofs();
            case DEFENSE_PRO:
                return devices.getTreeDevices().getDefensePros();
            case APPWALL:
                return devices.getTreeDevices().getAppWalls();
            default:
                return Collections.EMPTY_LIST;
        }
    }


}
