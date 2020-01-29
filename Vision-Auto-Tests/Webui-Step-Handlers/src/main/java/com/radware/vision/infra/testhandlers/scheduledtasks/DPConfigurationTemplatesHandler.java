package com.radware.vision.infra.testhandlers.scheduledtasks;

import com.radware.vision.infra.enums.DualListTypeEnum;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.DestinationType;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 * Created by stanislava on 9/3/2015.
 */
public class DPConfigurationTemplatesHandler extends BaseTasksHandler {

    public static List<String> availablePolicies = new ArrayList<String>();
    public static List<String> availableDevices = new ArrayList<String>();
    public static List<String> selectedPolicies = new ArrayList<String>();
    public static List<String> selectedDevices = new ArrayList<String>();

    public static String networkPoliciesDualListId = "networkPolicies";
    public static String serverPoliciesDualListId = "serverPolicies";

    public static void deleteTask(String columnName, String taskName) throws Exception {
        deleteBaseTask(columnName, taskName);
    }

    public static void addTask(HashMap<String, String> taskProperties) throws Exception {
        beforeAddTask(taskProperties);
        List<String> deviceDestinationsList = new ArrayList<String>();

        if(taskProperties.get("networkProtectionPolicies") != null && !taskProperties.get("networkProtectionPolicies").equals("")){
            setDevicePolicyPairsToAdd(taskProperties.get("networkProtectionPolicies"));
            if(availableDevices.size() > 0 && availablePolicies.size() > 0){
                taskEntity.getNetworkProtectionPolicies().addNetworkProtectionPolicies(availableDevices, availablePolicies, networkPoliciesDualListId);
            }
        }

        if(taskProperties.get("networkProtectionConfiguration") != null) {
            taskEntity.getNetworkProtectionPolicies().setConfiguration(Boolean.valueOf(taskProperties.get("networkProtectionConfiguration")));
        }
        if(taskProperties.get("networkProtectionBdosBaseline") != null) {
            taskEntity.getNetworkProtectionPolicies().setBdosBaseline(Boolean.valueOf(taskProperties.get("networkProtectionBdosBaseline")));
        }
        if(taskProperties.get("networkProtectionDnsBaseline") != null) {
            taskEntity.getNetworkProtectionPolicies().setDnsBaseline(Boolean.valueOf(taskProperties.get("networkProtectionDnsBaseline")));
        }
        //====================================
        if(taskProperties.get("serverProtectionPolicies") != null && !taskProperties.get("serverProtectionPolicies").equals("")){
            setDevicePolicyPairsToAdd(taskProperties.get("serverProtectionPolicies"));

            if(availableDevices.size() > 0 && availablePolicies.size() > 0){
                taskEntity.getServerProtectionPolicies().addServerProtectionPolicies(availableDevices, availablePolicies, serverPoliciesDualListId);
            }
        }
        if(taskProperties.get("serverProtectionConfiguration") != null) {
            taskEntity.getServerProtectionPolicies().setConfiguration(Boolean.valueOf(taskProperties.get("serverProtectionConfiguration")));
        }
        if(taskProperties.get("serverProtectionHttpBaseline") != null) {
            taskEntity.getServerProtectionPolicies().setHttpBaseline(Boolean.valueOf(taskProperties.get("serverProtectionHttpBaseline")));
        }

        if (taskProperties.get("deviceDestinations") != null) {
            deviceDestinationsList = Arrays.asList(taskProperties.get("deviceDestinations").split(","));
            taskEntity.getDestination(DestinationType.DeviceList);
            taskEntity.addSelectedDevices(DualListTypeEnum.SCHEDULE_TASKS_DEVICES, deviceDestinationsList);
            if(taskProperties.get("updateMethod") != null){
                taskEntity.setUpdateMethod(taskProperties.get("updateMethod"));
            }
            if(taskProperties.get("updatePoliciesAfterSendingConfiguration") != null){
                taskEntity.setUpdatePolicies(Boolean.valueOf(taskProperties.get("updatePoliciesAfterSendingConfiguration")));
            }
        }

        if (taskProperties.get("groupDestinations") != null) {
            deviceDestinationsList = Arrays.asList(taskProperties.get("groupDestinations").split(","));
            taskEntity.getDestination(DestinationType.DeviceList);
            taskEntity.addSelectedDevices(DualListTypeEnum.SCHEDULE_TASKS_GROUPS, deviceDestinationsList);
        }

        //setBaseTask(taskProperties);    // Work around to fix the scheduled time
        afterAddTask(taskProperties);
    }

    public static void editTask(HashMap<String, String> taskProperties) throws Exception {
        beforeEditTask(taskProperties);
        List<String> deviceDestinationsList = new ArrayList<String>();

        if(taskProperties.get("networkProtectionPoliciesToRemove") != null && !taskProperties.get("networkProtectionPoliciesToRemove").equals("")){
            setDevicePolicyPairsToAdd(taskProperties.get("networkProtectionPoliciesToRemove"));
            if(availableDevices.size() > 0 && availablePolicies.size() > 0){
                taskEntity.getNetworkProtectionPolicies().addNetworkProtectionPolicies(availableDevices, availablePolicies, networkPoliciesDualListId);
            }
        }

        if(taskProperties.get("networkProtectionPolicies") != null && !taskProperties.get("networkProtectionPolicies").equals("")){
            setDevicePolicyPairsToAdd(taskProperties.get("networkProtectionPolicies"));
            if(selectedDevices.size() > 0 && selectedPolicies.size() > 0){
                taskEntity.getNetworkProtectionPolicies().removeNetworkProtectionPolicies(selectedDevices, selectedPolicies, networkPoliciesDualListId);
            }
        }

        if(taskProperties.get("networkProtectionConfiguration") != null) {
            taskEntity.getNetworkProtectionPolicies().setConfiguration(Boolean.valueOf(taskProperties.get("networkProtectionConfiguration")));
        }
        if(taskProperties.get("networkProtectionBdosBaseline") != null) {
            taskEntity.getNetworkProtectionPolicies().setBdosBaseline(Boolean.valueOf(taskProperties.get("networkProtectionBdosBaseline")));
        }
        if(taskProperties.get("networkProtectionDnsBaseline") != null) {
            taskEntity.getNetworkProtectionPolicies().setDnsBaseline(Boolean.valueOf(taskProperties.get("networkProtectionDnsBaseline")));
        }
        //====================================
        if(taskProperties.get("serverProtectionPolicies") != null && !taskProperties.get("serverProtectionPolicies").equals("")){
            setDevicePolicyPairsToAdd(taskProperties.get("serverProtectionPolicies"));
            if(availableDevices.size() > 0 && availablePolicies.size() > 0){
                taskEntity.getServerProtectionPolicies().addServerProtectionPolicies(availableDevices, availablePolicies, serverPoliciesDualListId);
            }
        }

        if(taskProperties.get("serverProtectionPoliciesToRemove") != null && !taskProperties.get("serverProtectionPoliciesToRemove").equals("")){
            setDevicePolicyPairsToAdd(taskProperties.get("serverProtectionPoliciesToRemove"));
            if(selectedDevices.size() > 0 && selectedPolicies.size() > 0){
                taskEntity.getServerProtectionPolicies().addServerProtectionPolicies(selectedDevices, selectedPolicies, serverPoliciesDualListId);
            }
        }
        if(taskProperties.get("serverProtectionConfiguration") != null) {
            taskEntity.getServerProtectionPolicies().setConfiguration(Boolean.valueOf(taskProperties.get("serverProtectionConfiguration")));
        }
        if(taskProperties.get("serverProtectionHttpBaseline") != null) {
            taskEntity.getServerProtectionPolicies().setHttpBaseline(Boolean.valueOf(taskProperties.get("serverProtectionHttpBaseline")));
        }

        if (taskProperties.get("deviceDestinations") != null) {
            deviceDestinationsList = Arrays.asList(taskProperties.get("deviceDestinations").split(","));
            taskEntity.getDestination(DestinationType.DeviceList);
            taskEntity.addSelectedDevices(DualListTypeEnum.SCHEDULE_TASKS_DEVICES, deviceDestinationsList);
        }

        if (taskProperties.get("groupDestinations") != null) {
            deviceDestinationsList = Arrays.asList(taskProperties.get("groupDestinations").split(","));
            taskEntity.getDestination(DestinationType.DeviceList);
            taskEntity.addSelectedDevices(DualListTypeEnum.SCHEDULE_TASKS_GROUPS, deviceDestinationsList);
        }

        afterEditTask();
    }

    public static void initPoliciesLists() {
        availablePolicies.clear();
        availableDevices.clear();
        selectedDevices.clear();
        selectedPolicies.clear();

    }

    public static void setDevicePolicyPairsToAdd(String networkPoliciesList) {
        setDevicePolicyPairs(networkPoliciesList, true);
    }

    public static void setDevicePolicyPairsToRemove(String networkPoliciesList) {
        setDevicePolicyPairs(networkPoliciesList, false);
    }

    private static void setDevicePolicyPairs(String networkPoliciesList, boolean toAdd) {
        initPoliciesLists();
        List<String> networkPoliciesPairs = new ArrayList<String>();
        networkPoliciesPairs = Arrays.asList(networkPoliciesList.split("\\|"));
        List<String> pair = new ArrayList<String>();
        for (int i = 0; i < networkPoliciesPairs.size(); i++) {
            pair = Arrays.asList(networkPoliciesPairs.get(i).split("\\,"));
            if (toAdd) {
                availablePolicies.add(i, pair.get(0));
                availablePolicies.add(i, pair.get(1));
            } else {
                selectedDevices.add(i, pair.get(0));
                selectedPolicies.add(i, pair.get(1));
            }
        }
    }
}
