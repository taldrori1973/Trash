package com.radware.vision.tests.dp.networkprotection.clinetworkprotection;

import org.junit.Before;
import org.junit.Test;

import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import com.radware.automation.tools.basetest.Reporter;;
import junit.framework.SystemTestCase4;

import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.defensepro.DefenseProEnums.DpPolicyAction;
import com.radware.products.defensepro.defensepro.DefenseProEnums.DpRisk;
import com.radware.products.defensepro.defensepro.DefenseProEnums.DpStatus;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;

public class CliOOSProfileTest extends SystemTestCase4 {

	private String profileName;
	private String activationThreshold;
	private String terminationThreshold;
	private DpRisk profileRisk;
	private DpPolicyAction profileAction;
	private String allowSynAck;
	private String EnablePacketTrace;
	private String EnablePacketReport;

	DefenseProProduct defensepro;

	@Test
	@TestProperties(name = "Verify Out Of State Protection Profile - Cli", paramsInclude = { "qcTestId", "profileName", "activationThreshold",
			"terminationThreshold", "profileRisk", "profileAction", "allowSynAck", "EnablePacketTrace", "EnablePacketReport" })
	public void testDpCliTest() throws Exception {

		Long actTH = defensepro.dp.OutOfState().Profile().getActThreshold(profileName);
		Long termtTH = defensepro.dp.OutOfState().Profile().getTermThreshold(profileName);
		DpRisk profRisk = defensepro.dp.OutOfState().Profile().getRisk(profileName);
		DpPolicyAction profAction = defensepro.dp.OutOfState().Profile().getProfileAction(profileName);
		DpStatus synAckAllowStatus = defensepro.dp.OutOfState().Profile().getSynAckAllowStatus(profileName);
		DpStatus packetTraceStatus = defensepro.dp.OutOfState().Profile().getPacketTraceStatus(profileName);
		DpStatus packetReportStatus = defensepro.dp.OutOfState().Profile().getPacketReportStatus(profileName);

		boolean passed = true;

		if (activationThreshold != null) {
			if (!actTH.toString().equals(activationThreshold)) {
				ListenerstManager.getInstance().report("activation: " + actTH + " but expected: " + activationThreshold, Reporter.FAIL);
				passed = false;
			}
		}
		if (terminationThreshold != null) {
			if (!termtTH.toString().equals(terminationThreshold)) {
				ListenerstManager.getInstance().report("termination: " + termtTH + " but expected: " + terminationThreshold, Reporter.FAIL);
				passed = false;
			}
		}
		if (profileRisk != null) {
			if (!(profRisk.equals(profileRisk))) {
				ListenerstManager.getInstance().report("profileRisk: " + profRisk + " but expected: " + profileRisk, Reporter.FAIL);
				passed = false;
			}
		}
		if (profileAction != null) {
			if (!(profAction.equals(profileAction))) {
				ListenerstManager.getInstance().report("profileAction: " + profAction + " but expected: " + profileAction, Reporter.FAIL);
				passed = false;
			}
		}
		if (allowSynAck != null) {
			if (!(synAckAllowStatus.toString().equals(allowSynAck))) {
				ListenerstManager.getInstance().report("Allow SYN-ACK: " + synAckAllowStatus + " but expected: " + allowSynAck, Reporter.FAIL);
				passed = false;
			}
		}
		if (EnablePacketTrace != null) {
			if (!(packetTraceStatus.toString().equals(EnablePacketTrace))) {
				ListenerstManager.getInstance().report("Enable Packet Trace: " + packetTraceStatus + " but expected: " + EnablePacketTrace, Reporter.FAIL);
				passed = false;
			}
		}
		if (EnablePacketReport != null) {
			if (!(packetReportStatus.toString().equals(EnablePacketReport))) {
				ListenerstManager.getInstance().report("Enable Packet Trace: " + packetReportStatus + " but expected: " + EnablePacketReport, Reporter.FAIL);
				passed = false;
			}
		}

		if (passed) {
			if (activationThreshold != null)
				ListenerstManager.getInstance().report("activation: " + actTH + " expected: " + activationThreshold);
			if (terminationThreshold != null)
				ListenerstManager.getInstance().report("termination: " + termtTH + " expected: " + terminationThreshold);
			if (profileRisk != null)
				ListenerstManager.getInstance().report("profileRisk: " + profRisk + " expected: " + profileRisk);
			if (profileAction != null)
				ListenerstManager.getInstance().report("profileAction: " + profAction + " expected: " + profileAction);
			if (allowSynAck != null)
				ListenerstManager.getInstance().report("Allow SYN-ACK: " + synAckAllowStatus + " expected: " + allowSynAck);
			if (EnablePacketTrace != null)
				ListenerstManager.getInstance().report("Enable Packet Trace: " + packetTraceStatus + " expected: " + EnablePacketTrace);
			if (EnablePacketReport != null)
				ListenerstManager.getInstance().report("Enable Packet Reporting: " + packetReportStatus + " expected: " + EnablePacketReport);
		}
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

	public DefenseProProduct getDefensepro() {
		return defensepro;
	}

	public void setDefensepro(DefenseProProduct defensepro) {
		this.defensepro = defensepro;
	}

	public String getAllowSynAck() {
		return allowSynAck;
	}

	public void setAllowSynAck(String allowSynAck) {
		this.allowSynAck = allowSynAck;
	}

	public String getEnablePacketTrace() {
		return EnablePacketTrace;
	}

	public void setEnablePacketTrace(String enablePacketTrace) {
		EnablePacketTrace = enablePacketTrace;
	}

	public String getEnablePacketReport() {
		return EnablePacketReport;
	}

	public void setEnablePacketReport(String enablePacketReport) {
		EnablePacketReport = enablePacketReport;
	}

	public String getProfileName() {
		return profileName;
	}

	public void setProfileName(String profileName) {
		this.profileName = profileName;
	}

	public String getActivationThreshold() {
		return activationThreshold;
	}

	public void setActivationThreshold(String activationThreshold) {
		this.activationThreshold = activationThreshold;
	}

	public String getTerminationThreshold() {
		return terminationThreshold;
	}

	public void setTerminationThreshold(String terminationThreshold) {
		this.terminationThreshold = terminationThreshold;
	}

	public DpRisk getProfileRisk() {
		return profileRisk;
	}

	public void setProfileRisk(DpRisk profileRisk) {
		this.profileRisk = profileRisk;
	}

	public DpPolicyAction getProfileAction() {
		return profileAction;
	}

	public void setProfileAction(DpPolicyAction profileAction) {
		this.profileAction = profileAction;
	}

}
