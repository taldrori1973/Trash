package com.radware.vision.tests.dp.networkprotection.clinetworkprotection;

import com.radware.basics.application.RadwareCliCommand;
import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;
import jsystem.extensions.analyzers.text.GetTextCounter;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import com.radware.automation.tools.basetest.Reporter;
import junit.framework.SystemTestCase4;
import org.junit.Before;
import org.junit.Test;

public class CliNetworkProtectionPolicies extends SystemTestCase4 {

    public enum Direction {
        oneway, twoway;
    }

    public enum State {
        active, inactive
    }

    public enum Status {
        disable, enable
    }

    public enum Actions {
        Block, Report;

        public String getName() {
            switch (this) {
                case Block:
                    return "Block and Report";
                case Report:
                    return "Report Only";
                default:
                    return name();
            }
        }

        public String toString() {
            return getName();
        }

    }

    private String policyName;
    private State PolicyState;
    private String SRCNetwork;
    private String DSTNetwork;
    private String PortGroup;
    private Direction direction;
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
    private Actions Action;

    private Status PacketReporting;
    private Status PacketReportingTakesPrecedence;
    private Status PacketTrace;
    private Status PacketTraceTakesPrecedence;

    private DefenseProProduct defensepro;

    @Test
    @TestProperties(name = "Verify network Policy - Cli", paramsInclude = {"qcTestId", "policyName", "PolicyState", "SRCNetwork", "DSTNetwork", "PortGroup",
            "direction", "VLANTagGroup", "MPLSRDGroup", "BDoSProfile", "DNSProfile", "AntiScanningProfile", "SignatureProtectionProfile",
            "ConnectionLimitProfile", "SYNFloodProfile", "ConnectionPPSLimitProfile", "OutofStateProfile", "Action", "PacketReporting",
            "PacketReportingTakesPrecedence", "PacketTrace", "PacketTraceTakesPrecedence"})
    public void VerifyNetworkProtectionPoliciesCli() throws Exception {

        boolean passed = true;
        getDpPoliciesState(policyName);

        GetTextCounter gtcPolicyState = new GetTextCounter("State.*");
        GetTextCounter gtcSRCNetwork = new GetTextCounter("Source Address.*");
        GetTextCounter gtcDSTNetwork = new GetTextCounter("Destination Address.*");
        GetTextCounter gtcPortGroup = new GetTextCounter("Inbound Physical Port Group.*");
        GetTextCounter gtcDirection = new GetTextCounter("Direction.*");
        GetTextCounter gtcVLANTagGroup = new GetTextCounter("Vlan Tag Group.*");
        GetTextCounter gtcMPLSRDGroup = new GetTextCounter("MPLS RD Group.*");
        GetTextCounter gtcBDoSProfile = new GetTextCounter("Behavioral Dos Profile.*");
        GetTextCounter gtcDNSProfile = new GetTextCounter("SYN Protection Profile.*");
        //GetTextCounter gtcAntiScanningProfile = new GetTextCounter("Anti Scanning Profile.*");
        GetTextCounter gtcSignatureProtectionProfile = new GetTextCounter("Signatures Profile.*");
        GetTextCounter gtcConnectionLimitProfile = new GetTextCounter("Connection Limit Profile.*");
        GetTextCounter gtcSYNFloodProfile = new GetTextCounter("SYN Protection Profile.*");
        //GetTextCounter gtcConnectionPPSLimitProfile = new GetTextCounter("PPS Profile.*");
        GetTextCounter gtcOutofStateProfile = new GetTextCounter("Out-Of-State Profile.*");
        GetTextCounter gtcAction = new GetTextCounter("Action.*");
        GetTextCounter gtcPacketReporting = new GetTextCounter("Packet Report.*");
        GetTextCounter gtcPacketReportingTakesPrecedence = new GetTextCounter("Packet Report configuration.*");
        GetTextCounter gtcPacketTrace = new GetTextCounter("Packet Trace.*");
        GetTextCounter gtcPacketTraceTakesPrecedence = new GetTextCounter("Packet Trace configuration.*");


        defensepro.basic.analyze(gtcPolicyState, false, false);
        defensepro.basic.analyze(gtcSRCNetwork, false, false);
        defensepro.basic.analyze(gtcDSTNetwork, false, false);
        defensepro.basic.analyze(gtcPortGroup, false, false);
        defensepro.basic.analyze(gtcDirection, false, false);
        defensepro.basic.analyze(gtcVLANTagGroup, false, false);
        defensepro.basic.analyze(gtcMPLSRDGroup, false, false);
        defensepro.basic.analyze(gtcBDoSProfile, false, false);
        defensepro.basic.analyze(gtcDNSProfile, false, false);
        //defensepro.basic.analyze(gtcAntiScanningProfile, false, false);
        defensepro.basic.analyze(gtcSignatureProtectionProfile, false, false);
        defensepro.basic.analyze(gtcConnectionLimitProfile, false, false);
        defensepro.basic.analyze(gtcSYNFloodProfile, false, false);
        //defensepro.basic.analyze(gtcConnectionPPSLimitProfile, false, false);
        defensepro.basic.analyze(gtcOutofStateProfile, false, false);
        defensepro.basic.analyze(gtcAction, false, false);
        defensepro.basic.analyze(gtcPacketReporting, false, false);
        defensepro.basic.analyze(gtcPacketReportingTakesPrecedence, false, false);
        defensepro.basic.analyze(gtcPacketTrace, false, false);
        defensepro.basic.analyze(gtcPacketTraceTakesPrecedence, false, false);

        String cliPolicyState = gtcPolicyState.getCounter();
        String cliSRCNetwork = gtcSRCNetwork.getCounter();
        String cliDSTNetwork = gtcDSTNetwork.getCounter();
        String cliPortGroup = gtcPortGroup.getCounter();
        String cliDirection = gtcDirection.getCounter();
        String cliVLANTagGroup = gtcVLANTagGroup.getCounter();
        String cliMPLSRDGroup = gtcMPLSRDGroup.getCounter();
        String cliBDoSProfile = gtcBDoSProfile.getCounter();
        String cliDNSProfile = gtcDNSProfile.getCounter();
        //String cliAntiScanningProfile= gtcAntiScanningProfile.getCounter();
        String cliSignatureProtectionProfile = gtcSignatureProtectionProfile.getCounter();
        String cliConnectionLimitProfile = gtcConnectionLimitProfile.getCounter();
        String cliSYNFloodProfile = gtcSYNFloodProfile.getCounter();
        //String cliConnectionPPSLimitProfile= gtcConnectionPPSLimitProfile.getCounter();
        String cliOutofStateProfile = gtcOutofStateProfile.getCounter();
        String cliAction = gtcAction.getCounter();
        String cliPacketReporting = gtcPacketReporting.getCounter();
        String cliPacketReportingTakesPrecedence = gtcPacketReportingTakesPrecedence.getCounter();
        String cliPacketTrace = gtcPacketTrace.getCounter();
        String cliPacketTraceTakesPrecedence = gtcPacketTraceTakesPrecedence.getCounter();


        if (PolicyState != null) {
            if (!PolicyState.toString().equals(cliPolicyState)) {
                ListenerstManager.getInstance().report("FAIL : PolicyState: " + cliPolicyState + " but expected: " + PolicyState, Reporter.FAIL);
                passed = false;
            }
        }
        if (SRCNetwork != null) {
            if (!SRCNetwork.toString().equals(cliSRCNetwork)) {
                ListenerstManager.getInstance().report("FAIL : SRCNetwork: " + cliSRCNetwork + " but expected: " + SRCNetwork, Reporter.FAIL);
                passed = false;
            }
        }
        if (DSTNetwork != null) {
            if (!DSTNetwork.toString().equals(cliDSTNetwork)) {
                ListenerstManager.getInstance().report("FAIL : DSTNetwork: " + cliDSTNetwork + " but expected: " + DSTNetwork, Reporter.FAIL);
                passed = false;
            }
        }
        if (PortGroup != null) {
            if (!PortGroup.toString().equals(cliPortGroup)) {
                ListenerstManager.getInstance().report("FAIL : PortGroup: " + cliPortGroup + " but expected: " + PortGroup, Reporter.FAIL);
                passed = false;
            }
        }
        if (direction != null) {
            if (!direction.toString().equals(cliDirection)) {
                ListenerstManager.getInstance().report("FAIL : Direction: " + cliDirection + " but expected: " + direction, Reporter.FAIL);
                passed = false;
            }
        }
        if (VLANTagGroup != null) {
            if (!VLANTagGroup.toString().equals(cliVLANTagGroup)) {
                ListenerstManager.getInstance().report("FAIL : VLANTagGroup: " + cliVLANTagGroup + " but expected: " + VLANTagGroup, Reporter.FAIL);
                passed = false;
            }
        }
        if (MPLSRDGroup != null) {
            if (!MPLSRDGroup.toString().equals(cliMPLSRDGroup)) {
                ListenerstManager.getInstance().report("FAIL : MPLSRDGroup: " + cliMPLSRDGroup + " but expected: " + MPLSRDGroup, Reporter.FAIL);
                passed = false;
            }
        }
        if (BDoSProfile != null) {
            if (!BDoSProfile.toString().equals(cliBDoSProfile)) {
                ListenerstManager.getInstance().report("FAIL : BDoSProfile: " + cliBDoSProfile + " but expected: " + BDoSProfile, Reporter.FAIL);
                passed = false;
            }
        }
        if (DNSProfile != null) {
            if (!DNSProfile.toString().equals(cliDNSProfile)) {
                ListenerstManager.getInstance().report("FAIL : DNSProfile: " + cliDNSProfile + " but expected: " + DNSProfile, Reporter.FAIL);
                passed = false;
            }
        }
/*		if (AntiScanningProfile != null) {
            if (!AntiScanningProfile.toString().equals(cliAntiScanningProfile)) {
				ListenerstManager.getInstance().report("FAIL : AntiScanningProfile: " + cliAntiScanningProfile + " but expected: " + AntiScanningProfile, Reporter.FAIL);
				passed = false;
			}
		}*/
        if (SignatureProtectionProfile != null) {
            if (!SignatureProtectionProfile.toString().equals(cliSignatureProtectionProfile)) {
                ListenerstManager.getInstance().report("FAIL : SignatureProtectionProfile: " + cliSignatureProtectionProfile + " but expected: " + SignatureProtectionProfile, Reporter.FAIL);
                passed = false;
            }
        }
        if (ConnectionLimitProfile != null) {
            if (!ConnectionLimitProfile.toString().equals(cliConnectionLimitProfile)) {
                ListenerstManager.getInstance().report("FAIL : ConnectionLimitProfile: " + cliConnectionLimitProfile + " but expected: " + ConnectionLimitProfile, Reporter.FAIL);
                passed = false;
            }
        }
        if (SYNFloodProfile != null) {
            if (!SYNFloodProfile.toString().equals(cliSYNFloodProfile)) {
                ListenerstManager.getInstance().report("FAIL : SYNFloodProfile: " + cliSYNFloodProfile + " but expected: " + SYNFloodProfile, Reporter.FAIL);
                passed = false;
            }
        }
/*		if (ConnectionPPSLimitProfile != null) {
			if (!ConnectionPPSLimitProfile.toString().equals(cliConnectionPPSLimitProfile)) {
				ListenerstManager.getInstance().report("FAIL : ConnectionPPSLimitProfile: " + cliConnectionPPSLimitProfile + " but expected: " + ConnectionPPSLimitProfile, Reporter.FAIL);
				passed = false;
			}
		}*/
        if (OutofStateProfile != null) {
            if (!OutofStateProfile.toString().equals(cliOutofStateProfile)) {
                ListenerstManager.getInstance().report("FAIL : OutofStateProfile: " + cliOutofStateProfile + " but expected: " + OutofStateProfile, Reporter.FAIL);
                passed = false;
            }
        }
        if (Action != null) {
            if (!Action.toString().equals(cliAction)) {
                ListenerstManager.getInstance().report("FAIL : Action: " + cliAction + " but expected: " + Action, Reporter.FAIL);
                passed = false;
            }
        }
        if (PacketReporting != null) {
            if (!PacketReporting.toString().equals(cliPacketReporting)) {
                ListenerstManager.getInstance().report("FAIL : PacketReporting: " + cliPacketReporting + " but expected: " + PacketReporting, Reporter.FAIL);
                passed = false;
            }
        }
        if (PacketReportingTakesPrecedence != null) {
            if (!PacketReportingTakesPrecedence.toString().equals(cliPacketReportingTakesPrecedence)) {
                ListenerstManager.getInstance().report("FAIL : PacketReportingTakesPrecedence: " + cliPacketReportingTakesPrecedence + " but expected: " + PacketReportingTakesPrecedence, Reporter.FAIL);
                passed = false;
            }
        }
        if (PacketTrace != null) {
            if (!PacketTrace.toString().equals(cliPacketTrace)) {
                ListenerstManager.getInstance().report("FAIL : PacketTrace: " + cliPacketTrace + " but expected: " + PacketTrace, Reporter.FAIL);
                passed = false;
            }
        }
        if (PacketTraceTakesPrecedence != null) {
            if (!PacketTraceTakesPrecedence.toString().equals(cliPacketTraceTakesPrecedence)) {
                ListenerstManager.getInstance().report("FAIL : PacketTraceTakesPrecedence: " + cliPacketTraceTakesPrecedence + " but expected: " + PacketTraceTakesPrecedence, Reporter.FAIL);
                passed = false;
            }
        }

        if (passed) {

            if (PolicyState != null)
                ListenerstManager.getInstance().report("Pass : PolicyState: " + cliPolicyState + " expected: " + PolicyState);
            if (SRCNetwork != null)
                ListenerstManager.getInstance().report("Pass : SRCNetwork: " + cliSRCNetwork + " expected: " + SRCNetwork);
            if (DSTNetwork != null)
                ListenerstManager.getInstance().report("Pass : DSTNetwork: " + cliDSTNetwork + " expected: " + DSTNetwork);
            if (PortGroup != null)
                ListenerstManager.getInstance().report("Pass : PortGroup: " + cliPortGroup + " expected: " + PortGroup);
            if (direction != null)
                ListenerstManager.getInstance().report("Pass : direction: " + cliDirection + " expected: " + direction);
            if (VLANTagGroup != null)
                ListenerstManager.getInstance().report("Pass : VLANTagGroup: " + cliVLANTagGroup + " expected: " + VLANTagGroup);
            if (MPLSRDGroup != null)
                ListenerstManager.getInstance().report("Pass : MPLSRDGroup: " + cliMPLSRDGroup + " expected: " + MPLSRDGroup);
            if (BDoSProfile != null)
                ListenerstManager.getInstance().report("Pass : BDoSProfile: " + cliBDoSProfile + " expected: " + BDoSProfile);
            if (DNSProfile != null)
                ListenerstManager.getInstance().report("Pass : DNSProfile: " + cliDNSProfile + " expected: " + DNSProfile);
            if (AntiScanningProfile != null)
                //		ListenerstManager.getInstance().report("Pass : AntiScanningProfile: " + cliAntiScanningProfile + " expected: " + AntiScanningProfile);
                if (SignatureProtectionProfile != null)
                    ListenerstManager.getInstance().report("Pass : SignatureProtectionProfile: " + cliSignatureProtectionProfile + " expected: " + SignatureProtectionProfile);
            if (ConnectionLimitProfile != null)
                ListenerstManager.getInstance().report("Pass : ConnectionLimitProfile: " + cliConnectionLimitProfile + " expected: " + ConnectionLimitProfile);
            if (SYNFloodProfile != null)
                ListenerstManager.getInstance().report("Pass : SYNFloodProfile: " + cliSYNFloodProfile + " expected: " + SYNFloodProfile);
            if (ConnectionPPSLimitProfile != null)
                //		ListenerstManager.getInstance().report("Pass : ConnectionPPSLimitProfile: " + cliConnectionPPSLimitProfile + " expected: " + ConnectionPPSLimitProfile);
                if (OutofStateProfile != null)
                    ListenerstManager.getInstance().report("Pass : OutofStateProfile: " + cliOutofStateProfile + " expected: " + OutofStateProfile);
            if (Action != null)
                ListenerstManager.getInstance().report("Pass : Action: " + cliAction + " expected: " + Action);
            if (PacketReporting != null)
                ListenerstManager.getInstance().report("Pass : PacketReporting: " + cliPacketReporting + " expected: " + PacketReporting);
            if (PacketTrace != null)
                ListenerstManager.getInstance().report("Pass : PacketTrace: " + cliPacketTrace + " expected: " + PacketTrace);
            if (PacketReportingTakesPrecedence != null)
                ListenerstManager.getInstance().report("Pass : PacketReportingTakesPrecedence: " + cliPacketReportingTakesPrecedence + " expected: " + PacketReportingTakesPrecedence);
            if (PacketTraceTakesPrecedence != null)
                ListenerstManager.getInstance().report("Pass : PacketTraceTakesPrecedence: " + cliPacketTraceTakesPrecedence + " expected: " + PacketTraceTakesPrecedence);

        }
    }

    private void getDpPoliciesState(String policyName) throws Exception {

        RadwareCliCommand cmd = new RadwareCliCommand("dp policies-config table get " + policyName);
        defensepro.basic.sendCommand(cmd);

    }

    public DefenseProProduct getDefensepro() {
        return defensepro;
    }

    public void setDefensepro(DefenseProProduct defensepro) {
        this.defensepro = defensepro;
    }

    @Before
    public void setUp() throws Exception {
        ListenerstManager.getInstance().startLevel("Setup");
        defensepro = DpRadwareTestCase.getDefenseProInstance();
        ListenerstManager.getInstance().report("in setup...");
        ListenerstManager.getInstance().stopLevel();
    }

    public void tearDown() {

    }

    public String getPolicyName() {
        return policyName;
    }

    public void setPolicyName(String policyName) {
        this.policyName = policyName;
    }

    public State getPolicyState() {
        return PolicyState;
    }

    public void setPolicyState(State policyState) {
        PolicyState = policyState;
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

    public Actions getAction() {
        return Action;
    }

    public void setAction(Actions action) {
        Action = action;
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

    public void setPacketReportingTakesPrecedence(
            Status packetReportingTakesPrecedence) {
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

}
