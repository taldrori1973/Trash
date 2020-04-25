package com.radware.vision.infra.testhandlers.system.usermanagement.userstatistics;

import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.system.usermanagement.UserManagement;
import com.radware.vision.infra.base.pages.system.usermanagement.userstatistics.ConnectedUserEntry;
import com.radware.vision.infra.base.pages.system.usermanagement.userstatistics.UserStatisticsEntry;
import com.radware.vision.infra.base.pages.system.usermanagement.userstatistics.UsersStatistics;

import java.util.Date;
import java.util.List;

public class UsersStatisticsHandler {
	
	public static List<ConnectedUserEntry> getLoggedInUsers() {
		VisionServerMenuPane menuPane = new VisionServerMenuPane();
		UserManagement userManagement = menuPane.openSystemUserManagement();
		com.radware.vision.infra.base.pages.system.usermanagement.userstatistics.UsersStatistics usersStatisticsPage = userManagement.userStatisticsMenu();
		return usersStatisticsPage.getConnectedUsersList();
	}
	
	public static List<UserStatisticsEntry> getExistingUsersStatistics() {
		VisionServerMenuPane menuPane = new VisionServerMenuPane();
		UserManagement userManagement = menuPane.openSystemUserManagement();
		com.radware.vision.infra.base.pages.system.usermanagement.userstatistics.UsersStatistics usersStatisticsPage = userManagement.userStatisticsMenu();
		return usersStatisticsPage.getUserStatisticsList();
	}
	
	public static void filterUserStatistics(String userName, String statisticsDate, Integer numSuccessfulLogins, Integer numFailedLogins, Integer numPasswordChanges, Integer numLockOuts, Date loginDateAndTime) {
		VisionServerMenuPane menuPane = new VisionServerMenuPane();
		UserManagement userManagement = menuPane.openSystemUserManagement();
		com.radware.vision.infra.base.pages.system.usermanagement.userstatistics.UsersStatistics usersStatisticsPage = userManagement.userStatisticsMenu();
		setFilterFieldsAll(userName, statisticsDate, numSuccessfulLogins, numFailedLogins, numPasswordChanges, numLockOuts, loginDateAndTime);
		UsersStatistics.filterApply();
	}
	public static void setFilterFieldsAll(String userName, String statisticsDate, Integer numSuccessfulLogins, Integer numFailedLogins, Integer numPasswordChanges, Integer numLockOuts, Date loginDateAndTime){
		UsersStatistics.setUserNameSerch(userName);
		UsersStatistics.setStatisticsDate(statisticsDate);
		UsersStatistics.setNumSuccessfulLoginsSerch(String.valueOf(numSuccessfulLogins));
		UsersStatistics.setNumFailedLoginsSerch(String.valueOf(numFailedLogins));
		UsersStatistics.setNumPasswordChangesSerch(String.valueOf(numPasswordChanges));
		UsersStatistics.setNumLockOutsSerch(String.valueOf(numLockOuts));
		UsersStatistics.setLoginDateAndTimeSerch(loginDateAndTime.toString());
	}
}
