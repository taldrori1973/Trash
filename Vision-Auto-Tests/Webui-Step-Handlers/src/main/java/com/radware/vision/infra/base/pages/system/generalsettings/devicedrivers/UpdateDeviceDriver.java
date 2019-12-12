package com.radware.vision.infra.base.pages.system.generalsettings.devicedrivers;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIButton;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.awt.*;
import java.awt.datatransfer.StringSelection;
import java.awt.event.KeyEvent;

public class UpdateDeviceDriver extends WebUIVisionBasePage{
	public UpdateDeviceDriver() {
		super("Upload Device Driver", "MgtServer.DeviceDriverManagement.Upload.xml", false);
		
	}
	public static void selectFile(String fileName) throws Exception{
		ComponentLocator updateLocator = new ComponentLocator(How.ID , WebUIStringsVision.getMgtServerFileUploadWidget());
		WebUIButton button = new WebUIButton(new WebUIComponent(updateLocator));
		button.click();
		setFileNameToUpload(fileName);
	}
	public static void uploadFile(){
		ComponentLocator uploadLocator = new ComponentLocator(How.ID , WebUIStringsVision.getMgtServerFileUploadSubmit());
		WebUIButton uploadButton = new WebUIButton(new WebUIComponent(uploadLocator));
		uploadButton.click();
	}

	public static void setClipboardData(String fileName) {
	   StringSelection stringSelection = new StringSelection(fileName);
	   Toolkit.getDefaultToolkit().getSystemClipboard().setContents(stringSelection, null);
	}

    private static void setFileNameToUpload(String fileName) throws Exception {
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
			throw new Exception("Could NOT select " + fileName , e);
		}
	}
}
