package com.radware.vision.infra.testhandlers.DefencePro.dpConfiguration.setup.securitySettings;

import com.radware.automation.webui.events.PopupEventHandler;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.fraudprotection.FraudProtection;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.fraudprotection.SubmitDialogBoxButtons;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 4/26/2015.
 */
public class FraudProtectionHandler extends BaseHandler {

    public static void resetRSASignaturesLastUpdateField(HashMap<String, String> properties) throws Exception {
        enableFraudProtection(properties);
        disableFraudProtection(properties);
    }

    public static void enableFraudProtection(HashMap<String, String> properties) {
        PopupEventHandler popupEventHandler = new PopupEventHandler();
        initLockDevice(properties);
        FraudProtection fraudProtection = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mFraudProtection();
        fraudProtection.openPage();
        fraudProtection.disableFraudProtection();
        fraudProtection.submit();
        SubmitDialogBoxButtons submitDialogBoxButtons = new SubmitDialogBoxButtons();
        submitDialogBoxButtons.clickSubmitAndResetButton();
        BasicOperationsHandler.delay(360);
        popupEventHandler.handle();
    }

    public static void disableFraudProtection(HashMap<String, String> properties) {
        PopupEventHandler popupEventHandler = new PopupEventHandler();
        initLockDevice(properties);
        FraudProtection fraudProtection = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mFraudProtection();
        fraudProtection.openPage();
        fraudProtection.enableFraudProtection();
        fraudProtection.submit();
        SubmitDialogBoxButtons submitDialogBoxButtons = new SubmitDialogBoxButtons();
        submitDialogBoxButtons.clickSubmitAndResetButton();
        BasicOperationsHandler.delay(360);
        popupEventHandler.handle();
    }
}
