package com.radware.vision.infra.testhandlers.system.generalsettings.devicedriver;

import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.dialogboxes.AreYouSureDialogBox;
import com.radware.vision.infra.base.pages.system.generalsettings.devicedrivers.DeviceDrivers;
import com.radware.vision.infra.base.pages.system.generalsettings.devicedrivers.UpdateDeviceDriver;
import com.radware.vision.infra.base.pages.system.generalsettings.devicedrivers.UploadDeviceDriver;

public class DeviceDriverHandler {
	public static void updateDeviceDriver(String fileName, String columnValue, String columnName) throws Exception{
		DeviceDrivers deviceDriver = openDeviceDriverMenu();
		deviceDriver.selectDD(columnValue, columnName);
		deviceDriver.clickUpdateDD();
		UpdateDeviceDriver.selectFile(fileName);
		UpdateDeviceDriver.uploadFile();
		UploadDeviceDriver.closeUploudDialogBox();
	}
	
	public static void updateToLatestDriver(String columnValue, String columnName) { 
		DeviceDrivers deviceDrivers = openDeviceDriverMenu();
		deviceDrivers.selectDD(columnValue, columnName);
		deviceDrivers.clickUpdateToLatestD();
		AreYouSureDialogBox dialogBox = new AreYouSureDialogBox();
		dialogBox.yesButtonClick();
		}
	
	public static void revertToBaselineDriver(String columnValue, String columnName) { 
		DeviceDrivers deviceDrivers = openDeviceDriverMenu();
		deviceDrivers.selectDD(columnValue, columnName);
		deviceDrivers.clickRevertTobaselineD();
		AreYouSureDialogBox dialogBox = new AreYouSureDialogBox();
		dialogBox.yesButtonClick();
		}
	
	public static void uploadDeviceDriver(String fileName) { 
		DeviceDrivers deviceDrivers = openDeviceDriverMenu();
		deviceDrivers.clickUploadDD();
		UploadDeviceDriver.selectFile(fileName);
		UploadDeviceDriver.uploadFile();
		UploadDeviceDriver.closeUploudDialogBox();
		}
	
	public static void updateAllDriversToLatest() { 
		DeviceDrivers deviceDrivers = openDeviceDriverMenu();
		deviceDrivers.clickUpdateAllDriversToLatest();
		AreYouSureDialogBox dialogBox = new AreYouSureDialogBox();
		dialogBox.yesButtonClick();
		}
	
	public static DeviceDrivers openDeviceDriverMenu(){
		VisionServerMenuPane menuPane = new VisionServerMenuPane();
		return menuPane.openSystemGeneralSettings().deviceDriversMenu();
//		GeneralSettings.deviceDriversMenu();
	}
}
