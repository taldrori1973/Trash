package com.radware.vision.infra.base.pages.system.generalsettings.devicedrivers;

import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.awt.Toolkit;
import java.awt.datatransfer.StringSelection;

import org.openqa.selenium.support.How;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;

public class UploadDeviceDriver extends WebUIVisionBasePage{
	
	public UploadDeviceDriver() {
		super("Select Devices to Update", "MgtServer.DeviceDriverManagement.UploadDD.xml", false);
		
	}
	public static void selectFile(String fileName) {
		
		ComponentLocator uploadLocator = new ComponentLocator(How.ID , WebUIStringsVision.getMgtServerFileUploadWidget());
		WebUIButton button = new WebUIButton(new WebUIComponent(uploadLocator));
		button.click();
		setFileNameToUpload(fileName);
		

	}
	public static void uploadFile(){
		ComponentLocator uploadLocator = new ComponentLocator(How.ID , WebUIStringsVision.getMgtServerFileUploadSubmit());
		WebUIButton uploadButton = new WebUIButton(new WebUIComponent(uploadLocator));
		uploadButton.click();
	}
	
	public static void closeUploudDialogBox(){
		ComponentLocator locator = new ComponentLocator(How.ID , WebUIStringsVision.getDialogBoxClose());
		WebUIButton button = new WebUIButton(new WebUIComponent(locator));
		button.click();
	}
	public static void setClipboardData(String fileName) {
	   StringSelection stringSelection = new StringSelection(fileName);
	   Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
	}
	public static void setFileNameToUpload(String fileName) {
		setClipboardData(fileName);
		//native key strokes for CTRL, V and ENTER keys
		try {
			Robot robot = new Robot();
			robot.delay(1000);
			robot.keyPress(KeyEvent.VK_CONTROL);
			robot.keyPress(KeyEvent.VK_V);
			robot.keyRelease(KeyEvent.VK_V);
			robot.keyRelease(KeyEvent.VK_CONTROL);
			robot.delay(500);
			robot.keyPress(KeyEvent.VK_ENTER);
			robot.keyRelease(KeyEvent.VK_ENTER);
		} catch (AWTException e) {
			e.printStackTrace();
		}
	}
}
