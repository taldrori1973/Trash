package com.radware.vision.infra.testhandlers.alteon.configuration.system.Users;


import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.system.users.localUsers.LocalUsers;
import com.radware.automation.webui.webpages.configuration.system.users.localUsers.LocalUsersEnums;
import com.radware.automation.webui.widgets.impl.table.WebUIRowValues;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;
import java.util.List;

public class LocalUsersHandler {

    public static boolean checkIfUserExist(int userName, String deviceName) throws Exception {
        LocalUsers localUsers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mUsers().mLocalUsers();
        TopologyTreeHandler.openDeviceSitesClusters(deviceName);
        localUsers.openPage();
        WebUITable localUserTable = localUsers.getTable();
        List<WebUIRowValues> tableRows = localUserTable.getAllRowItems();
        for (WebUIRowValues row : tableRows) {
            if (row.toString().contains(Integer.toString(userName))) {
                return true;
            }
        }
        WebUIUtils.generateAndReportScreeshort();
        return false;
    }

    public static void initLockDevice(HashMap<String, String> testProperties) {
        DeviceOperationsHandler.lockUnlockDevice(testProperties.get("deviceName"), testProperties.get("parentTree"), testProperties.get("deviceState"), false);
    }

    public static void changeLocalUserProperties(HashMap<String, String> testProperties) {
        LocalUsers localUsers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mUsers().mLocalUsers();
        initLockDevice(testProperties);
        localUsers.openPage();
        localUsers.setUserRole(LocalUsersEnums.UserRole.getEnum(testProperties.get("userRoles")));
        localUsers.setAuthAdminPass(testProperties.get("currentPassword"));
        localUsers.setNewPass("newPassword");
        localUsers.setConfirmNewPass("newPassword");
        localUsers.submit();
    }

    public static void addLocalUser(HashMap<String, String> testProperties, GeneralEnums.State userState) {
        LocalUsers localUsers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mUsers().mLocalUsers();
        initLockDevice(testProperties);
        localUsers.openPage();
        localUsers.addUser();
        localUsers.enableUser(userState);

        if (testProperties.get("userId") != null) {
            localUsers.setUserId(Integer.parseInt(testProperties.get("userId")));
        }

        if (testProperties.get("userName") != null) {
            localUsers.setUserNameByLocator(testProperties.get("userName"));
        }

        localUsers.setUserRole(LocalUsersEnums.UserRole.getEnum(testProperties.get("userRole")));

        if (testProperties.get("currentAdminPass") != null) {
            localUsers.setCurrentAdminPass(testProperties.get("currentAdminPass"));
        }

        if (testProperties.get("newPass") != null) {
            localUsers.setNewPass(testProperties.get("newPass"));
        }

        if (testProperties.get("confirmNewPass") != null) {
            localUsers.setConfirmNewPass(testProperties.get("confirmNewPass"));
        }

        if (testProperties.get("userRole").equals("L4 Administrator") || testProperties.get("userRole").equals("SLB Administrator")) {
            localUsers.setCertificateManagementPermissions(testProperties.get("certificateManagementPermissions"));
        }

        localUsers.setRadiusTacacsFallback(GeneralEnums.State.getState(testProperties.get("fallback")));

        localUsers.submit();
    }


    public static void duplicateLocalUser(HashMap<String, String> testProperties, GeneralEnums.State userState, int num) {
        LocalUsers localUsers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mUsers().mLocalUsers();
        initLockDevice(testProperties);
        localUsers.openPage();
        //localUsers.duplicateUser(num);
        localUsers.enableUser(userState);

        if (testProperties.get("userId") != null) {
            localUsers.setUserId(Integer.parseInt(testProperties.get("userId")));
        }

        if (testProperties.get("userName") != null) {
            localUsers.setUserNameByLocator(testProperties.get("userName"));
        }

        localUsers.setUserRole(LocalUsersEnums.UserRole.getEnum(testProperties.get("userRole")));

        if (testProperties.get("currentAdminPass") != null) {
            localUsers.setCurrentAdminPass(testProperties.get("currentAdminPass"));
        }

        if (testProperties.get("newPass") != null) {
            localUsers.setNewPass(testProperties.get("newPass"));
        }

        if (testProperties.get("confirmNewPass") != null) {
            localUsers.setConfirmNewPass(testProperties.get("confirmNewPass"));
        }

        if (testProperties.get("userRole").equals("L4 Administrator") || testProperties.get("userRole").equals("SLB Administrator")) {
            localUsers.setCertificateManagementPermissions(testProperties.get("certificateManagementPermissions"));
        }

        localUsers.setRadiusTacacsFallback(GeneralEnums.State.getState(testProperties.get("fallback")));
        localUsers.submit();
    }


    public static void deleteLocalUser(HashMap<String, String> testProperties, int id) {
        LocalUsers localUsers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mUsers().mLocalUsers();
        initLockDevice(testProperties);
        localUsers.openPage();
        localUsers.deleteUser(id);
    }


    public static void editLocalUser(HashMap<String, String> testProperties, GeneralEnums.State userState) {
        LocalUsers localUsers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mUsers().mLocalUsers();
        initLockDevice(testProperties);
        localUsers.openPage();

        if (testProperties.get("userId") != null) {
            localUsers.editUser(Integer.parseInt(testProperties.get("userId")));
        }
        localUsers.enableUser(userState);

        if (testProperties.get("userName") != null) {
            localUsers.setUserNameByLocator(testProperties.get("userName"));
        }

        localUsers.setUserRole(LocalUsersEnums.UserRole.getEnum(testProperties.get("userRole")));

        if (testProperties.get("currentAdminPass") != null) {
            localUsers.setCurrentAdminPass(testProperties.get("currentAdminPass"));
        }

        if (testProperties.get("newPass") != null) {
            localUsers.setNewPass(testProperties.get("newPass"));
        }

        if (testProperties.get("confirmNewPass") != null) {
            localUsers.setConfirmNewPass(testProperties.get("confirmNewPass"));
        }

        if (testProperties.get("userRole").equals("L4 Administrator") || testProperties.get("userRole").equals("SLB Administrator")) {
            localUsers.setCertificateManagementPermissions(testProperties.get("certificateManagementPermissions"));
        }

        localUsers.setRadiusTacacsFallback(GeneralEnums.State.getState(testProperties.get("fallback")));
        localUsers.submit();
    }


}

