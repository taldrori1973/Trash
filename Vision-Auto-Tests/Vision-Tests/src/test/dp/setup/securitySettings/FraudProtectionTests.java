package com.radware.vision.tests.dp.setup.securitySettings;

import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.DefencePro.dpConfiguration.setup.securitySettings.FraudProtectionHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.awt.*;
import java.util.HashMap;

/**
 * Created by stanislava on 4/26/2015.
 */
public class FraudProtectionTests extends WebUITestBase {
    HashMap<String, String> testProperties = new HashMap<String, String>();
    TopologyTreeTabs parentTree = TopologyTreeTabs.SitesAndClusters;
    DeviceState deviceState = DeviceState.Lock;


    @Test
    @TestProperties(name = "resetRSASignaturesLastUpdate Field", paramsInclude = {"qcTestId", "deviceName"})
    public void resetRSASignaturesLastUpdateField() throws AWTException {
        try {
            setTestPropertiesBase();
            FraudProtectionHandler.resetRSASignaturesLastUpdateField(testProperties);
        } catch (Exception e) {
            report.report("export resetRSASignaturesLastUpdate Field operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    //=========== Set BASE Properties ======================
    public void setTestPropertiesBase() throws Exception {
        updateNavigationParser(getDeviceName());
        testProperties.put("deviceName", getDeviceName());
        testProperties.put("parentTree", parentTree.getTopologyTreeTab().toString());
        testProperties.put("deviceState", String.valueOf(deviceState));
    }
    //======================================================


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
}
