package com.radware.vision.tests.rbac.DefensePro.monitoring.networking;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.monitoring.networking.RBACDefenseProSessionTableTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 10/2/2014.
 */
public class RBACDefenseProSessionTableTableActionTests extends RBACTestBase {
    BaseTableActions sessionTableFiltersTableAction = BaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify SessionTableFilters Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "sessionTableFiltersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySessionTableFiltersTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("sessionTableFiltersTableAction", sessionTableFiltersTableAction.getTableAction().toString());

            if (!(RBACDefenseProSessionTableTableActionHandler.verifySessionTableFiltersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + sessionTableFiltersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify SessionTableFilters Disabled Table Action failed: " + sessionTableFiltersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getSessionTableFiltersTableAction() {
        return sessionTableFiltersTableAction;
    }

    public void setSessionTableFiltersTableAction(BaseTableActions sessionTableFiltersTableAction) {
        this.sessionTableFiltersTableAction = sessionTableFiltersTableAction;
    }

}
