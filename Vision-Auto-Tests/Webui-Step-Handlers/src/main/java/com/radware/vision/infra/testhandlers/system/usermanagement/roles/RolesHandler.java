package com.radware.vision.infra.testhandlers.system.usermanagement.roles;

import java.util.List;

import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.system.usermanagement.UserManagement;

public class RolesHandler {

	public static boolean verifyExistingRoles(List<String> rolesToVerify) {
		VisionServerMenuPane menuPane = new VisionServerMenuPane();
		UserManagement userManagement = menuPane.openSystemUserManagement();
		com.radware.vision.infra.base.pages.system.usermanagement.Roles roles = userManagement.userRolesMenu();
		List<String> existingRoles = roles.getRoleNames();
		return existingRoles.containsAll(rolesToVerify);
	}
}
