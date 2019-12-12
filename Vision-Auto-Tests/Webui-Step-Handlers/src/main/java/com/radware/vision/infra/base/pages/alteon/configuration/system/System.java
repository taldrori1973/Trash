package com.radware.vision.infra.base.pages.alteon.configuration.system;

import com.radware.vision.infra.base.pages.alteon.configuration.system.managementaccess.ManagementAccess;

/**
 * Created by moaada on 7/27/2017.
 */
public class System {

    public static ManagementAccess managementAccess() {

        return (ManagementAccess) new ManagementAccess().openPage();
    }
}
