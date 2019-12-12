package com.radware.vision.infra.testhandlers.localization.deviceproperties;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.localization.impl.DevicePropertySet;
import com.radware.restcore.VisionRestClient;
import com.radware.utils.DeviceUtils;
import com.radware.vision.pojomodel.device.DevicePojo;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created by stanislava on 7/7/2015.
 */
public class DevicePropertiesValidation {

    public static List<DevicePropertySet> validateDeviceProperties(String deviceName) {
        TopologyTreeHandler.clickTreeNode(deviceName);
        BasicOperationsHandler.delay(1);
        String props = "";
        long startTime = System.currentTimeMillis();
        do {
            props = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.XPATH, "//div[contains(@class,'" + "treeNodelabelTextArea" + "')]").getBy(), WebUIUtils.SHORT_WAIT_TIME, false).getText();
        }
        while (props.isEmpty() && (System.currentTimeMillis() - startTime < 30 * 1000));
        return parseDeviceProperties(props);
    }

    public static List<DevicePropertySet> parseDeviceProperties(String props) {
        List<String> deviceProperties = new ArrayList<String>();

        List<DevicePropertySet> actualPropsValues = new ArrayList<DevicePropertySet>();
        deviceProperties = Arrays.asList(props.split("\n"));
        for (int i = 0; i < deviceProperties.size(); i++) {
            actualPropsValues.add(i, new DevicePropertySet(deviceProperties.get(i).substring(0, deviceProperties.get(i).indexOf(":")), deviceProperties.get(i).substring(deviceProperties.get(i).indexOf(":") + 2, deviceProperties.get(i).length())));
        }

        return actualPropsValues;
    }

    public static String getDevicePropertiesRest(String deviceName, VisionRestClient visionRestClient) {
        DevicePojo deviceResult = DeviceUtils.getDeviceByName(visionRestClient, deviceName);

        return "";
    }
}
