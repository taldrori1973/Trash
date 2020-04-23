package com.radware.vision.tests.dp;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.dp.configuration.setup.networking.basic.Basic;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.bdosprotection.BDoSProtection;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.dnsfloodprotection.DNSFloodProtection;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.dosshield.DoSShield;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.fraudprotection.FraudProtection;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.httpfloodprotections.HTTPFloodProtections;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.outofstate.OutofState;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.signatureprotection.SignatureProtection;
import com.radware.automation.webui.webpages.dp.configuration.setup.scuritysettings.synfloodprotection.SYNFloodProtection;
import com.radware.automation.webui.widgets.impl.popups.WebUIPopup;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.VisionServerInfoPane;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class EnableAllProtectionTest extends DpTestBase {

	//private AntiScanning antiScanning = null;
	private BDoSProtection bDoSProtection = null;
	private DNSFloodProtection dNSFloodProtection = null;
	private FraudProtection fraudProtection = null;
	private HTTPFloodProtections hTTPFloodProtections = null;
	private SYNFloodProtection sYNFloodProtection = null;
	private SignatureProtection signatureProtection = null;
	private DoSShield doSShield = null;
	private OutofState outofState = null;
	private Basic basic = null;
	
	
	public TopologyTreeTabs parentTree;
	
	private WebUIPopup popup = null;

	@Test
	@TestProperties(name = "Enable All Protection", paramsInclude = { "qcTestId" , "deviceName", "parentTree"})
	public void enableAllProtection() throws Exception {

		boolean needRebot = false ;
		
		
		signatureProtection = dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mSignatureProtection();
		signatureProtection.openPage();
		if (!signatureProtection.isCheckedApplicationSecurityProtection()) {
			signatureProtection.enableApplicationSecurityProtection();
			signatureProtection.submit();
			WebDriver driver = webUtils.getDriver();
			driver.findElement(By.id("gwt-debug-Dialog_Box_Submit and Reset Later")).click();
			needRebot = true;
		}

		doSShield = dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mDoSShield();
		doSShield.openPage();
		if (!doSShield.isCheckedDoSShieldProtection()) {
			doSShield.enableDoSShieldProtection();
			doSShield.submit();
			WebDriver driver = webUtils.getDriver();
			driver.findElement(By.id("gwt-debug-Dialog_Box_Submit and Reset Later")).click();
			needRebot = true;
		}

		bDoSProtection = dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mBDoSProtection();
		bDoSProtection.openPage();
		if (!bDoSProtection.isCheckedBDoSProtection()) {
			bDoSProtection.enableBDoSProtection();
			bDoSProtection.submit();
			WebDriver driver = webUtils.getDriver();
			driver.findElement(By.id("gwt-debug-Dialog_Box_Submit and Reset Later")).click();
			needRebot = true;
		}

		hTTPFloodProtections = dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mHTTPFloodProtections();
		hTTPFloodProtections.openPage();
		if (!hTTPFloodProtections.isCheckedEnableHTTPMitigator()) {
			hTTPFloodProtections.enableEnableHTTPMitigator();
			hTTPFloodProtections.submit();
			WebDriver driver = webUtils.getDriver();
			driver.findElement(By.id("gwt-debug-Dialog_Box_Submit and Reset Later")).click();
			needRebot = true;
		}

		/*fraudProtection = dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mFraudProtection();
		fraudProtection.openPage();
		if (!fraudProtection.isCheckedFraudProtection()) {
			fraudProtection.enableFraudProtection();
			fraudProtection.submit();
			WebDriver driver = webUtils.getDriver();
			driver.findElement(By.id("gwt-debug-Dialog_Box_Submit and Reset Later")).click();
			needRebot = true;
		}*/

		dNSFloodProtection = dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mDNSFloodProtection();
		dNSFloodProtection.openPage();
		if (!dNSFloodProtection.isCheckedDNSFloodProtection()) {
			dNSFloodProtection.enableDNSFloodProtection();
			dNSFloodProtection.submit();
			WebDriver driver = webUtils.getDriver();
			driver.findElement(By.id("gwt-debug-Dialog_Box_Submit and Reset Later")).click();
			needRebot = true;
		}



/*		antiScanning = dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mAntiScanning();
		antiScanning.openPage();
		if (!antiScanning.isCheckedAntiScanningProtection()) {
			antiScanning.enableAntiScanningProtection();
			antiScanning.submit();
			WebDriver driver = webUtils.getDriver();
			driver.findElement(By.id("gwt-debug-Dialog_Box_Submit and Reset Later")).click();
			needRebot = true;
		}*/
		
		
		sYNFloodProtection = dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mSYNFloodProtection();
		sYNFloodProtection.openPage();
		if (!sYNFloodProtection.isCheckedSYNFloodProtection()) {
			sYNFloodProtection.enableSYNFloodProtection();
			WebDriver driver = webUtils.getDriver();
			driver.findElement(By.id("gwt-debug-Dialog_Box_Reset Now")).click();
			Thread.sleep(400000);
			//driver.navigate().refresh();
		}
		
		
		outofState = dpUtils.dpProduct.mConfiguration().mSetup().mSecuritySettings().mOutofState();
		outofState.openPage();
		if (!outofState.isCheckedOutOfStateProtection()) {
			outofState.enableOutOfStateProtection();
			WebDriver driver = webUtils.getDriver();
			driver.findElement(By.id("gwt-debug-Dialog_Box_Reset Now")).click();
			Thread.sleep(400000);
			//driver.navigate().refresh();
		}
		
		
		basic = dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mBasic();
		basic.openPage();
		basic.disableIPv6();
		basic.enableIPv6();
		basic.submit();
		WebDriver driver = webUtils.getDriver();
		driver.findElement(By.id("gwt-debug-Dialog_Box_Submit and Reset")).click();
		Thread.sleep(400000);
		//driver.navigate().refresh();

	}
	
	public void doReboot() throws Exception{
		
		WebDriver driver = webUtils.getDriver();
		driver.findElement(By.id("gwt-debug-Dialog_Box_Reset Now")).click();
		Thread.sleep(400000);
		//driver.navigate().refresh();
		
	}
	
	private void lockDevice() throws Exception {
		try {
			DeviceState state = DeviceState.Lock;
			DeviceOperationsHandler.lockUnlockDevice(getDeviceName(), String.valueOf(parentTree), String.valueOf(state), true);
			BasicOperationsHandler.delay(2);
			VisionServerInfoPane infopane = new VisionServerInfoPane();
			String currentyLockedBy = infopane.getDeviceLockedBy();
			if(!(currentyLockedBy.equals(WebUITestBase.getConnectionUsername()))) {
                BaseTestUtils.report("Device: " + getDeviceName() + " is locked by: " + currentyLockedBy + ", and not by " + WebUITestBase.getConnectionUsername(), Reporter.FAIL);
			}
		} catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :", Reporter.FAIL);
		}
	}

	
	
	public TopologyTreeTabs getParentTree() {
		return parentTree;
	}

	public void setParentTree(TopologyTreeTabs parentTree) {
		this.parentTree = parentTree;
	}

	
}
