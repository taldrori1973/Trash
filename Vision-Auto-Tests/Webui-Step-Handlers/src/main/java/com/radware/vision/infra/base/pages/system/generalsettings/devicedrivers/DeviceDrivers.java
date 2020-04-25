package com.radware.vision.infra.base.pages.system.generalsettings.devicedrivers;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

public class DeviceDrivers extends WebUIVisionBasePage{
	String deviceDrivers = "Manage Device Drivers";
	
	public DeviceDrivers() {
		super("Update to Latest Driver", "MgtServer.DeviceDriverManagement.xml", false);
		setPageLocatorHow(How.ID);
		setPageLocatorContent(WebUIStringsVision.getDeviceDriversNode());
	}
	public void clickUploadDD() {
		ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStringsVision.getUploadDeviceDriver());
		(new WebUIComponent(locator)).click();
	}
	public void clickUpdateToLatestD() {
		ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStringsVision.getUpdateToLatest());
		(new WebUIComponent(locator)).click();
	}
	public void clickRevertTobaselineD() {
		ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStringsVision.getRevertToBaselineDriver());
		(new WebUIComponent(locator)).click();
	}
	public void clickUpdateAllDriversToLatest() {
		ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStringsVision.getUpdateAllDriversToLatest());
		(new WebUIComponent(locator)).click();
	}
	public void clickUpdateDD() {
		ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStringsVision.getUpdateDeviceDriver());
		(new WebUIComponent(locator)).click();
	}
	
	public void selectDD(String columnValue, String columnName) {
		WebUITable ddTable = (WebUITable)container.getTable(deviceDrivers);
		ddTable.analyzeTable("span");
		ddTable.clickRowByKeyValue(columnName, columnValue);
	}
    public WebUITable getDeviceDriversTable() {
        WebUITable table = (WebUITable)container.getTable(deviceDrivers);
        return table;
    }

//	public boolean validateFileUpload(String columnValue, String columnName){
//		WebUITable ddTable = (WebUITable)container.getTable(deviceDrivers);
//		ddTable.analyzeTable("span");
//		int found = ddTable.getRowIndex(columnName, columnValue);
//		if()
//	}

}
