package com.radware.vision.tests.rbac;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.testhandlers.rbac.RBACTableVisionActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.*;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by stanislava on 9/3/2014.
 */
public class RBACVisionTableActionTests extends RBACTestBase {
    SchedulerTableActions schedulerTableAction = SchedulerTableActions.NEW;
    DpTemplateTableActions dpTemplateTableAction = DpTemplateTableActions.NEW;
    LocalUserTableActions localUserTableAction = LocalUserTableActions.NEW;
    CLIAccessListTableActions cliAccessListTableAction = CLIAccessListTableActions.NEW;
    DeviceBackupsTableActions deviceBackupsTableAction = DeviceBackupsTableActions.EDIT;
    DeviceDriversTableActions deviceDriversTableAction = DeviceDriversTableActions.UPDATE_DEVICE_DRIVER;
    BaseTableActions licenseManagementTableAction = BaseTableActions.NEW;
    BaseTableActions apmSettingsTableAction = BaseTableActions.NEW;
    AlertsTableActions AlertsTableAction = AlertsTableActions.VIEW;

    boolean clickOnTableRow = true;

    @Test
    @TestProperties(name = "verify Scheduler Disabled Table Action", paramsInclude = {"qcTestId", "schedulerTableAction", "clickOnTableRow", "expectedResult"})
    public void verifySchedulerDisabledTableAction() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if(!(RBACTableVisionActionHandler.verifySchedulerTableAction(schedulerTableAction.getTableAction().toString(), clickOnTableRow))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + schedulerTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        }
        catch(Exception e) {
            BaseTestUtils.report("verify Scheduler Disabled Table Action failed: " + schedulerTableAction.getTableAction() + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }
    @Test
    @TestProperties(name = "verify DP Templates Disabled Table Action", paramsInclude = {"qcTestId", "dpTemplateTableAction", "clickOnTableRow", "expectedResult"})
    public void verifyDpTemplatesDisabledTableAction() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if(!(RBACTableVisionActionHandler.verifyDpTemplatesTableAction(dpTemplateTableAction.getTableAction().toString(), clickOnTableRow))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + dpTemplateTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        }
        catch(Exception e) {
            BaseTestUtils.report("verify Templates Disabled Table Action failed: " + dpTemplateTableAction.getTableAction() + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Local User Table Disabled Action", paramsInclude = {"qcTestId", "localUserTableAction", "clickOnTableRow", "expectedResult"})
    public void verifyLocalUserTableDisabledAction() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if(!(RBACTableVisionActionHandler.verifyLocalUsersTableAction(localUserTableAction.getTableAction().toString(), clickOnTableRow))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + localUserTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        }
        catch(Exception e) {
            BaseTestUtils.report("verify Local User Disabled Table Action failed: " + schedulerTableAction.getTableAction() + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify CLI Access List Table Disabled Action", paramsInclude = {"qcTestId", "cliAccessListTableAction", "clickOnTableRow", "expectedResult"})
    public void verifyCLIAccessListTableDisabledAction() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if(!(RBACTableVisionActionHandler.verifyCLIAccessListTableAction(cliAccessListTableAction.getTableAction().toString(), clickOnTableRow))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + cliAccessListTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        }
        catch(Exception e) {
            BaseTestUtils.report("verify CLI Access List Disabled Table Action failed: " + cliAccessListTableAction.getTableAction() + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }
    @Test
    @TestProperties(name = "verify Device Backups Table Disabled Action", paramsInclude = {"qcTestId", "deviceBackupTableAction", "clickOnTableRow", "expectedResult"})
    public void verifyDeviceBackupsTableDisabledAction() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if(!(RBACTableVisionActionHandler.verifyDeviceBackupsTableAction(deviceBackupsTableAction.getTableAction().toString(), clickOnTableRow))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + deviceBackupsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        }
        catch(Exception e) {
            BaseTestUtils.report("verify Device Backups Disabled Table Action failed: " + deviceBackupsTableAction.getTableAction() + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Device Drivers Table Disabled Action", paramsInclude = {"qcTestId", "deviceDriversTableAction", "clickOnTableRow", "expectedResult"})
    public void verifyDeviceDriversTableDisabledAction() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if(!(RBACTableVisionActionHandler.verifyDeviceDriversTableAction(deviceDriversTableAction.getTableAction().toString(), clickOnTableRow))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + deviceDriversTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        }
        catch(Exception e) {
            BaseTestUtils.report("verify Device Drivers Disabled Table Action failed: " + deviceDriversTableAction.getTableAction() + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify License Management Table Disabled Action", paramsInclude = {"qcTestId", "licenseManagementTableAction", "clickOnTableRow", "expectedResult"})
    public void verifyLicenseManagementTableDisabledAction() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if(!(RBACTableVisionActionHandler.verifyLicenseManagementTableAction(licenseManagementTableAction.getTableAction().toString(), clickOnTableRow))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + licenseManagementTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        }
        catch(Exception e) {
            BaseTestUtils.report("verify License Management Disabled Table Action failed: " + licenseManagementTableAction.getTableAction() + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }
    @Test
    @TestProperties(name = "verify APM Settings Table Disabled Action", paramsInclude = {"qcTestId", "apmSettingsTableAction", "clickOnTableRow", "expectedResult"})
    public void verifyAPMSettingsTableDisabledAction() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if(!(RBACTableVisionActionHandler.verifyAPMSettingsTableAction(apmSettingsTableAction.getTableAction().toString(), clickOnTableRow))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + apmSettingsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        }
        catch(Exception e) {
            BaseTestUtils.report("verify APM Settings Disabled Table Action failed: " + apmSettingsTableAction.getTableAction() + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    //========================================
    @Test
    @TestProperties(name = "verify Alerts Table Disabled Action", paramsInclude = {"qcTestId", "AlertsTableAction", "clickOnTableRow", "expectedResult"})
    public void verifyAlertsTableDisabledAction() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if (!(RBACTableVisionActionHandler.verifyAlertsTableAction(AlertsTableAction.getTableAction().toString(), clickOnTableRow))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + AlertsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Alerts Table Disabled Table Action failed: " + AlertsTableAction.getTableAction() + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public AlertsTableActions getAlertsTableAction() {
        return AlertsTableAction;
    }

    public void setAlertsTableAction(AlertsTableActions alertsTableAction) {
        AlertsTableAction = alertsTableAction;
    }

    public DeviceDriversTableActions getDeviceDriversTableAction() {
        return deviceDriversTableAction;
    }

    public void setDeviceDriversTableAction(DeviceDriversTableActions deviceDriversTableAction) {
        this.deviceDriversTableAction = deviceDriversTableAction;
    }

    public SchedulerTableActions getSchedulerTableAction() {
        return schedulerTableAction;
    }
    @ParameterProperties(description = "Please, select a table action type You would like to verify.")
    public void setSchedulerTableAction(SchedulerTableActions schedulerTableAction) {
        this.schedulerTableAction = schedulerTableAction;
    }

    public DpTemplateTableActions getDpTemplateTableAction() {
        return dpTemplateTableAction;
    }
    @ParameterProperties(description = "Please, select a table action type You would like to verify.")
    public void setDpTemplateTableAction(DpTemplateTableActions dpTemplateTableAction) {
        this.dpTemplateTableAction = dpTemplateTableAction;
    }

    public boolean getClickOnTableRow() { return clickOnTableRow; }
    @ParameterProperties(description = "choose <true> to click on table's row.")
    public void setClickOnTableRow(boolean clickOnTableRow) {
        this.clickOnTableRow = clickOnTableRow;
    }

    public LocalUserTableActions getLocalUserTableAction() {
        return localUserTableAction;
    }
    @ParameterProperties(description = "Please, select a table action type You would like to verify.")
    public void setLocalUserTableAction(LocalUserTableActions localUserTableAction) {
        this.localUserTableAction = localUserTableAction;
    }

    public CLIAccessListTableActions getCliAccessListTableAction() {
        return cliAccessListTableAction;
    }
    @ParameterProperties(description = "Please, select a table action type You would like to verify.")
    public void setCliAccessListTableAction(CLIAccessListTableActions cliAccessListTableAction) {
        this.cliAccessListTableAction = cliAccessListTableAction;
    }

    public DeviceBackupsTableActions getDeviceBackupsTableAction() {
        return deviceBackupsTableAction;
    }
    @ParameterProperties(description = "Please, select a table action type You would like to verify.")
    public void setDeviceBackupsTableAction(DeviceBackupsTableActions deviceBackupsTableAction) {
        this.deviceBackupsTableAction = deviceBackupsTableAction;
    }

    public BaseTableActions getLicenseManagementTableAction() {
        return licenseManagementTableAction;
    }
    @ParameterProperties(description = "Please, select a table action type You would like to verify.")
    public void setLicenseManagementTableAction(BaseTableActions licenseManagementTableAction) {
        this.licenseManagementTableAction = licenseManagementTableAction;
    }

    public BaseTableActions getApmSettingsTableAction() {
        return apmSettingsTableAction;
    }
    public void setApmSettingsTableAction(BaseTableActions apmSettingsTableAction) { this.apmSettingsTableAction = apmSettingsTableAction; }
}
