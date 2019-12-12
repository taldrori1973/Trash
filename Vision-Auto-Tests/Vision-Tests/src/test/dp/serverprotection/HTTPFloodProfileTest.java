package com.radware.vision.tests.dp.serverprotection;

import com.radware.automation.webui.webpages.dp.configuration.serverprotection.httpfloodprofiles.HTTPFloodProfiles;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class HTTPFloodProfileTest extends DpTestBase {

	private String profileName;
	private String sensitivityLevel;
	private String Action;
	private String getAndPOSTRequest_Rate;
	private String OtherRequest_typeRequest_Rate;
	private String OutboundHTTP_BW;
	private String Requests_per_Source;
	private String Requests_per_Connection;
	private String Request_Rate_Threshold;
	private String Requests_per_Connection_Threshold;
	private String challengeMode;

	
	@Test
    @TestProperties(name = "Delete HTTP Flood Profile", paramsInclude = {"qcTestId", "deviceName", "profileName",})
	public void deleteHTTPFloodProfile() throws Exception {
		HTTPFloodProfiles httpProfile = dpUtils.dpProduct.mConfiguration().mServerProtection().mHTTPFloodProfiles();
		httpProfile.openPage();
		httpProfile.deleteHTTPFloodProfileByKeyValue("Profile Name", profileName);
	}

	@Test
    @TestProperties(name = "Create HTTP Flood Profile", paramsInclude = {"qcTestId", "deviceName", "profileName", "sensitivityLevel", "Action", /*"getAndPOSTRequest_Rate",
			"OtherRequest_typeRequest_Rate", "OutboundHTTP_BW", "Requests_per_Source", "Requests_per_Connection", "Request_Rate_Threshold",
			"Request_Rate_Threshold", "Requests_per_Connection_Threshold",*/ "challengeMode" })
	public void createHTTPFloodProfile() throws Exception {

		HTTPFloodProfiles httpProfile = dpUtils.dpProduct.mConfiguration().mServerProtection().mHTTPFloodProfiles();
		httpProfile.openPage();
		httpProfile.addHTTPFloodProfile();
		httpProfile.setHTTPFloodProfileName(profileName);
		if (sensitivityLevel != null) {
			httpProfile.selectSensitivityLevel(sensitivityLevel);
		}
		if (Action != null) {
			httpProfile.selectAction(Action);
		}
		// httpProfile.enableGETandPOSTRequestRate();
		// httpProfile.enableOtherRequestTypeRequestRate();
		// httpProfile.enableOutboundHTTPBandwidth();
		// httpProfile.enableRequestsperSourceRate();
		// httpProfile.enableRequestsperConnectionRate();
		// to do "User difined attack tab is not working correctly

		// httpProfile.enableUseTheFollowingThresholdsToIdentifyHTTPFloodattacks();
		// httpProfile.setGetAndPOSTRequestRate(getAndPOSTRequest_Rate);
		// httpProfile.setOtherRequestTypeRequestRate(OtherRequest_typeRequest_Rate);
		// httpProfile.setOutboundHTTPBW(OutboundHTTP_BW);
		// httpProfile.setRequestsPerSource(Requests_per_Source);
		// httpProfile.setRequestsPerConnection(Requests_per_Connection);
		if (Request_Rate_Threshold != null) {
			httpProfile.setRequestRateThreshold(Request_Rate_Threshold);
		}
		if (Requests_per_Connection_Threshold != null) {
			httpProfile.setRequestsPerConnection(Requests_per_Connection_Threshold);
		}
		// httpProfile.enablePacketReport();
		// httpProfile.enablePacketTrace();
		// httpProfile.enableChallengeSuspectedAttackers();
		// httpProfile.enableBlockSuspectedAttackers();
		// httpProfile.enableChallengeAllSources();
		if (challengeMode != null) {
			httpProfile.selectChallengeMode(challengeMode);
		}
		httpProfile.submit();
	}

	public String getProfileName() {
		return profileName;
	}

	public void setProfileName(String profileName) {
		this.profileName = profileName;
	}

	public String getSensitivityLevel() {
		return sensitivityLevel;
	}

	public void setSensitivityLevel(String sensitivityLevel) {
		this.sensitivityLevel = sensitivityLevel;
	}

	public String getAction() {
		return Action;
	}

	public void setAction(String action) {
		Action = action;
	}

	public String getGetAndPOSTRequest_Rate() {
		return getAndPOSTRequest_Rate;
	}

	public void setGetAndPOSTRequest_Rate(String getAndPOSTRequest_Rate) {
		this.getAndPOSTRequest_Rate = getAndPOSTRequest_Rate;
	}

	public String getOtherRequest_typeRequest_Rate() {
		return OtherRequest_typeRequest_Rate;
	}

	public void setOtherRequest_typeRequest_Rate(String otherRequest_typeRequest_Rate) {
		OtherRequest_typeRequest_Rate = otherRequest_typeRequest_Rate;
	}

	public String getOutboundHTTP_BW() {
		return OutboundHTTP_BW;
	}

	public void setOutboundHTTP_BW(String outboundHTTP_BW) {
		OutboundHTTP_BW = outboundHTTP_BW;
	}

	public String getRequests_per_Source() {
		return Requests_per_Source;
	}

	public void setRequests_per_Source(String requests_per_Source) {
		Requests_per_Source = requests_per_Source;
	}

	public String getRequests_per_Connection() {
		return Requests_per_Connection;
	}

	public void setRequests_per_Connection(String requests_per_Connection) {
		Requests_per_Connection = requests_per_Connection;
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
		return challengeMode;
	}

	public void setChallengeMode(String challengeMode) {
		this.challengeMode = challengeMode;
	}

}
