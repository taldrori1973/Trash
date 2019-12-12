package com.radware.vision.tests.Alteon.Configuration.network.layer2;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2.VLANHandler;
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
 * Created by vadyms on 6/11/2015.
 */
public class VLANTests extends AlteonTestBase {

    GeneralEnums.State VLANState;
    String VLANName;
    String VLANPorts;
    String UnSelectPorts;
    GeneralEnums.State IPv6LinkLocalAddressGenerationState;
    String IPv6LinkLocalAddress;
    GeneralEnums.State SourceMACLearning;
    GeneralEnums.State RouterAdvertisement;
    String RetransmissionInterval;
    GeneralEnums.State ManagedAddressConfigurationFlag;
    GeneralEnums.State OtherAddressConfigurationFlag;
    String PreferredLifeTime;
    String ValidLifeTime;
    GeneralEnums.State OnLinkFlagInPrefixState;
    GeneralEnums.State AutonomousAddressPrefixState;
    int LifeTime;
    int ReachableTime;
    int CurrentHopLimit;
    int MTU;
    int MaxIntervalRouterAdvertisements;
    int MinIntervalRouterAdvertisements;
    int TrafficContract;
    int SpanningTreeGroup;
    int VLANId;
    int rowNumber;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Test
    @TestProperties(name = "add VLAN", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"VLANState","VLANName","VLANPorts","IPv6LinkLocalAddressGenerationState","IPv6LinkLocalAddress","SourceMACLearning","RouterAdvertisement","RetransmissionInterval"
            ,"ManagedAddressConfigurationFlag","OtherAddressConfigurationFlag","PreferredLifeTime","ValidLifeTime","OnLinkFlagInPrefixState","AutonomousAddressPrefixState","LifeTime","ReachableTime"
            ,"CurrentHopLimit","MTU","MaxIntervalRouterAdvertisements","MinIntervalRouterAdvertisements","TrafficContract","SpanningTreeGroup","VLANId"
       })
    public void addVLAN() throws IOException {
        try {
            testProperties.put("VLANState", VLANState.toString());
            testProperties.put("VLANName", VLANName);
            testProperties.put("VLANPorts", VLANPorts);
            testProperties.put("IPv6LinkLocalAddressGenerationState", IPv6LinkLocalAddressGenerationState.toString());
            testProperties.put("IPv6LinkLocalAddress", IPv6LinkLocalAddress);
            testProperties.put("SourceMACLearning", SourceMACLearning.toString());
            testProperties.put("RouterAdvertisement", RouterAdvertisement.toString());
            testProperties.put("RetransmissionInterval", RetransmissionInterval);
            testProperties.put("ManagedAddressConfigurationFlag", ManagedAddressConfigurationFlag.toString());
            testProperties.put("OtherAddressConfigurationFlag", OtherAddressConfigurationFlag.toString());
            testProperties.put("PreferredLifeTime", PreferredLifeTime);
            testProperties.put("ValidLifeTime", ValidLifeTime);
            testProperties.put("OnLinkFlagInPrefixState", OnLinkFlagInPrefixState.toString());
            testProperties.put("AutonomousAddressPrefixState", AutonomousAddressPrefixState.toString());
            testProperties.put("LifeTime", getLifeTime());
            testProperties.put("ReachableTime", getReachableTime());
            testProperties.put("CurrentHopLimit", getCurrentHopLimit());
            testProperties.put("MTU", getMTU());
            testProperties.put("MaxIntervalRouterAdvertisements", getMaxIntervalRouterAdvertisements());
            testProperties.put("MinIntervalRouterAdvertisements", getMinIntervalRouterAdvertisements());
            testProperties.put("TrafficContract", getTrafficContract());
            testProperties.put("SpanningTreeGroup", getSpanningTreeGroup());
            testProperties.put("VLANId", getVLANId());
            VLANHandler.addVLAN(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "edit VLAN", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","VLANState","VLANName","VLANPorts","IPv6LinkLocalAddressGenerationState","IPv6LinkLocalAddress","SourceMACLearning","RouterAdvertisement","RetransmissionInterval"
            ,"ManagedAddressConfigurationFlag","OtherAddressConfigurationFlag","PreferredLifeTime","ValidLifeTime","OnLinkFlagInPrefixState","AutonomousAddressPrefixState","LifeTime","ReachableTime"
            ,"CurrentHopLimit","MTU","MaxIntervalRouterAdvertisements","MinIntervalRouterAdvertisements","TrafficContract","SpanningTreeGroup","UnSelectPorts"})
    public void editVLAN() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("VLANState", VLANState.toString());
            testProperties.put("VLANName", VLANName);
            testProperties.put("VLANPorts", VLANPorts);
            testProperties.put("IPv6LinkLocalAddressGenerationState", IPv6LinkLocalAddressGenerationState.toString());
            testProperties.put("IPv6LinkLocalAddress", IPv6LinkLocalAddress);
            testProperties.put("SourceMACLearning", SourceMACLearning.toString());
            testProperties.put("RouterAdvertisement", RouterAdvertisement.toString());
            testProperties.put("RetransmissionInterval", RetransmissionInterval);
            testProperties.put("ManagedAddressConfigurationFlag", ManagedAddressConfigurationFlag.toString());
            testProperties.put("OtherAddressConfigurationFlag", OtherAddressConfigurationFlag.toString());
            testProperties.put("PreferredLifeTime", PreferredLifeTime);
            testProperties.put("ValidLifeTime", ValidLifeTime);
            testProperties.put("OnLinkFlagInPrefixState", OnLinkFlagInPrefixState.toString());
            testProperties.put("AutonomousAddressPrefixState", AutonomousAddressPrefixState.toString());
            testProperties.put("LifeTime", getLifeTime());
            testProperties.put("ReachableTime", getReachableTime());
            testProperties.put("CurrentHopLimit", getCurrentHopLimit());
            testProperties.put("MTU", getMTU());
            testProperties.put("MaxIntervalRouterAdvertisements", getMaxIntervalRouterAdvertisements());
            testProperties.put("MinIntervalRouterAdvertisements", getMinIntervalRouterAdvertisements());
            testProperties.put("TrafficContract", getTrafficContract());
            testProperties.put("SpanningTreeGroup", getSpanningTreeGroup());
            testProperties.put("UnSelectPorts", UnSelectPorts.toString());
            VLANHandler.editVLAN(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "duplicate VLAN", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","VLANState","VLANName","VLANPorts","IPv6LinkLocalAddressGenerationState","IPv6LinkLocalAddress","SourceMACLearning","RouterAdvertisement","RetransmissionInterval"
            ,"ManagedAddressConfigurationFlag","OtherAddressConfigurationFlag","PreferredLifeTime","ValidLifeTime","OnLinkFlagInPrefixState","AutonomousAddressPrefixState","LifeTime","ReachableTime"
            ,"CurrentHopLimit","MTU","MaxIntervalRouterAdvertisements","MinIntervalRouterAdvertisements","TrafficContract","SpanningTreeGroup","UnSelectPorts","VLANId"})
    public void duplicateVLAN() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("VLANState", VLANState.toString());
            testProperties.put("VLANName", VLANName);
            testProperties.put("VLANPorts", VLANPorts);
            testProperties.put("IPv6LinkLocalAddressGenerationState", IPv6LinkLocalAddressGenerationState.toString());
            testProperties.put("IPv6LinkLocalAddress", IPv6LinkLocalAddress);
            testProperties.put("SourceMACLearning", SourceMACLearning.toString());
            testProperties.put("RouterAdvertisement", RouterAdvertisement.toString());
            testProperties.put("RetransmissionInterval", RetransmissionInterval);
            testProperties.put("ManagedAddressConfigurationFlag", ManagedAddressConfigurationFlag.toString());
            testProperties.put("OtherAddressConfigurationFlag", OtherAddressConfigurationFlag.toString());
            testProperties.put("PreferredLifeTime", PreferredLifeTime);
            testProperties.put("ValidLifeTime", ValidLifeTime);
            testProperties.put("OnLinkFlagInPrefixState", OnLinkFlagInPrefixState.toString());
            testProperties.put("AutonomousAddressPrefixState", AutonomousAddressPrefixState.toString());
            testProperties.put("LifeTime", getLifeTime());
            testProperties.put("ReachableTime", getReachableTime());
            testProperties.put("CurrentHopLimit", getCurrentHopLimit());
            testProperties.put("MTU", getMTU());
            testProperties.put("MaxIntervalRouterAdvertisements", getMaxIntervalRouterAdvertisements());
            testProperties.put("MinIntervalRouterAdvertisements", getMinIntervalRouterAdvertisements());
            testProperties.put("TrafficContract", getTrafficContract());
            testProperties.put("SpanningTreeGroup", getSpanningTreeGroup());
            testProperties.put("UnSelectPorts", UnSelectPorts.toString());
            testProperties.put("VLANId", getVLANId());
            VLANHandler.duplicateVLAN(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "del VLAN", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber"})
    public void delPortTeam() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            VLANHandler.delVLAN(testProperties);
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

    public String getVLANId() {
        return String.valueOf(VLANId);
    }
    @ParameterProperties(description = "Input value 1 to 4090")
    public void setVLANId(String id) {
        if (Integer.valueOf(StringUtils.fixNumeric(id)) < 1) {
            this.VLANId = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(id)) > 4090) {
            this.VLANId = 4090;
        } else{ this.VLANId = Integer.valueOf(StringUtils.fixNumeric(id));}

    }

    public String getSpanningTreeGroup() {
        return String.valueOf(SpanningTreeGroup);
    }
    @ParameterProperties(description = "Input value 1 to 16")
    public void setSpanningTreeGroup(String id) {
        if (Integer.valueOf(StringUtils.fixNumeric(id)) < 1) {
            this.SpanningTreeGroup = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(id)) > 16) {
            this.SpanningTreeGroup = 16;
        } else{ this.SpanningTreeGroup = Integer.valueOf(StringUtils.fixNumeric(id));}

    }

    public String getTrafficContract() {
        return String.valueOf(TrafficContract);
    }
    @ParameterProperties(description = "Input value 1 to 1024")
    public void setTrafficContract(String id) {
        if (Integer.valueOf(StringUtils.fixNumeric(id)) < 1) {
            this.TrafficContract = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(id)) > 1024) {
            this.TrafficContract = 1024;
        } else{ this.TrafficContract = Integer.valueOf(StringUtils.fixNumeric(id));}

    }

    public String getMinIntervalRouterAdvertisements() {
        return String.valueOf(MinIntervalRouterAdvertisements);
    }
    @ParameterProperties(description = "Input value 3 to 1800")
    public void setMinIntervalRouterAdvertisements(String id) {
        if (Integer.valueOf(StringUtils.fixNumeric(id)) < 3) {
            this.MinIntervalRouterAdvertisements = 3;
        } else if (Integer.valueOf(StringUtils.fixNumeric(id)) > 1800) {
            this.MinIntervalRouterAdvertisements = 1800;
        } else{ this.MinIntervalRouterAdvertisements = Integer.valueOf(StringUtils.fixNumeric(id));}

    }
    public String getMaxIntervalRouterAdvertisements() {
        return String.valueOf(MaxIntervalRouterAdvertisements);
    }
    @ParameterProperties(description = "Input value 4 to 1800")
    public void setMaxIntervalRouterAdvertisements(String id) {
        if (Integer.valueOf(StringUtils.fixNumeric(id)) < 4) {
            this.MaxIntervalRouterAdvertisements = 4;
        } else if (Integer.valueOf(StringUtils.fixNumeric(id)) > 1800) {
            this.MaxIntervalRouterAdvertisements = 1800;
        } else{ this.MaxIntervalRouterAdvertisements = Integer.valueOf(StringUtils.fixNumeric(id));}

    }

    public String getMTU() {
        return String.valueOf(MTU);
    }
    @ParameterProperties(description = "Input value 1280 to 1500, or 0")
    public void setMTU(String id) {
        if (Integer.valueOf(StringUtils.fixNumeric(id)) == 0) {
            this.MTU = 0;
        }
        else if (Integer.valueOf(StringUtils.fixNumeric(id)) < 1280 && Integer.valueOf(StringUtils.fixNumeric(id))!= 0) {
            this.MTU = 1280;
        }else if (Integer.valueOf(StringUtils.fixNumeric(id)) > 1500) {
            this.MTU = 1500;
        } else{ this.MTU = Integer.valueOf(StringUtils.fixNumeric(id));}

    }
    public String getCurrentHopLimit() {
        return String.valueOf(CurrentHopLimit);
    }
    @ParameterProperties(description = "Input value 0 to 255")
    public void setCurrentHopLimit(String id) {
        if (Integer.valueOf(StringUtils.fixNumeric(id)) < 0) {
            this.CurrentHopLimit = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(id)) > 255) {
            this.CurrentHopLimit = 255;
        } else{ this.CurrentHopLimit = Integer.valueOf(StringUtils.fixNumeric(id));}

    }


    public String getReachableTime() {
        return String.valueOf(ReachableTime);
    }
    @ParameterProperties(description = "Input value 0 to 3600000")
    public void setReachableTime(String id) {
        if (Integer.valueOf(StringUtils.fixNumeric(id)) < 0) {
            this.ReachableTime = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(id)) > 3600000) {
            this.ReachableTime = 3600000;
        } else{ this.ReachableTime = Integer.valueOf(StringUtils.fixNumeric(id));}

    }



    public String getLifeTime() {
        return String.valueOf(LifeTime);
    }
    @ParameterProperties(description = "Input value 0 to 9000")
    public void setLifeTime(String id) {
        if (Integer.valueOf(StringUtils.fixNumeric(id)) < 0) {
            this.LifeTime = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(id)) > 9000) {
            this.LifeTime = 9000;
        } else{ this.LifeTime = Integer.valueOf(StringUtils.fixNumeric(id));}

    }

    public String getVLANPorts() {
        return VLANPorts;
    }
    @ParameterProperties(description = "Separate by ,")
    public void setVLANPorts(String VLANPorts) {
        this.VLANPorts = VLANPorts;
    }

    public GeneralEnums.State getVLANState() {
        return VLANState;
    }

    public void setVLANState(GeneralEnums.State VLANState) {
        this.VLANState = VLANState;
    }

    public String getVLANName() {
        return VLANName;
    }

    public void setVLANName(String VLANName) {
        this.VLANName = VLANName;
    }

    public GeneralEnums.State getIPv6LinkLocalAddressGenerationState() {
        return IPv6LinkLocalAddressGenerationState;
    }

    public void setIPv6LinkLocalAddressGenerationState(GeneralEnums.State IPv6LinkLocalAddressGenerationState) {
        this.IPv6LinkLocalAddressGenerationState = IPv6LinkLocalAddressGenerationState;
    }

    public String getIPv6LinkLocalAddress() {
        return IPv6LinkLocalAddress;
    }

    public void setIPv6LinkLocalAddress(String IPv6LinkLocalAddress) {
        this.IPv6LinkLocalAddress = IPv6LinkLocalAddress;
    }

    public GeneralEnums.State getSourceMACLearning() {
        return SourceMACLearning;
    }

    public void setSourceMACLearning(GeneralEnums.State sourceMACLearning) {
        SourceMACLearning = sourceMACLearning;
    }

    public GeneralEnums.State getRouterAdvertisement() {
        return RouterAdvertisement;
    }

    public void setRouterAdvertisement(GeneralEnums.State routerAdvertisement) {
        RouterAdvertisement = routerAdvertisement;
    }

    public String getRetransmissionInterval() {
        return RetransmissionInterval;
    }
    @ParameterProperties(description = "Valid range: 0 ... 4294967295")
    public void setRetransmissionInterval(String retransmissionInterval) {
        RetransmissionInterval = retransmissionInterval;
    }

    public GeneralEnums.State getManagedAddressConfigurationFlag() {
        return ManagedAddressConfigurationFlag;
    }

    public void setManagedAddressConfigurationFlag(GeneralEnums.State managedAddressConfigurationFlag) {
        ManagedAddressConfigurationFlag = managedAddressConfigurationFlag;
    }

    public GeneralEnums.State getOtherAddressConfigurationFlag() {
        return OtherAddressConfigurationFlag;
    }

    public void setOtherAddressConfigurationFlag(GeneralEnums.State otherAddressConfigurationFlag) {
        OtherAddressConfigurationFlag = otherAddressConfigurationFlag;
    }

    public String getValidLifeTime() {
        return ValidLifeTime;
    }
    @ParameterProperties(description = "Valid range: 0 ... 4294967295")
    public void setValidLifeTime(String validLifeTime) {
        ValidLifeTime = validLifeTime;
    }

    public String getPreferredLifeTime() {
        return PreferredLifeTime;
    }
    @ParameterProperties(description = "Valid range: 0 ... 4294967295")
    public void setPreferredLifeTime(String preferredLifeTime) {
        PreferredLifeTime = preferredLifeTime;
    }

    public GeneralEnums.State getOnLinkFlagInPrefixState() {
        return OnLinkFlagInPrefixState;
    }

    public void setOnLinkFlagInPrefixState(GeneralEnums.State onLinkFlagInPrefixState) {
        OnLinkFlagInPrefixState = onLinkFlagInPrefixState;
    }

    public GeneralEnums.State getAutonomousAddressPrefixState() {
        return AutonomousAddressPrefixState;
    }

    public void setAutonomousAddressPrefixState(GeneralEnums.State autonomousAddressPrefixState) {
        AutonomousAddressPrefixState = autonomousAddressPrefixState;
    }

    public String getUnSelectPorts() {
        return UnSelectPorts;
    }
    @ParameterProperties(description = "Separate by ,")
    public void setUnSelectPorts(String unSelectPorts) {
        UnSelectPorts = unSelectPorts;
    }


}
