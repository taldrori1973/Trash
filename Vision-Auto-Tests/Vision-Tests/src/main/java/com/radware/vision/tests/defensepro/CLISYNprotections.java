package com.radware.vision.tests.defensepro;

import org.junit.Test;

//import com.radware.products.defensepro.DefenseProProduct;
//import com.radware.products.defensepro.defensepro.DefenseProEnums.DpPolicyAction;
//import com.radware.products.defensepro.defensepro.DefenseProEnums.DpRisk;
//import com.radware.products.defensepro.defensepro.DefenseProEnums.DpStatus;
//import com.radware.products.defensepro.utilities.DpRadwareTestCase;

import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import junit.framework.SystemTestCase4;

public class CLISYNprotections extends SystemTestCase4{
	
	private String protectionName="HTTP";
	private String protectionID="200000";
	private String applicationPortGroup="http";
	
	private String activationThreshold="1500";
	private String terminationThreshold="1500";
	private String risk;
	private String sourceType;
//	DefenseProProduct defensepro;
	
	@Test
	@TestProperties(name = "Verify SYN Protections - Cli", paramsInclude = {"qcTestId", "protectionName" , "protectionID", 
			"applicationPortGroup", "activationThreshold", "terminationThreshold","risk","sourceType"} )
	public void SynProtectionsCliTest() throws Exception {
		
		
		 
		 //String _protectionID=defensepro.dp.getDpSynProtectionAttacksUserId(protectionName);
//		 String _applicationPortGroup=defensepro.dp.getdpsynprotectionUserAttackApplicationPortGroup(protectionName);
//		 String _activationThreshold=defensepro.dp.getdpsynprotectionUserAttackActivationThreshold(protectionName);
//		 String _terminationThreshold=defensepro.dp.getdpsynprotectionUserAttackTerminationThreshold(protectionName);
		 //String _risk=defensepro.dp.getdpsynprotectionUserAttackRisk(protectionName);
	//	 String sourceType=defensepro.dp.getdpsynprotection
		
	}	
	
	
	
	public void setUp() throws Exception
	{
		ListenerstManager.getInstance().startLevel("Setup");
//		defensepro = DpRadwareTestCase.getDefenseProInstance();
		
		ListenerstManager.getInstance().report("in setup...");
		ListenerstManager.getInstance().stopLevel();
	}
	
	
	public void tearDown()
	{
		
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
