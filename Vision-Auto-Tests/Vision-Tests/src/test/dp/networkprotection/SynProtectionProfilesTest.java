package com.radware.vision.tests.dp.networkprotection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.synprotectionprofiles.SYNProtectionProfiles;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.synprotectionprofiles.synnonescreen.AddSYNProtectionInnerTable;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class SynProtectionProfilesTest extends DpTestBase{
	
	private String ProtectionName;
	private String ProfileName;
	
	
	@Test
    @TestProperties(name = "Delete SYN Profiles", paramsInclude = {"qcTestId", "deviceName", "ProfileName"})
	public void deleteSynProtectionProfiles() throws Exception {
		SYNProtectionProfiles synProtectionProfiles = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSYNProtectionProfiles();
		synProtectionProfiles.openPage();
		synProtectionProfiles.deleteSYNProtectionProfileByKeyValue("Profile Name", ProfileName);
	}
	
	@Test
    @TestProperties(name = "Create SYN Profiles", paramsInclude = {"qcTestId", "deviceName", "ProfileName", "ProtectionName"})
	public void createSynProtectionProfiles() throws Exception {
		SYNProtectionProfiles synProtectionProfiles = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSYNProtectionProfiles();
		synProtectionProfiles.openPage();
		synProtectionProfiles.addSYNProtectionProfile();
		synProtectionProfiles.setProfileName(ProfileName);
		AddSYNProtectionInnerTable addSYNProtectionInnerTable = (AddSYNProtectionInnerTable) synProtectionProfiles.mAddProtectionInnerTable().open();
		addSYNProtectionInnerTable.addProtectionToProfile();
		addSYNProtectionInnerTable.selectProtectionName(ProtectionName);
		addSYNProtectionInnerTable.submit();
		Thread.sleep(6000);
		synProtectionProfiles.submit();
	}

	public String getProtectionName() {
		return ProtectionName;
	}


	public void setProtectionName(String protectionName) {
		ProtectionName = protectionName;
	}


	public String getProfileName() {
		return ProfileName;
	}


	public void setProfileName(String profileName) {
		ProfileName = profileName;
	}
	
}
