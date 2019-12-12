package com.radware.vision.tests.deviceoperations;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.SerializeDeviceDriver;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.GlobalConstants;
import com.radware.vision.utils.ScreensUtils;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.io.IOException;

/**
 * Created by AviH on 09/02/2016.
 */

public class DDSerializing extends WebUITestBase {
    String deviceDriverIdList;
    String rootPath;
    String simultaneousXMLFilesOperation = "4";

    /**
     * before running the test make sure all the xmls are under:DeviceDriverNameAndType\client\configuration\screens
     */
    @Test
    @TestProperties(name = "DDSerializing", paramsInclude = {"deviceDriverIdList", "rootPath", "simultaneousXMLFilesOperation"})
    public void ddSerializing() {
        try {
            report.report("DD files location and hierarchy example: " + "\\JSystem\\DeviceDrivers\\DefensePro-1.00.00-DD-1.00-24\\client");
            SerializeDeviceDriver serializeDeviceDriver = new SerializeDeviceDriver();
            try {
                serializeDeviceDriver.setSerializeThreadPoolSize(Integer.parseInt(getSimultaneousXMLFilesOperation()));
            } catch (Exception e) {
                // Ignore
            }
            for (String deviceDriverId : deviceDriverIdList.split(",")) {
                if (deviceDriverId.equals(WebUIUtils.VISION_DEVICE_DRIVER_ID)) {
                    ScreensUtils.writeClientDeviceDriverFiles(getVisionRestClient(), GlobalConstants.CLIENT_DEVICE_DRIVERS_OUTPUT_FOLDER.getValue(), GlobalConstants.CLIENT_NAVIGATION_OUTPUT_FOLDER.getValue(), GlobalConstants.CLIENT_SERVER_HIERARCHY_OUTPUT_FOLDER.getValue());
                }

                serializeDeviceDriver.serializingDD(deviceDriverId, rootPath);
                report.report("Finished Serializing DD  " + deviceDriverId, Reporter.PASS);
            }
        } catch (IOException e) {
            report.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public String getDeviceDriverIdList() {
        return deviceDriverIdList;
    }

    public void setDeviceDriverIdList(String deviceDriverIdList) {
        this.deviceDriverIdList = deviceDriverIdList;
    }

    public String getRootPath() {
        return rootPath;
    }

    public void setRootPath(String rootPath) {
        this.rootPath = rootPath;
    }

    public String getSimultaneousXMLFilesOperation() {
        return simultaneousXMLFilesOperation;
    }

    public void setSimultaneousXMLFilesOperation(String simultaneousXMLFilesOperation) {
        this.simultaneousXMLFilesOperation = simultaneousXMLFilesOperation;
    }
}
