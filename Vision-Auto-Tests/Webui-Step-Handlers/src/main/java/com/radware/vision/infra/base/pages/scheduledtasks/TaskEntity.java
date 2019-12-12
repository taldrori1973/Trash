package com.radware.vision.infra.base.pages.scheduledtasks;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.*;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.dpPolicies.DpPoliciesUtils;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.ToolboxActionsEnum;
import com.radware.vision.infra.testhandlers.scheduledtasks.WeekDaysSetter;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.BackupDestinations;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.DestinationType;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.ProtocolType;
import com.radware.vision.infra.testhandlers.scheduledtasks.enums.TaskType;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.Arrays;
import java.util.List;

public class TaskEntity extends WebUIVisionBasePage {
    public List<String> weekDaysAll = Arrays.asList(new String[]{"Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"});
    public Schedule schedule;
    public Destination destination;
    public Parameters parameters;
    public ConfigurationTemplate configurationTemplate;
    public NetworkProtectionPolicies networkProtectionPolicies;
    public ServerProtectionPolicies serverProtectionPolicies;
    public String endTime = "EndDate";
    public String startTime = "StartDate";

    protected TaskEntity(String deviceDriverFilename) {
        super("Add Shceduled Task", deviceDriverFilename, false);
        loadPageElements(false);
    }

    public void setTaskType(TaskType taskType) {
        WebUIDropdown taskTypeCombo = (WebUIDropdown) container.getDropdown("Task Type");
        if (taskTypeCombo.isEnabled()) {
            taskTypeCombo.selectOptionByText(taskType.getType());
        }
    }

    public void setName(String taskName) {
        WebUITextField taskNameField = (WebUITextField) container.getTextField("Name");
        setTextFieldIfNotEmpty(taskNameField, taskName);
    }

    public void setDecription(String description) {
        WebUITextField taskDecription = (WebUITextField) container.getTextField("Description");
        setTextFieldIfNotEmpty(taskDecription, description);
    }

    private void switchToNetworkProtectionPoliciesTab() {
        WebUIVerticalTab scheduleTab = (WebUIVerticalTab) container.getVerticalTab("Network Protection Policies");
        String classValue = scheduleTab.getWebElement().getAttribute("class");
        if (!(classValue.contains("selected")))
            scheduleTab.click();
    }

    private void switchToServerProtectionPoliciesTab() {
        WebUIVerticalTab scheduleTab = (WebUIVerticalTab) container.getVerticalTab("Server Protection Policies");
        String classValue = scheduleTab.getWebElement().getAttribute("class");
        if (!(classValue.contains("selected")))
            scheduleTab.click();
    }

    private void switchToScheduleTab() {
        WebUIVerticalTab scheduleTab = (WebUIVerticalTab) container.getVerticalTab("Schedule");
        String classValue = scheduleTab.getWebElement().getAttribute("class");
        if (!(classValue.contains("selected")))
            scheduleTab.click();
    }

    private void switchToDestinationTab() {
        WebUIVerticalTab parametersTab = (WebUIVerticalTab) container.getVerticalTab("Destination");
        String classValue = parametersTab.getWebElement().getAttribute("class");
        if (!(classValue.contains("selected")))
            parametersTab.click();
    }

    private void switchToDeviceListTab() {

        WebUIVerticalTab parametersTab = (WebUIVerticalTab) container.getVerticalTabById("scheduledTasksDualList");
        String classValue = parametersTab.getWebElement().getAttribute("class");
        if (!(classValue.contains("selected")))
            parametersTab.click();
    }

    private void switchToParametersTab() {
        WebUIVerticalTab destinationTab = (WebUIVerticalTab) container.getVerticalTab("Parameters");
        String classValue = destinationTab.getWebElement().getAttribute("class");
        if (!(classValue.contains("selected")))
            destinationTab.click();
    }

    /*
    * Shay Even Zor: verifying sub tab existence
     */
    public boolean fieldsNotExistVerification(List<String> fields){
        for (String field : fields){

            WebUIVerticalTab tab = (WebUIVerticalTab) container.getVerticalTab(field);
            if(tab.find()){
               return false;
            }
        }
        return true;
    }

    private void switchToConfigurationTemplateTab() {
        WebUIVerticalTab configurationTemplateTab = (WebUIVerticalTab) container.getVerticalTab("Configuration Template");
        String classValue = configurationTemplateTab.getWebElement().getAttribute("class");
        if (!(classValue.contains("selected")))
            configurationTemplateTab.click();

    }


    public void setTaskStatus(boolean taskEnabled) {
        switchToScheduleTab();
        WebUICheckbox taskRunMode = (WebUICheckbox) container.getCheckbox("Enabled");
        if (taskEnabled)
            taskRunMode.check();
        else
            taskRunMode.uncheck();
    }

    public void setAllowUpdateDuringAttack(boolean update) {
        WebUICheckbox taskRunMode = (WebUICheckbox) container.getCheckbox("Allow Device Updates During Attacks");
        if (update)
            taskRunMode.check();
        else
            taskRunMode.uncheck();
    }

    public Schedule getSchedule() {
        if (this.schedule == null) {
            this.schedule = new Schedule();
        }
        return this.schedule;
    }

    public Destination getDestination(DestinationType destinationType) {
        if (this.destination != null) {
            destination.setDestinationType(destinationType);
            destination.switchToTargetsTab();
            return this.destination;
        } else {
            destination = new Destination(destinationType);
            destination.switchToTargetsTab();
            return destination;
        }
    }

    public ConfigurationTemplate getConfigurationTemplate() {
        return configurationTemplate == null ? new ConfigurationTemplate() : configurationTemplate;
    }

    public Parameters getParameters() {
        if (this.parameters != null)
            return this.parameters;
        else
            return new Parameters();
    }

    public NetworkProtectionPolicies getNetworkProtectionPolicies() {
        if (this.networkProtectionPolicies != null)
            return this.networkProtectionPolicies;
        else
            return new NetworkProtectionPolicies();
    }
    //==================================

    public ServerProtectionPolicies getServerProtectionPolicies() {
        if (this.serverProtectionPolicies != null)
            return this.serverProtectionPolicies;
        else
            return new ServerProtectionPolicies();
    }

    private void setTextFieldIfNotEmpty(WebUITextField taskElement, String value) {
        setTextFieldIfNotEmpty(taskElement, value, null);
    }

    private void setTextFieldIfNotEmpty(WebUITextField taskElement, String value, String listParentId) {
        if (value != null && !value.isEmpty()) {
            if (taskElement.getId().endsWith("-input")) {
                WebUIDropdown element = new WebUIDropdown();
                element.setWebElement(taskElement.getWebElement());
                if (listParentId == null) {
                    element.selectOptionByText(value);
                } else {
                    element.selectOptionByText(value, listParentId);
                }
                element.applySelection();
            } else {
                taskElement.type(value);
            }
        }
    }

    private void setDropdownIfNotEmpty(WebUIDropdown taskElement, String value, String listParentId) {
        if (value != null && !value.isEmpty()) {
            taskElement.clearSelection();
            taskElement.selectOptionByText(value, listParentId);
            taskElement.applySelection();
        }
    }

    public void setUpdateMethod(String method) {
        switchToDeviceListTab();
        WebUIDropdown taskRunMode = (WebUIDropdown) container.getDropdown("Update Method");
        if (taskRunMode.isEnabled()) {
            taskRunMode.selectOptionByText(method);
        }
    }

    public void setUpdatePolicies(boolean ifUpdate) {
        switchToDeviceListTab();
        WebUICheckbox updatePolicies = (WebUICheckbox) container.getCheckbox("Update Policies After Sending configuration");
        if (ifUpdate) {
            updatePolicies.check();
        } else {
            updatePolicies.uncheck();
        }
    }

    public class Destination {
        DestinationType destinationType;

        private Destination(DestinationType destinationType) {
            this.destinationType = destinationType;
        }

        public void setDestinationType(DestinationType destinationType) {
            this.destinationType = destinationType;
        }

        public void setProtocol(ProtocolType protocolType) {
            switchToTargetsTab();
            WebUIDropdown protocolCombo = (WebUIDropdown) container.getDropdown("Protocol");
            if (protocolCombo.isEnabled()) {
                protocolCombo.selectOptionByText(protocolType.getProtocolType());
            }
        }

        public void setDirectory(String directory) {
            switchToTargetsTab();
            WebUITextField directoryField = (WebUITextField) container.getTextField("Directory");
            setTextFieldIfNotEmpty(directoryField, directory);
        }

        public void setUser(String user) {
            switchToTargetsTab();
            WebUITextField userField = (WebUITextField) container.getTextField("User");
            setTextFieldIfNotEmpty(userField, user);
        }

        public void setIpAddress(String ipAddress) {
            switchToTargetsTab();
            WebUITextField ipAddressField = (WebUITextField) container.getTextField("IP Address");
            setTextFieldIfNotEmpty(ipAddressField, ipAddress);
        }

        public void setBackupFileName(String backupFileName) {
            switchToTargetsTab();
            WebUITextField backupFileNameField = (WebUITextField) container.getTextField("Backup File Name");
            setTextFieldIfNotEmpty(backupFileNameField, backupFileName);
        }

        public void setConfirmPassword(String password) {
            switchToTargetsTab();
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getPasswordDuplicatedField());
            WebUIPasswordTextField textField = new WebUIPasswordTextField(locator);
            textField.setWebElement((new WebUIComponent(locator)).getWebElement());

            textField.insertContent(password);

        }

        public void setPassword(String password) {
            switchToTargetsTab();
            WebUITextField confirmPasswordField = (WebUITextField) container.getTextField("Password");
            WebUIPasswordTextField passwordTextField = new WebUIPasswordTextField(confirmPasswordField.getLocator());
            passwordTextField.setWebElement(confirmPasswordField.getWebElement());
            passwordTextField.insertContent(password);
        }

        private void switchToTargetsTab() {
            if (this.destinationType.equals(DestinationType.Destination)) {
                switchToDestinationTab();
            } else if (this.destinationType.equals(DestinationType.DeviceList)) {
                switchToDeviceListTab();
            }
        }

    }

    public class ConfigurationTemplate {
        private ConfigurationTemplate() {
        }

        public void selectScript(ToolboxActionsEnum script) {
            switchToConfigurationTemplateTab();
            OperatorToolboxTask operatorToolboxTask = new OperatorToolboxTask();

            WebUITable table = (WebUITable) operatorToolboxTask.getContainer().getTableById("adminScriptTable");
            table.clickRowByKeyValue("Action Title", script.getActionName());
        }


    }

    public class Parameters {
        private Parameters() {
        }

        public void setIncludePrivateKeys(boolean includePrivateKeys) {
            switchToParametersTab();
            WebUICheckbox taskRunMode = (WebUICheckbox) container.getCheckbox("Include Private Keys (in supported devices only)");
            if (includePrivateKeys)
                taskRunMode.check();
            else
                taskRunMode.uncheck();
        }

        public void setAction(String actionType) {
            switchToParametersTab();
            WebUIDropdown actionCombo = (WebUIDropdown) container.getDropdown("Action");
            if (actionCombo.isEnabled()) {
                actionCombo.selectOptionByText(actionType);
            }
        }

    }

    //==================================
    public class NetworkProtectionPolicies {
        private NetworkProtectionPolicies() {
        }

        public void setConfiguration(boolean configuration) {
            switchToNetworkProtectionPoliciesTab();
            WebUICheckbox config = (WebUICheckbox) container.getCheckboxByID("additionalParams.networkPolicyConfig");
            if (configuration)
                config.check();
            else
                config.uncheck();
        }

        public void setDnsBaseline(boolean dnsBaseline) {
            switchToNetworkProtectionPoliciesTab();
            WebUICheckbox dnsBaselineCheckbox = (WebUICheckbox) container.getCheckbox("DNS Baseline");
            if (dnsBaseline)
                dnsBaselineCheckbox.check();
            else
                dnsBaselineCheckbox.uncheck();
        }

        public void setBdosBaseline(boolean bdosBaseline) {
            switchToNetworkProtectionPoliciesTab();
            WebUICheckbox bdosBaselineCheckbox = (WebUICheckbox) container.getCheckbox("BDoS Baseline");
            if (bdosBaseline)
                bdosBaselineCheckbox.check();
            else
                bdosBaselineCheckbox.uncheck();
        }

        public void removeNetworkProtectionPolicies(List<String> devices, List<String> policies, String dualListId) {
            switchToNetworkProtectionPoliciesTab();
            DpPoliciesUtils.removeNetworkPoliciesMultiColumns(devices, policies, dualListId);
        }

        public void addNetworkProtectionPolicies(List<String> devices, List<String> policies, String dualListId) {
            switchToNetworkProtectionPoliciesTab();
            DpPoliciesUtils.addNetworkPoliciesMultiColumns(devices, policies, dualListId);
        }

    }

    //==================================
    public class ServerProtectionPolicies {
        private ServerProtectionPolicies() {
        }

        public void setConfiguration(boolean configuration) {
            switchToServerProtectionPoliciesTab();
            WebUICheckbox config = (WebUICheckbox) container.getCheckboxByID("additionalParams.serverProtectionConfig");
            if (configuration)
                config.check();
            else
                config.uncheck();
        }

        public void setHttpBaseline(boolean httpBaseline) {
            switchToServerProtectionPoliciesTab();
            WebUICheckbox httpBaselineCheckbox = (WebUICheckbox) container.getCheckbox("HTTP Baseline");
            if (httpBaseline)
                httpBaselineCheckbox.check();
            else
                httpBaselineCheckbox.uncheck();
        }

        public void removeServerProtectionPolicies(List<String> devices, List<String> policies, String dualListId) {
            switchToServerProtectionPoliciesTab();
            DpPoliciesUtils.removeNetworkPoliciesMultiColumns(devices, policies, dualListId);
        }

        public void addServerProtectionPolicies(List<String> devices, List<String> policies, String dualListId) {
            switchToServerProtectionPoliciesTab();
            DpPoliciesUtils.addNetworkPoliciesMultiColumns(devices, policies, dualListId);
        }
    }

    public class Schedule {

        String time;

        private Schedule() {
        }

        public String getTime() {
            return time;
        }

        public void setRunAlways(boolean runAlways) {
            switchToScheduleTab();
            WebUICheckbox taskRunMode = (WebUICheckbox) container.getCheckbox("Run Always");
            if (runAlways)
                taskRunMode.check();
            else
                taskRunMode.uncheck();
        }

        public void setRunInterval(String runInterval) {
            switchToScheduleTab();
            WebUIDropdown taskRunMode = (WebUIDropdown) container.getDropdown("Run");
            if (taskRunMode.isEnabled()) {
                taskRunMode.selectOptionByText(runInterval);
            }
        }

        //===========================
        public void setTime(String time, String timeType) {
            switchToScheduleTab();
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getTimeWidgetByFrequency(timeType));
            WebUITextField timeField = new WebUITextField(locator);
            timeField.setWebElement((new WebUIComponent(locator)).getWebElement());
            setTextFieldIfNotEmpty(timeField, time, WebUIStrings.getTimeListView());
            this.time = time;
        }

        //	Minutes Schedule
        public void setRunMinutesMinutes(String minutes) {
            switchToScheduleTab();
            setScheduleTextField("Minutes", "time.minutes", minutes);
        }

        public void checkWeekDays(List<String> weekDays) {
            switchToScheduleTab();
            WeekDaysSetter weekDaysSetter = new WeekDaysSetter();
            weekDaysSetter.uncheckAllWeekDays();
            weekDaysSetter.checkWeekDays(weekDays);
        }

        public void setRunOnceDate(String date) {
            switchToScheduleTab();
            WebUITextField taskRunEndDate = (WebUITextField) container.getTimeField("Date");
            setTextFieldIfNotEmpty(taskRunEndDate, date);
        }

        public void setRunStartDate(String startDate) {
            innerSetRunDate(startDate, true);
        }

        public void setRunEndDate(String endDate) {
            innerSetRunDate(endDate, false);
        }

        public void setStartTime(String time) {
            innerSetRunTime(time, true);
        }

        public void setEndTime(String time) {
            innerSetRunTime(time, false);
        }

        private void innerSetRunTime(String time, boolean isStartTime) {
            switchToScheduleTab();
            WebUITextField taskRunEndDate = (WebUITextField) container.getTimeField(isStartTime ? "Start Time" : "End Time");
            setTextFieldIfNotEmpty(taskRunEndDate, time);
        }

        private void innerSetRunDate(String date, boolean isStartDate) {
            switchToScheduleTab();
            WebUITextField taskRunEndDate = (WebUITextField) container.getTimeField(isStartDate ? "Start Date" : "End Date");
            setTextFieldIfNotEmpty(taskRunEndDate, date);
            taskRunEndDate.sendEnter();
        }

        private void setScheduleTextField(String widgetName, String widgetId, String value) {
            switchToScheduleTab();
            WebUITextField taskElement = widgetId == null ? (WebUITextField) container.getTextField(widgetName) : (WebUITextField) container.getTextField(widgetName, widgetId);
            taskElement.setWebElement(WebUIUtils.fluentWaitDisplayed(taskElement.getLocator().getBy(), WebUIUtils.SHORT_WAIT_TIME, false));
            setTextFieldIfNotEmpty(taskElement, value);
        }

        public void setBackupDestination(BackupDestinations backupDestination) {
            switchToDestinationTab();
            WebUIRadioGroup backupDestinationRadioGroup = (WebUIRadioGroup) container.getRadioGroup("Backup Configuration To");
            backupDestinationRadioGroup.selectOption(backupDestination.getBackupDestination());
        }
    }
}
