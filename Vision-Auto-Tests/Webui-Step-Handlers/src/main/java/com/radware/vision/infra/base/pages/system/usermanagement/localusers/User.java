package com.radware.vision.infra.base.pages.system.usermanagement.localusers;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.WidgetsContainer;
import com.radware.automation.webui.widgets.api.TextField;
import com.radware.automation.webui.widgets.api.VerticalTab;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDualList;
import com.radware.automation.webui.widgets.impl.WebUIPasswordTextField;
import com.radware.automation.webui.widgets.impl.table.WebUICell;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.List;

public class User extends WebUIVisionBasePage {

    final String usernameLabel = "Name";
    final String fullnameLabel = "Full Name";
    final String tabPermissions = "Permissions";
    final String tabContactinfo = "Contact Info";
    final String contactInfoOrg = "Organization";
    final String contactInfoAddr = "Address";
    final String contactInfoPhone = "Phone Number";
    final String networkPolicies = "Authorized network Policies for Security Monitoring";
    final String tabPassword = "Password";
    final String passwordLabel = "Password";
    final String confirmPasswordID = "gwt-debug-password_DuplicatePasswordField";

    final static String UserRolesScopesTable = "User Roles and Scopes";

    private User() {
        super("Local Users", "UserManagement.Users.xml", false);
    }

    public User(WidgetsContainer addedWidgets) {
        super("Local Users", "UserManagement.Users.xml", false);
        loadPageElements(false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStrings.getUserMgmtLocalUsers());
        setXmlFile("UserManagement.RoleGroupPair.xml");
        loadPageElements(false);
    }

    public void setUsername(String username) {
        TextField usernameText = container.getTextField(usernameLabel);
        usernameText.type(username);
    }

    public void setFullname(String fullname) {
        TextField fullnameText = container.getTextField(fullnameLabel);
        fullnameText.type(fullname);
    }

    public void openTabPermissions() {
        VerticalTab verticalTab = container.getVerticalTab(tabPermissions);
        verticalTab.click();
    }

    public void openTabContactInfo() {
        VerticalTab verticalTab = container.getVerticalTab(tabContactinfo);
        verticalTab.click();
    }

    public void setContactInfoOrg(String organisation) {
        openTabContactInfo();
        TextField contactInfoWidget = container.getTextField(contactInfoOrg);
        contactInfoWidget.type(organisation);
    }

    public void setContactInfoAddress(String address) {
        openTabContactInfo();
        TextField contactInfoWidget = container.getTextField(contactInfoAddr);
        contactInfoWidget.type(address);
    }

    public void setContactInfoPhone(String phone) {
        openTabContactInfo();
        TextField contactInfoWidget = container.getTextField(contactInfoPhone);
        contactInfoWidget.type(phone);
    }

    public void deletePermission(String columnName, String columnValue) {
        WebUITable usersTable = (WebUITable) container.getTable(UserRolesScopesTable);
        usersTable.setWaitForTableToLoad(false);
        usersTable.deleteRowByKeyValue(columnName, columnValue);
    }

    public void editPermission(String columnName, String columnValue, String newRole, String newScope) {
        WebUITable usersTable = (WebUITable) container.getTable(UserRolesScopesTable);
        usersTable.editRowByKeyValue(columnName, columnValue);
        Permission permission = new Permission();
        permission.setRole(newRole);
        permission.setScope(newScope);
        permission.submit();
    }

    public Permission addPermission() {
        WebUITable permissionsTable = (WebUITable) container.getTable(UserRolesScopesTable);
        permissionsTable.setWaitForTableToLoad(false);
        permissionsTable.addRow();
        return new Permission();
    }

    public List<PermissionEntry> getUserPermissions() {
        WebUITable usersTable = (WebUITable) container.getTable(UserRolesScopesTable);
        usersTable.analyzeTable("span");
        List<PermissionEntry> permissionsList = new ArrayList<PermissionEntry>();
        int rowCount = usersTable.getRowsNumber();
        for (int i = 0; i < rowCount; i++) {
            try {
                WebUICell roleCell = (WebUICell) usersTable.cell(i, 0);
                WebUICell scopeCell = (WebUICell) usersTable.cell(i, 1);
                permissionsList.add(new PermissionEntry(roleCell.value(), scopeCell.value()));
            } catch (Exception e) {
                // Ignore - Skip current cell's value.
            }
        }
        return permissionsList;
    }

    public void closeUserTab() {
        try {
            ComponentLocator cancelLocator = new ComponentLocator(How.ID, "gwt-debug-ConfigTab_NEW_User_Close");
            WebUIUtils.fluentWaitDisplayed(cancelLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false).click();
        }
        catch (Exception e) {
//            Ignore
        }
    }

    public void addNetworkPolicies(List<String> networkPolicies) {
        if (networkPolicies == null || networkPolicies.size() == 0)
            return;
        WebUIDualList networkPoliciesDualList = getDualList(this.networkPolicies);
        networkPoliciesDualList.moveRight(networkPolicies, 1);
    }

    public void addPassword (String password) {
        VerticalTab verticalTab = container.getVerticalTab(tabPassword);
        verticalTab.click();
        TextField passwordWidget = container.getTextField(passwordLabel);
        passwordWidget.type(password);

        ComponentLocator locator = new ComponentLocator(How.ID, confirmPasswordID);
        WebUIPasswordTextField confirmPasswordTextField = new WebUIPasswordTextField(locator);
        confirmPasswordTextField.setWebElement((new WebUIComponent(locator)).getWebElement());
        confirmPasswordTextField.fillConfirmationPassword(password);
    }
}
