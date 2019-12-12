package com.radware.vision.infra.base.pages.defensepro;

import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import org.openqa.selenium.support.How;

import java.util.List;

public class DpClusterInformationPane extends WebUIVisionBasePage {

	DpClusterInformationTable dpClusterInformationTable;

	public void switchover() throws Exception {
		clickButton(WebUIStrings.getDpClusterControlBarSwitch());
	}

	public void updatePolicies() throws Exception {
		clickButton(WebUIStrings.getUpdatePoliciesButton());
	}

	public void sychronize() throws Exception {
		clickButton(WebUIStrings.getDpClusterControlBarSync());
	}
	
	public List<DpClusterEntity> getDpClusterEntities() {
		DpClusterInformationTable dpClusterInformationTable = new DpClusterInformationTable();
		return dpClusterInformationTable.getDpClusters();
	}

    public boolean isDpDevicePrimary(String dpDeviceName) {
		return innerCheckDeviceStatus(dpDeviceName, HAStatus.Primary);
	}
	
	public boolean isDpDeviceSecondary(String dpDeviceName) {
		 return innerCheckDeviceStatus(dpDeviceName, HAStatus.Secondary);
	}
	
	private boolean innerCheckDeviceStatus(String dpDeviceName, HAStatus requiredStatus) {
		List<DpClusterEntity> dpClusterEntities = getDpClusterEntities();
		HAStatus dpDeviceStatus = getStatusForDevice(dpClusterEntities, dpDeviceName);
		return dpDeviceStatus != null ? dpDeviceStatus == requiredStatus : false;
	}
	
	private HAStatus getStatusForDevice(List<DpClusterEntity> devices, String deviceName) {
		for(DpClusterEntity currentDpDevice : devices) {
			if(currentDpDevice.getDeviceName().equals(deviceName)) {
				return currentDpDevice.getHaStatus();
			}
		}
		return null;
	}

	private void clickButton(String buttonName) throws Exception {
		WebUIButton button = new WebUIButton();
		ComponentLocator locator = new ComponentLocator(How.ID, buttonName);
		button.setLocator(locator);
		if (button.find()) {
			button.click();
		} else {

			throw new Exception("Element could not be found | is not enabled | is not displayed" + locator.getLocatorValue());
		}

	}
}
