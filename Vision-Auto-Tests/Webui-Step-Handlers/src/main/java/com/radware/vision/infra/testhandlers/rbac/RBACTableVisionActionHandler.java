package com.radware.vision.infra.testhandlers.rbac;

import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.alerts.Alerts;
import com.radware.vision.infra.base.pages.dptemplates.DpTemplates;
import com.radware.vision.infra.base.pages.navigation.WebUIUpperBar;
import com.radware.vision.infra.base.pages.scheduledtasks.ScheduledTasks;
import com.radware.vision.infra.base.pages.system.deviceresources.DeviceResources;
import com.radware.vision.infra.base.pages.system.deviceresources.devicebackups.DeviceBackups;
import com.radware.vision.infra.base.pages.system.generalsettings.apmsettings.APMSettings;
import com.radware.vision.infra.base.pages.system.generalsettings.devicedrivers.DeviceDrivers;
import com.radware.vision.infra.base.pages.system.generalsettings.licensemanagement.LicenseManagement;
import com.radware.vision.infra.base.pages.system.usermanagement.UserManagement;
import com.radware.vision.infra.base.pages.system.usermanagement.cliaccesslist.CliAccessList;
import com.radware.vision.infra.enums.UpperBarItems;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.system.usermanagement.localusers.LocalUsersHandler;

/**
 * Created by stanislava on 9/3/2014.
 */
public class RBACTableVisionActionHandler extends RBACHandlerBase {
    public static boolean verifySchedulerTableAction(String action, Boolean clickOnRow) {
        BasicOperationsHandler.scheduler(true);
        ScheduledTasks scheduledTasks = new ScheduledTasks();
        WebUITable table = scheduledTasks.getTaskTable();
        if (table.getRowsNumber() > 0 && clickOnRow) {
            table.clickOnRow(0);
        }

        boolean result = table.isTableActionDisabled(action, expectedResultRBAC);
        return result;
    }

    public static boolean verifyDpTemplatesTableAction(String action, Boolean clickOnRow) {
        WebUIUpperBar.select(UpperBarItems.ToolBox_Advanced);
        DpTemplates templates = new DpTemplates();
        WebUITable table = templates.getTemplatesTable();
        if (table.getRowsNumber() > 0 && clickOnRow) {
            table.clickOnRow(0);
        }
        boolean result = table.isTableActionDisabled(action, expectedResultRBAC);
        return result;
    }

    public static boolean verifyLocalUsersTableAction(String action, Boolean clickOnRow) {

        WebUITable table = LocalUsersHandler.getLocalUsers().getLocalUsersTable();
        if (table.getRowsNumber() > 0 && clickOnRow) {
            table.clickOnRow(0);
        }
        boolean result = table.isTableActionDisabled(action, expectedResultRBAC);
        return result;
    }

    public static boolean verifyCLIAccessListTableAction(String action, Boolean clickOnRow) {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        UserManagement userManagement = menuPane.openSystemUserManagement();
        CliAccessList cliAccessList = userManagement.cliAccessListMenu();
        WebUITable table = cliAccessList.getCLIAccessListTable();
        if (table.getRowsNumber() > 0 && clickOnRow) {
            table.clickOnRow(0);
        }
        boolean result = table.isTableActionDisabled(action, expectedResultRBAC);
        return result;
    }

    public static boolean verifyDeviceBackupsTableAction(String action, Boolean clickOnRow) {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        DeviceResources deviceResources = menuPane.openSystemDeviceResources();
        DeviceBackups deviceBackups = deviceResources.deviceBackupsMenu();

        WebUITable table = deviceBackups.getDeviceBackupsTable();
        if (table.getRowsNumber() > 0 && clickOnRow) {
            table.clickOnRow(0);
        }
        boolean result = table.isTableActionDisabled(action, expectedResultRBAC);
        return result;
    }

    public static boolean verifyDeviceDriversTableAction(String action, Boolean clickOnRow) {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        DeviceDrivers deviceDrivers = menuPane.openSystemGeneralSettings().deviceDriversMenu();

        WebUITable table = deviceDrivers.getDeviceDriversTable();
        if (table.getRowsNumber() > 0 && clickOnRow) {
            table.clickOnRow(0);
        }
        boolean result = table.isTableActionDisabled(action, expectedResultRBAC);
        return result;
    }

    public static boolean verifyLicenseManagementTableAction(String action, Boolean clickOnRow) {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        LicenseManagement licenseManagement = menuPane.openSystemGeneralSettings().licenseManagementMenu();

        WebUITable table = licenseManagement.getLicenseManagementTable();
        if (table.getRowsNumber() > 0 && clickOnRow) {
            table.clickOnRow(0);
        }
        boolean result = table.isTableActionDisabled(action, expectedResultRBAC);
        return result;
    }

    public static boolean verifyAPMSettingsTableAction(String action, Boolean clickOnRow) {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        APMSettings apmSettings = menuPane.openSystemGeneralSettings().apmSettingsMenu();

        WebUITable table = apmSettings.getAPMSettingsTable();
        if (table.getRowsNumber() > 0 && clickOnRow) {
            table.clickOnRow(0);
        }
        boolean result = table.isTableActionDisabled(action, expectedResultRBAC);
        return result;
    }

    public static boolean verifyAlertsTableAction(String action, Boolean clickOnRow) {
        Alerts alerts = new Alerts();
        alerts.alertsMaximize();

        WebUITable table = alerts.retrieveAlertsTable();
        if (table.getRowsNumber() > 0 && Boolean.valueOf(clickOnRow)) {
            table.clickOnRow(0);
        }

        boolean result = table.isTableActionDisabled(action, expectedResultRBAC);
        return result;
    }
}
