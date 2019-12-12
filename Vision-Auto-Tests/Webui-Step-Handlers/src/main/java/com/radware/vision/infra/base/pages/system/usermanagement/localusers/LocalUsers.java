package com.radware.vision.infra.base.pages.system.usermanagement.localusers;

import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.table.WebUICell;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.List;

public class LocalUsers extends WebUIVisionBasePage {

    String usersTableLabel = "Local Users";

    public LocalUsers() {
        super("Local Users", "UserManagement.Users.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getUserMgmtLocalUsers());
    }

    public User editUser(String columnName, String columnValue) {
        WebUITable table = (WebUITable) container.getTable(usersTableLabel);
        table.setWaitForTableToLoad(false);
        table.analyzeTable("span");
        table = reOrderHeaders(table);

        table.editRow(table.getRowIndex(columnName, columnValue));
        return new User(container);
    }

    private WebUITable reOrderHeaders(WebUITable table) {
        List<String> tableHeadersOrdered = new ArrayList<String>();
        tableHeadersOrdered = orderHeaders(table);
        table.setTableHeaders(tableHeadersOrdered);
        return table;

    }

    private List<String> orderHeaders(WebUITable usersTable) {
        List<String> tableHeaders = usersTable.getTableHeaders();
        int headersSize = tableHeaders.size();

        List<String> tableHeadersOrdered = new ArrayList<String>(headersSize);
        for (int i = 0; i < headersSize; i++) {
            tableHeadersOrdered.add(String.valueOf(i));
        }
        for (int i = 0; i < headersSize; i++) {
            tableHeadersOrdered.set(getHeadersOrderedPos(headersSize, i), tableHeaders.get(i));
        }
        return tableHeadersOrdered;
    }

    private int getHeadersOrderedPos(int headersSize, int index) {
        int secondLinePos = headersSize / 2 + 1;
        if (index < secondLinePos) {
            return index + secondLinePos - 2;
        } else {
            return index - secondLinePos;
        }
    }

    public User newUser() {
        WebUITable usersTable = (WebUITable) container.getTable(usersTableLabel);
        usersTable.waitForLoadingLabel();
        usersTable.addRow();
        return new User(container);
    }

    public WebUITable getLocalUsersTable() {
        WebUITable table = (WebUITable) container.getTable(usersTableLabel);
        return table;
    }

    public void deleteUser(String columnName, String columnValue) {
        WebUITable table = (WebUITable) container.getTable(usersTableLabel);

        table.analyzeTable("span");
        table = reOrderHeaders(table);
        table.deleteRowByKeyValue(columnName, columnValue);
    }

    public void selectUser(String columnName, String columnValue) {
        WebUITable table = (WebUITable) container.getTable(usersTableLabel);
        table.setWaitForTableToLoad(false);
        table.analyzeTable("span");

        table = reOrderHeaders(table);
        table.clickRowByKeyValue(columnName, columnValue);
    }

    public void enableUserClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getUserEnableButton());
        (new WebUIComponent(locator)).click();
    }

    public void revokeUserClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getUserRevokeButton());
        (new WebUIComponent(locator)).click();
    }

    public void unlockUserClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getUserUnlockButton());
        (new WebUIComponent(locator)).click();
    }

    public void resetUserPwdClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getUserResetPwdButton());
        (new WebUIComponent(locator)).click();
    }

    public List<UserEntry> getLocalUsers() {
        WebUITable localUsersTable = (WebUITable) container.getTable("Local Users");
        localUsersTable.setWaitForTableToLoad(false);
        localUsersTable.analyzeTable("span");

        localUsersTable = reOrderHeaders(localUsersTable);
        List<UserEntry> localUsersList = new ArrayList<UserEntry>();
        int rowCount = localUsersTable.getRowsNumber();
        for (int i = 0; i < rowCount; i++) {
            try {
                WebUICell userNameCell = (WebUICell) localUsersTable.cell(i, 0);
                WebUICell scopeCell = (WebUICell) localUsersTable.cell(i, 3);
                WebUICell roleCell = (WebUICell) localUsersTable.cell(i, 4);
                UserEntry userEntry =
                        new UserEntry(userNameCell.getInnerText(), new PermissionEntry(roleCell.getInnerText(), scopeCell.getInnerText()));

                localUsersList.add(userEntry);
            } catch (Exception e) {
                throw new IllegalStateException("Failed to add table columns - " + e.getMessage() + "\n" + e.getCause(), e);
            }
        }
        return localUsersList;
    }

}
