package com.radware.vision.infra.testhandlers.multipleUseHandlers;

import com.radware.vision.infra.testhandlers.rbac.RBACHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;

/**
 * Created by stanislava on 9/16/2015.
 */
public class MultipleUseHandlers {

    public static boolean verifyLockUnlockOperation(boolean expectedResult, String deviceName, String parentTree) {
        RBACHandlerBase.expectedResultRBAC = expectedResult;
        return RBACHandler.verifyDeviceStateOperation(deviceName, parentTree);
    }
}
