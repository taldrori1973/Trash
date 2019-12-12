package com.radware.vision.tests.rbac;

import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;

import java.util.HashMap;

/**
 * Created by stanislava on 10/7/2014.
 */
public class RBACTestBase extends WebUITestBase {

    protected HashMap<String, String> testProperties = new HashMap<String, String>();

    protected String deviceIp;
    protected TopologyTreeTabs parentTree = TopologyTreeTabs.SitesAndClusters;
    protected boolean clickOnTableRow = false;
    protected DeviceState deviceState = DeviceState.Lock;
    protected boolean expectedResult = false;

    //=========== Set BASE Properties ======================
    public void setTestPropertiesBase() throws Exception {
        updateNavigationParser(deviceIp);
        setCommonProperties();
    }
    public void setAlteonTestPropertiesBase() throws Exception {
        updateNavigationParser(deviceIp);
        setCommonProperties();
    }

    public void setCommonProperties() throws Exception{
        testProperties.put("deviceName", getDeviceName());
        testProperties.put("parentTree", parentTree.getTopologyTreeTab().toString());
        testProperties.put("clickOnTableRow", String.valueOf(clickOnTableRow));
        testProperties.put("deviceState", String.valueOf(deviceState));
        setDeviceType(getVisionRestClient(), getDeviceName());
        testProperties.put("deviceTypeCurrent", getDeviceTypeCurrent());
        RBACHandlerBase.expectedResultRBAC = expectedResult;
    }
    //======================================================

    public boolean getExpectedResult() {
        return expectedResult;
    }
    public void setExpectedResult(boolean expectedResult) {
        this.expectedResult = expectedResult;
    }

    public boolean getClickOnTableRow() {
        return clickOnTableRow;
    }
    public void setClickOnTableRow(boolean clickOnTableRow) {
        this.clickOnTableRow = clickOnTableRow;
    }

    public TopologyTreeTabs getParentTree() {
        return parentTree;
    }
    public void setParentTree(TopologyTreeTabs parentTree) {
        this.parentTree = parentTree;
    }

    public DeviceState getDeviceState() {
        return deviceState;
    }
    public void setDeviceState(DeviceState deviceState) {
        this.deviceState = deviceState;
    }

    public HashMap<String, String> getTestProperties() {
        return testProperties;
    }
    public void setTestProperties(HashMap<String, String> testProperties) {
        this.testProperties = testProperties;
    }

    public String getDeviceIp() {
        return deviceIp;
    }
    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }
}
