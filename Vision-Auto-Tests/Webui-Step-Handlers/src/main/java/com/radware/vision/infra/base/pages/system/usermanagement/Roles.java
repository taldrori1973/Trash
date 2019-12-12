package com.radware.vision.infra.base.pages.system.usermanagement;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.support.How;

import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.automation.webui.widgets.impl.table.WebUICell;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;

public class Roles extends WebUIVisionBasePage {
	
	String VIEW_ITEM_BUTTON = "gwt-debug-Role_VIEW_ONLY";
	
	public Roles() {
		super("Roles", "UserManagement.Roles.xml", false);
		setPageLocatorHow(How.ID);
		setPageLocatorContent(WebUIStrings.getUserMgmtRoles());
	}
		
	public List<String> getRoleNames() {
		WebUITable usersTable = (WebUITable) container.getTables().get(0);
		usersTable.analyzeTable("span");
		List<String> roleNames = new ArrayList<String>();
		int rowCount = usersTable.getRowsNumber();
		for (int i = 0; i < rowCount; i++) {
			try {
				WebUICell currentCell = (WebUICell)usersTable.cell(i, 0);

				String currentCellvalue = currentCell.value();
				roleNames.add(currentCellvalue);
			} catch (Exception e) {
				// Ignore - Skip current cell's value.
			}
		}
		return roleNames;
	}
}
