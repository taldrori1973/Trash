package com.radware.vision.tests.dp.serverprotection;

import com.radware.automation.webui.webpages.dp.configuration.serverprotection.servercrackingprofiles.ServerCrackingProfiles;
import com.radware.automation.webui.webpages.dp.configuration.serverprotection.servercrackingprofiles.servercrackingprofilesnonscreen.SCProfileInnerTable;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class ServerCrackingProfileTest extends DpTestBase {

	public enum Sn {
		Minor, Low, Medium, High;
	}
	
	public enum Risk {
		Info, Low, Medium, High;
	}

	public enum Status {
		Enable, Disable
	}

	public enum Action {
		ReportOnly, BlockAndReport;

		public String getName() {
			switch (this) {
			case ReportOnly:
				return "Report Only";
			case BlockAndReport:
				return "Block and Report";
			default:
				return name();
			}
		}

		public String toString() {
			return getName();
		}

	}

	private String profileName;
	private Action action;
	private Status packetTrace;
	private Risk risk;
	private Sn sensitivity;
	private String serverCrackingProtectionName;

	@Test
    @TestProperties(name = "Delete Server Cracking Profile", paramsInclude = {"qcTestId", "deviceName", "profileName"})
	public void deleteServerCrackingProfile() throws Exception {
		ServerCrackingProfiles serverCrackingProfiles = dpUtils.dpProduct.mConfiguration().mServerProtection().mServerCrackingProfiles();
		serverCrackingProfiles.openPage();
		serverCrackingProfiles.deleteServerCrackingProfileByKeyValue("Profile Name", profileName);
	}

	@Test
    @TestProperties(name = "Create Server Cracking Profile", paramsInclude = {"qcTestId", "deviceName", "profileName", "action", "packetTrace",
			"serverCrackingProtectionName", "risk", "sensitivity" })
	public void createServerCrackingProfile() throws Exception {
		ServerCrackingProfiles serverCrackingProfiles = dpUtils.dpProduct.mConfiguration().mServerProtection().mServerCrackingProfiles();
		serverCrackingProfiles.openPage();
		serverCrackingProfiles.addServerCrackingProfile();
		serverCrackingProfiles.setProfileName(profileName);
		if (action != null) {
			serverCrackingProfiles.selectAction(action.toString());
		}
		if (packetTrace != null) {
			if (packetTrace.equals(Status.Enable)) {
				serverCrackingProfiles.enablePacketTrace();
			}
			if (packetTrace.equals(Status.Disable)) {
				serverCrackingProfiles.disablePacketTrace();
			}
		}

		SCProfileInnerTable sCProfileInnerTable = (SCProfileInnerTable) serverCrackingProfiles.mSCProfileInnerTable().open();
		sCProfileInnerTable.addServerCrackingProtection();
		sCProfileInnerTable.selectServerCrackingProtectionName(serverCrackingProtectionName);
		if (action != null) {
			sCProfileInnerTable.selectSensitivity(sensitivity.toString());
		}
		if (action != null) {
			sCProfileInnerTable.selectRisk(risk.toString());
		}
		
		sCProfileInnerTable.submit();
		try {
			Thread.sleep(6000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		serverCrackingProfiles.submit();
	}

	public String getProfileName() {
		return profileName;
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
