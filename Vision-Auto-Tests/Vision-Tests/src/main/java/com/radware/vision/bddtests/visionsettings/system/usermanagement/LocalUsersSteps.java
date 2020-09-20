package com.radware.vision.bddtests.visionsettings.system.usermanagement;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.base.pages.system.usermanagement.localusers.PermissionEntry;
import com.radware.vision.infra.base.pages.system.usermanagement.localusers.UserEntry;
import com.radware.vision.infra.testhandlers.rbac.RBACHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.testhandlers.rbac.enums.EnableDisableEnum;
import com.radware.vision.infra.testhandlers.rbac.enums.UserRoles;
import com.radware.vision.infra.testhandlers.system.usermanagement.localusers.LocalUsersHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

public class LocalUsersSteps {

    /**
     * creates new user
     *
     * @param userName
     * @param role
     * @param scope
     * @throws Throwable
     */
    @When("^UI Create New User With User Name \"([^\"]*)\" ,Role \"([^\"]*)\" ,Scope \"([^\"]*)\" ,Password \"([^\"]*)\"$")
    public void createNewUser(String userName, String role, String scope, String pass) throws Throwable {

        if (scope.equals("[ALL]")) {
            scope = "";
        }
        String roleAndScope = role + "," + scope;
        LocalUsersHandler.addUser(userName, "", "", "", "", roleAndScope, "", pass);
    }

    @When("^UI Delete User With User Name \"([^\"]*)\"$")
    public void deleteUser(String userName) {

        LocalUsersHandler.deleteUser(userName);
    }

    /**
     * Check if the use exists in the table
     *
     * @param userName
     * @param role
     * @param scope
     * @throws Throwable
     */

    @Then("^UI User With User Name \"([^\"]*)\" ,Role \"([^\"]*)\" ,Scope \"([^\"]*)\" Exists$")
    public void userExists(String userName, String role, String scope) throws Throwable {
        if (!LocalUsersHandler.isUserExists(new UserEntry(userName, new PermissionEntry(role, scope)), null)) {
            ReportsUtils.reportAndTakeScreenShot("The User " + userName + " Does not Exist", Reporter.FAIL);
        }
    }

    /**
     * @param enabledOrDisabled "enabled" or "disabled"
     * @param role              the role value , Example ""
     */

    @Given("^Scope Is \"([^\"]*)\" For Role \"([^\"]*)\"$")
    public void scopeIsForRole(String enabledOrDisabled, String role) {

        if (enabledOrDisabled.equalsIgnoreCase(EnableDisableEnum.ENABLED.toString())) {
            RBACHandlerBase.expectedResultRBAC = true;
        } else {
            RBACHandlerBase.expectedResultRBAC = false;
        }

        if (!RBACHandler.verifyRoleScope(UserRoles.getEnumValue(role))) {

            ReportsUtils.reportAndTakeScreenShot("Scope Is Not " + enabledOrDisabled, Reporter.FAIL);
        }

    }

}
