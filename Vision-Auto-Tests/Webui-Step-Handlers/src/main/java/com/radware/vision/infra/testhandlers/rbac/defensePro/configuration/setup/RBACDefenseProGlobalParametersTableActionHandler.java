package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup;

import com.radware.automation.webui.webpages.dp.configuration.setup.globalParameters.certificates.Certificates;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/29/2014.
 */
public class RBACDefenseProGlobalParametersTableActionHandler extends RBACHandlerBase {
    public static boolean verifyCertificatesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Certificates certificates = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mGlobalParameters().mCertificates();
        certificates.openPage();

        WebUITable table = certificates.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("certificatesTableAction"), expectedResultRBAC);
        return result;
    }

}
