package com.radware.vision.infra.testhandlers.system.usermanagement.cliaccesslist;

import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.dialogboxes.AreYouSureDialogBox;
import com.radware.vision.infra.base.pages.system.usermanagement.UserManagement;
import com.radware.vision.infra.base.pages.system.usermanagement.cliaccesslist.CliAccessList;

public class CliAccessListHandler {
	
	public static void addUser(String userName){
		VisionServerMenuPane menuPane = new VisionServerMenuPane();
		UserManagement userManagement = menuPane.openSystemUserManagement();
		CliAccessList cliAccessList = userManagement.cliAccessListMenu();
		cliAccessList.addUser();
		cliAccessList.setUserName(userName);
		
	}
	public static void viewUser(String userName){
		VisionServerMenuPane menuPane = new VisionServerMenuPane();
		UserManagement userManagement = menuPane.openSystemUserManagement();	
		CliAccessList cliAccessList = userManagement.cliAccessListMenu();
		cliAccessList.viewUser("User Name", userName);
	}
	public static void deleteUser(String userName){
		VisionServerMenuPane menuPane = new VisionServerMenuPane();
		UserManagement userManagement = menuPane.openSystemUserManagement();
		CliAccessList cliAccessList = userManagement.cliAccessListMenu();
		cliAccessList.deleteUser("User Name", userName);
		AreYouSureDialogBox dialogBox = new AreYouSureDialogBox();
		dialogBox.yesButtonClick();
	}
}
