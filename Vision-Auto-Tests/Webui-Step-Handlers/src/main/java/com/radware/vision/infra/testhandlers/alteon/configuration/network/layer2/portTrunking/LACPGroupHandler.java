package com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2.portTrunking;

import com.radware.automation.webui.webpages.configuration.network.layer2.portTrunking.lacpGroup.LACPGroup;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 6/10/2015.
 */
public class LACPGroupHandler extends BaseHandler {

    public static void configLACPGroup(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        LACPGroup lacpGroup = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTrunking().mLACPGroup();
        lacpGroup.openPage();
        lacpGroup.setLACPName(testProperties.get("LACPGroupName"));
        lacpGroup.setLACPPriority(testProperties.get("SystemPriority"));
        lacpGroup.selectLACPTimeout(testProperties.get("timeout"));
        lacpGroup.submit();
    }

    public static void editLACPGroup(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        LACPGroup lacpGroup = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTrunking().mLACPGroup();
        lacpGroup.openPage();
        lacpGroup.editLACPPort(testProperties.get("rowNumber"));
        lacpGroup.selectLACPState(testProperties.get("LACPState"));
        lacpGroup.setAdminKey(testProperties.get("AdminKey"));
        lacpGroup.setPortPriority(testProperties.get("Priority"));
        lacpGroup.submit();
    }

}
