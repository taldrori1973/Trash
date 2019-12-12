package com.radware.vision.infra.testhandlers.DefencePro.dpConfiguration.setup.globalparameters;


import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.base.pages.DpMenuPane;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;


/**
 * Created by moaada on 7/25/2017.
 */
public class GlobalParametersHandler extends BaseHandler {

    private static String parentTree = TopologyTreeTabs.SitesAndClusters.getTopologyTreeTab();

    public static void updateLocation(String location, String deviceName) throws TargetWebElementNotFoundException {
        lockUnlockDevice(deviceName, parentTree, DeviceState.Lock.getDeviceState(), false);

        DpMenuPane.openSetup().globalParameters().setLocation(location);
        WebUIVisionBasePage.submit();

        DeviceOperationsHandler.atomicLockUnlockDevice(DeviceState.UnLock.getDeviceState());
    }

    public static String getLocation(String deviceName) {
        lockUnlockDevice(deviceName, parentTree, DeviceState.UnLock.getDeviceState(), false);
        return DpMenuPane.openSetup().globalParameters().getLocation();


    }


}
