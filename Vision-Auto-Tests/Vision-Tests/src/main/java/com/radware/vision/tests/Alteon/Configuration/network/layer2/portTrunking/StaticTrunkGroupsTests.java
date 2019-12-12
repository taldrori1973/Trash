package com.radware.vision.tests.Alteon.Configuration.network.layer2.portTrunking;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2.portTrunking.StaticTrunkGroupsHandler;
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
public class StaticTrunkGroupsTests extends AlteonTestBase {

    GeneralEnums.State StaticTrunkGroupState;
    String StaticTrunkGroupName;
    String StaticTrunkGroupNamePorts;
    String unSelectStaticTrunkGroupNamePorts;
    int TrafficContract;
    int TrunkGroupID;
    int rowNumber;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Test
    @TestProperties(name = "add Static Trunk Group", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"StaticTrunkGroupState","StaticTrunkGroupName","StaticTrunkGroupNamePorts","TrafficContract"
            ,"TrunkGroupID"})
    public void addStaticTrunkGroup() throws IOException {
        try {
            testProperties.put("StaticTrunkGroupState", StaticTrunkGroupState.toString());
            testProperties.put("StaticTrunkGroupName", StaticTrunkGroupName);
            testProperties.put("StaticTrunkGroupNamePorts", StaticTrunkGroupNamePorts);
            testProperties.put("TrafficContract", getTrafficContract());
            testProperties.put("TrunkGroupID", getTrunkGroupID());
            StaticTrunkGroupsHandler.addStaticTrunkGroup(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "edit Static Trunk Group", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","unSelectStaticTrunkGroupNamePorts","StaticTrunkGroupState","StaticTrunkGroupName","StaticTrunkGroupNamePorts","TrafficContract"
            ,"TrunkGroupID"})
    public void editStaticTrunkGroup() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("StaticTrunkGroupState", StaticTrunkGroupState.toString());
            testProperties.put("StaticTrunkGroupName", StaticTrunkGroupName);
            testProperties.put("StaticTrunkGroupNamePorts", StaticTrunkGroupNamePorts);
            testProperties.put("TrafficContract", getTrafficContract());
            testProperties.put("unSelectStaticTrunkGroupNamePorts", unSelectStaticTrunkGroupNamePorts.toString());
            StaticTrunkGroupsHandler.editStaticTrunkGroup(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "duplicate Static Trunk Group", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","unSelectStaticTrunkGroupNamePorts","StaticTrunkGroupState","StaticTrunkGroupName","StaticTrunkGroupNamePorts","TrafficContract"
            ,"TrunkGroupID"})
    public void duplicateStaticTrunkGroup() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("StaticTrunkGroupState", StaticTrunkGroupState.toString());
            testProperties.put("StaticTrunkGroupName", StaticTrunkGroupName);
            testProperties.put("StaticTrunkGroupNamePorts", StaticTrunkGroupNamePorts);
            testProperties.put("TrafficContract", getTrafficContract());
            testProperties.put("TrunkGroupID", getTrunkGroupID());
            testProperties.put("unSelectStaticTrunkGroupNamePorts", unSelectStaticTrunkGroupNamePorts.toString());
            StaticTrunkGroupsHandler.duplicateStaticTrunkGroup(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "del Static Trunk Group", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber"})
    public void delStaticTrunkGroup() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            StaticTrunkGroupsHandler.delStaticTrunkGroup(testProperties);
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

    public String getTrunkGroupID() {
        return String.valueOf(TrunkGroupID);
    }
    @ParameterProperties(description = "Input value 1 to 12")
    public void setTrunkGroupID(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.TrunkGroupID = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 12) {
            this.TrunkGroupID = 12;
        } else{ this.TrunkGroupID = Integer.valueOf(StringUtils.fixNumeric(port));}

    }



    public String getTrafficContract() {
        return String.valueOf(TrafficContract);
    }
    @ParameterProperties(description = "Input value 1 to 1024")
    public void setTrafficContract(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.TrafficContract = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 1024) {
            this.TrafficContract = 1024;
        } else{ this.TrafficContract = Integer.valueOf(StringUtils.fixNumeric(port));}

    }

    public GeneralEnums.State getStaticTrunkGroupState() {
        return StaticTrunkGroupState;
    }

    public void setStaticTrunkGroupState(GeneralEnums.State staticTrunkGroupState) {
        StaticTrunkGroupState = staticTrunkGroupState;
    }

    public String getStaticTrunkGroupName() {
        return StaticTrunkGroupName;
    }

    public void setStaticTrunkGroupName(String staticTrunkGroupName) {
        StaticTrunkGroupName = staticTrunkGroupName;
    }

    public String getStaticTrunkGroupNamePorts() {
        return StaticTrunkGroupNamePorts;
    }
    @ParameterProperties(description = "Separate by ,")
    public void setStaticTrunkGroupNamePorts(String staticTrunkGroupNamePorts) {
        StaticTrunkGroupNamePorts = staticTrunkGroupNamePorts;
    }


    public String getUnSelectStaticTrunkGroupNamePorts() {
        return unSelectStaticTrunkGroupNamePorts;
    }

    public void setUnSelectStaticTrunkGroupNamePorts(String unSelectStaticTrunkGroupNamePorts) {
        this.unSelectStaticTrunkGroupNamePorts = unSelectStaticTrunkGroupNamePorts;
    }

}
