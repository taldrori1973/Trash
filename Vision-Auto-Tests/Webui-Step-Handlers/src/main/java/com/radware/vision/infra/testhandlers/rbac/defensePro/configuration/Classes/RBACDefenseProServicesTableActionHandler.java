package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.Classes;

import com.radware.automation.webui.webpages.dp.configuration.classes.services.andgroups.ANDGroups;
import com.radware.automation.webui.webpages.dp.configuration.classes.services.basicfilters.BasicFilters;
import com.radware.automation.webui.webpages.dp.configuration.classes.services.orgroups.ORGroups;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProServicesTableActionHandler extends RBACHandlerBase {

    public static boolean verifyBasicFiltersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        BasicFilters basicFilters = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mClasses().mServices().mBasicFilters();
        basicFilters.openPage();

        WebUITable table = basicFilters.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("basicFiltersTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyANDGroupsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ANDGroups andGroups = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mClasses().mServices().mANDGroups();
        andGroups.openPage();

        WebUITable table = andGroups.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("andGroupsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyORGroupsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ORGroups orGroups = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mClasses().mServices().mORGroups();
        orGroups.openPage();

        WebUITable table = orGroups.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("orGroupsTableAction"), expectedResultRBAC);
        return result;
    }

}
