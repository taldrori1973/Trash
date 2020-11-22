package com.radware.vision.infra.testhandlers.system.usermanagement.localusers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.infra.base.pages.dialogboxes.AreYouSureDialogBox;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.system.usermanagement.localusers.*;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.infra.utils.WebUIStringsVision;
import com.radware.vision.utils.RegexUtils;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class LocalUsersHandler {

    private static final String LOCAL_USERS_TAB_ID = "gwt-debug-ConfigTab_EDIT_UserManagement.Users_Tab";
    public static List<String> devices = new ArrayList<String>();
    public static LocalUsers localUsers = new LocalUsers();

    public static void NavigateHereIfNeedTo() {
        if (WebUIUtils.fluentWait(new ComponentLocator(How.ID, "gwt-debug-ConfigTab_EDIT_UserManagement.Users_Tab").getBy()) == null) {
            BasicOperationsHandler.settings();
            WebUIVisionBasePage.navigateToPage("System->User Management->Local Users");
            localUsers.setContainer(WebUIVisionBasePage.getCurrentPage().getContainer());

        }
    }


    public static void addUser(String username, String fullName, String address, String organisation, String phoneNumber, String permissions, String networkPolicies, String password) {
        List<String> permissionsList = Arrays.asList(permissions.split(","));

        NavigateHereIfNeedTo();

        UserEntry expUserEntry = new UserEntry(username, new PermissionEntry(permissionsList.get(0), "ALL"));
        if (!LocalUsersHandler.isUserExists(expUserEntry, null)) {
            AuthorizedNetworkPolicies authorizedNetworkPolicies = new AuthorizedNetworkPolicies();
            User newUser = localUsers.newUser();
            newUser.setUsername(username);
            if (fullName != null && !fullName.isEmpty())
                newUser.setFullname(fullName);
            if (organisation != null && !organisation.isEmpty())
                newUser.setContactInfoOrg(organisation);
            if (address != null && !address.isEmpty())
                newUser.setContactInfoAddress(address);
            if (phoneNumber != null && !phoneNumber.isEmpty())
                newUser.setContactInfoPhone(phoneNumber);

            addPermissions(parsePermissions(permissions), newUser);
            if (networkPolicies != null && !networkPolicies.isEmpty()) {
                AuthorizedNetworkPoliciesHandler.selectNetworkPolices(networkPolicies, authorizedNetworkPolicies);
            }

            if (password != null && !password.isEmpty()) {
                newUser.addPassword(password);
            }

            BasicOperationsHandler.delay(2);

            WebUIDriver.getListenerManager().getWebUIDriverEventListener().setWaitBeforeEventOperation(Long.valueOf(5 * 1000));

            //Check if it timing issue in jenkins
            WebUIUtils.sleep(3);

            newUser.submit();
            LocalUsersHandler.isUserExists(expUserEntry, 30);
        }
    }

    public static void editUser(String username, String fullName, String address, String organisation, String phoneNumber, String permissions, String permissionsToRemove, String networkPoliciesToRemove, String networkPoliciesToAdd) {

        NavigateHereIfNeedTo();

        AuthorizedNetworkPolicies authorizedNetworkPolicies = new AuthorizedNetworkPolicies();
        User editUser = localUsers.editUser("User Name", username);

        if (fullName != null) {
            editUser.setFullname(fullName);
        }
        if (organisation != null)
            editUser.setContactInfoOrg(organisation);
        if (address != null)
            editUser.setContactInfoAddress(address);
        if (phoneNumber != null)
            editUser.setContactInfoPhone(phoneNumber);

        deletePermissions(parsePermissions(permissionsToRemove), editUser);
        addPermissions(parsePermissions(permissions), editUser);

        if (networkPoliciesToRemove != null) {
            AuthorizedNetworkPoliciesHandler.removeNetworkPolices(networkPoliciesToRemove, authorizedNetworkPolicies);
        }
        if (networkPoliciesToAdd != null) {
            AuthorizedNetworkPoliciesHandler.selectNetworkPolices(networkPoliciesToAdd, authorizedNetworkPolicies);
        }

        BasicOperationsHandler.delay(2);
        editUser.submit();
    }

    public static void deleteUser(String username) {
        NavigateHereIfNeedTo();
        localUsers.deleteUser("User Name", username);
    }

    public static void enableUser(String username) {
        NavigateHereIfNeedTo();
        localUsers.selectUser("User Name", username);
        localUsers.enableUserClick();
    }

    public static void revokeUser(String username) {
        NavigateHereIfNeedTo();
        localUsers.selectUser("User Name", username);
        localUsers.revokeUserClick();
        AreYouSureDialogBox dialogBox = new AreYouSureDialogBox();
        dialogBox.yesButtonClick();
    }

    public static void unlockUser(String username) {
        NavigateHereIfNeedTo();
        localUsers.selectUser("User Name", username);
        localUsers.unlockUserClick();
    }

    public static void resetUserPwd(String username) {
        NavigateHereIfNeedTo();
        localUsers.selectUser("User Name", username);
        localUsers.resetUserPwdClick();
        AreYouSureDialogBox dialogBox = new AreYouSureDialogBox();
        dialogBox.yesButtonClick();
    }

    public static List<UserEntry> getExistingUsers() {
        NavigateHereIfNeedTo();
        return localUsers.getLocalUsers();

    }


    public static List<PermissionEntry> parsePermissions(String permissions) {
        // Format: <role>,<scope>|...
        List<PermissionEntry> permissionsList = new ArrayList<PermissionEntry>();
        if (permissions == null)
            return permissionsList;
        List<String> rawPermissions = new ArrayList<String>();
        rawPermissions = Arrays.asList(permissions.split("\\|"));

        for (String rawPermission : rawPermissions) {
            //String[] currentPermission = rawPermission.split("|");
            List<String> currentPermission = Arrays.asList(rawPermission.split("\\,"));
            String role = null;
            String scope = null;
            if (currentPermission.size() == 2) {
                role = currentPermission.get(0);
                scope = currentPermission.get(1);
            } else if (currentPermission.size() == 1) {
                role = currentPermission.get(0);
            }
            permissionsList.add(new PermissionEntry(role, scope));
        }
        return permissionsList;
    }

    private static void deletePermissions(List<PermissionEntry> permissions, User userPage) {
        userPage.openTabPermissions();
        for (PermissionEntry currentPermission : permissions) {
            userPage.deletePermission("Role", currentPermission.getRole());
        }
    }

    public static void addPermissions(List<PermissionEntry> permissions, User userPage) {
        userPage.openTabPermissions();
        for (PermissionEntry currentPermission : permissions) {
            Permission permissionPage = userPage.addPermission();
            permissionPage.setRole(currentPermission.getRole().toString());
            if (currentPermission.getScope() != null && !currentPermission.getScope().toString().equals("")) {
                permissionPage.setScope(currentPermission.getScope().toString());
            }
            permissionPage.submit(WebUIStringsVision.getUserRoleGroupSubmit());
            BasicOperationsHandler.delay(1);
        }
    }

    /**
     *
     * @param userToSearch UserEntry object
     * @param timeout in seconds to search for user
     * @return true if user exists
     */
    public static boolean isUserExists(UserEntry userToSearch, Integer timeout) {
        timeout = timeout == null ? 0 : timeout * 1000;
        long startTime = System.currentTimeMillis();
        try {
            do {
                List<UserEntry> users = LocalUsersHandler.getExistingUsers();
                for (UserEntry currentUser : users) {
                    if (currentUser.getUsername().equals(userToSearch.getUsername())) {
                        if (currentUser.getUsername().equals(userToSearch.getUsername())) {
                            return true;
                        }
                    }
                }
            } while (System.currentTimeMillis() - startTime < timeout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        return false;
    }

    public static String usersListAsText() {

        StringBuffer result = new StringBuffer();
        for (UserEntry currentUser : getExistingUsers()) {
            result.append("Username: ").append(currentUser.getUsername()).append(currentUser.toString()).append("\n");
        }
        return result.toString();
    }

    public static LocalUsers getLocalUsers() {
        NavigateHereIfNeedTo();
        return localUsers;
    }
}
