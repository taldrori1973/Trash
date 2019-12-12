package com.radware.vision.infra.base.pages.system.deviceresources;

import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.system.deviceresources.devicebackups.DeviceBackups;
import com.radware.vision.infra.base.pages.system.deviceresources.devicesubscriptions.DeviceSubscriptions;

/**
 * Created by stanislava on 9/4/2014.
 */
public class DeviceResources extends WebUIVisionBasePage {
    public DeviceBackups deviceBackupsMenu() {
        return (DeviceBackups) new DeviceBackups().openPage();
    }

    public DeviceSubscriptions deviceSubscriptionsMenu() {
        return (DeviceSubscriptions) new DeviceSubscriptions().openPage();
    }
}
