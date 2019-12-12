package com.radware.vision.infra.testhandlers.DefencePro.dpConfiguration.networkprotection;

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
import com.radware.vision.infra.utils.DpWebUIUtils;
import com.radware.vision.infra.utils.GeneralUtils;

import java.util.Arrays;
import java.util.List;

public class NetworkProtectionPoliciesHandler extends BaseHandler {


    public static void deleteNetworkPolicy(String deviceName, String policyName, DpWebUIUtils dpUtils) throws Exception {
        TopologyTreeHandler.clickTreeNode(deviceName );
        BaseHandler.lockUnlockDevice(deviceName , TopologyTreeTabs.SitesAndClusters.getTopologyTreeTab(), DeviceState.Lock.getDeviceState(), false);
        NetworkProtectionPolicies networkProtectionPolicies = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        networkProtectionPolicies.openPage();
        networkProtectionPolicies.deleteNetworkProtectionPoliciesByKeyValue("Policy Name", policyName);
    }

    public static void deleteAllNetworkPolicy(String deviceName , DpWebUIUtils dpUtils ) throws Exception {
        TopologyTreeHandler.clickTreeNode(deviceName );
        DeviceOperationsHandler.lockUnlockDevice(deviceName , TopologyTreeTabs.SitesAndClusters.getTopologyTreeTab(), DeviceState.Lock.getDeviceState(), true);
        NetworkProtectionPolicies networkProtectionPolicies = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        networkProtectionPolicies.openPage();
        networkProtectionPolicies.deleteAllNetworkProtectionPolicies(ProtectionPoliciesDeleteOptions.POLICIES_ONLY);
    }

    public static void verifyNetworkPolicy(String deviceName, String policyName, String PolicyStatus ,String SRCNetwork, String DSTNetwork, String PortGroup,
                                    Direction direction, String VLANTagGroup, String MPLSRDGroup, String BDoSProfile, String DNSProfile, String AntiScanningProfile,
                                    String SignatureProtectionProfile, String ConnectionLimitProfile, String SYNFloodProfile, String ConnectionPPSLimitProfile,
                                    String OutofStateProfile, PolicyAction  Action, Status PacketReporting, Status PacketReportingTakesPrecedence, Status PacketTrace,
                                    Status PacketTraceTakesPrecedence, PolicyWebQuarantine webQuarantine, DpWebUIUtils dpUtils) throws Exception {
        TopologyTreeHandler.clickTreeNode(deviceName );
        NetworkProtectionPolicies networkProtectionPolicies = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        networkProtectionPolicies.openPage();
        List<WebUIRowValues> networkProtectionPolicyItems = networkProtectionPolicies.getNetworkProtectionPolicyItems();

        WebUIRowValues expectedNetworkProtectionPolicyItem = new WebUIRowValues(Arrays.asList(new String[]{deviceName , policyName, PolicyStatus, SRCNetwork, DSTNetwork,
                PortGroup, direction.toString(), VLANTagGroup, MPLSRDGroup, BDoSProfile, DNSProfile, AntiScanningProfile, SignatureProtectionProfile, webQuarantine.getPolicyWebQuarantineState(),
                ConnectionLimitProfile, SYNFloodProfile, ConnectionPPSLimitProfile, OutofStateProfile, Action.getPolicyAction(), PacketReporting.getDisplayedStatus(),
                PacketReportingTakesPrecedence.getDisplayedStatus(), PacketTrace.getDisplayedStatus(), PacketTraceTakesPrecedence.getDisplayedStatus(),
                getProtectionProfilesList(BDoSProfile,DNSProfile,AntiScanningProfile,SignatureProtectionProfile,ConnectionLimitProfile,SYNFloodProfile,ConnectionPPSLimitProfile,OutofStateProfile)}));

        if (!networkProtectionPolicyItems.contains(expectedNetworkProtectionPolicyItem)) {
            BaseTestUtils.report("Expected: \n" + expectedNetworkProtectionPolicyItem.toString() + "\n" + "Actual items: \n" + outputNetworkClassItems(networkProtectionPolicyItems), Reporter.FAIL);
        }
    }

    public static void createNetworkPolicy(String deviceName, String policyName, String PolicyStatus ,String SRCNetwork, String DSTNetwork, String PortGroup,
                                    Direction direction, String VLANTagGroup, String MPLSRDGroup, String BDoSProfile, String DNSProfile, String AntiScanningProfile,
                                    String SignatureProtectionProfile, String ConnectionLimitProfile, String SYNFloodProfile, String ConnectionPPSLimitProfile,
                                    String OutofStateProfile, PolicyAction  Action, Status PacketReporting, Status PacketReportingTakesPrecedence, Status PacketTrace,
                                    Status PacketTraceTakesPrecedence, PolicyWebQuarantine webQuarantine, DpWebUIUtils dpUtils) throws Exception {
        TopologyTreeHandler.clickTreeNode(deviceName );
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

    private static String getProtectionProfilesList(String BDoSProfile, String DNSProfile, String AntiScanningProfile,
                                             String SignatureProtectionProfile, String ConnectionLimitProfile, String SYNFloodProfile, String ConnectionPPSLimitProfile,
                                             String OutofStateProfile) {
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

    private static String outputNetworkClassItems(List<WebUIRowValues> items) {
        StringBuilder output = new StringBuilder();
        for (WebUIRowValues item : items) {
            output.append(item.toString()).append("\n");
        }
        return output.toString();
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
