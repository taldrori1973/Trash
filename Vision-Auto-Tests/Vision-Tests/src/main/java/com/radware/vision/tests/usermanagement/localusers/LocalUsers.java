package com.radware.vision.tests.usermanagement.localusers;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.system.usermanagement.localusers.PermissionEntry;
import com.radware.vision.infra.base.pages.system.usermanagement.localusers.UserEntry;
import com.radware.vision.infra.testhandlers.system.usermanagement.localusers.AuthorizedNetworkPoliciesHandler;
import com.radware.vision.infra.testhandlers.system.usermanagement.localusers.LocalUsersHandler;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class LocalUsers extends WebUITestBase {

    String username;
    String fullName;
    String organisation;
    String address;
    String phoneNumber;
    String permissions;
    String permissionToDelete;
    String newNetworkPolicies;
    String removeNetworkPolicies;

    String networkPoliciesToAdd;
    String networkPoliciesToRemove;


    String password;

    String role;
    String scope;

    @Test
    @TestProperties(name = "Add Local user", paramsInclude = {"qcTestId", "username", "fullName", "organisation", "address", "phoneNumber", "permissions", "newNetworkPolicies", "password"})
    public void createUser() {
        try {
            LocalUsersHandler.addUser(username, fullName, address, organisation, phoneNumber, permissions, newNetworkPolicies, password);
        } catch (Exception e) {
            report.report("Adding user:" + username + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Edit Local user", paramsInclude = {"qcTestId", "username", "fullName", "organisation", "address", "phoneNumber", "permissions", "permissionToDelete", "networkPoliciesToRemove", "networkPoliciesToAdd"})
    public void editUser() {
        try {
            LocalUsersHandler.editUser(username, fullName, address, organisation, phoneNumber, permissions, permissionToDelete, networkPoliciesToRemove, networkPoliciesToAdd);
        } catch (Exception e) {
            report.report("Edit user:" + username + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "enable Local user", paramsInclude = {"qcTestId", "username"})
    public void enableUser() {
        try {
            LocalUsersHandler.enableUser(username);
        } catch (Exception e) {
            report.report("Enable user:" + username + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "revoke Local user", paramsInclude = {"qcTestId", "username"})
    public void revokeUser() {
        try {
            LocalUsersHandler.revokeUser(username);
        } catch (Exception e) {
            report.report("Revoke user:" + username + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "unlock Local user", paramsInclude = {"qcTestId", "username"})
    public void unlockUser() {
        try {
            LocalUsersHandler.unlockUser(username);
        } catch (Exception e) {
            report.report("Unlock user:" + username + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "reset User Password", paramsInclude = {"qcTestId", "username"})
    public void resetUserPassword() {
        try {
            LocalUsersHandler.resetUserPwd(username);
        } catch (Exception e) {
            report.report("reset User Password:" + username + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Delete Local user", paramsInclude = {"qcTestId", "username", "targetTestId"})
    public void deleteUser() {
        try {
            LocalUsersHandler.deleteUser(username);
        } catch (Exception e) {
            report.report("Deleting user:" + username + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify Existing Local user", paramsInclude = {"username", "role", "scope"})
    public void verifyUser() {
        try {
            UserEntry expUserEntry = new UserEntry(username, new PermissionEntry(role, scope));
            if (!LocalUsersHandler.isUserExists(expUserEntry, null)) {
                report.report("User: " + username + " with properties: \n" + expUserEntry.toString() + "\n was not found in the current users list: \n" + LocalUsersHandler.usersListAsText(), Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verifying user:" + username + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    //====================================== AuthorizedNetworkPolicies ===============
    @Test
    @TestProperties(name = "select NetworkPolicies For Security Monitoring", paramsInclude = {"qcTestId", "username", "newNetworkPolicies", "removeNetworkPolicies"})
    public void selectNetworkPoliciesForSecurityMonitoring() {
        try {
            AuthorizedNetworkPoliciesHandler.addRemoveAuthorizedNetworkPolicies(username, newNetworkPolicies, removeNetworkPolicies);

        } catch (Exception e) {
            report.report("Verifying user:" + username + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate NetworkPolicies For Security Monitoring", paramsInclude = {"qcTestId", "username"})
    public void validateNetworkPoliciesForSecurityMonitoring() {
        try {
            if (!AuthorizedNetworkPoliciesHandler.validateAuthorizedNetworkPolicies(username)) {
                report.report("Displayed Network Policies List is incorrect: \n", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Verifying user:" + username + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getOrganisation() {
        return organisation;
    }

    public void setOrganisation(String organisation) {
        this.organisation = organisation;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPermissions() {
        return permissions;
    }

    @ParameterProperties(description = "Pairs must be separated by <|>. Role and Group must be separated by <,>!")
    public void setPermissions(String permissions) {
        this.permissions = permissions;
    }

    public String getPermissionToDelete() {
        return permissionToDelete;
    }

    public void setPermissionToDelete(String permissionToDelete) {
        this.permissionToDelete = permissionToDelete;
    }


    public String getNewNetworkPolicies() {
        return newNetworkPolicies;
    }

    @ParameterProperties(description = "Pairs must be separated by <|>. Device and policyName must be separated by <,>!")
    public void setNewNetworkPolicies(String newNetworkPolicies) {
        this.newNetworkPolicies = newNetworkPolicies;
    }

    public String getNetworkPoliciesToAdd() {
        return networkPoliciesToAdd;
    }

    public void setNetworkPoliciesToAdd(String networkPoliciesToAdd) {
        this.networkPoliciesToAdd = networkPoliciesToAdd;
    }

    public String getNetworkPoliciesToRemove() {
        return networkPoliciesToRemove;
    }

    public void setNetworkPoliciesToRemove(String networkPoliciesToRemove) {
        this.networkPoliciesToRemove = networkPoliciesToRemove;
    }

    public String getRemoveNetworkPolicies() {
        return removeNetworkPolicies;
    }

    @ParameterProperties(description = "Pairs must be separated by <|>. Device and policyName must be separated by <,>!")
    public void setRemoveNetworkPolicies(String removeNetworkPolicies) {
        this.removeNetworkPolicies = removeNetworkPolicies;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getScope() {
        return scope;
    }

    public void setScope(String scope) {
        this.scope = scope;
    }
}
