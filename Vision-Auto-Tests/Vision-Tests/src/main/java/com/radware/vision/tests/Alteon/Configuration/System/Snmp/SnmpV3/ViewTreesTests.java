package com.radware.vision.tests.Alteon.Configuration.System.Snmp.SnmpV3;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.configuration.system.snmp.SnmpEnums;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.Snmp.SnmpV3.SnmpV3TableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by vadyms on 6/2/2015.
 */
public class ViewTreesTests extends WebUITestBase {




    SnmpEnums.viewTreeNameInput viewTreeNameInput;
    String viewTreeName;
    int viewTreeNameRow;
    int subTree;
    int mask;
    int rowNumber;
    SnmpEnums.ViewTreeType viewTreeType;

    boolean clickOnTableRow = true;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    TopologyTreeTabs parentTree = TopologyTreeTabs.SitesAndClusters;
    DeviceState deviceState = DeviceState.Lock;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;
    String deviceIp;

    HashMap<String, String> testProperties = new HashMap<String, String>();


    @Test
    @TestProperties(name = "add View Tree", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree", "expectedResult"
            , "clickOnTableRow","viewTreeType","viewTreeNameInput","viewTreeName","subTree","mask","viewTreeNameRow" })
    public void addViewTree() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("viewTreeType", viewTreeType.toString());
            testProperties.put("viewTreeNameInput", viewTreeNameInput.toString());
            testProperties.put("viewTreeName", viewTreeName);
            testProperties.put("subTree", getSubTree());
            testProperties.put("mask", getMask());
            testProperties.put("viewTreeNameRow", getViewTreeNameRow());
            SnmpV3TableActionHandler.addViewTree(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }

    @Test
    @TestProperties(name = "del View Tree", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber"})
    public void delViewTree() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("rowNumber", getRowNumber());
            SnmpV3TableActionHandler.delViewTree(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }


    @Test
    @TestProperties(name = "edit View Tree", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","mask","viewTreeType"})
    public void editViewTree() throws IOException {
        try {
            setTestPropertiesBase();

            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("mask", getMask());
            testProperties.put("viewTreeType", viewTreeType.toString());
            SnmpV3TableActionHandler.editViewTree(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }


    @Test
    @TestProperties(name = "duplicate View Tree", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","viewTreeType","viewTreeNameInput","viewTreeName","subTree","mask","viewTreeNameRow"})
    public void duplicateViewTree() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("viewTreeType", viewTreeType.toString());
            testProperties.put("viewTreeNameInput", viewTreeNameInput.toString());
            testProperties.put("viewTreeName", viewTreeName);
            testProperties.put("subTree", getSubTree());
            testProperties.put("mask", getMask());
            testProperties.put("viewTreeNameRow", getViewTreeNameRow());
            SnmpV3TableActionHandler.duplicateViewTree(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }



    //=========== Set BASE Properties ======================
    public void setTestPropertiesBase() throws Exception {
        WebUIUtils.visionUtils.setDeviceIpIfNew(deviceIp);
        testProperties.put("deviceName", getDeviceName());
        testProperties.put("parentTree", parentTree.getTopologyTreeTab().toString());
        testProperties.put("clickOnTableRow", String.valueOf(clickOnTableRow));
        testProperties.put("deviceState", String.valueOf(deviceState));
        
    }
    //======================================================


    public boolean getClickOnTableRow() {
        return clickOnTableRow;
    }

    public void setClickOnTableRow(boolean clickOnTableRow) {
        this.clickOnTableRow = clickOnTableRow;
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

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

    public String getDeviceIp() {
        return deviceIp;
    }

    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public HashMap<String, String> getTestProperties() {
        return testProperties;
    }

    public void setTestProperties(HashMap<String, String> testProperties) {
        this.testProperties = testProperties;
    }



    public String getViewTreeName() {
        return viewTreeName;
    }

    public void setViewTreeName(String viewTreeName) {
        this.viewTreeName = viewTreeName;
    }

    public SnmpEnums.ViewTreeType getViewTreeType() {
        return viewTreeType;
    }

    public void setViewTreeType(SnmpEnums.ViewTreeType viewTreeType) {
        this.viewTreeType = viewTreeType;
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

    public String getViewTreeNameRow() {
        return String.valueOf(viewTreeNameRow);
    }

    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setViewTreeNameRow(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.viewTreeNameRow = 3;
        } else {
            this.viewTreeNameRow = Integer.valueOf(StringUtils.fixNumeric(row)+3);
        }
    }

    public String getSubTree() {
        return String.valueOf(subTree);
    }

    @ParameterProperties(description = "Input value 0 or more, Max. Number of Characters: 32")
    public void setSubTree(String tree) {
        if (Integer.valueOf(StringUtils.fixNumeric(tree)) < 0) {
            this.subTree = 0;
        } else {
            this.subTree = Integer.valueOf(StringUtils.fixNumeric(tree));
        }
    }

    public String getMask() {
        return String.valueOf(mask);
    }

    @ParameterProperties(description = "The bit mask which, in combination with the corresponding instance of Subtree, defines a family of view subtrees.")
    public void setMask(String msk) {
        if (Integer.valueOf(StringUtils.fixNumeric(msk)) < 0) {
            this.mask = 0;
        } else {
            this.mask = Integer.valueOf(StringUtils.fixNumeric(msk));
        }
    }
    public SnmpEnums.viewTreeNameInput getViewTreeNameInput() {
        return viewTreeNameInput;
    }

    public void setViewTreeNameInput(SnmpEnums.viewTreeNameInput viewTreeNameInput) {
        this.viewTreeNameInput = viewTreeNameInput;
    }
}
