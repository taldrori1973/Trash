package com.radware.vision.infra.testhandlers.alteon.configuration.system;

import com.radware.automation.webui.webpages.configuration.system.licensing.Licensing;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by konstantinr on 6/3/2015.
 */
public class LicensingHandler extends BaseHandler {

    public static void setLicenseString(HashMap<String, String> testProperties){
        Licensing licensing = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mLicensing();
        initLockDevice(testProperties);
        licensing.openPage();
        licensing.setLicenseString(testProperties.get("licenseString"));
        licensing.submit();
    }

    public static  void viewCapacityLicenses(HashMap<String, String> testProperties){
        Licensing licensing = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mLicensing();
        initLockDevice(testProperties);
        licensing.openPage();
        licensing.viewCapacityLicenses();
    }

    public static  void viewFeatureLicenses(HashMap<String, String> testProperties){
        Licensing licensing = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mLicensing();
        initLockDevice(testProperties);
        licensing.openPage();
        licensing.viewFeatureLicenses();
    }

    public static  void viewLastInstalledLicenseStrings(HashMap<String, String> testProperties){
        Licensing licensing = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mLicensing();
        initLockDevice(testProperties);
        licensing.openPage();
        licensing.viewLastInstalledLicenseStrings();
    }
}
