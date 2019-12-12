package com.radware.vision.infra.base.pages.system.usermanagement.userstatistics;

import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.automation.webui.widgets.impl.table.WebUICell;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.List;

public class UsersStatistics extends WebUIVisionBasePage {
	
	final String connectedUsersTableName = "CurrentlyUsers.title";
	final String userStatisticsTableName = "User Statistics";
			
	public UsersStatistics() {
		super("User Statistics", "UserManagement.StatisticsFilter.xml", false);
		setPageLocatorHow(How.ID);
		setPageLocatorContent(WebUIStrings.getUserMgmtUserStatistics());
	}
	public static void setUserNameSerch(String userName){
		ComponentLocator locator = new ComponentLocator(How.ID , WebUIStringsVision.getUserNameSearch());
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement((new WebUIComponent(locator)).getWebElement());
		setTextFieldIfNotEmpty(textField, userName);
		
	}
	public static void setNumLockOutsSerch(String numLockOuts){
		ComponentLocator locator = new ComponentLocator(How.ID , WebUIStringsVision.getNumLockOutsSearch());
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement((new WebUIComponent(locator)).getWebElement());
		setTextFieldIfNotEmpty(textField, numLockOuts);
		
	}
	public static void setStatisticsDate(String statisticsDate){
		ComponentLocator locator = new ComponentLocator(How.ID , WebUIStringsVision.getStatisticsDateSearch());
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement((new WebUIComponent(locator)).getWebElement());
		setTextFieldIfNotEmpty(textField, statisticsDate);
		
	}
	public static void setNumSuccessfulLoginsSerch(String numSuccessfulLogins){
		ComponentLocator locator = new ComponentLocator(How.ID , WebUIStringsVision.getNumSuccessfulLoginsSearch());
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement((new WebUIComponent(locator)).getWebElement());
		setTextFieldIfNotEmpty(textField, numSuccessfulLogins);
		
	}
	public static void setNumFailedLoginsSerch(String numFailedLogins){
		ComponentLocator locator = new ComponentLocator(How.ID , WebUIStringsVision.getNumFailedLoginsSearch());
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement((new WebUIComponent(locator)).getWebElement());
		setTextFieldIfNotEmpty(textField, numFailedLogins);
		
	}
	public static void setNumPasswordChangesSerch(String numPasswordChanges){
		ComponentLocator locator = new ComponentLocator(How.ID , WebUIStringsVision.getNumPasswordChangesSearch());
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement((new WebUIComponent(locator)).getWebElement());
		setTextFieldIfNotEmpty(textField, numPasswordChanges);
		
	}
	public static void setLoginDateAndTimeSerch(String loginDateAndTime){
		ComponentLocator locator = new ComponentLocator(How.ID , WebUIStringsVision.getLoginDateAndTimeSearch());
        WebUITextField textField = new WebUITextField(locator);
        textField.setWebElement((new WebUIComponent(locator)).getWebElement());
		setTextFieldIfNotEmpty(textField, loginDateAndTime);
		
	}
	public static void filterApply(){
		ComponentLocator locator = new ComponentLocator(How.ID , WebUIStringsVision.getFilterApplyButton());
		WebUIComponent loginButton = new WebUIComponent(locator);
		loginButton.click();
	}
	
	
	
	public List<ConnectedUserEntry> getConnectedUsersList() {
		WebUITable usersTable = (WebUITable) container.getTable(connectedUsersTableName);
		usersTable.analyzeTable("span");
		List<ConnectedUserEntry> connectedUsers = new ArrayList<ConnectedUserEntry>();
		int rowCount = usersTable.getRowsNumber();
		for (int i = 0; i < rowCount; i++) {
			try {
				WebUICell userNameCell = (WebUICell)usersTable.cell(i, 0);
				WebUICell userFullNameCell = (WebUICell)usersTable.cell(i, 1);
				WebUICell LoginDateAndTimeCell = (WebUICell)usersTable.cell(i, 2);
				ConnectedUserEntry connectedUser = new ConnectedUserEntry(userNameCell.value(), userFullNameCell.value(), LoginDateAndTimeCell.value());
				connectedUsers.add(connectedUser);
			} catch (Exception e) {
				// Ignore - Skip current cell's value.
			}
		}
		return connectedUsers;
	}
	
	public List<UserStatisticsEntry> getUserStatisticsList() {
		WebUITable userStatisticsTable = (WebUITable) container.getTable(userStatisticsTableName);
		userStatisticsTable.analyzeTable("span");
		List<UserStatisticsEntry> userStatisticsList = new ArrayList<UserStatisticsEntry>();
		int rowCount = userStatisticsTable.getRowsNumber();
		for (int i = 0; i < rowCount; i++) {
			try {
				WebUICell userNameCell = (WebUICell)userStatisticsTable.cell(i, 0);
				WebUICell dateCell = (WebUICell)userStatisticsTable.cell(i, 1);
				WebUICell numberOfSuccessfulLoginsCell = (WebUICell)userStatisticsTable.cell(i, 2);
				WebUICell numberOfFailedLoginAttemptsCell = (WebUICell)userStatisticsTable.cell(i, 3);
				WebUICell numberOfPasswordChangesCell = (WebUICell)userStatisticsTable.cell(i, 4);
				WebUICell NumberOfLockOutsCell = (WebUICell)userStatisticsTable.cell(i, 5);
				UserStatisticsEntry userStatisticsEntry = 
						new UserStatisticsEntry(userNameCell.value(), 
								dateCell.value(), 
								numberOfSuccessfulLoginsCell.value(), 
								numberOfFailedLoginAttemptsCell.value(), 
								numberOfPasswordChangesCell.value(), 
								NumberOfLockOutsCell.value());
				userStatisticsList.add(userStatisticsEntry);
			} catch (Exception e) {
				// Ignore - Skip current cell's value.
			}
		}
		return userStatisticsList;
	}
	private static void setTextFieldIfNotEmpty(WebUITextField element, String value){
		if(value != null && !value.isEmpty()){
			element.type(value);
		}
	}
}
