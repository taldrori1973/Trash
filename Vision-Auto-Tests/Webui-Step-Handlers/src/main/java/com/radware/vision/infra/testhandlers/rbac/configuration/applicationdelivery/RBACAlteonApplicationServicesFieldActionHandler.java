package com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.HashMap;

/**
 * Created by stanislava on 1/7/2015.
 */
public class RBACAlteonApplicationServicesFieldActionHandler extends RBACHandlerBase {

    public static boolean verifySSLCertificateRepositoryFieldAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mSSL().mCertificateRepository().mCertificateSubjectDefaults().openPage();

        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getCertificateSubjectDefaults(testProperties.get("certificateSubjectDefaultsFieldAction")));
        WebUIComponent component = new WebUIComponent(itemLocator);
        return component.isItemEnabled(expectedResultRBAC, itemLocator);
    }
}
