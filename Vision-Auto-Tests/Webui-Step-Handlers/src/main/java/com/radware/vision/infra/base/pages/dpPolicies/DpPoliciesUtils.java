package com.radware.vision.infra.base.pages.dpPolicies;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDualListMultiColumn;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import org.openqa.selenium.support.How;

import java.util.HashMap;
import java.util.List;

/**
 * Created by StanislavA on 12/6/2015.
 */
public class DpPoliciesUtils extends WebUIVisionBasePage {

    public static void addNetworkPoliciesMultiColumns(List<String> devices, List<String> networkPolicies, String dualListId) {
        innerRemoveNetworkPoliciesMultiColumns(devices, networkPolicies, dualListId, false);
    }

    public static void removeNetworkPoliciesMultiColumns(List<String> devices, List<String> networkPolicies, String dualListId) {
        innerRemoveNetworkPoliciesMultiColumns(devices, networkPolicies, dualListId,true);
    }

    public static void innerRemoveNetworkPoliciesMultiColumns(List<String> devices, List<String> networkPolicies, String dualListId, boolean remove) {
        HashMap<Integer, String> devicePolicyPair = new HashMap<Integer, String>();
        ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-".concat(dualListId));
        WebUIDualListMultiColumn dualListMultiColumn = new WebUIDualListMultiColumn(new WebUIComponent(locator));
        dualListMultiColumn.setRawId(dualListId);
        for (int i = 0; i < devices.size(); i++) {
            devicePolicyPair.clear();
            devicePolicyPair.put(0, devices.get(i));
            devicePolicyPair.put(1, networkPolicies.get(i));
            if (remove) {
                dualListMultiColumn.moveLeftByValue(devicePolicyPair);
            } else {
                dualListMultiColumn.moveRightByValue(devicePolicyPair);
            }
        }
    }
}
