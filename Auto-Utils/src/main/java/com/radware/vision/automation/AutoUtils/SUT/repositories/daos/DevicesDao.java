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
    private DevicesPojo devicesPojo;
    private List<Device> allDevices;

    public DevicesDao() {
        ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();
        RuntimeVMOptions runtimeVMOptions = new RuntimeVMOptions();
        this.devicesPojo = JsonUtilities.loadJsonFile(
                runtimeVMOptions.getResourcesPath(
                        String.format("%s/%s", applicationPropertiesUtils.getProperty(SUT_DEVICES_FILES_PATH_PROPERTY), DEVICES_FILE_NAME)
                ),
                DevicesPojo.class
        );

        loadAllDevices();


    }

    private void loadAllDevices() {
        this.allDevices = new ArrayList<>();
        allDevices.addAll(devicesPojo.getTreeDevices().getAlteons());
        allDevices.addAll(devicesPojo.getTreeDevices().getLinkProofs());
        allDevices.addAll(devicesPojo.getTreeDevices().getDefensePros());
        allDevices.addAll(devicesPojo.getTreeDevices().getAppWalls());
    }

    public static DevicesDao get_instance() {
        return _instance;
    }


    //    DAO
    public Optional<Device> findDeviceById(String deviceId) {

        return findAllDevices().stream().filter(device -> deviceId.equals(device.getDeviceId())).findFirst();

    }

    public List<Device> findDevicesByType(DeviceType deviceType) {
        switch (deviceType) {
            case ALTEON:
                return devicesPojo.getTreeDevices().getAlteons();
            case LINK_PROOF:
                return devicesPojo.getTreeDevices().getLinkProofs();
            case DEFENSE_PRO:
                return devicesPojo.getTreeDevices().getDefensePros();
            case APPWALL:
                return devicesPojo.getTreeDevices().getAppWalls();
            default:
                return Collections.EMPTY_LIST;
        }
    }


    public List<Device> findAllDevices() {

        return this.allDevices;
    }

}
