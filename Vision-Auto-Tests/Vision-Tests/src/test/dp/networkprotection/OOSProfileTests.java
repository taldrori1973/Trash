package com.radware.vision.tests.dp.networkprotection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.outofstateprotectionprofiles.OutOfStateProtectionProfiles;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class OOSProfileTests extends DpTestBase {

	private String profileName;
	private String activationThreshold;
	private String terminationThreshold;
	private String profileRisk;
	private String profileAction;
	private String allowSYNAck;
	private String enablePacketTrace;
	private String enablePacketReporting;

	@Test
	@TestProperties(name = "Delete Out Of State Protection Profile", paramsInclude = {
            "qcTestId", "deviceName", "profileName"})
	public void deleteOOSProfile() throws Exception {
		OutOfStateProtectionProfiles oosProfile = dpUtils.dpProduct
				.mConfiguration().mNetworkProtection()
				.mOutOfStateProtectionProfiles();
		oosProfile.openPage();
		oosProfile.deleteOutOfStateProtectionProfileByKeyValue("Profile Name",
				profileName);
	}

	@Test
	@TestProperties(name = "Create Out Of State Protection Profile", paramsInclude = {
            "qcTestId", "deviceName", "profileName", "activationThreshold",
			"terminationThreshold", "profileRisk", "profileAction",
			"allowSYNAck", "enablePacketTrace", "EnablePacketReporting" })
	public void createOOSProfile() throws Exception {
		OutOfStateProtectionProfiles oosProfile = dpUtils.dpProduct
				.mConfiguration().mNetworkProtection()
				.mOutOfStateProtectionProfiles();
		oosProfile.openPage();
		oosProfile.addOutOfStateProtectionProfile();
		oosProfile.setProfileName(profileName);
		oosProfile.setActivationThreshold(activationThreshold);
		oosProfile.setTerminationThreshold(terminationThreshold);
		if (profileRisk != null) {
			oosProfile.selectProfileRisk(profileRisk);
		}
		if (profileAction != null) {
			oosProfile.selectProfileAction(profileAction);
		}
		if (allowSYNAck != null) {
			if (allowSYNAck.equals("enable")) {
				oosProfile.allowSYN_ACK();
			}
			if (allowSYNAck.equals("disable")) {
				oosProfile.disAllowSYN_ACK();
			}
		}

		if (enablePacketReporting != null) {
			if (enablePacketReporting.equals("enable")) {
				oosProfile.enablePacketReporting();
			}
			if (enablePacketReporting.equals("disable")) {
				oosProfile.disablePacketReporting();
			}
		}

		if (enablePacketTrace != null) {

			if (enablePacketTrace.equals("enable")) {
				oosProfile.enablePacketTrace();
			}
			if (enablePacketTrace.equals("disable")) {
				oosProfile.disablePacketTrace();
			}
		}
		oosProfile.submit();
	}

	public String getEnablePacketTrace() {
		return enablePacketTrace;
	}

	public void setEnablePacketTrace(String enablePacketTrace) {
		this.enablePacketTrace = enablePacketTrace;
	}

	public String getEnablePacketReporting() {
		return enablePacketReporting;
	}

	public void setEnablePacketReporting(String enablePacketReporting) {
		this.enablePacketReporting = enablePacketReporting;
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

	public String getProfileRisk() {
		return profileRisk;
	}

	public void setProfileRisk(String profileRisk) {
		this.profileRisk = profileRisk;
	}

	public String getProfileAction() {
		return profileAction;
	}

	public void setProfileAction(String profileAction) {
		this.profileAction = profileAction;
	}

	public String getAllowSYNAck() {
		return allowSYNAck;
	}

	public void setAllowSYNAck(String allowSYNAck) {
		this.allowSYNAck = allowSYNAck;
	}

}
