package com.radware.vision.tests.dp.networkprotection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.synprotectionprofiles.synprotections.SYNProtections;
import com.radware.vision.tests.dp.DpTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;


public class SYNProtectionsTest extends DpTestBase {
	
	private String protectionName;
	private String protectionID;
	private String applicationPortGroup;
	private String activationThreshold;
	private String terminationThreshold;
	private String risk;
	private String sourceType;
	
	@Test
    @TestProperties(name = "Create Syn protections", paramsInclude = {"qcTestId", "deviceName", "protectionName", "protectionID", "applicationPortGroup", "activationThreshold", "terminationThreshold", "risk", "sourceType"})
	public void createDNSProfile() throws Exception {
		SYNProtections synProtections = dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSYNProtectionProfiles().mSYNProtections();
		synProtections.openPage();
		synProtections.addSYNProtections();
		synProtections.setProtectionName(protectionName);
	//	synProtections.setProtectionID(protectionID);
		synProtections.selectApplicationPortGroup(applicationPortGroup);
		synProtections.setActivationThreshold(activationThreshold);
		synProtections.setTerminationThreshold(terminationThreshold);
		//synProtections.selectRisk(risk);
		//synProtections.selectSourceType(sourceType);
		synProtections.submit();

	}
	
	
	
	
	
	public String getProtectionName() {
		return protectionName;
	}
	public void setProtectionName(String protectionName) {
		this.protectionName = protectionName;
	}
	public String getProtectionID() {
		return protectionID;
	}
	public void setProtectionID(String protectionID) {
		this.protectionID = protectionID;
	}
	public String getApplicationPortGroup() {
		return applicationPortGroup;
	}
	public void setApplicationPortGroup(String applicationPortGroup) {
		this.applicationPortGroup = applicationPortGroup;
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
	public String getRisk() {
		return risk;
	}
	public void setRisk(String risk) {
		this.risk = risk;
	}
	public String getSourceType() {
		return sourceType;
	}
	public void setSourceType(String sourceType) {
		this.sourceType = sourceType;
	}
	
	

}
