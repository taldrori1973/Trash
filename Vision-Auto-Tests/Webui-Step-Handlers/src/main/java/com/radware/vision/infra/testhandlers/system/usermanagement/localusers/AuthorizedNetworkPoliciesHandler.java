package com.radware.vision.infra.testhandlers.system.usermanagement.localusers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.system.usermanagement.localusers.AuthorizedNetworkPolicies;
import com.radware.vision.infra.base.pages.system.usermanagement.localusers.User;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by stanislava on 1/18/2015.
 */
public class AuthorizedNetworkPoliciesHandler {

    public static List<String> availableNetworkPolicies = new ArrayList<String>();
    public static List<String> availableDevices = new ArrayList<String>();
    public static List<String> selectedNetworkPolicies = new ArrayList<String>();
    public static List<String> selectedDevices = new ArrayList<String>();

    public static boolean validateAuthorizedNetworkPolicies(String username) {
        boolean isValid = false;
        User user = openAuthorizedNetworkPoliciesView(username);
        AuthorizedNetworkPolicies authorizedNetworkPolicies = new AuthorizedNetworkPolicies();
        BasicOperationsHandler.delay(2);
        isValid = authorizedNetworkPolicies.validateNetworkPoliciesDualList();
        WebUIVisionBasePage.cancel();
        return isValid;
    }

    public static void addRemoveAuthorizedNetworkPolicies(String username, String addNetworkPolicies, String removeNetworkPolicies) {

        User newUser = openAuthorizedNetworkPoliciesView(username);
        AuthorizedNetworkPolicies authorizedNetworkPolicies = new AuthorizedNetworkPolicies();
        BasicOperationsHandler.delay(2);
        if (addNetworkPolicies != null && !addNetworkPolicies.trim().equals("")) {
            selectNetworkPolices(addNetworkPolicies, authorizedNetworkPolicies);
        }

        if (removeNetworkPolicies != null && !removeNetworkPolicies.trim().equals("")) {
            removeNetworkPolices(removeNetworkPolicies, authorizedNetworkPolicies);
        }

        BasicOperationsHandler.delay(2);

        String failedSelectedAdd = authorizedNetworkPolicies.validatePolicyExistenceSelectedList(availableDevices, availableNetworkPolicies, true);
        String failedAvailableAdd = authorizedNetworkPolicies.validatePolicyExistenceAvailableList(availableDevices, availableNetworkPolicies, false);
        if (!failedSelectedAdd.equals("") || !failedAvailableAdd.equals("")) {
            BaseTestUtils.report("Following policies are not as expected - exist/not exist in the selected/available lists: " + failedSelectedAdd + failedAvailableAdd + "\n.", Reporter.FAIL);
        }
        String failedSelectedRemove = authorizedNetworkPolicies.validatePolicyExistenceAvailableList(selectedDevices, selectedNetworkPolicies, true);
        String failedAvailableRemove = authorizedNetworkPolicies.validatePolicyExistenceSelectedList(selectedDevices, selectedNetworkPolicies, false);
        if (!failedSelectedRemove.equals("") || !failedAvailableRemove.equals("")) {
            BaseTestUtils.report("Following policies are not as expected - exist/not exist in the selected/available lists: " + failedSelectedRemove + failedAvailableRemove + "\n.", Reporter.FAIL);
        }
        WebUIVisionBasePage.submit();
    }

    public static User openAuthorizedNetworkPoliciesView(String username) {
        User user = LocalUsersHandler.getLocalUsers().editUser("User Name", username);
        //LocalUsersHandler.addPermissions(LocalUsersHandler.parsePermissions(permissions), newUser);
        return user;
    }

    public static void selectNetworkPolices(String addNetworkPolicies, AuthorizedNetworkPolicies authorizedNetworkPolicies) {
        setDevicePolicyPairsToAdd(addNetworkPolicies);
        if (availableDevices.size() > 0 && availableNetworkPolicies.size() > 0) {
            authorizedNetworkPolicies.addNetworkPoliciesMultiColumns(availableDevices, availableNetworkPolicies);
        }
    }

    public static void removeNetworkPolices(String removeNetworkPolicies, AuthorizedNetworkPolicies authorizedNetworkPolicies) {
        setDevicePolicyPairsToRemove(removeNetworkPolicies);
        if (selectedDevices.size() > 0 && selectedNetworkPolicies.size() > 0) {
            authorizedNetworkPolicies.removeNetworkPoliciesMultiColumns(selectedDevices, selectedNetworkPolicies);
        }
    }

    public static void setDevicePolicyPairsToAdd(String networkPoliciesList) {
        initPoliciesLists();
        List<String> networkPoliciesPairs = new ArrayList<String>();
        networkPoliciesPairs = Arrays.asList(networkPoliciesList.split("\\|"));
        List<String> pair = new ArrayList<String>();
        for (int i = 0; i < networkPoliciesPairs.size(); i++) {
            pair = Arrays.asList(networkPoliciesPairs.get(i).split("\\,"));
            availableDevices.add(i, pair.get(0));
            availableNetworkPolicies.add(i, pair.get(1));
        }
    }

    public static void initPoliciesLists() {
        availableNetworkPolicies.clear();
        availableDevices.clear();
        selectedNetworkPolicies.clear();
        selectedDevices.clear();
    }

    public static void setDevicePolicyPairsToRemove(String networkPoliciesList) {
        initPoliciesLists();
        List<String> networkPoliciesPairs = new ArrayList<String>();
        networkPoliciesPairs = Arrays.asList(networkPoliciesList.split("\\|"));
        List<String> pair = new ArrayList<String>();
        for (int i = 0; i < networkPoliciesPairs.size(); i++) {
            pair = Arrays.asList(networkPoliciesPairs.get(i).split("\\,"));
            selectedDevices.add(i, pair.get(0));
            selectedNetworkPolicies.add(i, pair.get(1));
        }
    }
}
