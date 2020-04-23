package com.radware.vision.tests.GeneralOperations.DeviceProperties;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.VisionServerInfoPane;
import com.radware.vision.infra.enums.DeviceInfoPaneProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 9/9/2015.
 */
public class DevicePropertiesValidationTests extends WebUITestBase {

    DeviceInfoPaneProperties deviceInfoPaneProperties = DeviceInfoPaneProperties.SELECT_RELEVANT_PROPERTY;
    String expectedResult;

    @Test
    @TestProperties(name = "Validate InfoPane Property", paramsInclude = {"deviceInfoPaneProperties", "expectedResult"})
    public void validateInfoPaneProperty() {
        try {
            VisionServerInfoPane visionServerInfoPane = new VisionServerInfoPane();
            if (visionServerInfoPane.isLabelExists(deviceInfoPaneProperties.getDeviceInfoPaneProperties())) {
                if (!visionServerInfoPane.getInfoPanePropertyVersion(deviceInfoPaneProperties.getDeviceInfoPaneProperties()).equals(expectedResult)) {
                    BaseTestUtils.report("Device Operation validation has failed: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
                }
            } else {
                BaseTestUtils.report("No such property is found: " + deviceInfoPaneProperties.getDeviceInfoPaneProperties() + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Device Property validation has failed : " + "expected is: " + expectedResult + " actual is: " + deviceInfoPaneProperties.getDeviceInfoPaneProperties(), Reporter.FAIL);
        }
    }

    public DeviceInfoPaneProperties getDeviceInfoPaneProperties() {
        return deviceInfoPaneProperties;
    }

    public void setDeviceInfoPaneProperties(DeviceInfoPaneProperties deviceInfoPaneProperties) {
        this.deviceInfoPaneProperties = deviceInfoPaneProperties;
    }

    public String getExpectedResult() {
        return expectedResult;
    }

    public void setExpectedResult(String expectedResult) {
        this.expectedResult = expectedResult;
    }
}
