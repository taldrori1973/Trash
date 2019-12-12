package com.radware.vision.infra.testhandlers.system.usermanagement.settings;

import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.system.usermanagement.UserManagement;
import com.radware.vision.infra.base.pages.system.usermanagement.UserSettings;
import com.radware.vision.infra.utils.WebUIStringsVision;

public class SettingsHandler {

    public static void fillSettings(UserMgmtSettingsEntryHandler userMgmtSettingsEntry) {

        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        UserManagement userManagement = menuPane.openSystemUserManagement();
        UserSettings userSettingsPage = userManagement.userSettingsMenu();

        if (userMgmtSettingsEntry.getUserAuth() != null) {
            userSettingsPage.setAuthenticationMode(userMgmtSettingsEntry.getUserAuth());
        }
        if (userMgmtSettingsEntry.getNumOfPassChallanges() != null) {
            userSettingsPage.setNumOfPasswordChallenges(userMgmtSettingsEntry.getNumOfPassChallanges());
        }

        if (userMgmtSettingsEntry.getConfirmPassOtherUsers() != null) {
            userSettingsPage.setDefaultPasswordForOtherUsers(userMgmtSettingsEntry.getConfirmPassOtherUsers());
        }
        if (userMgmtSettingsEntry.getConfirmPassOtherUsers() != null) {
            userSettingsPage.setConfirmDefaultPassword(userMgmtSettingsEntry.getConfirmPassOtherUsers());
        }

        if (userMgmtSettingsEntry.getConfirmPassOtherUsers() != null) {
            userSettingsPage.setDefaultPasswordForOtherUsers(userMgmtSettingsEntry.getConfirmPassOtherUsers());

        }
        if (userMgmtSettingsEntry.getPassValidityPeriod() != null) {
            userSettingsPage.setPasswordValidityPeriod(userMgmtSettingsEntry.getPassValidityPeriod());
        }
        if (userMgmtSettingsEntry.getUserStatisticsStoragePeriod() != null) {
            userSettingsPage.setUserStatisticStoragePeriod(userMgmtSettingsEntry.getUserStatisticsStoragePeriod());
        }
        if (userMgmtSettingsEntry.getNumLastPassSaved() != null) {
            userSettingsPage.setNumberOfLastPasswordsSaved(userMgmtSettingsEntry.getNumLastPassSaved());
        }
        if (userMgmtSettingsEntry.getMustChangePasswordFirstLogin()) {
            userSettingsPage.setUsersMustChangePasswordAtFirstLogin(userMgmtSettingsEntry.getMustChangePasswordFirstLogin());
        }

        WebUIVisionBasePage.submit(WebUIStringsVision.getUserManagementSettingsSubmit());
    }

    public static UserMgmtSettingsEntryHandler getUserMgmtSettings() {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        UserManagement userManagement = menuPane.openSystemUserManagement();
        UserSettings userSettingsPage = userManagement.userSettingsMenu();
        UserMgmtSettingsEntryHandler retrievedUsersSettings = userSettingsPage.getUserSettings();
        userSettingsPage.cancel();
        return retrievedUsersSettings;
    }
}
