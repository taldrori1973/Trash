package com.radware.vision.automation.AutoUtils.SUT.repositories.daos;

import com.radware.vision.automation.AutoUtils.SUT.enums.DeviceType;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.DeviceConfiguration;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.DevicesPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.SimulatorPojo;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.automation.AutoUtils.utils.DevicesUtils;
import com.radware.vision.automation.AutoUtils.utils.JsonUtilities;
import com.radware.vision.automation.AutoUtils.utils.SystemProperties;

import java.util.*;

public class DevicesDao {

    private static final String SUT_DEVICES_FILES_PATH_PROPERTY = "SUT.devices.path";
    private static final String DEVICES_FILE_NAME = "devices.json";
    private static final String SIMULATORS_FILE_NAME = "simulators.json";

    private static DevicesDao _instance = new DevicesDao();
    private DevicesPojo devicesPojo;
    private SimulatorPojo simulatorPojo;
    private List<Device> allDevices;

    public DevicesDao() {
        ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();
        SystemProperties systemProperties = SystemProperties.get_instance();
        this.devicesPojo = JsonUtilities.loadJsonFile(
                systemProperties.getResourcesPath(
                        String.format("%s/%s", applicationPropertiesUtils.getProperty(SUT_DEVICES_FILES_PATH_PROPERTY), DEVICES_FILE_NAME)
                ),
                DevicesPojo.class
        );

        this.simulatorPojo = JsonUtilities.loadJsonFile(
                systemProperties.getResourcesPath(
                        String.format("%s/%s", applicationPropertiesUtils.getProperty(SUT_DEVICES_FILES_PATH_PROPERTY), SIMULATORS_FILE_NAME)
                ),
                SimulatorPojo.class
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

    public void addSimulatorsBySetId(String simSetId) {
        List<String> simulatorsIp = simulatorPojo.getSimulatorSets().entrySet().stream().filter(sim -> sim.getKey().equals(simSetId)).map(Map.Entry::getValue).findAny().get();
        simulatorsIp.forEach(simIP -> {
            Device simulator = new Device();
            simulator.setDeviceId("Alteon_" + "Fake_" + simulatorsIp.indexOf(simIP));
            simulator.setDeviceSetId("Alteon_" + "Sim_" + "Set_" + simulatorsIp.indexOf(simIP));
            DeviceConfiguration configurations = DevicesUtils.getDeviceConfigurationFromTemplate(simulatorPojo.getConfigurations());
            configurations.setName(simIP);
            configurations.getDeviceSetup().getDeviceAccess().setManagementIp(simIP);
            simulator.setConfigurations(configurations);
            allDevices.add(simulator);

        });
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
