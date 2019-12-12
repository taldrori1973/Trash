package com.radware.vision.tests.dp.networkprotection;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.networkprotectionrules.NetworkProtectionPolicies;
import com.radware.automation.webui.webpages.dp.enums.ProtectionPoliciesDeleteOptions;
import com.radware.automation.webui.widgets.impl.table.WebUIRowValues;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import com.radware.vision.infra.testhandlers.dptemplates.enums.PolicyAction;
import com.radware.vision.infra.testhandlers.dptemplates.enums.PolicyWebQuarantine;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.infra.utils.GeneralUtils;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;

public class NetworkProtectionPoliciesTest extends DpTestBase {

    private String policyName;
    private Status PolicyStatus = Status.Enable;
    private String SRCNetwork;
    private String DSTNetwork;
    private String PortGroup;
    private Direction direction = Direction.OneWay;
    private String VLANTagGroup;
    private String MPLSRDGroup;
    private String BDoSProfile;
    private String DNSProfile;
    private String AntiScanningProfile;
    private String SignatureProtectionProfile;
    private String ConnectionLimitProfile;
    private String SYNFloodProfile;
    private String ConnectionPPSLimitProfile;
    private String OutofStateProfile;
    private PolicyAction Action = PolicyAction.BLOCK_AND_REPORT;
    private PolicyWebQuarantine webQuarantine = PolicyWebQuarantine.DISABLE;
    private Status PacketReporting = Status.Disable;
    private Status PacketReportingTakesPrecedence = Status.Disable;
    private Status PacketTrace = Status.Disable;
    private Status PacketTraceTakesPrecedence = Status.Disable;
    private boolean useValidation = true;

    @Test
    @TestProperties(name = "Delete network Policy", paramsInclude = {"qcTestId", "deviceName", "policyName"})
    public void deleteNetworkPolicy() throws Exception {
        TopologyTreeHandler.clickTreeNode(getDeviceName());
        BaseHandler.lockUnlockDevice(getDeviceName(), TopologyTreeTabs.SitesAndClusters.getTopologyTreeTab(), DeviceState.Lock.getDeviceState(), false);
        NetworkProtectionPolicies networkProtectionPolicies = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        networkProtectionPolicies.openPage();
        networkProtectionPolicies.deleteNetworkProtectionPoliciesByKeyValue("Policy Name", policyName);
    }

    @Test
    @TestProperties(name = "Delete All network Policy", paramsInclude = {"qcTestId", "deviceName"})
    public void deleteAllNetworkPolicy() throws Exception {
        TopologyTreeHandler.clickTreeNode(getDeviceName());
        DeviceOperationsHandler.lockUnlockDevice(getDeviceName(), TopologyTreeTabs.SitesAndClusters.getTopologyTreeTab(), DeviceState.Lock.getDeviceState(), true);
        NetworkProtectionPolicies networkProtectionPolicies = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        networkProtectionPolicies.openPage();
        networkProtectionPolicies.deleteAllNetworkProtectionPolicies(ProtectionPoliciesDeleteOptions.POLICIES_ONLY);
    }

    @Test
    @TestProperties(name = "Verify network Policy", paramsInclude = {"qcTestId", "deviceName", "policyName", "PolicyStatus", "SRCNetwork", "DSTNetwork",
            "PortGroup", "direction", "VLANTagGroup", "MPLSRDGroup", "BDoSProfile", "DNSProfile", "AntiScanningProfile", "SignatureProtectionProfile",
            "ConnectionLimitProfile", "SYNFloodProfile", "ConnectionPPSLimitProfile", "OutofStateProfile", "Action", "PacketReporting",
            "PacketReportingTakesPrecedence", "PacketTrace", "PacketTraceTakesPrecedence", "webQuarantine"})
    public void verifyNetworkPolicy() throws Exception {
        TopologyTreeHandler.clickTreeNode(getDeviceName());
        NetworkProtectionPolicies networkProtectionPolicies = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        networkProtectionPolicies.openPage();
        List<WebUIRowValues> networkProtectionPolicyItems = networkProtectionPolicies.getNetworkProtectionPolicyItems();

        WebUIRowValues expectedNetworkProtectionPolicyItem = new WebUIRowValues(Arrays.asList(new String[]{getDeviceName(), policyName, PolicyStatus.getDisplayedStatus(), SRCNetwork, DSTNetwork,
                PortGroup, direction.toString(), VLANTagGroup, MPLSRDGroup, BDoSProfile, DNSProfile, AntiScanningProfile, SignatureProtectionProfile, webQuarantine.getPolicyWebQuarantineState(),
                ConnectionLimitProfile, SYNFloodProfile, ConnectionPPSLimitProfile, OutofStateProfile, Action.getPolicyAction(), PacketReporting.getDisplayedStatus(),
                PacketReportingTakesPrecedence.getDisplayedStatus(), PacketTrace.getDisplayedStatus(), PacketTraceTakesPrecedence.getDisplayedStatus(), getProtectionProfilesList()}));

        if (!networkProtectionPolicyItems.contains(expectedNetworkProtectionPolicyItem)) {
            BaseTestUtils.report("Expected: \n" + expectedNetworkProtectionPolicyItem.toString() + "\n" + "Actual items: \n" + outputNetworkClassItems(networkProtectionPolicyItems), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Create network Policy", paramsInclude = {"qcTestId", "deviceName", "policyName", "PolicyStatus", "SRCNetwork", "DSTNetwork", "PortGroup",
            "direction", "VLANTagGroup", "MPLSRDGroup", "BDoSProfile", "DNSProfile", "AntiScanningProfile", "SignatureProtectionProfile",
            "ConnectionLimitProfile", "SYNFloodProfile", "ConnectionPPSLimitProfile", "OutofStateProfile", "Action", "PacketReporting",
            "PacketReportingTakesPrecedence", "PacketTrace", "PacketTraceTakesPrecedence", "webQuarantine", "useValidation"})
    public void createNetworkPolicy() throws Exception {
        TopologyTreeHandler.clickTreeNode(getDeviceName());
        TopologyTreeHandler.openDeviceInfoPane();
        NetworkProtectionPolicies networkProtectionPolicies = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        networkProtectionPolicies.openPage();
        BaseHandler.atomicLockUnlockDevice(DeviceState.Lock.getDeviceState());
        networkProtectionPolicies.addNetworkProtectionPolicies();

        networkProtectionPolicies.setPolicyName(policyName);
        if (PolicyStatus != null) {
            if (PolicyStatus.equals(Status.Enable)) {
                networkProtectionPolicies.enable();
            }
            if (PolicyStatus.equals(Status.Disable)) {
                networkProtectionPolicies.disable();
            }
        }
        if (SRCNetwork != null) {
            networkProtectionPolicies.selectSRCNetwork(SRCNetwork);
        }
        if (DSTNetwork != null) {
            networkProtectionPolicies.selectDSTNetwork(DSTNetwork);
        }
        if (PortGroup != null) {
            networkProtectionPolicies.selectPortGroup(PortGroup);
        }
        if (direction != null) {
            networkProtectionPolicies.selectDirection(direction.toString());
        }
        if (VLANTagGroup != null) {
            networkProtectionPolicies.selectVLANTagGroup(VLANTagGroup);
        }
        if (MPLSRDGroup != null) {
            networkProtectionPolicies.selectMPLSRDGroup(MPLSRDGroup);
        }
        if (BDoSProfile != null) {
            networkProtectionPolicies.selectBDoSProfile(BDoSProfile);
        }
        if (DNSProfile != null) {
            networkProtectionPolicies.selectDNSProfile(DNSProfile);
        }
        if (AntiScanningProfile != null) {
            networkProtectionPolicies.selectAntiScanningProfile(AntiScanningProfile);
        }
        if (SignatureProtectionProfile != null) {
            networkProtectionPolicies.selectSignatureProtectionProfile(SignatureProtectionProfile);
        }
        if (ConnectionLimitProfile != null) {
            networkProtectionPolicies.selectConnectionLimitProfile(ConnectionLimitProfile);
        }
        if (SYNFloodProfile != null) {
            networkProtectionPolicies.selectSYNFloodProfile(SYNFloodProfile);
        }
        if (ConnectionPPSLimitProfile != null) {
            networkProtectionPolicies.selectConnectionPPSLimitProfile(ConnectionPPSLimitProfile);
        }
        if (OutofStateProfile != null) {
            networkProtectionPolicies.selectOutofStateProfile(OutofStateProfile);
        }
        if (Action != null) {
            networkProtectionPolicies.selectAction(Action.getPolicyAction());
        }
        if (PacketReporting != null) {
            if (PacketReporting.equals(Status.Enable)) {
                networkProtectionPolicies.enablePacketReporting();
            }
            if (PacketReporting.equals(Status.Disable)) {
                networkProtectionPolicies.disablePacketReporting();
            }
        }

        if (PacketReportingTakesPrecedence != null) {
            if (PacketReportingTakesPrecedence.equals(Status.Enable)) {
                networkProtectionPolicies.enablePacketReportingConfigurationonPolicyTakesPrecedence();
            }
            if (PacketReportingTakesPrecedence.equals(Status.Disable)) {
                networkProtectionPolicies.disablePacketReportingConfigurationonPolicyTakesPrecedence();
            }
        }
        if (PacketTrace != null) {
            if (PacketTrace.equals(Status.Enable)) {
                networkProtectionPolicies.enablePacketTrace();
            }
            if (PacketTrace.equals(Status.Disable)) {
                networkProtectionPolicies.disablePacketTrace();
            }
        }

        if (PacketTraceTakesPrecedence != null) {
            if (PacketTraceTakesPrecedence.equals(Status.Enable)) {
                networkProtectionPolicies.enablePacketTraceConfigurationonPolicyTakesPrecedence();
            }
            if (PacketTraceTakesPrecedence.equals(Status.Disable)) {
                networkProtectionPolicies.disablePacketTraceConfigurationonPolicyTakesPrecedence();
            }
        }
        GeneralUtils.submitAndWait(7);

//        if (useValidation) {
//            WebUIRowValues expectedNetworkProtectionPolicyItem = new WebUIRowValues(Arrays.asList(new String[]{deviceName, policyName, PolicyStatus.getDisplayedStatus(), SRCNetwork, DSTNetwork,
//                    PortGroup, direction.toString(), VLANTagGroup, MPLSRDGroup, BDoSProfile, DNSProfile, AntiScanningProfile, SignatureProtectionProfile, webQuarantine.getPolicyWebQuarantineState(),
//                    ConnectionLimitProfile, SYNFloodProfile, ConnectionPPSLimitProfile, OutofStateProfile, Action.getPolicyAction(), PacketReporting.getDisplayedStatus(),
//                    PacketReportingTakesPrecedence.getDisplayedStatus(), PacketTrace.getDisplayedStatus(), PacketTraceTakesPrecedence.getDisplayedStatus(), getProtectionProfilesList()}));
//            List<WebUIRowValues> networkProtectionPolicyItems = networkProtectionPolicies.getNetworkProtectionPolicyItems();
//            if (!networkProtectionPolicyItems.contains(expectedNetworkProtectionPolicyItem)) {
//                BaseTestUtils.report("Expected: \n" + expectedNetworkProtectionPolicyItem.toString() + "\n" + "Actual items: \n" + outputNetworkClassItems(networkProtectionPolicyItems), Reporter.FAIL);
//            }
//        }

        BaseHandler.atomicLockUnlockDevice(DeviceState.UnLock.getDeviceState());
    }

    private String getProtectionProfilesList() {
        StringBuilder result = new StringBuilder();

        result.append(BDoSProfile != null ? BDoSProfile : "");
        result.append(DNSProfile != null ? "\n" : "").append(DNSProfile != null ? DNSProfile : "");
        result.append(AntiScanningProfile != null ? "\n" : "").append(AntiScanningProfile != null ? AntiScanningProfile : "");
        result.append(SignatureProtectionProfile != null ? "\n" : "").append(SignatureProtectionProfile != null ? SignatureProtectionProfile : "");
        result.append(ConnectionLimitProfile != null ? "\n" : "").append(ConnectionLimitProfile != null ? ConnectionLimitProfile : "");
        result.append(SYNFloodProfile != null ? "\n" : "").append(SYNFloodProfile != null ? SYNFloodProfile : "");
        result.append(ConnectionPPSLimitProfile != null ? "\n" : "").append(ConnectionPPSLimitProfile != null ? ConnectionPPSLimitProfile : "");
        result.append(OutofStateProfile != null ? OutofStateProfile : "");
        return result.toString();
    }

    private String outputNetworkClassItems(List<WebUIRowValues> items) {
        StringBuilder output = new StringBuilder();
        for (WebUIRowValues item : items) {
            output.append(item.toString()).append("\n");
        }
        return output.toString();
    }

    public boolean isUseValidation() {
        return useValidation;
    }

    public void setUseValidation(boolean useValidation) {
        this.useValidation = useValidation;
    }

    public String getBDoSProfile() {
        return BDoSProfile;
    }

    public void setBDoSProfile(String bDoSProfile) {
        BDoSProfile = bDoSProfile;
    }

    public String getDNSProfile() {
        return DNSProfile;
    }

    public void setDNSProfile(String dNSProfile) {
        DNSProfile = dNSProfile;
    }

    public String getAntiScanningProfile() {
        return AntiScanningProfile;
    }

    public void setAntiScanningProfile(String antiScanningProfile) {
        AntiScanningProfile = antiScanningProfile;
    }

    public String getSignatureProtectionProfile() {
        return SignatureProtectionProfile;
    }

    public void setSignatureProtectionProfile(String signatureProtectionProfile) {
        SignatureProtectionProfile = signatureProtectionProfile;
    }

    public String getConnectionLimitProfile() {
        return ConnectionLimitProfile;
    }

    public void setConnectionLimitProfile(String connectionLimitProfile) {
        ConnectionLimitProfile = connectionLimitProfile;
    }

    public String getSYNFloodProfile() {
        return SYNFloodProfile;
    }

    public void setSYNFloodProfile(String sYNFloodProfile) {
        SYNFloodProfile = sYNFloodProfile;
    }

    public String getConnectionPPSLimitProfile() {
        return ConnectionPPSLimitProfile;
    }

    public void setConnectionPPSLimitProfile(String connectionPPSLimitProfile) {
        ConnectionPPSLimitProfile = connectionPPSLimitProfile;
    }

    public String getOutofStateProfile() {
        return OutofStateProfile;
    }

    public void setOutofStateProfile(String outofStateProfile) {
        OutofStateProfile = outofStateProfile;
    }

    public PolicyAction getAction() {
        return Action;
    }

    public void setAction(PolicyAction action) {
        Action = action;
    }

    public PolicyWebQuarantine getWebQuarantine() {
        return webQuarantine;
    }

    public void setWebQuarantine(PolicyWebQuarantine webQuarantine) {
        this.webQuarantine = webQuarantine;
    }

    public Status getPacketReporting() {
        return PacketReporting;
    }

    public void setPacketReporting(Status packetReporting) {
        PacketReporting = packetReporting;
    }

    public Status getPacketReportingTakesPrecedence() {
        return PacketReportingTakesPrecedence;
    }

    public void setPacketReportingTakesPrecedence(Status packetReportingTakesPrecedence) {
        PacketReportingTakesPrecedence = packetReportingTakesPrecedence;
    }

    public Status getPacketTrace() {
        return PacketTrace;
    }

    public void setPacketTrace(Status packetTrace) {
        PacketTrace = packetTrace;
    }

    public Status getPacketTraceTakesPrecedence() {
        return PacketTraceTakesPrecedence;
    }

    public void setPacketTraceTakesPrecedence(Status packetTraceTakesPrecedence) {
        PacketTraceTakesPrecedence = packetTraceTakesPrecedence;
    }

    public Status getPolicyStatus() {
        return PolicyStatus;
    }

    public void setPolicyStatus(Status policyStatus) {
        this.PolicyStatus = policyStatus;
    }

    public String getSRCNetwork() {
        return SRCNetwork;
    }

    public void setSRCNetwork(String sRCNetwork) {
        SRCNetwork = sRCNetwork;
    }

    public String getDSTNetwork() {
        return DSTNetwork;
    }

    public void setDSTNetwork(String dSTNetwork) {
        DSTNetwork = dSTNetwork;
    }

    public String getPortGroup() {
        return PortGroup;
    }

    public void setPortGroup(String portGroup) {
        PortGroup = portGroup;
    }

    public Direction getDirection() {
        return direction;
    }

    public void setDirection(Direction direction) {
        this.direction = direction;
    }

    public String getVLANTagGroup() {
        return VLANTagGroup;
    }

    public void setVLANTagGroup(String vLANTagGroup) {
        VLANTagGroup = vLANTagGroup;
    }

    public String getMPLSRDGroup() {
        return MPLSRDGroup;
    }

    public void setMPLSRDGroup(String mPLSRDGroup) {
        MPLSRDGroup = mPLSRDGroup;
    }

    public String getPolicyName() {
        return policyName;
    }

    public void setPolicyName(String policyName) {
        this.policyName = policyName;
    }

    public enum Status {
        Enable, Disable;

        public String getDisplayedStatus() {
            return this.toString() + "d";
        }
    }

    public enum Direction {
        OneWay, TwoWay;

        public String getName() {
            switch (this) {
                case OneWay:
                    return "One Way";
                case TwoWay:
                    return "Two Way";
                default:
                    return name();
            }
        }

        public String toString() {
            return getName();
        }

    }
}
