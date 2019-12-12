package com.radware.vision.tests.dp.networkprotection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.connectionlimitprofiles.ConnectionLimitProfiles;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.connectionlimitprofiles.connectionlimitnonscreen.AddCLProtectionInnerTable;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class CLProfileTest extends DpTestBase{


	
	private String protectionName;
	private String profileName;

	@Test
    @TestProperties(name = "Delete Connection Limit Profile", paramsInclude = {"qcTestId", "deviceName", "profileName"})
	public void deleteConnectionLimitProfile() throws Exception {
		ConnectionLimitProfiles clProfile = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mConnectionLimitProfiles();
		clProfile.openPage();
		clProfile.deleteConnectionLimitProfilesByKeyValue("Profile Name", profileName);
	}
	
	@Test
    @TestProperties(name = "Create Connection Limit Profile", paramsInclude = {"qcTestId", "deviceName", "profileName", "protectionName"})
	public void createConnectionLimitProfile() throws Exception {
		ConnectionLimitProfiles clProfile = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mConnectionLimitProfiles();
		clProfile.openPage();
		clProfile.addConnectionLimitProfiles();
		clProfile.setProfileName(profileName);
		AddCLProtectionInnerTable addCLProtectionInnerTable = (AddCLProtectionInnerTable) clProfile.mAddCLProtectionInnerTable().open();
		addCLProtectionInnerTable.addCLToProfile();
		addCLProtectionInnerTable.selectProtectionName(protectionName);
		addCLProtectionInnerTable.submit();
		Thread.sleep(6000);
		clProfile.submit();
	}




	public String getProtectionName() {
		return protectionName;
	}




	public void setProtectionName(String protectionName) {
		this.protectionName = protectionName;
	}




	public String getProfileName() {
		return profileName;
	}




	public void setProfileName(String profileName) {
		this.profileName = profileName;
	}
	
	
}
