package com.radware.vision.infra.base.pages.system.usermanagement.localusers;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDualListMultiColumn;
import com.radware.automation.webui.widgets.impl.table.WebUIRow;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by stanislava on 1/22/2015.
 */
public class AuthorizedNetworkPolicies extends WebUIVisionBasePage {


    final String networkPolicies = "Authorized network Policies for Security Monitoring";

    public void addNetworkPoliciesMultiColumns(List<String> devices, List<String> networkPolicies) {
        innerRemoveNetworkPoliciesMultiColumns(devices, networkPolicies, false);
    }

    public void removeNetworkPoliciesMultiColumns(List<String> devices, List<String> networkPolicies) {
        innerRemoveNetworkPoliciesMultiColumns(devices, networkPolicies, true);
    }

    private void innerRemoveNetworkPoliciesMultiColumns(List<String> devices, List<String> networkPolicies, boolean remove) {
        HashMap<Integer, String> devicePolicyPair = new HashMap<Integer, String>();
        ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-UserManagement.Users.Column_4");
        WebUIDualListMultiColumn dualListMultiColumn = new WebUIDualListMultiColumn(new WebUIComponent(locator));
        dualListMultiColumn.setRawId("UserManagement.Users.Column_4");
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

    public String validatePolicyExistenceSelectedList(List<String> devices, List<String> networkPolicies, boolean expectedResult) {
        HashMap<Integer, String> devicePolicyPair = new HashMap<Integer, String>();
        ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-UserManagement.Users.Column_4");
        WebUIDualListMultiColumn dualListMultiColumn = new WebUIDualListMultiColumn(new WebUIComponent(locator));
        dualListMultiColumn.setRawId("UserManagement.Users.Column_4");
        String failedPolicies = "";
        for (int i = 0; i < devices.size(); i++) {
            devicePolicyPair.clear();
            devicePolicyPair.put(0, devices.get(i));
            devicePolicyPair.put(1, networkPolicies.get(i));
            if (!(dualListMultiColumn.isItemSelectedList(devicePolicyPair) == expectedResult)) {
                failedPolicies.concat(devicePolicyPair.get(0).concat(",")).concat("\n\r");
            }
        }
        return failedPolicies;
    }

    public String validatePolicyExistenceAvailableList(List<String> devices, List<String> networkPolicies, boolean expectedResult) {
        HashMap<Integer, String> devicePolicyPair = new HashMap<Integer, String>();
        ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-UserManagement.Users.Column_4");
        WebUIDualListMultiColumn dualListMultiColumn = new WebUIDualListMultiColumn(new WebUIComponent(locator));
        dualListMultiColumn.setRawId("UserManagement.Users.Column_4");
        String failedPolicies = "";
        for (int i = 0; i < devices.size(); i++) {
            devicePolicyPair.clear();
            devicePolicyPair.put(0, devices.get(i));
            devicePolicyPair.put(1, networkPolicies.get(i));
            if (!(dualListMultiColumn.isItemAvailableList(devicePolicyPair) == expectedResult)) {
                failedPolicies.concat(devicePolicyPair.get(0).concat(",")).concat("\n\r");
            }
        }
        return failedPolicies;
    }

    public boolean validateDefaultSelection(WebUIDualListMultiColumn dualListMultiColumn) {
        List<String> devices = new ArrayList<String>();
        boolean rightListValid = false;
        boolean leftListValid = false;
        boolean noAllAllInLeftColumn = false;
        HashMap<Integer, String> allAllPolicyPair = new HashMap<Integer, String>();
        allAllPolicyPair.put(0, "[ALL]");
        allAllPolicyPair.put(1, "[ALL]");
        noAllAllInLeftColumn = dualListMultiColumn.isItemAvailableList(allAllPolicyPair);
        rightListValid = dualListMultiColumn.isItemSelectedList(allAllPolicyPair);
        leftListValid = verifyDeviceAllListPolicy(dualListMultiColumn);
        if (rightListValid == true && leftListValid == true && noAllAllInLeftColumn == false) {
            return true;
        }
        return false;
    }

    public boolean validateNetworkPoliciesDualList() {
        boolean isValidList = false;
        boolean rightListValid = false;
        boolean deviceAllListValid = false;
        HashMap<Integer, String> allAllPolicyPair = new HashMap<Integer, String>();
        allAllPolicyPair.put(0, "[ALL]");
        allAllPolicyPair.put(1, "[ALL]");
        ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-UserManagement.Users.Column_4");
        WebUIDualListMultiColumn dualListMultiColumn = new WebUIDualListMultiColumn(new WebUIComponent(locator));
        dualListMultiColumn.setRawId("UserManagement.Users.Column_4");
        if (dualListMultiColumn.getRightListRows().size() == 1) {
            isValidList = validateDefaultSelection(dualListMultiColumn);
        } else {

            deviceAllListValid = verifyDeviceAllListPolicy(dualListMultiColumn);
            rightListValid = verifyRightList(dualListMultiColumn);
            if (deviceAllListValid == true && rightListValid == true && dualListMultiColumn.isItemAvailableList(allAllPolicyPair)) {
                isValidList = true;
            }
        }
        return isValidList;
    }

    public boolean verifyDeviceAllListPolicy(WebUIDualListMultiColumn dualListMultiColumn) {
        List<String> devicesList = getLeftDevicesList(dualListMultiColumn);
        HashMap<Integer, String> deviceAllPolicyPair = new HashMap<Integer, String>();
        int countDeviceAll = 0;

        for (int i = 0; i < devicesList.size(); i++) {
            deviceAllPolicyPair.put(0, devicesList.get(i));
            deviceAllPolicyPair.put(1, "[ALL]");
            boolean isItemAvailableList = dualListMultiColumn.isItemAvailableList(deviceAllPolicyPair);
            boolean isItemSelectedList = dualListMultiColumn.isItemSelectedList(deviceAllPolicyPair);

            if ((isItemAvailableList && !isItemSelectedList) || (!isItemAvailableList && isItemSelectedList)) {
                countDeviceAll++;
            }
        }
        if (countDeviceAll == devicesList.size()) {
            return true;
        }
        return false;
    }

    public boolean verifyRightList(WebUIDualListMultiColumn dualListMultiColumn) {
        List<String> devicesList = getRightDevicesList(dualListMultiColumn);
        List<WebUIRow> rows = dualListMultiColumn.getRightListRows();
        List<String> devicesListValues = new ArrayList<String>();
        List<String> policyListValues = new ArrayList<String>();
        int countIdenticalDevices = 0;
        boolean isAllForDevice = false;

        for (int i = 0; i < rows.size(); i++) {
            devicesListValues.add(i, rows.get(i).cell(0).value());
            policyListValues.add(i, rows.get(i).cell(1).value());
        }

        for (int i = 0; i < devicesList.size(); i++) {
            countIdenticalDevices = 0;
            isAllForDevice = false;
            for (int j = 0; j < devicesListValues.size(); j++) {
                if (devicesList.get(i).equals(devicesListValues.get(j))) {
                    countIdenticalDevices++;
                    if (devicesList.get(i).equals(devicesListValues.get(j)) && policyListValues.get(j).equals("[ALL]")) {
                        isAllForDevice = true;
                    }
                }
            }
            if (countIdenticalDevices > 1 && isAllForDevice == true) {
                return false;
            }
        }
        return true;
    }

    public List<String> getLeftDevicesList(WebUIDualListMultiColumn dualListMultiColumn) {
        return getInnerDevicesList(dualListMultiColumn, true);
    }

    public List<String> getRightDevicesList(WebUIDualListMultiColumn dualListMultiColumn) {
        return getInnerDevicesList(dualListMultiColumn, false);
    }

    public List<String> getInnerDevicesList(WebUIDualListMultiColumn dualListMultiColumn, boolean leftSide) {
        List<WebUIRow> rows = new ArrayList<WebUIRow>();
        HashMap<String, String> deviceListHash = new HashMap<String, String>(100);
        if (leftSide) {
            rows = dualListMultiColumn.getLeftListRows();
        } else {
            rows = dualListMultiColumn.getRightListRows();
        }

        for (int i = 0; i < rows.size(); i++) {
            deviceListHash.put(rows.get(i).cell(0).value(), "");
        }
        return new ArrayList<String>(deviceListHash.keySet());

//        boolean inList = false;
//        for(int i = 0;i < devicesListValues.size();i++){
//            if(i == 0){
//                devicesList.add(0, devicesListValues.get(i));
//            }
//            inList = false;
//            for(int j = 0;j < devicesList.size() && inList == false;j++){
//                  if(devicesListValues.get(i).equals(devicesList.get(j))){
//                      inList = true;
//                  }
//                  else if(devicesList.size() == (j+1)){
//                      devicesList.add(j+1, devicesListValues.get(i));
//                  }
//            }
//        }
        //return devicesList;
    }


}
