package com.radware.vision.infra.utils;

public class WebUIStringsVision {
    public static final String GWT_DEBUG = "gwt-debug-";
    public static final String GWT = "gwt-";
    public static final String WIDGET_SUFFIX = "_Widget";

    public static String getWidgetString(String id) {
        return GWT_DEBUG + id + WIDGET_SUFFIX;
    }

    static final String TABLE_ADD = "_NEW";
    static final String TABLE_EDIT = "_EDIT";
    static final String TABLE_DELETE = "_DELETE";
    static final String TABLE_EXPORT_POLICY = "_null";
    static final String ROW_ID = "_RowID_";
    static final String VIEW_ID = "_VIEW_ONLY";
    static final String DIALOG_BOX = "Dialog_Box";
    static final String DOWNLOAD = "_download";
    static final String RUN_NOW = "_runNow";
    static final String APPLY_FILTER = "_ApplyFilter";

    static final String VISION_HELP = "DeviceControlBar_Help";
    static final String VISION_LOGIN_ICON = "Dialog_Box_undefined";
    static final String VISION_LOGIN_STATUS = "userInfo";

    public static final String getTableAdd(String id) {

        return GWT_DEBUG + id + TABLE_ADD;
    }

    public static final String getTableEdit(String id) {

        return GWT_DEBUG + id + TABLE_EDIT;
    }

    public static final String getTableDelete(String id) {

        return GWT_DEBUG + id + TABLE_DELETE;
    }

    public static final String getTableRow(String id, int index) {

        return GWT_DEBUG + id + ROW_ID + index;
    }

    public static final String getVisionHelpButton() {
        return GWT_DEBUG + VISION_HELP;
    }

    public static final String getVisionLoginStatus() {
        return GWT_DEBUG + VISION_LOGIN_STATUS;
    }

    public static final String getVisionLoginIcon() {
        return GWT_DEBUG + VISION_LOGIN_ICON;
    }

    public static final String getTableView(String id) {
        return GWT_DEBUG + id + VIEW_ID;
    }

    static final String SCREEN_CONFIG_PAGE_OPEN_PREFIX = "ConfigTab_EDIT_";
    static final String SCREEN_CONFIG_ADD_PREFIX = "ConfigTab_NEW_";
    static final String SCREEN_CONFIG_EDIT_PREFIX = "ConfigTab_EDIT_";
    static final String SUBMIT_BUTTON_SUFFIX = "_Submit";
    static final String CLOSE_BUTTON_SUFFIX = "_Close";
    static final String SCREEN_TAB_SUFFIX = "_Tab";


    /**********************************************************************************************/
    /******* Global Header  ***********************************************************************/
    /**
     * ******************************************************************************************
     */

    static final String GLOBAL = "Global";
    static final String GLOBAL_REFRESH = "_Refresh";
    static final String GLOBAL_SCHEDULER_TASK_TAB = "ScheduledTaskTab";
    static final String GLOBAL_SCHEDULER_TASKS_TAB = "scheduledTasks_Tab";
    static final String GLOBAL_SCHEDULER_TASKS = "scheduledTasks";
    static final String GLOBAL_TOOLBOX_TAB = "_ToolBox";
    static final String GLOBAL_VISION_SETTINGS_TAB = "_VisionSettings";

    static final String GLOBAL_DATE = "_Date";
    static final String GLOBAL_USERNAME = "_UserName";
    static final String GLOBAL_USERROLE = "_UserRole";
    static final String SCOPE_MENU = "groupName";

    public static String getScopeMenu() {
        return GWT_DEBUG + SCOPE_MENU + WIDGET_INPUT;
    }

    private static String getGlobalHeader() {
        return GWT_DEBUG + GLOBAL;
    }

    public static String getToolboxTab() {
        return getGlobalHeader() + GLOBAL_TOOLBOX_TAB;
    }

    public static final String getRefreshButton() {
        return getGlobalHeader() + GLOBAL_REFRESH;
    }

    public static final String getDate() {
        return getGlobalHeader() + GLOBAL_DATE;
    }

    public static final String getUserName() {
        return getGlobalHeader() + GLOBAL_USERNAME;
    }

    public static final String getUserRole() {
        return getGlobalHeader() + GLOBAL_USERROLE;
    }
    /**********************************************************************************************/
    /******* WebUI Week Days Components ***********************************************************/
    /**
     * ******************************************************************************************
     */
    static final String TIME_DAYS_COLLECTION = "time.daysCollection.";
    static final String WIDGET_LABEL = "_Widget-label";
    public static final String WIDGET_INPUT = "_Widget-input";

    public static String getWeekDay(String weekDay) {
        return GWT_DEBUG + TIME_DAYS_COLLECTION + weekDay + WIDGET_INPUT;
    }

    /**********************************************************************************************/
    /******* Dashboards ***********************************************************/
    /**
     * ******************************************************************************************
     */
    static final String TOPICS_NODE_SECURITY_CONTROL_CENTER = "TopicsNode_SecurityControlCenter";

    //gwt-debug-TopicsNode_SecurityControlCenter-content
    public static String getSecurityControlCenterNode() {
        return GWT_DEBUG + TOPICS_NODE_SECURITY_CONTROL_CENTER + CONTENT;
    }

    /**********************************************************************************************/
    /******* Templates Module Components ***********************************************************/
    /**
     * ******************************************************************************************
     */
    static final String BROWSE_SERVER = "browseServer_";
    static final String BROWSE_NETWORK = "browseNetwork_";

    public static String getDpBrowseServerButton() {
        return GWT_DEBUG + BROWSE_SERVER + FILE_UPLOAD_WIDGET;
    }

    public static String getDpBrowseNetworkButton() {
        return GWT_DEBUG + BROWSE_NETWORK + FILE_UPLOAD_WIDGET;
    }

    public static String getServerDpTemplatesFileUploadButton() {
        return GWT_DEBUG + BROWSE_SERVER + FILE_UPLOAD_SUBMIT;
    }

    public static String getNetworkDpTemplatesFileUploadButton() {
        return GWT_DEBUG + BROWSE_NETWORK + FILE_UPLOAD_SUBMIT;
    }


    /**
     * *******************************************************************************************
     * ******* Dynamic View filters
     */
    static final String SEARCH_BUTTON_DYNAMIC_VIEW = "quickSearchButton";

    public static String getDynamicViewSearchButton() {
        return GWT_DEBUG + SEARCH_BUTTON_DYNAMIC_VIEW + SEARCH_CONTROL;
    }

    public static String getDynamicViewFilter(String dynamicViewFilter) {
        return GWT_DEBUG + dynamicViewFilter + SEARCH_CONTROL;
    }

    /**********************************************************************************************/
    /******* Table Page related Components ***********************************************************/
    /**
     * ******************************************************************************************
     */
    static final String NEXT_PAGE = "nextPage";
    static final String PREVIOUS_PAGE = "prevPage";
    static final String FIRST_PAGE = "firstPage";
    static final String LAST_PAGE = "lastPage";
    static final String PAGES_COUNT = "size";
    static final String TOTAL_ROWS = "totalRows";

    public static String getNextPageButton() {
        return GWT_DEBUG + NEXT_PAGE;
    }

    public static String getPrevPageButton() {
        return GWT_DEBUG + PREVIOUS_PAGE;
    }

    public static String getFirstPageButton() {
        return GWT_DEBUG + FIRST_PAGE;
    }

    public static String getLastPageButton() {
        return GWT_DEBUG + LAST_PAGE;
    }

    public static String getPageTextBoxButton() {
        return GWT_DEBUG + PAGE_TEXT_BOX;
    }

    public static String getPagesCount() {
        return GWT_DEBUG + PAGES_COUNT;
    }

    public static String getTotalRows() {
        return GWT_DEBUG + TOTAL_ROWS;
    }
    /**********************************************************************************************/
    /******* Vision WebUI Components **************************************************************/
    /**
     * ******************************************************************************************
     */

    static final String USER_MNG_SETTINGS = "ConfigTab_EDIT_UserManagement.GlobalAAAParameters";
    static final String SEND_FILE_TO_DEVICE_TEMPLATES = "ConfigTab_EDIT_DPConfigTemplates.SendFileToDevice";
    static final String ADD_NEW_NETWORK_PROTECTION_POLICY = "ConfigTab_NEW_rsIDSNewRulesTable";
    static final String ADD_NEW_SERVER_PROTECTION_POLICY = "ConfigTab_NEW_rsIDSServerTable";
    static final String DEVICES_TO_UPDATE_APPLY_FILTER = "devicesToUpdate_ApplyFilter";
    static final String DP_CONFIGURATION_TEMPLATES_TABLE = "DPConfigurationTemplatesTable";
    static final String SEND_TO_DEVICES = "_Send_to_Devices";
    static final String DEVICE_CONTROL_BAR = "DeviceControlBar_";
    static final String SCHEDULED_TASKS_SCHEDULE = "scheduledTasks.Schedule.";
    static final String TIME_CONTROL_INPUT = ".Time_TimeControl-input";
    static final String TIME_WIDGET_INPUT = ".Time_Widget-input";
    static final String TIME_WIDGET = ".Time_Widget";
    static final String SCHEDULED_TASKS_RUN_NOW_BUTTON = "scheduledTasks_runNow";
    static final String PASSWORD_DUPLICATED_FIELD = "additionalParams.password_DuplicatePasswordField";
    static final String CLOSE_SCHEDULED_TASKS_MODULE = "ConfigTab_EDIT_Scheduler.ScheduledTasks.xml_Close";
    static final String SUBMIT_SCHEDULED_TASKS_MODULE = "ConfigTab_NEW_scheduledTasks_Submit";
    static final String ALERTS_ACKNOWLEDGE = "alerts_acknowledge";
    static final String ALERTS_UNACKNOWLEDGE = "alerts_unacknowledge";
    static final String ALERTS_FILTER_BUTTON = "alerts_undefined";
    static final String ALERTS_AUTO_REFRESH_BUTTON = "alerts_AutoRefreshButton";
    static final String ALERTS_CLEAR = "alerts_clear";
    static final String ALERTS_CLEAR_ALL = "alerts_clearall";
    static final String ALERTS_ACK_ALL = "alerts_ackall";
    static final String ALERTS_MAXIMIZE = "AlertsMaximize";
    static final String ALERTS_MINIMIZE = "ConfigTab_EDIT_AlertBrowser.Alerts_Submit";
    static final String ALERTS_FILTER_SUBMIT = "ConfigTab_EDIT_AlertBrowser.Filter_Submit";
    static final String ALERTS_TAB = "ConfigTab_EDIT_AlertBrowser.Alerts_Tab";
    static final String ALERTS_FILTER_TAB = "ConfigTab_EDIT_AlertBrowser.Filter_Tab";
    static final String VIEW_ALERTS_TAB_CLOSE = "ConfigTab_EDIT_alerts_Close";
    static final String RAISED_LAST_TIME_UNIT_COMBO = "raisedInTheLastTimeUnit_Widget-input";
    static final String RAISED_LAST_VAL_HOUR_COMBO = "raisedInTheLastVal_Hour_Widget-input";
    static final String RAISED_LAST_VAL_MIN_COMBO = "raisedInTheLastVal_Min_Widget-input";
    static final String ALERTS_MODULE_VISION_TYPE = "insite_";
    static final String ALERTS_MODULE_DEVICE_TYPE = "device_";
    static final String ALERTS_RESTORE_DEFAULTS_BUTTON = "AlertBrowser.Filter.RestoreDefaults_Widget";
    static final String PAGE_TEXT_BOX = "pageTextBox";
    static final String ALERTS_BROWSER = "ConfigTab_EDIT_MgtServer.AlertBrowser";
    static final String DEVICE_FILE_DOWNLOAD = "DeviceFile_download";
    static final String DISPLAY_EDIT = "ConfigTab_EDIT_MgtServer.Display";
    static final String MONITORING_EDIT = "ConfigTab_EDIT_MgtServer.Monitoring";
    static final String DEVICE_CONTROL_BAR_OPERATIONS = "DeviceControlBar_Operations";

    /**********************************************************************************************/
    /******* AMS String **************************************************************/
    /*****************************************************************************************/
    static final String VRM_REPORT_LIST_ITEM_CONTAINER_ID = "vrm-forensics-views-list-item-container_";

    public static String getVRMReportListItemIdByName(String name) {
        return VRM_REPORT_LIST_ITEM_CONTAINER_ID.concat(name);
    }


    public static String getDeviceControlBarOperations() {
        return GWT_DEBUG + DEVICE_CONTROL_BAR_OPERATIONS;
    }

    public static String getDeviceFileDownload() {
        return GWT_DEBUG + DEVICE_FILE_DOWNLOAD;
    }

    public static String getUserManagementSettingsSubmit() {
        return GWT_DEBUG + USER_MNG_SETTINGS + SUBMIT_BUTTON_SUFFIX;
    }

    public static String getSubmitDpTemplatesSendToFile() {
        return GWT_DEBUG + SEND_FILE_TO_DEVICE_TEMPLATES + SUBMIT_BUTTON_SUFFIX;
    }

    public static String getSubmitAddNetworkPolicy() {
        return GWT_DEBUG + ADD_NEW_NETWORK_PROTECTION_POLICY + SUBMIT_BUTTON_SUFFIX;
    }

    public static String getSubmitAddServerPolicy() {
        return GWT_DEBUG + ADD_NEW_SERVER_PROTECTION_POLICY + SUBMIT_BUTTON_SUFFIX;
    }

    public static String getDpTemplatesApplyFilter() {
        return GWT_DEBUG + DP_CONFIGURATION_TEMPLATES_TABLE + APPLY_FILTER;
    }

    public static String getDpConfigurationSearchByColumnDropdown(String columnName) {
        return GWT_DEBUG + columnName + WIDGET_INPUT;
    }

    public static String getDpConfigurationSearchByColumnText(String columnName) {
        return GWT_DEBUG + columnName + SEARCH_CONTROL;
    }

    public static String getPageTextBox() {
        return GWT_DEBUG + PAGE_TEXT_BOX;
    }

    public static String getAlertsBrowserSubmitButton() {
        return GWT_DEBUG + ALERTS_BROWSER + SUBMIT_BUTTON_SUFFIX;
    }

    public static String getDisplaySubmitButton() {
        return GWT_DEBUG + DISPLAY_EDIT + SUBMIT_BUTTON_SUFFIX;
    }

    public static String getMonitoringSubmitButton() {
        return GWT_DEBUG + MONITORING_EDIT + SUBMIT_BUTTON_SUFFIX;

    }


    public static String getScheduledTaskTableAction(String action) {
        return GWT_DEBUG + GLOBAL_SCHEDULER_TASKS + action;
    }

    public static String getDpConfigurationTemplatesTableId() {
        return GWT_DEBUG + DP_CONFIGURATION_TEMPLATES_TABLE;
    }

    public static String getDevicesToUpdateApplyFilterButton() {
        return GWT_DEBUG + DEVICES_TO_UPDATE_APPLY_FILTER;
    }

    public static String getDpTemplatesTableNewButton() {
        return GWT_DEBUG + DP_CONFIGURATION_TEMPLATES_TABLE + TABLE_ADD;
    }

    public static String getDpTemplatesTableDeleteButton() {
        return GWT_DEBUG + DP_CONFIGURATION_TEMPLATES_TABLE + TABLE_DELETE;
    }

    public static String getDpTemplatesTableDownloadButton() {
        return GWT_DEBUG + DP_CONFIGURATION_TEMPLATES_TABLE + DOWNLOAD;
    }

    public static String getDpTemplatesTableSendToDevicesButton() {
        return GWT_DEBUG + DP_CONFIGURATION_TEMPLATES_TABLE + SEND_TO_DEVICES;
    }

    public static String getTimeControlByFrequency(String timeType) {
        return SCHEDULED_TASKS_SCHEDULE + timeType + TIME_CONTROL_INPUT;
    }

    public static String getStartEndTimeWidgetByFrequency(String timeType) {
        return GWT_DEBUG + SCHEDULED_TASKS_SCHEDULE + timeType + TIME_WIDGET;
    }

    public static String getTimeWidgetByFrequency(String timeType) {
        return GWT_DEBUG + SCHEDULED_TASKS_SCHEDULE + timeType + TIME_WIDGET;
    }

    public static String getAlertsRestoreDefaultsButton() {
        return GWT_DEBUG + ALERTS_RESTORE_DEFAULTS_BUTTON;
    }

    public static String getRunNowSchedulerButton() {
        return GWT_DEBUG + SCHEDULED_TASKS_RUN_NOW_BUTTON;
    }

    public static String getAlertsDeviceTypeCombo(String deviceType) {
        if (deviceType.contains("defensepro")) {
            return GWT_DEBUG + "defense_pro" + WIDGET_INPUT;
        } else return GWT_DEBUG + deviceType + WIDGET_INPUT;
    }

    public static String getAlertsAckStatusCombo(String ackStatus) {
        if (ackStatus.contains("un")) {
            return GWT_DEBUG + "unAcknowledged" + WIDGET_INPUT;
        } else return GWT_DEBUG + ackStatus + WIDGET_INPUT;
    }


    public static String getAlertsModuleCombo(String module) {
        if (module.equals("vision analytics alerts")) {
            return GWT_DEBUG + "rt_alerts" + WIDGET_INPUT;
        }
        if (module.contains("vision")) {
            return GWT_DEBUG + ALERTS_MODULE_VISION_TYPE + module.substring(module.indexOf(" ") + 1) + WIDGET_INPUT;
        } else {
            return GWT_DEBUG + module.replace(" ", "_") + WIDGET_INPUT;
        }
    }

    public static String getAlertsSeverityCombo(String severity) {
        return GWT_DEBUG + severity + WIDGET_INPUT;
    }

    public static String getRaisedLastTimeUnitCombo() {
        return GWT_DEBUG + RAISED_LAST_TIME_UNIT_COMBO;
    }

    public static String getRaisedLastValHourCombo() {
        return GWT_DEBUG + RAISED_LAST_VAL_HOUR_COMBO;
    }

    public static String getRaisedLastValMinCombo() {
        return GWT_DEBUG + RAISED_LAST_VAL_MIN_COMBO;
    }

    public static String getViewAlertsTabCloseButton() {
        return GWT_DEBUG + VIEW_ALERTS_TAB_CLOSE;
    }

    public static String getAlertsFilterTab() {
        return GWT_DEBUG + ALERTS_FILTER_TAB;
    }

    public static String getAlertsTab() {
        return GWT_DEBUG + ALERTS_TAB;
    }

    public static String getAlertsMaximizeButton() {
        return GWT_DEBUG + ALERTS_MAXIMIZE;
    }

    public static String getAlertsMinimizeButton() {
        return GWT_DEBUG + ALERTS_MINIMIZE;
    }

    public static String getAlertsFIlterSubmitButton() {
        return GWT_DEBUG + ALERTS_FILTER_SUBMIT;
    }

    public static String getAlertsAcknowlegeButton() {
        return GWT_DEBUG + ALERTS_ACKNOWLEDGE;
    }

    public static String getAlertsClearButton() {
        return GWT_DEBUG + ALERTS_CLEAR;
    }

    public static String getAckAllAlerts() {
        return GWT_DEBUG + ALERTS_ACK_ALL;
    }

    public static String getAlertsClearAllButton() {
        return GWT_DEBUG + ALERTS_CLEAR_ALL;
    }

    public static String getAlertsUnacknowlegeButton() {
        return GWT_DEBUG + ALERTS_UNACKNOWLEDGE;
    }

    public static String getAlertsFilterButton() {
        return GWT_DEBUG + ALERTS_FILTER_BUTTON;
    }

    public static String getAlertsAutoRefreshButton() {
        return GWT_DEBUG + ALERTS_AUTO_REFRESH_BUTTON;
    }

    public static String getPasswordDuplicatedField() {
        return GWT_DEBUG + PASSWORD_DUPLICATED_FIELD;
    }

    public static String getCloseScheduledTasksModule() {
        return GWT_DEBUG + CLOSE_SCHEDULED_TASKS_MODULE;
    }

    public static String getScheduledTasksTab() {
        return GWT_DEBUG + SCREEN_CONFIG_ADD_PREFIX + GLOBAL_SCHEDULER_TASKS_TAB;
    }

    public static String getSubmitEditScheduledTasksModule() {
        return GWT_DEBUG + SCREEN_CONFIG_EDIT_PREFIX + GLOBAL_SCHEDULER_TASKS + SUBMIT_BUTTON_SUFFIX;
    }

    public static String getSubmitAddScheduledTasksModule() {
        return GWT_DEBUG + SCREEN_CONFIG_ADD_PREFIX + GLOBAL_SCHEDULER_TASKS + SUBMIT_BUTTON_SUFFIX;
    }

    public static String getCancelAddScheduledTasksModule() {
        return GWT_DEBUG + SCREEN_CONFIG_ADD_PREFIX + GLOBAL_SCHEDULER_TASKS + CLOSE_BUTTON_SUFFIX;
    }

    /**********************************************************************************************/
    /******* Vision Topology Tree Related Items *******************************************************/
    /**
     * ******************************************************************************************
     */

    static final String ADD_TREE_ELEMENT = "Add";
    static final String EDIT_TREE_ELEMENT = "Edit";
    static final String DELETE_TREE_ELEMENT = "Delete";
    static final String DEVICE_TREE_OPERATION_PREFIX = "DeviceTree";
    static final String DEVICE_TREE_SELECTION = "DeviceTreeSelection";
    static final String ADD_NEW_GROUP = "GroupAdd";
    static final String EDIT_GROUP = "GroupEdit";

    public static String getTopologyTreeOperation(String operation) {
        return GWT_DEBUG + DEVICE_TREE_OPERATION_PREFIX + operation;
    }

    public static String getDeviceTreeSelection() {
        return GWT_DEBUG + DEVICE_TREE_SELECTION;
    }

    public static String getAddNewGroupCommand() {
        return GWT_DEBUG + ADD_NEW_GROUP;
    }

    public static String getEditGroupCommand() {
        return GWT_DEBUG + EDIT_GROUP;
    }

    /**********************************************************************************************/
    /******* configuration system menu *******************************************************/
    /**
     * ******************************************************************************************
     */
    static final String LEFT_MENU_PANE_CONFIGURATION_SYSTEM = "TopicsStack_Configuration.System";
    static final String LEFT_VISION_MENU_PANE_CONFIGURATION_SYSTEM = "System";
    static final String MIDDLE_VISION_MENU_PANE_CONFIGURATION_DASHBOARDS = "Dashboards";

    static final String LEFT_MENU_PANE_CONFIGURATION_PREFERENCES = "Preferences";

    public static String getLeftMenuPaneConfigurationSystem() {
        return GWT_DEBUG + LEFT_MENU_PANE_CONFIGURATION_SYSTEM;
    }

    public static String getLeftMenuPaneConfigurationVisionSystem() {
        return GWT_DEBUG + LEFT_VISION_MENU_PANE_CONFIGURATION_SYSTEM;
    }

    public static String getMiddleMenuPaneConfigurationVisionDashboards() {
        return GWT_DEBUG + MIDDLE_VISION_MENU_PANE_CONFIGURATION_DASHBOARDS;
    }


    public static String getLeftMenuPaneConfigurationPreferences() {
        return GWT_DEBUG + LEFT_MENU_PANE_CONFIGURATION_PREFERENCES;
    }
    /**********************************************************************************************/
    /******* General Settings Related Items *******************************************************/
    /**
     * ******************************************************************************************
     */
    static final String DSV_DRIVER_VERSIONS_ENTRY = "DsvDriverVersionsEntry_";
    static final String TOPICS_NODE_GENERAL_SETTINGS = "TopicsNode_am.system.tree.generalSettings.";
    static final String TOPICS_NODE_ADDITIONAL = "TopicsNode_am.system.tree.additional.";
    static final String MANAGEMENT_ACCESS_NODE = "TopicsNode_System.tree.Node0";
    static final String MGT_SERVER_DD_MANAGEMENT = "MgtServer.DeviceDriverManagement.FileName_";
    static final String TOPICS_CLI_ACCESS_LIST = "TopicsNode_am.system.tree.userManagement.cliAccessList";
    static final String CONTENT = "-content";

    static final String UPDATE_DEVICE_DRIVER = "updateDeviceDriver";
    static final String UPDATE_TO_LATEST = "updatetolatest";
    static final String UPLOAD_DEVICE_DRIVER = "uploadDeviceDriver";
    static final String REVERT_TO_BASELINE = "reverttobaseline";
    static final String UPDATE_ALL_DRIVERS_TO_LATEST = "updatealltolatest";
    static final String BASIC_PARAMETERS = "basicParameters";
    static final String DISPLAY = "display";
    static final String DEVICE_DRIVER = "deviceDrivers";
    static final String ALERT_BROWSER = "alertBrowser";
    static final String ALERT_SETTINGS = "alertsettings";


    static final String LICENSE_MANAGEMENT = "licenseManagement";
    static final String APM_SETTINGS = "apmSettings";
    static final String DEVICE_BACKUPS = "deviceBackups";
    static final String DEVICE_SUBSCRIPTIONS = "deviceSubscriptions";
    static final String FILE_UPLOAD_WIDGET = "FileUploadWidget";
    static final String FILE_UPLOAD_SUBMIT = "FileUploadSubmit";
    static final String MANAGEMENT_PORTS = ".Management Ports";
    static final String LEFT_MENU_PANE_CONFIGURATION = "Configuration";
    static final String LEFT_MENU_PANE_MONITORING = "Monitoring";
    static final String LEFT_MENU_PANE_SECURITY_MONITORING = "Security Monitoring";
    static final String VISION_SYSTEM_SUB_MENU_ITEM = "TopicsStack_am.system.";
    static final String VISION_PREFERENCES_SUB_MENU_ITEM = "TopicsStack_am.";
    static final String ALTEON_CONFIGURATION_ITEM = "TopicsStack_";
    static final String ALTEON_MONITORING_ITEM = "TopicsStack_Monitoring";
    static final String DEFENSEPRO_CONFIGURATION_ITEM = "TopicsStack_dp.";
    static final String DEFENSEPRO_MONITORING_ITEM = "TopicsStack_.SystemExplorerPerspective.";
    static final String DEFENSEPRO_SECURITY_MONITORING_ITEM = "TopicsStack_";
    static final String DUMP_INCLUDE_PRIVATE_KEYS = "gwt-uid-1369";
    static final String MONITORING = "monitoring";

    public static String getDumpIncludePrivateKeysCheckBox() {
        return DUMP_INCLUDE_PRIVATE_KEYS;
    }

    public static String getBasicParametersItem() {
        return GWT_DEBUG + TOPICS_NODE_GENERAL_SETTINGS + BASIC_PARAMETERS + CONTENT;
    }

    public static String getDeviceSettingsMenuItem(String item) {
        return GWT_DEBUG + item;
    }

    public static String getAlteonConfigurationSubMenuItem(String item) {
        return GWT_DEBUG + ALTEON_CONFIGURATION_ITEM + item;
    }

    public static String getAlteonMonitoringSubMenuItem(String item) {
        return GWT_DEBUG + ALTEON_MONITORING_ITEM + item;
    }


    public static String getDefenceProConfigurationSubMenuItem(String item) {
        return GWT_DEBUG + DEFENSEPRO_CONFIGURATION_ITEM + item;
    }

    public static String getDefenceProMonitoringSubMenuItem(String item) {
        return GWT_DEBUG + DEFENSEPRO_MONITORING_ITEM + item;
    }

    public static String getDefenceProSecurityMonitoringSubMenuItem(String item) {
        return GWT_DEBUG + DEFENSEPRO_SECURITY_MONITORING_ITEM + item + SCREEN_TAB_SUFFIX.toLowerCase();
    }

    public static String getVisionSystemSubMenuItem(String item) {
        return GWT_DEBUG + VISION_SYSTEM_SUB_MENU_ITEM + item;
    }

    public static String getVisionPreferencesSubMenuItem(String item) {
        return GWT_DEBUG + VISION_PREFERENCES_SUB_MENU_ITEM + item;
    }

    public static String getDeviceControlBarItem(String item) {
        return GWT_DEBUG + DEVICE_CONTROL_BAR + item;
    }

    public static String getDeviceDriverLink(String actionType) {
        return GWT_DEBUG + DSV_DRIVER_VERSIONS_ENTRY + actionType;
    }

    public static String getUpdateDeviceDriver() {
        return GWT_DEBUG + DSV_DRIVER_VERSIONS_ENTRY + UPDATE_DEVICE_DRIVER;
    }

    public static String getUpdateToLatest() {
        return GWT_DEBUG + DSV_DRIVER_VERSIONS_ENTRY + UPDATE_TO_LATEST;
    }

    public static String getUploadDeviceDriver() {
        return GWT_DEBUG + DSV_DRIVER_VERSIONS_ENTRY + UPLOAD_DEVICE_DRIVER;
    }

    public static String getRevertToBaselineDriver() {
        return GWT_DEBUG + DSV_DRIVER_VERSIONS_ENTRY + REVERT_TO_BASELINE;
    }

    public static String getUpdateAllDriversToLatest() {
        return GWT_DEBUG + DSV_DRIVER_VERSIONS_ENTRY + UPDATE_ALL_DRIVERS_TO_LATEST;
    }

    public static String getLeftMenuPaneConfiguration() {
        return GWT_DEBUG + LEFT_MENU_PANE_CONFIGURATION;
    }

    public static String getLeftMenuPaneMonitoring() {
        return GWT_DEBUG + LEFT_MENU_PANE_MONITORING;
    }

    public static String getLeftMenuPaneSecurityMonitoring() {
        return GWT_DEBUG + LEFT_MENU_PANE_SECURITY_MONITORING;
    }


    //gwt-debug-TopicsNode_am.system.tree.
    public static String getGeneralSettingsMonitoringNode() {
        return GWT_DEBUG + TOPICS_NODE_GENERAL_SETTINGS + MONITORING + CONTENT;
    }

    //gwt-debug-TopicsNode_am.system.tree.additional.deviceBackups-content
    public static String getDeviceDriversNode() {
        return GWT_DEBUG + TOPICS_NODE_GENERAL_SETTINGS + DEVICE_DRIVER + CONTENT;
    }

    public static String getDisplayNode() {
        return GWT_DEBUG + TOPICS_NODE_GENERAL_SETTINGS + DISPLAY + CONTENT;
    }

    public static String getAlertBrowserNode() {
        return GWT_DEBUG + TOPICS_NODE_GENERAL_SETTINGS + ALERT_BROWSER + CONTENT;
    }

    public static String getAlertSettingsLeaf() {
        return GWT_DEBUG + TOPICS_NODE_GENERAL_SETTINGS + ALERT_SETTINGS + CONTENT;
    }


    public static String getManagementPortsNode() {
        return GWT_DEBUG + MANAGEMENT_ACCESS_NODE + MANAGEMENT_PORTS + CONTENT;
    }

    public static String getManagementAccessNode() {
        return GWT_DEBUG + MANAGEMENT_ACCESS_NODE + CONTENT;
    }

    public static String getAPMSettingsNode() {
        return GWT_DEBUG + TOPICS_NODE_GENERAL_SETTINGS + APM_SETTINGS + CONTENT;
    }

    public static String getLicenseManagementNode() {
        return GWT_DEBUG + TOPICS_NODE_GENERAL_SETTINGS + LICENSE_MANAGEMENT + CONTENT;
    }

    public static String getDeviceBackupsNode() {
        return GWT_DEBUG + TOPICS_NODE_ADDITIONAL + DEVICE_BACKUPS + CONTENT;
    }

    public static String getDeviceSubscriptionsNode() {
        return GWT_DEBUG + TOPICS_NODE_ADDITIONAL + DEVICE_SUBSCRIPTIONS + CONTENT;
    }

    public static String getCliAccessListNode() {
        return GWT_DEBUG + TOPICS_CLI_ACCESS_LIST + CONTENT;
    }

    public static String getMgtServerFileUploadWidget() {
        return GWT_DEBUG + MGT_SERVER_DD_MANAGEMENT + FILE_UPLOAD_WIDGET;
    }

    public static String getMgtServerFileUploadSubmit() {
        return GWT_DEBUG + MGT_SERVER_DD_MANAGEMENT + FILE_UPLOAD_SUBMIT;
    }

    public static String getDialogBoxClose() {
        return GWT_DEBUG + DIALOG_BOX + CLOSE_BUTTON_SUFFIX;
    }

    /**********************************************************************************************/
    /******* RBAC related Text Fields *******************************************************/
    /**
     * ******************************************************************************************
     */
    static final String CERTIFICATE_SUBJECT_DEFAULTS = "slbNewSslCfgCertsDefaults";

    public static String getCertificateSubjectDefaults(String textField) {
        return GWT_DEBUG + CERTIFICATE_SUBJECT_DEFAULTS + textField + WIDGET_SUFFIX;
    }

    /**********************************************************************************************/
    /******* Users Management Related Items *******************************************************/
    /**
     * ******************************************************************************************
     */

    static final String SEARCH_CONTROL = "_SearchControl";
    static final String USER_FULL_NAME = "userFullName";
    static final String USER_NAME = "userName";
    static final String LAST_LOGIN_DATE = "lastLoginDate";
    static final String STATISTICS_DAY = "statisticsDay";
    static final String NUM_SUCCESSFUL_AUTH = "numSuccessfulAuth";
    static final String NUM_FAILED_AUTH = "numFailedAuth";
    static final String NUM_SUCCESSFUL_CHANGES = "numPasswordChanges";
    static final String NUM_LOCK_OUTS = "numLockOuts";
    static final String USERS_STATISTICS_FILTER = "ConfigTab_EDIT_UserManagement.StatisticsFilter_Tab";
    static final String USERS_STATISTICS_APPLY_FILTER = "UserStatistics_ApplyFilter";
    static final String USER_ENABLE = "User_enable";
    static final String USER_REVOKE = "User_revoke";
    static final String USER_UNLOCK = "User_unlock";
    static final String USER_RESET_PWD = "User_resetpwd";
    static final String USER = "User";
    static final String USER_ROLE_GROUP = "roleGroupPairList";


    public static String getUserFullNameSearch() {
        return GWT_DEBUG + USER_FULL_NAME + SEARCH_CONTROL;
    }

    public static String getUserNameSearch() {
        return GWT_DEBUG + USER_NAME + SEARCH_CONTROL;
    }

    public static String getLoginDateAndTimeSearch() {
        return GWT_DEBUG + LAST_LOGIN_DATE + SEARCH_CONTROL;
    }

    public static String getStatisticsDateSearch() {
        return GWT_DEBUG + STATISTICS_DAY + SEARCH_CONTROL;
    }

    public static String getNumSuccessfulLoginsSearch() {
        return GWT_DEBUG + NUM_SUCCESSFUL_AUTH + SEARCH_CONTROL;
    }

    public static String getNumFailedLoginsSearch() {
        return GWT_DEBUG + NUM_FAILED_AUTH + SEARCH_CONTROL;
    }

    public static String getNumPasswordChangesSearch() {
        return GWT_DEBUG + NUM_SUCCESSFUL_CHANGES + SEARCH_CONTROL;
    }

    public static String getNumLockOutsSearch() {
        return GWT_DEBUG + NUM_LOCK_OUTS + SEARCH_CONTROL;
    }

    public static String getUsersStatisticsMenu() {
        return GWT_DEBUG + USERS_STATISTICS_FILTER;
    }

    public static String getFilterApplyButton() {
        return GWT_DEBUG + USERS_STATISTICS_APPLY_FILTER;
    }

    public static String getUserEnableButton() {
        return GWT_DEBUG + USER_ENABLE;
    }

    public static String getUserRevokeButton() {
        return GWT_DEBUG + USER_REVOKE;
    }

    public static String getUserUnlockButton() {
        return GWT_DEBUG + USER_UNLOCK;
    }

    public static String getUserResetPwdButton() {
        return GWT_DEBUG + USER_RESET_PWD;
    }

    public static String getUserAddTabSubmit() {
        return GWT_DEBUG + SCREEN_CONFIG_ADD_PREFIX + USER + SUBMIT_BUTTON_SUFFIX;
    }

    public static String getUserRoleGroupSubmit() {
        return GWT_DEBUG + SCREEN_CONFIG_ADD_PREFIX + USER_ROLE_GROUP + SUBMIT_BUTTON_SUFFIX;
    }


}
