package com.radware.vision.tests.Alteon.Configuration.network.layer2.portTrunking;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.configuration.network.layer2.Layer2Enums;
import com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2.portTrunking.LACPGroupHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by vadyms on 6/10/2015.
 */
public class LACPGroupTests  extends AlteonTestBase {

    String LACPGroupName;
    String SystemPriority;
    Layer2Enums.Timeout timeout;
    int AdminKey;
    Layer2Enums.LACPState LACPState;
    int Priority;
    int rowNumber;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Test
    @TestProperties(name = "config LACP Group", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"LACPGroupName","SystemPriority","timeout"})
    public void configLACPGroup() throws IOException {
        try {
            testProperties.put("LACPGroupName", LACPGroupName);
            testProperties.put("SystemPriority", SystemPriority);
            testProperties.put("timeout", timeout.toString());
            LACPGroupHandler.configLACPGroup(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "edit LACP Group", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","AdminKey","LACPState","Priority"})
    public void editLACPGroup() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("AdminKey", getAdminKey());
            testProperties.put("LACPState", LACPState.toString());
            testProperties.put("Priority", getPriority());
            LACPGroupHandler.editLACPGroup(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }

    public BaseTableActions getExternalMonitoringTableAction() {
        return externalMonitoringTableAction;
    }

    public void setExternalMonitoringTableAction(BaseTableActions externalMonitoringTableAction) {
        this.externalMonitoringTableAction = externalMonitoringTableAction;
    }

    public EditTableActions getDataPortAccessActions() {
        return dataPortAccessActions;
    }

    public void setDataPortAccessActions(EditTableActions dataPortAccessActions) {
        this.dataPortAccessActions = dataPortAccessActions;
    }

    public BaseTableActions getAllowedProtocolPerNetworkActions() {
        return allowedProtocolPerNetworkActions;
    }

    public void setAllowedProtocolPerNetworkActions(BaseTableActions allowedProtocolPerNetworkActions) {
        this.allowedProtocolPerNetworkActions = allowedProtocolPerNetworkActions;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

    public HashMap<String, String> getTestProperties() {
        return testProperties;
    }

    public void setTestProperties(HashMap<String, String> testProperties) {
        this.testProperties = testProperties;
    }


    public String getRowNumber() {
        return String.valueOf(rowNumber);
    }

    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setRowNumber(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.rowNumber = 0;
        } else {
            this.rowNumber = Integer.valueOf(StringUtils.fixNumeric(row));
        }
    }

    public String getLACPGroupName() {
        return LACPGroupName;
    }

    public void setLACPGroupName(String LACPGroupName) {
        this.LACPGroupName = LACPGroupName;
    }

    public String getSystemPriority() {
        return SystemPriority;
    }

    public void setSystemPriority(String systemPriority) {
        SystemPriority = systemPriority;
    }

    public Layer2Enums.Timeout getTimeout() {
        return timeout;
    }

    public void setTimeout(Layer2Enums.Timeout timeout) {
        this.timeout = timeout;
    }
    public Layer2Enums.LACPState getLACPState() {
        return LACPState;
    }

    public void setLACPState(Layer2Enums.LACPState LACPState) {
        this.LACPState = LACPState;
    }

    public String getAdminKey() {
        return String.valueOf(AdminKey);
    }
    @ParameterProperties(description = "Input interval 1..65535")
    public void setAdminKey(String key) {
        if (Integer.valueOf(StringUtils.fixNumeric(key)) < 1) {
            this.AdminKey = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(key)) > 65535) {
            this.AdminKey = 65535;
        } else this.AdminKey = Integer.valueOf(StringUtils.fixNumeric(key));
    }

    public String getPriority() {
        return String.valueOf(Priority);
    }
    @ParameterProperties(description = "Input interval 1..65535")
    public void setPriority(String key) {
        if (Integer.valueOf(StringUtils.fixNumeric(key)) < 1) {
            this.Priority = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(key)) > 65535) {
            this.Priority = 65535;
        } else this.Priority = Integer.valueOf(StringUtils.fixNumeric(key));
    }

}
