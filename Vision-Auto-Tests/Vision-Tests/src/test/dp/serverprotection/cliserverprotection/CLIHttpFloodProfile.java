package com.radware.vision.tests.dp.serverprotection.cliserverprotection;

import org.junit.Before;
import org.junit.Test;

import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.defensepro.DefenseProEnums.DpPolicyAction;
import com.radware.products.defensepro.defensepro.DefenseProEnums.HTTPMitigatorProfilesTableSensitivity;
import com.radware.products.defensepro.defensepro.DefenseProEnums.HttpChallengeMode;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;

import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import com.radware.automation.tools.basetest.Reporter;
import junit.framework.SystemTestCase4;

public class CLIHttpFloodProfile extends SystemTestCase4 {

	private String ProfileName;
	private HTTPMitigatorProfilesTableSensitivity SensitivityLevel;
	private DpPolicyAction Action;
	// private long GetAndPOSTRequest_Rate;
	// private long OtherRequest_typeRequest_Rate;
	// private long OutboundHTTP_BW;
	// private long Requests_per_Source;
	// private long Requests_per_Connection;
	private String Request_Rate_Threshold;
	private String Requests_per_Connection_Threshold;
	private String ChallengeMode;
	private DefenseProProduct defensepro;

	@Test
	@TestProperties(name = "Verify HTTP Protection profile - Cli", paramsInclude = { "qcTestId", "ProfileName", "sensitivityLevel", "Action",
	/*
	 * "GetAndPOSTRequest_Rate", "OtherRequest_typeRequest_Rate",
	 * "OutboundHTTP_BW", "Requests_per_Source", "Requests_per_Connection",
	 */
	"Request_Rate_Threshold", "Requests_per_Connection_Threshold", "ChallengeMode" })
	public void HTTPfloodProfileTest() throws Exception {

		HTTPMitigatorProfilesTableSensitivity sensitivity_Level = defensepro.dp.getDpHttpMitigatorAdvancedProfileSensitivity(ProfileName);
		DpPolicyAction action = defensepro.dp.getDpHttpMitigatorAdvancedProfileAction(ProfileName);
		Integer request_Rate_Threshold = defensepro.dp.getDpHttpMitigatorAdvancedProfileRequestRateThreshold(ProfileName);
		Integer requests_per_Connection_Threshold = defensepro.dp.getDpHttpMitigatorAdvancedProfileRequestRateThreshold(ProfileName);
		HttpChallengeMode challengeMode = defensepro.dp.getDpHttpMitigatorAdvancedProfileChallengeMode(ProfileName);

		boolean passed = true;
		if (SensitivityLevel != null) {
			if (!(sensitivity_Level.toString().equals(SensitivityLevel.toString()))) {
				ListenerstManager.getInstance().report("FAIL : sensitivityLevel: " + sensitivity_Level + " but expected: " + SensitivityLevel, Reporter.FAIL);
				passed = false;
			}
		}
		if (Action != null) {
			if (!(action.toString().equals(Action.toString()))) {
				ListenerstManager.getInstance().report("FAIL : Action: " + action + " but expected: " + Action, Reporter.FAIL);
				passed = false;
			}
		}
		if (Request_Rate_Threshold != null) {
			if (!(request_Rate_Threshold.toString().equals(Request_Rate_Threshold.toString()))) {
				ListenerstManager.getInstance().report("FAIL : Request_Rate_Threshold: " + request_Rate_Threshold + " but expected: " + Request_Rate_Threshold,
						Reporter.FAIL);
				passed = false;
			}
		}
		if (Requests_per_Connection_Threshold != null) {
			if (!(requests_per_Connection_Threshold.toString().equals(Requests_per_Connection_Threshold.toString()))) {
				ListenerstManager.getInstance().report(
						"FAIL : requests_per_Connection_Threshold: " + requests_per_Connection_Threshold + " but expected: " + Requests_per_Connection_Threshold,
						Reporter.FAIL);
				passed = false;
			}
		}
		if (ChallengeMode != null) {
			if (!(challengeMode.toString().trim().equals(ChallengeMode.toString().trim()))) {
				ListenerstManager.getInstance().report("FAIL : challengeMode: " + challengeMode + " but expected: " + ChallengeMode, Reporter.FAIL);
				passed = false;
			}
		}

		if (passed) {
			if (SensitivityLevel != null) 
			ListenerstManager.getInstance().report("Pass : sensitivityLevel: " + sensitivity_Level + " expected: " + SensitivityLevel);
			if (Action != null) 
			ListenerstManager.getInstance().report("Pass : Action: " + action + " expected: " + Action);
			if (Request_Rate_Threshold != null) 
			ListenerstManager.getInstance().report("Pass : Request_Rate_Threshold: " + request_Rate_Threshold + " expected: " + Request_Rate_Threshold);
			if (Requests_per_Connection_Threshold != null) 
			ListenerstManager.getInstance().report(
					"Pass : requests_per_Connection_Threshold: " + requests_per_Connection_Threshold + " expected: " + Requests_per_Connection_Threshold);
			if (ChallengeMode != null)
			ListenerstManager.getInstance().report("Pass : ChallengeMode: " + challengeMode + " expected: " + ChallengeMode);

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

	public String getProfileName() {
		return ProfileName;
	}

	public void setProfileName(String profileName) {
		this.ProfileName = profileName;
	}

	public HTTPMitigatorProfilesTableSensitivity getSensitivityLevel() {
		return SensitivityLevel;
	}

	public void setSensitivityLevel(HTTPMitigatorProfilesTableSensitivity sensitivityLevel) {
		this.SensitivityLevel = sensitivityLevel;
	}

	public DpPolicyAction getAction() {
		return Action;
	}

	public void setAction(DpPolicyAction action) {
		Action = action;
	}

	public String getRequest_Rate_Threshold() {
		return Request_Rate_Threshold;
	}

	public void setRequest_Rate_Threshold(String request_Rate_Threshold) {
		Request_Rate_Threshold = request_Rate_Threshold;
	}

	public String getRequests_per_Connection_Threshold() {
		return Requests_per_Connection_Threshold;
	}

	public void setRequests_per_Connection_Threshold(String requests_per_Connection_Threshold) {
		Requests_per_Connection_Threshold = requests_per_Connection_Threshold;
	}

	public String getChallengeMode() {
		return ChallengeMode;
	}

	public void setChallengeMode(String challengeMode) {
		this.ChallengeMode = challengeMode;
	}

	public DefenseProProduct getDefensepro() {
		return defensepro;
	}

}
