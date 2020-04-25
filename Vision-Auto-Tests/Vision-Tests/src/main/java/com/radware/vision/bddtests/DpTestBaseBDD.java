package com.radware.vision.bddtests;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.insite.model.helpers.constants.ImConstants;
import com.radware.vision.infra.utils.DpWebUIUtils;
import com.radware.vision.pojomodel.helpers.constants.ImConstants$DeviceStatusEnumPojo;
import jsystem.framework.ParameterProperties;
import org.junit.Before;
import testhandlers.Device;

public class DpTestBaseBDD extends BddUITestBase{
    protected DpWebUIUtils dpUtils;
    String defenceProVersion = "Mandatory Parameter";

    public DpTestBaseBDD() throws Exception {
    }

    @Before
    public void uiInit() throws Exception {
        if (getDeviceName() != null) {
            updateNavigationParser(Device.getDeviceIp(getVisionRestClient(), getDeviceName()));
        }
        dpUtils = new DpWebUIUtils();
        dpUtils.setUp();
    }

    public void updatePolicies() {
        String deviceIp = Device.getDeviceIp(getVisionRestClient(), getDeviceName());
        try {
            getVisionRestClient().mgmtCommands.deviceOperationsCommands.lockCommand(deviceIp);
            getVisionRestClient().mgmtCommands.deviceOperationsCommands.deviceUpdatePolicies(deviceIp);
            if(!Device.waitForDeviceStatus(getVisionRestClient(), getDeviceName(), ImConstants$DeviceStatusEnumPojo.OK, 60 * 1000)) {
                BaseTestUtils.report("Device: " + getDeviceName() + " " + "did not reach required status: " + ImConstants.DeviceStatusEnum.OK.name(), Reporter.PASS);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to wait for status of device: " + getDeviceName() + parseExceptionBody(e), Reporter.PASS);
        }
        finally {
            getVisionRestClient().mgmtCommands.deviceOperationsCommands.unlockCommand(deviceIp);
        }
    }

    private void switchDpVersion() {
        WebUIUtils.visionUtils.resetParserScreens();
    }

    public String getDefenceProVersion() {
        return defenceProVersion;
    }

    @ParameterProperties(description = "DefencePro version must be set ahead, by specifically predefined test")
    public void setDefenceProVersion(String defenceProVersion) {
        this.defenceProVersion = defenceProVersion;
    }
}
