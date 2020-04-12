package com.radware.vision.automation.AutoUtils.SUT.repositories;

import com.radware.vision.automation.AutoUtils.SUT.DeviceType;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Devices;

import java.util.Collections;
import java.util.List;

public class DevicesRepository {

    private Devices devices;

    public List<Device> findDevicesByType(DeviceType deviceType) {
        switch (deviceType) {
            case ALTEON:
                return devices.getTreeDevices().getAlteons();
            case LINK_PROOF:
                return devices.getTreeDevices().getLinkProofs()
            case DEFENSE_PRO:
                return devices.getTreeDevices().getDefensePros();
            case APPWALL:
                return devices.getTreeDevices().getAppWalls();
            default:
                return Collections.EMPTY_LIST;
        }
    }


}
