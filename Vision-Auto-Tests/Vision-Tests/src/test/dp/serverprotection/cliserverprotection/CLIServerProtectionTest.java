package com.radware.vision.tests.dp.serverprotection.cliserverprotection;

import org.junit.Before;
import org.junit.Test;

import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.defensepro.DefenseProEnums.DpStatus;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;

import jsystem.extensions.analyzers.text.GetTextCounter;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import com.radware.automation.tools.basetest.Reporter;
import junit.framework.SystemTestCase4;

public class CLIServerProtectionTest extends SystemTestCase4{

	
	enum Activation {active , inactive}
	
	private String ServerName;
	private String IPRange;
	private String HTTPFloodProfile;
	private String ServerCrackingProfile;
	private String VLANTagGroup;
	private String Policy;

	private Activation State;
	private DpStatus PacketReporting;
	private DpStatus PacketReportingPrecedence;
	private DpStatus PacketTrace;
	private DpStatus PacketTracePrecedence;
	
	private DefenseProProduct defensepro;
	boolean passed = true;
	
	@Test
	@TestProperties(name = "Verify Server Protection - Cli", paramsInclude = { "qcTestId", "ServerName", "State", "HTTPFloodProfile", "ServerCrackingProfile",
			"IPRange", "VLANTagGroup", "PacketReporting", "PacketReportingPrecedence", "PacketTrace", "PacketTracePrecedence", })
	public void VerifyServerProtectionCli() throws Exception {
	

		defensepro.dp.getDpServerProtectionProtectedServer(ServerName);
		GetTextCounter counter;
		
		if (IPRange != null) {
			counter = new GetTextCounter("IP.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(IPRange.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL : IPRange: "
								+ counter.getCounter() + " but expected: "
								+ IPRange, Reporter.FAIL);
				passed = false;
			}
		}
		if (HTTPFloodProfile != null) {
			counter = new GetTextCounter("HTTP mitigator Profile.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(HTTPFloodProfile.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL : HTTPFloodProfile: "
								+ counter.getCounter() + " but expected: "
								+ HTTPFloodProfile, Reporter.FAIL);
				passed = false;
			}
		}
		if (ServerCrackingProfile != null) {
			counter = new GetTextCounter("Server Cracking Protection.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(ServerCrackingProfile.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL : ServerCrackingProfile: "
								+ counter.getCounter() + " but expected: "
								+ ServerCrackingProfile, Reporter.FAIL);
				passed = false;
			}
		}
		if (VLANTagGroup != null) {
			counter = new GetTextCounter("VLAN Tag group.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(VLANTagGroup.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL :   VLANTagGroup: "
								+ counter.getCounter() + " but expected: "
								+ VLANTagGroup, Reporter.FAIL);
				passed = false;
			}
		}
		if (Policy != null) {
			counter = new GetTextCounter("Policy Name.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(Policy.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL :   Policy: "
								+ counter.getCounter() + " but expected: "
								+ Policy, Reporter.FAIL);
				passed = false;
			}
		}
		if (State != null) {
			counter = new GetTextCounter("State.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(State.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL :   State: "
								+ counter.getCounter() + " but expected: "
								+ State, Reporter.FAIL);
				passed = false;
			}
		}
		if (PacketReporting != null) {
			counter = new GetTextCounter("Packet Report.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(PacketReporting.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL :   PacketReporting: "
								+ counter.getCounter() + " but expected: "
								+ PacketReporting, Reporter.FAIL);
				passed = false;
			}
		}
		if (PacketReportingPrecedence != null) {
			counter = new GetTextCounter("Packet Report configuration on policy takes precedence.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(PacketReportingPrecedence.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL :   PacketReportingPrecedence: "
								+ counter.getCounter() + " but expected: "
								+ PacketReportingPrecedence, Reporter.FAIL);
				passed = false;
			}
		}
		if (PacketTrace != null) {
			counter = new GetTextCounter("Packet Trace.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(PacketTrace.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL :   PacketTrace: "
								+ counter.getCounter() + " but expected: "
								+ PacketTrace, Reporter.FAIL);
				passed = false;
			}
		}
		if (PacketTracePrecedence != null) {
			counter = new GetTextCounter("Packet Trace configuration on policy takes precedence.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(PacketTracePrecedence.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL :   PacketTracePrecedence: "
								+ counter.getCounter() + " but expected: "
								+ PacketTracePrecedence, Reporter.FAIL);
				passed = false;
			}
		}
		
	
		if(passed){
			if (IPRange != null)
				ListenerstManager.getInstance().report("Pass : IPRange: " + IPRange + " expected: " + IPRange);
			if (HTTPFloodProfile != null)
				ListenerstManager.getInstance().report("Pass : HTTPFloodProfile: " + HTTPFloodProfile + " expected: " + HTTPFloodProfile);
			if (ServerCrackingProfile != null)
				ListenerstManager.getInstance().report("Pass : ServerCrackingProfile: " + ServerCrackingProfile + " expected: " + ServerCrackingProfile);
			if (VLANTagGroup != null)
				ListenerstManager.getInstance().report("Pass : VLANTagGroup: " + VLANTagGroup + " expected: " + VLANTagGroup);
			if (Policy != null)
				ListenerstManager.getInstance().report("Pass : Policy: " + Policy + " expected: " + Policy);
			if (State != null)
				ListenerstManager.getInstance().report("Pass : State: " + State + " expected: " + State);
			if (PacketReporting != null)
				ListenerstManager.getInstance().report("Pass : PacketReporting: " + PacketReporting + " expected: " + PacketReporting);
			if (PacketReportingPrecedence != null)
				ListenerstManager.getInstance().report("Pass : PacketReportingPrecedence: " + PacketReportingPrecedence + " expected: " + PacketReportingPrecedence);
			if (PacketTrace != null)
				ListenerstManager.getInstance().report("Pass : PacketTrace: " + PacketTrace + " expected: " + PacketTrace);
			if (PacketTracePrecedence != null)
				ListenerstManager.getInstance().report("Pass : PacketTracePrecedence: " + PacketTracePrecedence + " expected: " + PacketTracePrecedence);
		}
		
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


	public Activation getState() {
		return State;
	}




	public void setState(Activation state) {
		State = state;
	}




	public String getServerName() {
		return ServerName;
	}




	public void setServerName(String serverName) {
		ServerName = serverName;
	}




	public String getHTTPFloodProfile() {
		return HTTPFloodProfile;
	}




	public void setHTTPFloodProfile(String hTTPFloodProfile) {
		HTTPFloodProfile = hTTPFloodProfile;
	}




	public String getServerCrackingProfile() {
		return ServerCrackingProfile;
	}




	public void setServerCrackingProfile(String serverCrackingProfile) {
		ServerCrackingProfile = serverCrackingProfile;
	}




	public String getIPRange() {
		return IPRange;
	}




	public void setIPRange(String iPRange) {
		IPRange = iPRange;
	}




	public String getVLANTagGroup() {
		return VLANTagGroup;
	}




	public void setVLANTagGroup(String vLANTagGroup) {
		VLANTagGroup = vLANTagGroup;
	}









	public DpStatus getPacketReporting() {
		return PacketReporting;
	}




	public void setPacketReporting(DpStatus packetReporting) {
		PacketReporting = packetReporting;
	}




	public DpStatus getPacketReportingPrecedence() {
		return PacketReportingPrecedence;
	}




	public void setPacketReportingPrecedence(DpStatus packetReportingPrecedence) {
		PacketReportingPrecedence = packetReportingPrecedence;
	}




	public DpStatus getPacketTrace() {
		return PacketTrace;
	}




	public void setPacketTrace(DpStatus packetTrace) {
		PacketTrace = packetTrace;
	}




	public DpStatus getPacketTracePrecedence() {
		return PacketTracePrecedence;
	}




	public void setPacketTracePrecedence(DpStatus packetTracePrecedence) {
		PacketTracePrecedence = packetTracePrecedence;
	}




	public DefenseProProduct getDefensepro() {
		return defensepro;
	}




	public void setPolicy(String policy) {
		Policy = policy;
	}




	public String getPolicy() {
		return Policy;
	}
	
	
}
