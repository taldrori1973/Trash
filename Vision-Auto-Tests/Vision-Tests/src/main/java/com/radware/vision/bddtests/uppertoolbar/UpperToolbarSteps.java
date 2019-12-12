package com.radware.vision.bddtests.uppertoolbar;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.base.pages.navigation.WebUIUpperBar;
import com.radware.vision.infra.enums.UpperBarItems;
import com.radware.vision.infra.testhandlers.rbac.RBACHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;

public class UpperToolbarSteps {

    /**
     * checks if upper bar item exist or not
     *
     * @param item       UpperBarItems.name
     * @param existOrNot true means exists , false means does not exist
     */

    @Given("^Upper Bar Item : \"([^\"]*)\", Visible : \"([^\"]*)\"$")
    public void upperBarItemVisible(String item, String existOrNot) {

        RBACHandlerBase.expectedResultRBAC = Boolean.valueOf(existOrNot);
        if (!RBACHandler.IsUpperBarItemExist(UpperBarItems.getEnumValue(item))) {
            if (RBACHandlerBase.expectedResultRBAC) {
                ReportsUtils.reportAndTakeScreenShot("Upper Bar Item -->" + item + " Does Not Exists", Reporter.FAIL);
            } else {

                ReportsUtils.reportAndTakeScreenShot("Upper Bar Item -->" + item + " Does Exists", Reporter.FAIL);
            }
        }
    }

    /**
     * @param item : UpperBarItems.name
     */
    @When("^UI Open Upper Bar Item \"([^\"]*)\"(?: (negative))?$")
    public void uiOpenUpperBarItem(String item, String negative) {
        try {
            if (negative != null) {
                WebUIUpperBar.select(UpperBarItems.getEnumValue(item), true);
            } else {
                Thread.sleep(8000);//to have time to render the page
                WebUIUpperBar.select(UpperBarItems.getEnumValue(item));
            }

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

}
