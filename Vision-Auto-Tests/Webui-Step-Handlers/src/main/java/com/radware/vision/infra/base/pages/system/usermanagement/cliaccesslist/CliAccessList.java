package com.radware.vision.infra.base.pages.system.usermanagement.cliaccesslist;

import com.radware.automation.webui.widgets.api.TextField;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

public class CliAccessList extends WebUIVisionBasePage{
	String userNameLabel =  "User Name";
	String cliAccessListTable = "CLI Access List";
	
	public CliAccessList() {
		super("CLI Access List", "UserManagement.CLIAccess.xml", false);
		setPageLocatorHow(How.ID);
		setPageLocatorContent(WebUIStringsVision.getCliAccessListNode());
	}
	
	public void deleteUser(String columnName, String columnValue) {
		WebUITable usersTable = (WebUITable)container.getTable(cliAccessListTable);
		usersTable.deleteRowByKeyValue(columnName, columnValue);
	}
	
	public void addUser() {
		WebUITable usersTable = (WebUITable)container.getTable(cliAccessListTable);
		usersTable.addRow();
		
	}
    public WebUITable getCLIAccessListTable() {
        WebUITable table = (WebUITable)container.getTable(cliAccessListTable);
        return table;

    }
	public void viewUser(String columnName, String columnValue) {
		WebUITable usersTable = (WebUITable)container.getTable(cliAccessListTable);
		usersTable.viewRowByKeyValue(columnName, columnValue);
		
	}
	public void setUserName(String userName) {
		TextField usernameText = container.getTextField(userNameLabel);
		usernameText.type(userName);
	}
}
