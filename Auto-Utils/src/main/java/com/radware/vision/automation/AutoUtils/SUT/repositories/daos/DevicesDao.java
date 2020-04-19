package com.radware.vision.automation.AutoUtils.SUT.repositories.daos;

import com.radware.vision.automation.AutoUtils.SUT.enums.DeviceType;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.DevicesPojo;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.automation.AutoUtils.utils.JsonUtilities;
import com.radware.vision.automation.AutoUtils.utils.RuntimeVMOptions;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

public class DevicesDao {

    private static final String SUT_DEVICES_FILES_PATH_PROPERTY = "SUT.devices.path";
    private static final String DEVICES_FILE_NAME = "devices.json";

    private static DevicesDao _instance = new DevicesDao();
    private DevicesPojo devices;


    public DevicesDao() {
        ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();
        RuntimeVMOptions runtimeVMOptions = new RuntimeVMOptions();
        this.devices = JsonUtilities.loadJsonFile(
                runtimeVMOptions.getResourcesPath(
                        String.format("%s/%s", applicationPropertiesUtils.getProperty(SUT_DEVICES_FILES_PATH_PROPERTY), DEVICES_FILE_NAME)
                ),
                DevicesPojo.class
        );


    }

    public static DevicesDao get_instance() {
        return _instance;
    }


    //    DAO
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


    public List<Device> findAllDevices() {

        List<Device> allDevices = new ArrayList<>();
        allDevices.addAll(devices.getTreeDevices().getAlteons());
        allDevices.addAll(devices.getTreeDevices().getLinkProofs());
        allDevices.addAll(devices.getTreeDevices().getDefensePros());
        allDevices.addAll(devices.getTreeDevices().getAppWalls());
        return allDevices;
    }

}
