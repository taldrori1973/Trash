package com.radware.vision.tests.scheduledtasks.operatortoolbox;

import com.radware.automation.webui.webpages.configuration.system.users.localUsers.LocalUsersEnumsAlteonTable;
import com.radware.vision.infra.testhandlers.rbac.enums.EnableDisableEnum;
import com.radware.vision.infra.testhandlers.scheduledtasks.OperatorToolboxHandler;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import com.radware.vision.tests.scheduledtasks.ScheduledTasksTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.util.HashMap;

public class OperatorToolBoxTests extends ScheduledTasksTestBase {

    TaskType taskType = TaskType.OPERATOR_TOOLBOX;
    String columnName = "Name";

//    ADC Create/Delete User Task

    String deviceDestinations;
    String groupDestinations;

    //Parameter
    EnableDisableEnum enableUser = EnableDisableEnum.ENABLE;
    String userId;
    String userName;
    LocalUsersEnumsAlteonTable.UserRole userRoles = LocalUsersEnumsAlteonTable.UserRole.USER;
    String password;
    String confirmPassword;
    String adminPassword;
    String confirmAdminPassword;
    EnableDisableEnum certificateManagement = EnableDisableEnum.DISABLE;
    boolean apply;
    boolean save;


    @Test
    @TestProperties(name = "ADC Create User Task", paramsInclude = {"taskEnabled", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "deviceDestinations", "groupDestinations",
            "taskSchedRunTime", "runOnceDate", "taskSchedMinutes", "executeDeltaTime", "enableUser", "userId", "userName", "userRoles",
            "password", "confirmPassword", "adminPassword", "confirmAdminPassword", "certificateManagement", "apply", "save"})
    public void addAdcCreateUserTaskTest() {

        HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
        taskPorperties.putAll(setBaseProperties());
        taskPorperties.put("taskType", String.valueOf(taskType));
        taskPorperties.put("columnName", columnName);
        //target devices and logical groups
        taskPorperties.put("deviceDestinations", deviceDestinations);
        taskPorperties.put("groupDestinations", groupDestinations);
        //Parameters
        taskPorperties.put("enableUser", enableUser == null ? null : enableUser.getmEnableDisable());
        taskPorperties.put("userId", userId);
        taskPorperties.put("userName", userName);
        taskPorperties.put("userRoles", userRoles == null ? null : userRoles.toString());
        taskPorperties.put("password", password);
        taskPorperties.put("confirmPassword", confirmPassword);
        taskPorperties.put("adminPassword", adminPassword);
        taskPorperties.put("confirmAdminPassword", confirmAdminPassword);
        taskPorperties.put("certificateManagement", certificateManagement == null ? null : certificateManagement.getmEnableDisable());
        taskPorperties.put("apply", String.valueOf(apply));
        taskPorperties.put("save", String.valueOf(save));


        OperatorToolboxHandler.AdcCreateUser.addAdcCreateUserTask(taskPorperties);
    }


    @Test
    @TestProperties(name = "ADC Delete User Task", paramsInclude = {"taskEnabled", "taskName", "taskDescription", "taskSchedRunInterval",
            "taskRunAlways", "taskSchedWeekdays", "taskSchedStartDate", "taskSchedStartTime", "taskSchedEndDate", "taskSchedEndTime", "deviceDestinations", "groupDestinations",
            "taskSchedRunTime", "runOnceDate", "taskSchedMinutes", "executeDeltaTime", "userId", "apply", "save"})
    public void addAdcDeleteUserTaskTest() {

        HashMap<String, String> taskPorperties = new HashMap<String, String>(50);
        taskPorperties.putAll(setBaseProperties());
        taskPorperties.put("taskType", String.valueOf(taskType));
        taskPorperties.put("columnName", columnName);
        //target devices and logical groups
        taskPorperties.put("deviceDestinations", deviceDestinations);
        taskPorperties.put("groupDestinations", groupDestinations);
        //Parameters
        taskPorperties.put("userId", userId);
        taskPorperties.put("apply", String.valueOf(apply));
        taskPorperties.put("save", String.valueOf(save));


        OperatorToolboxHandler.AdcDeleteUser.addAdcDeleteUserTask(taskPorperties);
    }


    public String getDeviceDestinations() {
        return deviceDestinations;
    }

    public void setDeviceDestinations(String deviceDestinations) {
        this.deviceDestinations = deviceDestinations;
    }

    public String getGroupDestinations() {
        return groupDestinations;
    }

    public void setGroupDestinations(String groupDestinations) {
        this.groupDestinations = groupDestinations;
    }

    public EnableDisableEnum getEnableUser() {
        return enableUser;
    }

    public void setEnableUser(EnableDisableEnum enableUser) {
        this.enableUser = enableUser;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public LocalUsersEnumsAlteonTable.UserRole getUserRoles() {
        return userRoles;
    }

    public void setUserRoles(LocalUsersEnumsAlteonTable.UserRole userRoles) {
        this.userRoles = userRoles;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

    public String getAdminPassword() {
        return adminPassword;
    }

    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword;
    }

    public String getConfirmAdminPassword() {
        return confirmAdminPassword;
    }

    public void setConfirmAdminPassword(String confirmAdminPassword) {
        this.confirmAdminPassword = confirmAdminPassword;
    }

    public EnableDisableEnum getCertificateManagement() {
        return certificateManagement;
    }

    public void setCertificateManagement(EnableDisableEnum certificateManagement) {
        this.certificateManagement = certificateManagement;
    }

    public boolean isApply() {
        return apply;
    }

    public void setApply(boolean apply) {
        this.apply = apply;
    }

    public boolean isSave() {
        return save;
    }

    public void setSave(boolean save) {
        this.save = save;
    }
}

