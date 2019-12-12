package com.radware.vision.infra.testhandlers.alteon.configuration.system.managementaccess;


import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.base.pages.AlteonMenuPane;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.testhandlers.BaseHandler;

/**
 * Created by moaada on 7/27/2017.
 */
public class ManagementAccessHandler extends BaseHandler {


    public static String getIdleTimeout(String deviceName, String parentTree) {

        lockUnlockDevice(deviceName, parentTree, DeviceState.UnLock.getDeviceState(), false);
        return AlteonMenuPane.openSystem().managementAccess().getIdleTimeout();

    }

    public static void updateIdleTimeout(String deviceName, String parentTree, String value) throws TargetWebElementNotFoundException {

        lockUnlockDevice(deviceName, parentTree, DeviceState.Lock.getDeviceState(), false);
        AlteonMenuPane.openSystem().managementAccess().setIdleTimeOut(value);
        WebUIVisionBasePage.submit();
        atomicLockUnlockDevice(DeviceState.UnLock.getDeviceState());

    }


}
