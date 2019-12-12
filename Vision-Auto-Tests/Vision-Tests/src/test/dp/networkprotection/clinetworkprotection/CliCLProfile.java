package com.radware.vision.tests.dp.networkprotection.clinetworkprotection;

import org.junit.Before;
import org.junit.Test;

import com.radware.basics.application.RadwareCliCommand;
import com.radware.basics.tables.RadwareTableRepository;
import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;

import jsystem.extensions.analyzers.tabletext.TTable;
import jsystem.extensions.analyzers.text.GetTextCounter;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import com.radware.automation.tools.basetest.Reporter;;
import junit.framework.SystemTestCase4;

public class CliCLProfile extends SystemTestCase4 {

	private String ProtectionName;
	private String ApplicationPortGroupName;
	private String Protocol;
	private String NumberOfConnections;
	private String TrackingType;
	private String ActionMode;
	private String Risk;
	private String SuspendAction;
	private String ProfileName;
	
	
	DefenseProProduct defensepro;

	
	@Test
	@TestProperties(name = "Verify Connection Limit Profile - CLI", paramsInclude = {"ProfileName"})
	public void ConnectionLimitProfile() throws Exception {
		
		defensepro.dp.getDpConnLimitProfile(ProfileName);
		
	}
	
	
	public String getProfileName() {
		return ProfileName;
	}


	public void setProfileName(String profileName) {
		ProfileName = profileName;
	}


	@Test
	@TestProperties(name = "Verify Connection Limit Protections - CLI", paramsInclude = {
			"qcTestId", "ProtectionName", "ApplicationPortGroupName",
			"Protocol", "NumberOfConnections", "TrackingType", "ActionMode",
			"Risk", "SuspendAction" })
	public void ConnectionLimitProtection() throws Exception {

		String id = defensepro.dp.getDpConnLimitAttackId(ProtectionName);

//		defensepro.dp.getDpConnLimitAttack(id);
		RadwareCliCommand cmd = new RadwareCliCommand("dp connection-limit attack get " + id);
		defensepro.basic.sendCommand(cmd);
	
		
		if (ApplicationPortGroupName != null) {
			GetTextCounter gtcApplicationPortGroupName = new GetTextCounter(
					"Destination App. Port.*");
			//defensepro.basic.setTestAgainstObject((String)defensepro.basic.getTestAgainstObject());
			defensepro.basic.analyze(gtcApplicationPortGroupName, false, false);
			if (gtcApplicationPortGroupName.getCounter().equals(
					ApplicationPortGroupName)) {
				report.step("ApplicationPortGroupName is as expected: "
						+ ApplicationPortGroupName);
			} else {
				ListenerstManager.getInstance().report(
						"FAIL : Destination App. Port.: "
								+ gtcApplicationPortGroupName.getCounter()
								+ " but expected: " + ApplicationPortGroupName,
						Reporter.FAIL);
			}
		}

		if (Protocol != null) {
			GetTextCounter gtcProtocol = new GetTextCounter("Protocol.*");
			
			defensepro.basic.analyze(gtcProtocol, false, false);
			if (gtcProtocol.getCounter().equals(Protocol)) {
				report.step("Protocol is as expected: " + Protocol);
			} else {
				ListenerstManager.getInstance().report(
						"FAIL : Protocol: " + gtcProtocol.getCounter()
								+ " but expected: " + Protocol, Reporter.FAIL);
			}
		}

		if (NumberOfConnections != null) {
			GetTextCounter counter = new GetTextCounter("Threshold.*");
			defensepro.basic.analyze(counter, false, false);
			if (counter.getCounter().equals(NumberOfConnections)) {
				report.step("NumberOfConnections is as expected: "
						+ NumberOfConnections);
			} else {
				ListenerstManager.getInstance().report(
						"FAIL : NumberOfConnections: " + counter.getCounter()
								+ " but expected: " + NumberOfConnections,
						Reporter.FAIL);
			}
		}

		if (TrackingType != null) {
			GetTextCounter counter = new GetTextCounter("Tracking Type.*");
			defensepro.basic.analyze(counter, false, false);
			if (counter.getCounter().equals(TrackingType)) {
				report.step("TrackingType is as expected: " + TrackingType);
			} else {
				ListenerstManager.getInstance().report(
						"FAIL : Tracking Type: " + counter.getCounter()
								+ " but expected: " + TrackingType,
						Reporter.FAIL);
			}
		}
		if (ActionMode != null) {
			GetTextCounter counter = new GetTextCounter("Action Mode.*");
			defensepro.basic.analyze(counter, false, false);
			if (counter.getCounter().equals(ActionMode)) {
				report.step("Action Mode is as expected: " + ActionMode);
			} else {
				ListenerstManager
						.getInstance()
						.report("FAIL : Action Mode: " + counter.getCounter()
								+ " but expected: " + ActionMode, Reporter.FAIL);
			}
		}
		if (Risk != null) {
			GetTextCounter counter = new GetTextCounter("Risk.*");
			defensepro.basic.analyze(counter, false, false);
			if (counter.getCounter().equals(Risk)) {
				report.step("Risk is as expected: " + Risk);
			} else {
				ListenerstManager.getInstance().report(
						"FAIL : Risk: " + counter.getCounter()
								+ " but expected: " + Risk, Reporter.FAIL);
			}
		}
		if (SuspendAction != null) {
			GetTextCounter counter = new GetTextCounter("Suspend Action.*");
			defensepro.basic.analyze(counter, false, false);
			if (counter.getCounter().equals(SuspendAction)) {
				report.step("SuspendAction is as expected: " + SuspendAction);
			} else {
				ListenerstManager.getInstance().report(
						"FAIL : SuspendAction: " + counter.getCounter()
								+ " but expected: " + SuspendAction,
						Reporter.FAIL);
			}
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

	public String getProtectionName() {
		return ProtectionName;
	}

	public void setProtectionName(String protectionName) {
		ProtectionName = protectionName;
	}

	public String getApplicationPortGroupName() {
		return ApplicationPortGroupName;
	}

	public void setApplicationPortGroupName(String applicationPortGroupName) {
		ApplicationPortGroupName = applicationPortGroupName;
	}

	public String getProtocol() {
		return Protocol;
	}

	public void setProtocol(String protocol) {
		Protocol = protocol;
	}

	public String getNumberOfConnections() {
		return NumberOfConnections;
	}

	public void setNumberOfConnections(String numberOfConnections) {
		NumberOfConnections = numberOfConnections;
	}

	public String getTrackingType() {
		return TrackingType;
	}

	public void setTrackingType(String trackingType) {
		TrackingType = trackingType;
	}

	public String getActionMode() {
		return ActionMode;
	}

	public void setActionMode(String actionMode) {
		ActionMode = actionMode;
	}

	public String getRisk() {
		return Risk;
	}

	public void setRisk(String risk) {
		Risk = risk;
	}

	public String getSuspendAction() {
		return SuspendAction;
	}

	public void setSuspendAction(String suspendAction) {
		SuspendAction = suspendAction;
	}

}
