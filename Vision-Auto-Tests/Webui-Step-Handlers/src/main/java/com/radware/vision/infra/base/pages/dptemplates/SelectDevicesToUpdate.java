package com.radware.vision.infra.base.pages.dptemplates;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.Instance;
import com.radware.vision.infra.enums.UpdateMethod;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

public class SelectDevicesToUpdate extends WebUIVisionBasePage {
	public SelectDevicesToUpdate() {
		super("Upload File to Server", "DPConfigTemplates.SendFileToDevice.xml", false);
		setPageLocatorHow(How.ID);
		setPageLocatorContent(WebUIStringsVision.getAlertsTab());
	}

	public void setUpdateMethod(UpdateMethod method) {
		WebUIDropdown methodCombo = (WebUIDropdown)container.getDropdown("Update Method");
		if(methodCombo.isEnabled()){
			methodCombo.selectOptionByText(method.getUpdateMethod().toString());
		}
	}
	public void setInstallOnInstance(Instance instance) {
		WebUIDropdown instanceCombo = (WebUIDropdown)container.getDropdown("Install on Instance");
		if(instanceCombo.isEnabled()){
			instanceCombo.selectOptionByText(instance.getInstance().toString());
		}
	}
	public void setUpdatePoliciesAfterSendingConfiguration(boolean updatePolicies) {
		WebUICheckbox checkBox = (WebUICheckbox) container.getCheckbox("Update Policies After Sending Configuration");
		if (updatePolicies)
			checkBox.check();
		else
			checkBox.uncheck();
	}
	public void filterButtonClick(){
		ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStringsVision.getDevicesToUpdateApplyFilterButton());
		(new WebUIComponent(locator)).click();
	}
}
