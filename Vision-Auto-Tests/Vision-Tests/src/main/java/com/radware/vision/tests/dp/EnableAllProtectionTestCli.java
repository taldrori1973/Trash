package com.radware.vision.tests.dp;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.products.defensepro.DefenseProProduct;
import com.radware.products.defensepro.defensepro.DefenseProEnums.DpStatus;
import com.radware.products.defensepro.device.DpDeviceEnums.DpDevIpVersion;
import com.radware.products.defensepro.utilities.DpRadwareTestCase;
import jsystem.framework.TestProperties;
import jsystem.framework.report.ListenerstManager;
import junit.framework.SystemTestCase4;
import org.junit.Before;
import org.junit.Test;

public class EnableAllProtectionTestCli extends SystemTestCase4{

	DefenseProProduct defensepro;
	
	@Test
	@TestProperties(name = "Check All Protections Cli", paramsInclude = {"qcTestId"} )
	public void checkAllProtectionCli() throws Exception{
		
		boolean passed = true;
	
		//Signature
	
		DpStatus oosStatus = defensepro.dp.OutOfState().GlobalParameters().getStatus();
		DpStatus dnsStatus = defensepro.dp.Dns().Global().getStatusAsEnum();
		
		boolean bDoSProtectionStatus =  defensepro.dp.isEnabledDpBdos();
		boolean sYNFloodProtectionStatus= defensepro.dp.isEnabledDpSynProtection();
		boolean doSShieldStatus = defensepro.dp.isEnabledDpSignatureDosShield();
		
		boolean hTTPFloodProtectionsStatus = defensepro.dp.isEnabledDpHttpMitigator();

		boolean fraudProtectionStatus = defensepro.dp.isEnabledDpAntiFraud();
		
		DpDevIpVersion ipVersionMode = defensepro.device.getDevIpVersionMode();
		

		if(!bDoSProtectionStatus){
			ListenerstManager.getInstance().report("FAIL : BDoS Protection Status is: " + bDoSProtectionStatus , Reporter.FAIL);
			passed = false;
		}
		if(!hTTPFloodProtectionsStatus){
			ListenerstManager.getInstance().report("FAIL : HTTP Flood Protections Status is: " + hTTPFloodProtectionsStatus , Reporter.FAIL);
			passed = false;
		}
		if(!sYNFloodProtectionStatus){
			ListenerstManager.getInstance().report("FAIL : SYN Flood Protection Status is: " + sYNFloodProtectionStatus , Reporter.FAIL);
			passed = false;
		}
		if(!doSShieldStatus){
			ListenerstManager.getInstance().report("FAIL : DoS Shield Status is: " + doSShieldStatus , Reporter.FAIL);
			passed = false;
		}
		if(!fraudProtectionStatus){
			ListenerstManager.getInstance().report("FAIL : Fraud Protection Status is: " + fraudProtectionStatus , Reporter.FAIL);
			passed = false;
		}
		
		if(dnsStatus.equals(DpStatus.disable)){
			ListenerstManager.getInstance().report("FAIL : Dns Protection Status is: " + dnsStatus , Reporter.FAIL);
			passed = false;
		}
		
		if(oosStatus.equals(DpStatus.disable)){
			ListenerstManager.getInstance().report("FAIL : OOS Protection Status is: " + oosStatus , Reporter.FAIL);
			passed = false;
		}
		
		
		if(ipVersionMode.equals(DpDevIpVersion.ipv4)){
			ListenerstManager.getInstance().report("FAIL : IpVersion Mode : " + ipVersionMode + " but expected: " + DpDevIpVersion.ipv4and6, Reporter.FAIL);
			passed = false;
		}

		
		if (passed) {
			ListenerstManager.getInstance().report("Pass : BDoS Protection Status: Enabled As Expected.");
			ListenerstManager.getInstance().report("Pass : HTTP Flood Protections Status: Enabled As Expected.");
			ListenerstManager.getInstance().report("Pass : SYN Flood Protection Status: Enabled As Expected.");
			ListenerstManager.getInstance().report("Pass : DoS Shield Status: Enabled As Expected.");
			ListenerstManager.getInstance().report("Pass : Fraud Protection Status: Enabled As Expected.");
			ListenerstManager.getInstance().report("Pass : Dns Protection Status is : "+dnsStatus+" As Expected.");
			ListenerstManager.getInstance().report("Pass : OOS Protection Status is : "+oosStatus+" As Expected.");
			ListenerstManager.getInstance().report("Pass : IpVersion Mode: "+ipVersionMode+" As Expected.");
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

	public DefenseProProduct getDefensepro() {
		return defensepro;
	}

	public void setDefensepro(DefenseProProduct defensepro) {
		this.defensepro = defensepro;
	}
}
