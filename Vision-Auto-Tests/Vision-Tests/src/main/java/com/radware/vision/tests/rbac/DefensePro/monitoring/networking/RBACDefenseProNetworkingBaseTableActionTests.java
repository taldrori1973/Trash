package com.radware.vision.tests.rbac.DefensePro.monitoring.networking;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.monitoring.networking.RBACDefenseProNetworkingBaseTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.ViewBaseTableActions;
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
public class RBACDefenseProNetworkingBaseTableActionTests extends RBACTestBase {

    ViewBaseTableActions mplsRDTableAction = ViewBaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify MplsRD Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "mplsRDTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyMplsRDTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("mplsRDTableAction", mplsRDTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingBaseTableActionHandler.verifyMplsRDTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + mplsRDTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify MplsRD Disabled Table Action failed: " + mplsRDTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public ViewBaseTableActions getMplsRDTableAction() {
        return mplsRDTableAction;
    }

    public void setMplsRDTableAction(ViewBaseTableActions mplsRDTableAction) {
        this.mplsRDTableAction = mplsRDTableAction;
    }

}