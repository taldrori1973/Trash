package com.radware.vision.infra.base.pages.topologytree.devicecfg;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.automation.webui.widgets.impl.WebUIReferencedDropdown;
import com.radware.vision.infra.base.pages.topologytree.DeviceProperties;
import junit.framework.SystemTestCase4;

public class EventNotification extends DeviceProperties{
	
	String visionServerIpComboName = "Register APSolute Vision Server IP";
	String removeAllTargetsCheckBoxName = "Remove All Other Targets of Device Events";
	String registerVisionServerName = "Register This APSolute Vision Server for Device Events";
	
	public EventNotification(String deviceDriverFilename) {
		super(deviceDriverFilename);
	}
	
	public void setVisionServerIp(String visionServerIp) {
		WebUIDropdown serverIpCombo = (WebUIDropdown)container.getDropdown(visionServerIpComboName);
		WebUIReferencedDropdown webUIReferencedDropdown = new WebUIReferencedDropdown();
		webUIReferencedDropdown.setWebElement(serverIpCombo.getWebElement());
		for(int i = 0; i < 3; i++){
			try {
				webUIReferencedDropdown.selectOptionByText(visionServerIp);
				break;
			} catch(Exception ise) {
				SystemTestCase4.report.report("Failed to find Vision Server IP: " + visionServerIp + " - " + "Iteration: " + i, Reporter.PASS);
				continue;
			}
		}
        webUIReferencedDropdown.applySelection();
	}
	
	public void setRemoveAllOtherTargets(boolean check) {
		WebUICheckbox removeAllTargetsCheckBox = (WebUICheckbox)container.getCheckbox(removeAllTargetsCheckBoxName);
		if (check) {
			removeAllTargetsCheckBox.check();
		} else {
			removeAllTargetsCheckBox.uncheck();
		}
	}
	public void setRegisterVisionServerForDeviceEvents(boolean check) {
		WebUICheckbox registerVisionServerCheckBox = (WebUICheckbox)container.getCheckbox(registerVisionServerName);
		
		if (check) {
			registerVisionServerCheckBox.check();
		} else {
			registerVisionServerCheckBox.uncheck();
		}
	}

}
