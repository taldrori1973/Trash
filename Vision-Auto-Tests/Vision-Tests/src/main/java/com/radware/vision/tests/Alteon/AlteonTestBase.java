package com.radware.vision.tests.Alteon;

import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;

import java.util.HashMap;

/**
 * Created by urig on 2/17/2016.
 */
public class AlteonTestBase extends WebUITestBase {

    protected HashMap<String, String> testProperties = new HashMap<String, String>();
    String deviceIp;
    TopologyTreeTabs parentTree = TopologyTreeTabs.SitesAndClusters;
    boolean clickOnTableRow = true;
    DeviceState deviceState = DeviceState.Lock;

    @Override
    public void uiInit() throws Exception {
        super.uiInit();
        //WebUIBasePage.serializingMode = true;
        setTestPropertiesBase();
    }
    //=========== Set BASE Properties ======================
    private void setTestPropertiesBase() throws Exception {
        updateNavigationParser(deviceIp);
        testProperties.put("deviceName", getDeviceName());
        testProperties.put("parentTree", parentTree.getTopologyTreeTab().toString());
        testProperties.put("clickOnTableRow", String.valueOf(clickOnTableRow));
        testProperties.put("deviceState", String.valueOf(deviceState));
    }
    //======================================================


    public String getDeviceIp() {
        return deviceIp;
    }

    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public TopologyTreeTabs getParentTree() {
        return parentTree;
    }

    public void setParentTree(TopologyTreeTabs parentTree) {
        this.parentTree = parentTree;
    }

    public boolean getClickOnTableRow() {
        return clickOnTableRow;
    }

    public void setClickOnTableRow(boolean clickOnTableRow) {
        this.clickOnTableRow = clickOnTableRow;
    }

    public DeviceState getDeviceState() {
        return deviceState;
    }

    public void setDeviceState(DeviceState deviceState) {
        this.deviceState = deviceState;
    }
}
