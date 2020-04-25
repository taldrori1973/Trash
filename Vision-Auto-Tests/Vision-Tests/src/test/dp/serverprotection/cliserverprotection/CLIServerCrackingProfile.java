package com.radware.vision.tests.dp.serverprotection.cliserverprotection;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;
import jsystem.extensions.analyzers.text.GetTextCounter;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import junit.framework.SystemTestCase4;
import org.junit.Before;
import org.junit.Test;


public class CLIServerCrackingProfile extends SystemTestCase4{

	public enum Action {
		Report, Block;
	}

	public enum Sn {
		Minor, Low, Medium, High;
	}
	
	public enum Risk {
		Info, Low, Medium, High;
	}
	
	public enum Status {
		enable, disable
	}
	
	DefenseProProduct defensepro;

	private String profileName;
	private Action action;
	private Status packetTrace;
	private Risk risk;
	private Sn sensitivity;
	private String serverCrackingProtectionName;
	

	@Test
	@TestProperties(name = "Verifiy Server Cracking Profile - Cli", paramsInclude = { "qcTestId", "profileName", "action", "packetTrace",
			"serverCrackingProtectionName", "risk", "sensitivity" })
	public void verifiyServerCrackingProfile() throws Exception {
		
		boolean passed = true;

		
		String nameCH = "Name";
		String senCH = "Sensitivity";
		String riskCH= "Risk";
		
		defensepro.dp.getDpCrackingProfile(profileName);
		GetTextCounter counter;
		
		if (action != null) {
			counter = new GetTextCounter("Action of profile.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(action.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL : Action of profile : "
								+ counter.getCounter() + " but expected: "
								+ action, Reporter.FAIL);
				passed = false;
			}
		}
		if (packetTrace != null) {
			counter = new GetTextCounter("Packet Trace Status of profile.*");
			defensepro.dp.analyze(counter, false, false);
			if (!(counter.getCounter().equals(packetTrace.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL : Packet Trace Status: "
								+ counter.getCounter() + " but expected: "
								+ packetTrace, Reporter.FAIL);
				passed = false;
			}
		}
		
/*		defensepro.dp.getDpCrackingProfile(profileName);
		
		GetTableColumn nametc = new GetTableColumn(nameCH);
		GetTableColumn sentc = new GetTableColumn(senCH);
		GetTableColumn risktc = new GetTableColumn(riskCH);
		
		defensepro.classes.analyze(nametc);
		defensepro.classes.analyze(sentc);
		defensepro.classes.analyze(risktc);
		
		String[] namegn = nametc.getColumn();
		
		int indexOfEntry = ArrayUtils.indexOf(namegn, serverCrackingProtectionName);
		
		if (!(indexOfEntry == -1)) {
			
			String sengc = sentc.getColumn()[indexOfEntry];
			String riskgc = risktc.getColumn()[indexOfEntry];
			
			
			if (risk != null) {
				if (!risk.toString().equals(riskgc.toString())) {
					ListenerstManager.getInstance().report(
							"FAIL : risk: " + risk
									+ " but Actual: "
									+ riskgc.toString(), Reporter.FAIL);
					passed = false;
				}
			}
			
			
			if (sensitivity != null) {
				if (!sensitivity.toString().equals(sengc)) {
					ListenerstManager.getInstance().report(
							"FAIL : sensitivity: " + sensitivity
									+ " but Actual: "
									+ sengc.toString(), Reporter.FAIL);
					passed = false;
				}
			}
			
			
			if (passed) {
				if (risk != null)
					ListenerstManager.getInstance().report(
							"Pass : risk : " + risk + " Actual: "
									+ riskgc.toString());
				
				
				if (sensitivity != null)
					ListenerstManager.getInstance().report(
							"Pass : Sensitivity : " + sensitivity
									+ " Actual: " + sengc.toString());

			}
			
			
			
		}else {
			ListenerstManager.getInstance().report("FAIL : ServerCrackingProtectionName not found in protection table ",
					Reporter.FAIL);
		}*/
		
		if(passed){
			if (action != null)
				ListenerstManager.getInstance().report(
						"Pass : Action : " + action
								+ " Actual: " + action);
			
			if (packetTrace != null)
				ListenerstManager.getInstance().report(
						"Pass : Packet Trace : " + packetTrace
								+ " Actual: " + packetTrace);
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

	public String getProfileName() {
		return profileName;
	}
	
	public DefenseProProduct getDefensepro() {
		return defensepro;
	}

	public void setDefensepro(DefenseProProduct defensepro) {
		this.defensepro = defensepro;
	}
	
	public void setProfileName(String profileName) {
		this.profileName = profileName;
	}

	public Action getAction() {
		return action;
	}

	public void setAction(Action action) {
		this.action = action;
	}

	public Status getPacketTrace() {
		return packetTrace;
	}

	public void setPacketTrace(Status packetTrace) {
		this.packetTrace = packetTrace;
	}

	public Risk getRisk() {
		return risk;
	}

	public void setRisk(Risk risk) {
		this.risk = risk;
	}

	public Sn getSensitivity() {
		return sensitivity;
	}

	public void setSensitivity(Sn sensitivity) {
		this.sensitivity = sensitivity;
	}

	public String getServerCrackingProtectionName() {
		return serverCrackingProtectionName;
	}

	public void setServerCrackingProtectionName(String serverCrackingProtectionName) {
		this.serverCrackingProtectionName = serverCrackingProtectionName;
	}
}
