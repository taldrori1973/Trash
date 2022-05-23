package com.radware.vision.automation.AutoUtils.SUT.repositories.daos;

import com.radware.vision.automation.AutoUtils.SUT.enums.DeviceType;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.*;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.automation.AutoUtils.utils.DevicesUtils;
import com.radware.vision.automation.AutoUtils.utils.JsonUtilities;
import com.radware.vision.automation.AutoUtils.utils.SystemProperties;

import java.util.*;
import java.util.stream.Collectors;

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
        allDevices.addAll(devicesPojo.getNonTreeDevices().getDefenseFlows());
        allDevices.addAll(devicesPojo.getNonTreeDevices().getFnms());
    }

    public static DevicesDao get_instance() {
        return _instance;
    }


    //    DAO
    public Optional<Device> findDeviceById(String deviceId) {
        return findAllDevices().stream().filter(device -> deviceId.equals(device.getDeviceId())).findFirst();

    }

    public void addSimulatorsBySetId(List<String> simSetId) {
        int alteonCounter = 0;
        int dpCounter = 0;
        for (String id : simSetId) {
            SimulatorSets simSet = simulatorPojo.getSimulators().getSimSets().stream().filter(sim -> sim.getId().equals(id)).findAny().get();
            for (String simIP : simSet.getIps()) {
                switch (simSet.getType()) {
                    case "alteon": {
                        Device simulator = new Device();
                        simulator.setDeviceId("Alteon_Fake_" + alteonCounter);
                        simulator.setDeviceSetId("Alteon_Sim_Set_" + alteonCounter);
                        DeviceConfiguration configurations = DevicesUtils.getDeviceConfigurationFromTemplate(simulatorPojo.getConfigurations());
                        configurations.setName(simIP);
                        configurations.setType("Alteon");
                        configurations.getDeviceSetup().getDeviceAccess().setManagementIp(simIP);
                        simulator.setConfigurations(configurations);
                        allDevices.add(simulator);
                        alteonCounter++;
                        break;
                    }
                    case "defensePro": {
                        Device simulator = new Device();
                        simulator.setDeviceId("DP_Fake_" + dpCounter);
                        simulator.setDeviceSetId("DP_Sim_Set_" + dpCounter);
                        DeviceConfiguration configurations = DevicesUtils.getDeviceConfigurationFromTemplate(simulatorPojo.getConfigurations());
                        configurations.setName(simIP);
                        configurations.setType("DefensePro");
                        configurations.getDeviceSetup().getDeviceAccess().setManagementIp(simIP);
                        simulator.setConfigurations(configurations);
                        allDevices.add(simulator);
                        dpCounter++;
                        break;
                    }
                }
            }
        }
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
