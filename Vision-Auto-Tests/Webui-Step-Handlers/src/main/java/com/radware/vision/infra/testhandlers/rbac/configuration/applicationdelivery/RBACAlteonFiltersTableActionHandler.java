package com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery;

import com.radware.automation.webui.webpages.configuration.appDelivery.Filters.Filters;
import com.radware.automation.webui.webpages.configuration.appDelivery.Filters.patternMatchingGroup.PatternMatchingGroup;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonFiltersTableActionHandler extends RBACHandlerBase {

    public static boolean verifyFiltersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Filters filters = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mFilters();
        filters.openPage();

        WebUITable table = filters.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("filtersTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPatternMatchingGroupTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PatternMatchingGroup patternMatchingGroup = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mFilters().mPatternMatchingGroup();
        patternMatchingGroup.openPage();

        WebUITable table = patternMatchingGroup.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("patternMatchingGroupTableAction"), expectedResultRBAC);
        return result;
    }

}
