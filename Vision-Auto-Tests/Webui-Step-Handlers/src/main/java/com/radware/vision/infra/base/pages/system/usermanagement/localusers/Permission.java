package com.radware.vision.infra.base.pages.system.usermanagement.localusers;

import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.automation.webui.widgets.impl.WebUIReferencedDropdown;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;

public class Permission extends WebUIVisionBasePage {
	
	public Permission() {
		super("Permission", "UserManagement.RoleGroupPair.xml", false);
	}
	
	public void setRole(String roleName) {
		WebUIDropdown roleDropdown = (WebUIDropdown)container.getDropdown("Role");
		roleDropdown.selectOptionByText(roleName);
	}
	
	public void setScope(String scope) {
		WebUIReferencedDropdown roleDropdown = (WebUIReferencedDropdown)container.getDropdown("Scope");
		if(!roleDropdown.isEnabled()) {
			return;
		}
		roleDropdown.selectOptionByText(scope);
	}
}
