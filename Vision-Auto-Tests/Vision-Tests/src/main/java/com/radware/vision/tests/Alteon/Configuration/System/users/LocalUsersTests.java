package com.radware.vision.tests.Alteon.Configuration.System.users;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.system.users.localUsers.LocalUsersEnumsAlteon;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.Users.LocalUsersHandler;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by konstantinr on 6/2/2015.
 */
public class LocalUsersTests extends AlteonTestBase {
    int userId;
    int rowNumber;
    String userName;
    LocalUsersEnumsAlteon.UserRole userRole = LocalUsersEnumsAlteon.UserRole.USER;
    String currentAdminPass;
    String newPass;
    String confirmNewPass;
    GeneralEnums.State fallback = GeneralEnums.State.DISABLE;
    GeneralEnums.State userState = GeneralEnums.State.DISABLE;
    GeneralEnums.State certificateManagementPermissions = GeneralEnums.State.DISABLE;

    @Test
    @TestProperties(name = "Verify User Existence", paramsInclude = {"userId", "deviceName"})
    public void verifyUserExistence() throws IOException {
        try {
            if (!LocalUsersHandler.checkIfUserExist(userId, getDeviceName())) {
                BaseTestUtils.report("the user not exist", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Add Local User", paramsInclude = {"qcTestId", "deviceState", "deviceIp", "deviceName", "parentTree",
            "userState", "userId", "userName", "userrole", "currentAdminPass", "newPass", "confirmNewPass", "certificateManagementPermissions", "fallback"})
    public void addLocalUser() throws IOException {
        try {
            testProperties.put("userId", String.valueOf(userId));
            testProperties.put("userName", userName);
            testProperties.put("userRole", userRole.toString());
            testProperties.put("currentAdminPass", currentAdminPass);
            testProperties.put("newPass", newPass);
            testProperties.put("confirmNewPass", confirmNewPass);
            testProperties.put("certificateManagementPermissions", certificateManagementPermissions.toString());
            testProperties.put("fallback", fallback.toString());
            LocalUsersHandler.addLocalUser(testProperties, userState);
//            String username, String fullName, String address, String organisation, String phoneNumber, String permissions, String networkPolicies
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    //
    @Test
    @TestProperties(name = "Edit Local User", paramsInclude = {"qcTestId", "deviceState", "deviceIp", "deviceName", "parentTree",
            "userState", "userId", "userName", "userrole", "currentAdminPass", "newPass", "confirmNewPass", "certificateManagementPermissions", "fallback"})
    public void editLocalUser() throws IOException {
        try {
            testProperties.put("userId", String.valueOf(userId));
            testProperties.put("userName", userName);
            testProperties.put("userrole", userRole.toString());
            testProperties.put("currentAdminPass", currentAdminPass);
            testProperties.put("newPass", newPass);
            testProperties.put("confirmNewPass", confirmNewPass);
            testProperties.put("certificateManagementPermissions", certificateManagementPermissions.toString());
            testProperties.put("fallback", fallback.toString());
            LocalUsersHandler.addLocalUser(testProperties, userState);
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "duplicate Local User", paramsInclude = {"qcTestId", "deviceState", "deviceIp", "deviceName", "parentTree",
            "userState", "rowNumber", "userId", "userName", "userrole", "currentAdminPass", "newPass", "confirmNewPass", "certificateManagementPermissions", "fallback"})
    public void duplicateLocalUser() throws IOException {
        try {
            testProperties.put("userId", String.valueOf(userId));
            testProperties.put("userName", userName);
            testProperties.put("userRole", userRole.toString());
            testProperties.put("currentAdminPass", currentAdminPass);
            testProperties.put("newPass", newPass);
            testProperties.put("confirmNewPass", confirmNewPass);
            testProperties.put("certificateManagementPermissions", certificateManagementPermissions.toString());
            testProperties.put("fallback", fallback.toString());
            LocalUsersHandler.duplicateLocalUser(testProperties, userState, rowNumber);
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Delete Local User", paramsInclude = {"qcTestId", "deviceState", "deviceIp", "deviceName", "parentTree",
            "userId", "targetTestId"})
    public void deleteLocalUser() throws IOException {
        try {
            LocalUsersHandler.deleteLocalUser(testProperties, userId);
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public HashMap<String, String> getTestProperties() {
        return testProperties;
    }

    public void setTestProperties(HashMap<String, String> testProperties) {
        this.testProperties = testProperties;
    }

    public String getUserName() {
        return userName;
    }

    @ParameterProperties(description = "Max nubber of characters: 8")
    public void setUserName(String userName) {
        this.userName = userName;
    }

    public LocalUsersEnumsAlteon.UserRole getUserrole() {
        return userRole;
    }

    public void setUserrole(LocalUsersEnumsAlteon.UserRole userRole) {
        this.userRole = userRole;
    }

    public String getCurrentAdminPass() {
        return currentAdminPass;
    }

    @ParameterProperties(description = "Max nubber of characters: 128")
    public void setCurrentAdminPass(String currentAdminPass) {
        this.currentAdminPass = currentAdminPass;
    }

    public String getNewPass() {
        return newPass;
    }

    @ParameterProperties(description = "Max nubber of characters: 128")
    public void setNewPass(String newPass) {
        this.newPass = newPass;
    }

    public String getConfirmNewPass() {
        return confirmNewPass;
    }

    @ParameterProperties(description = "Max number of characters: 128")
    public void setConfirmNewPass(String confirmNewPass) {
        this.confirmNewPass = confirmNewPass;
    }

    public GeneralEnums.State getFallback() {
        return fallback;
    }

    public void setFallback(GeneralEnums.State fallback) {
        this.fallback = fallback;
    }

    public int getUserId() {
        return userId;
    }

    @ParameterProperties(description = "Valid range: 1...11")

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public GeneralEnums.State getUserState() {
        return userState;
    }

    public void setUserState(GeneralEnums.State userState) {
        this.userState = userState;
    }

    public GeneralEnums.State getCertificateManagementPermissions() {
        return certificateManagementPermissions;
    }

    public void setCertificateManagementPermissions(GeneralEnums.State certificateManagementPermissions) {
        this.certificateManagementPermissions = certificateManagementPermissions;
    }

    public int getRowNumber() {
        return rowNumber;
    }

    public void setRowNumber(int rowNumber) {
        this.rowNumber = rowNumber;
    }
}
