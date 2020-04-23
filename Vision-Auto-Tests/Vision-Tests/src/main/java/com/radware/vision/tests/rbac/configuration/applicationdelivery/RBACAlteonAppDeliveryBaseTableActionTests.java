package com.radware.vision.tests.rbac.configuration.applicationdelivery;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery.RBACAlteonApplicationDeliveryBaseTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.ContentClassesTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonAppDeliveryBaseTableActionTests extends RBACTestBase {

    EditTableActions basePortProcessingTableAction = EditTableActions.EDIT;
    ContentClassesTableActions baseNetworkClassesTableAction = ContentClassesTableActions.NEW;
    ContentClassesTableActions baseDataClassesTableAction = ContentClassesTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify BasePortProcessing  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "basePortProcessingTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyBasePortProcessingDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("basePortProcessingTableAction", basePortProcessingTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationDeliveryBaseTableActionHandler.verifyPortProcessingTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + basePortProcessingTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify BasePortProcessing Disabled Table Action failed: " + basePortProcessingTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify BaseNetworkClasses  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "baseNetworkClassesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyBaseNetworkClassesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("baseNetworkClassesTableAction", baseNetworkClassesTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationDeliveryBaseTableActionHandler.verifyNetworkClassesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + baseNetworkClassesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify BaseNetworkClasses Disabled Table Action failed: " + baseNetworkClassesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify BaseDataClasses  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "baseDataClassesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyBaseDataClassesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("baseDataClassesTableAction", baseDataClassesTableAction.getTableAction().toString());

            if (!(RBACAlteonApplicationDeliveryBaseTableActionHandler.verifyDataClassesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + baseDataClassesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify BaseDataClasses Disabled Table Action failed: " + baseDataClassesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public EditTableActions getBasePortProcessingTableAction() {
        return basePortProcessingTableAction;
    }

    public void setBasePortProcessingTableAction(EditTableActions basePortProcessingTableAction) {
        this.basePortProcessingTableAction = basePortProcessingTableAction;
    }

    public ContentClassesTableActions getBaseNetworkClassesTableAction() {
        return baseNetworkClassesTableAction;
    }

    public void setBaseNetworkClassesTableAction(ContentClassesTableActions baseNetworkClassesTableAction) {
        this.baseNetworkClassesTableAction = baseNetworkClassesTableAction;
    }

    public ContentClassesTableActions getBaseDataClassesTableAction() {
        return baseDataClassesTableAction;
    }

    public void setBaseDataClassesTableAction(ContentClassesTableActions baseDataClassesTableAction) {
        this.baseDataClassesTableAction = baseDataClassesTableAction;
    }

}
