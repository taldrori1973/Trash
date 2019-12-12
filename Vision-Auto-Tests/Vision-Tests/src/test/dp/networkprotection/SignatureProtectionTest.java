package com.radware.vision.tests.dp.networkprotection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.signatureprotection.profiles.Profiles;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.signatureprotection.profiles.profilesnonscreen.AddSignatureProfileInnerTable;
import com.radware.vision.tests.dp.DpTestBase;
import com.radware.vision.tests.dp.networkprotection.enums.SigProtectionAttributeType;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class SignatureProtectionTest extends DpTestBase{

	private String profileName;
	private String ruleName;
	private SigProtectionAttributeType attributeType;
	private String attributeValue;
	

	@Test
    @TestProperties(name = "Delete Signature Protection Profile", paramsInclude = {"qcTestId", "deviceName", "profileName"})
	public void deleteSignatureProtectionProfile() throws Exception {
		Profiles signatureProfile = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSignatureProtection().mProfiles();
		signatureProfile.openPage();
		signatureProfile.deleteSignatureProfileByKeyValue("Profile Name", profileName);
	}
	
	
	@Test
    @TestProperties(name = "Create Signature Protection Profile", paramsInclude = {"qcTestId", "deviceName", "profileName", "ruleName", "attributeType", "attributeValue"})
	public void CreateSignatureProtectionProfile() throws Exception {
		Profiles signatureProfile = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSignatureProtection().mProfiles();
		signatureProfile.openPage();
		signatureProfile.addSignatureProfile();
		signatureProfile.setSignatureProfileName(profileName);
		AddSignatureProfileInnerTable addSignatureProfileInnerTable = (AddSignatureProfileInnerTable)signatureProfile.mAddSignatureProfileInnerTable().open();
		addSignatureProfileInnerTable.addSignatureToProfile();
		addSignatureProfileInnerTable.setRuleName(ruleName);
		addSignatureProfileInnerTable.selectAttributeType(attributeType.getAttrType());
		addSignatureProfileInnerTable.selectAttributeValue(attributeValue);
		addSignatureProfileInnerTable.submit();
		Thread.sleep(6000);
		signatureProfile.submit();
		
	}
	
	
	
	public String getRuleName() {
		return ruleName;
	}


	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}


	public SigProtectionAttributeType getAttributeType() {
		return attributeType;
	}


	public void setAttributeType(SigProtectionAttributeType attributeType) {
		this.attributeType = attributeType;
	}


	public String getAttributeValue() {
		return attributeValue;
	}


	public void setAttributeValue(String attributeValue) {
		this.attributeValue = attributeValue;
	}


	public String getProfileName() {
		return profileName;
	}

	public void setProfileName(String profileName) {
		this.profileName = profileName;
	}

}
