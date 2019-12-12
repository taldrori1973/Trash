package com.radware.vision.infra.testhandlers.rbac.configuration.system;

import com.radware.automation.webui.webpages.configuration.system.users.localUsers.LocalUsers;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonUsersTableActionHandler extends RBACHandlerBase {
    public static boolean verifyLocalUsersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        LocalUsers localUsers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mUsers().mLocalUsers();
        localUsers.openPage();

        WebUITable table = localUsers.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("localUsersTableAction"), expectedResultRBAC);
        return result;
    }
}
