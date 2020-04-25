package com.radware.vision.tests.rbac.RestTestsForWebUiRBAC;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.utils.device.DeviceTableUtils;
import com.radware.vision.base.WebUITestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by stanislava on 9/28/2014.
 */
public class RestTestsForRBAC extends WebUITestBase {
    private String deviceIp;
    private String names;
    private String values;
    private String tableName;


    @Test
    @TestProperties(name = "create Table Row", paramsInclude = {"qcTestId", "deviceIp", "names", "values", "tableName"})
    public void createTableRow() throws Exception {
        try {
            DeviceTableUtils.createTableRow(getVisionRestClient(), deviceIp, tableName, names, values);

        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "createTableRow may not have been executed properly.", e.toString(), Reporter.FAIL);
        }
    }

    public String getDeviceIp() {
        return deviceIp;
    }

    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public String getNames() {
        return names;
    }

    @ParameterProperties(description = "Specify list of Fields You want to add value to. Fields must be separated by <,>.")
    public void setNames(String names) {
        this.names = names;
    }

    public String getValues() {
        return values;
    }

    @ParameterProperties(description = "Specify list of Values You want to add. Values must be separated by <,>.")
    public void setValues(String values) {
        this.values = values;
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }
}
