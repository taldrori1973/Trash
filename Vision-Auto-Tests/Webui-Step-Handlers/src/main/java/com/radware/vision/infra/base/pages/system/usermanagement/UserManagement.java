package com.radware.vision.infra.base.pages.system.usermanagement;

import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.system.usermanagement.cliaccesslist.CliAccessList;
import com.radware.vision.infra.base.pages.system.usermanagement.localusers.LocalUsers;
import com.radware.vision.infra.base.pages.system.usermanagement.userstatistics.UsersStatistics;

public class UserManagement extends WebUIVisionBasePage {

//	public BasicParameters userBasicParametersMenu() {
//		return (BasicParameters)new BasicParameters().openPage();
//	}

    public LocalUsers userLocalUsersMenu() {
        return (LocalUsers) new LocalUsers().openPage();
    }

    public Roles userRolesMenu() {
        return (Roles) new Roles().openPage();
    }

    public UsersStatistics userStatisticsMenu() {
        return (UsersStatistics) new UsersStatistics().openPage();
    }

    public UserSettings userSettingsMenu() {
        return (UserSettings) new UserSettings().openPage();
    }

    public CliAccessList cliAccessListMenu() {
        return (CliAccessList) new CliAccessList().openPage();
    }
}
