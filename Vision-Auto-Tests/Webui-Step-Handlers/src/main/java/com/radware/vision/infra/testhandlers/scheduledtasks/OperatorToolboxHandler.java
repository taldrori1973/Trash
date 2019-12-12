package com.radware.vision.infra.testhandlers.scheduledtasks;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.vision.infra.enums.ToolboxActionsEnum;
import org.openqa.selenium.By;
import org.openqa.selenium.support.How;

import java.util.HashMap;

import static com.radware.vision.infra.utils.WebUIStringsVision.WIDGET_INPUT;
import static com.radware.vision.infra.utils.WebUIStringsVision.WIDGET_SUFFIX;

public class OperatorToolboxHandler extends BaseTasksHandler {

    private static void switchToParameterTab() {
        WebUIUtils.fluentWaitClick(By.id("gwt-debug-parametersFieldGroup_Tab"), WebUIUtils.SHORT_WAIT_TIME, false);
    }

    private static void applyAndSave(HashMap<String, String> taskParameters) {
        final String applySaveObject = "gwt-debug-#adminscript#ApplySaveObj#CustomType#.";
        WebUICheckbox applyCheckbox = new WebUICheckbox(new ComponentLocator(How.ID, applySaveObject + "apply" + WIDGET_INPUT));
        if (Boolean.valueOf(taskParameters.get("apply"))) {
            applyCheckbox.check();
        } else {
            applyCheckbox.uncheck();
        }


        WebUICheckbox saveCheckbox = new WebUICheckbox(new ComponentLocator(How.ID, applySaveObject + "save" + WIDGET_INPUT));

        if (Boolean.valueOf(taskParameters.get("save"))) {
            saveCheckbox.check();
        } else {
            saveCheckbox.uncheck();
        }

    }

    public static class AdcCreateUser {


        public static void addAdcCreateUserTask(HashMap<String, String> taskProperties) {
            beforeAddTask(taskProperties);
            taskEntity.getConfigurationTemplate().selectScript(ToolboxActionsEnum.ADC_CREATE_USERS);
            setAdcScriptParams(taskProperties);
            afterAddTask(taskProperties);

        }

        public static void setAdcScriptParams(HashMap<String, String> taskParameters) {

            switchToParameterTab();
            setScriptValues(taskParameters);
            applyAndSave(taskParameters);

        }

        private static void setScriptValues(HashMap<String, String> taskParameters) {
            final String userParmaObject = "gwt-debug-#adminscript#UserParamObj#CustomType#.";
            WebUIUtils.fluentWaitSendText(taskParameters.get("enableUser"), By.id(userParmaObject + "activate" + WIDGET_INPUT), WebUIUtils.SHORT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(taskParameters.get("userId"), By.id(userParmaObject + "UID" + WIDGET_SUFFIX), WebUIUtils.SHORT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(taskParameters.get("userName"), By.id(userParmaObject + "name" + WIDGET_SUFFIX), WebUIUtils.SHORT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(taskParameters.get("userRoles"), By.id(userParmaObject + "cos" + WIDGET_INPUT), WebUIUtils.SHORT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(taskParameters.get("password"), By.id(userParmaObject + "pswd" + WIDGET_SUFFIX), WebUIUtils.SHORT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(taskParameters.get("confirmPassword"), By.id(userParmaObject + "pswd_DuplicatePasswordField"), WebUIUtils.SHORT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(taskParameters.get("adminPassword"), By.id(userParmaObject + "adminPswd" + WIDGET_SUFFIX), WebUIUtils.SHORT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(taskParameters.get("confirmAdminPassword"), By.id(userParmaObject + "adminPswd_DuplicatePasswordField"), WebUIUtils.SHORT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(taskParameters.get("certificateManagement"), By.id(userParmaObject + "crtmng" + WIDGET_INPUT), WebUIUtils.SHORT_WAIT_TIME, false);
        }

    }

    public static class AdcDeleteUser {


        public static void addAdcDeleteUserTask(HashMap<String, String> taskProperties) {
            beforeAddTask(taskProperties);
            taskEntity.getConfigurationTemplate().selectScript(ToolboxActionsEnum.ADC_DELETE_USERS);
            switchToParameterTab();
            addUserId(taskProperties.get("userId"));
            applyAndSave(taskProperties);
            afterAddTask(taskProperties);


        }

        private static void addUserId(String userId) {
            WebUIUtils.fluentWaitClick(By.id("gwt-debug-#adminscript#UIDs_NEW"), WebUIUtils.SHORT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(userId, By.id("gwt-debug-#adminscript#UIDs_Widget"), WebUIUtils.SHORT_WAIT_TIME, false);
            WebUIBasePage.submit();

        }

    }


}
