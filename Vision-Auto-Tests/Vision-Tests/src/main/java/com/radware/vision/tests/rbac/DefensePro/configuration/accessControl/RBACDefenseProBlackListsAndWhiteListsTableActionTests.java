package com.radware.vision.tests.rbac.DefensePro.configuration.accessControl;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.accessControl.RBACDefenseProBlackListsAndWhiteListsTableActionHandler;
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
public class RBACDefenseProBlackListsAndWhiteListsTableActionTests extends RBACTestBase {

    BaseTableActions whiteListTableAction = BaseTableActions.NEW;
    BaseTableActions blackListTableAction = BaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify WhiteList Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "whiteListTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyWhiteListDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("whiteListTableAction", whiteListTableAction.getTableAction().toString());

            if (!(RBACDefenseProBlackListsAndWhiteListsTableActionHandler.verifyWhiteListTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + whiteListTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify WhiteList Disabled Table Action failed: " + whiteListTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify BlackList Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "blackListTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyBlackListDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("blackListTableAction", blackListTableAction.getTableAction().toString());

            if (!(RBACDefenseProBlackListsAndWhiteListsTableActionHandler.verifyBlackListTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + blackListTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify BlackList Disabled Table Action failed: " + blackListTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }



    public BaseTableActions getWhiteListTableAction() {
        return whiteListTableAction;
    }

    public void setWhiteListTableAction(BaseTableActions whiteListTableAction) {
        this.whiteListTableAction = whiteListTableAction;
    }

    public BaseTableActions getBlackListTableAction() {
        return blackListTableAction;
    }

    public void setBlackListTableAction(BaseTableActions blackListTableAction) {
        this.blackListTableAction = blackListTableAction;
    }

}
