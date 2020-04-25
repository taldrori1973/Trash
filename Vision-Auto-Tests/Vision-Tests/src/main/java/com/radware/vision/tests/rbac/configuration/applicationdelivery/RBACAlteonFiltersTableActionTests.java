package com.radware.vision.tests.rbac.configuration.applicationdelivery;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery.RBACAlteonFiltersTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
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
public class RBACAlteonFiltersTableActionTests extends RBACTestBase {

    BaseTableActions patternMatchingGroupTableAction = BaseTableActions.NEW;
    BaseTableActions filtersTableAction = BaseTableActions.NEW;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify Filters  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "filtersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyFiltersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("filtersTableAction", filtersTableAction.getTableAction().toString());

            if (!(RBACAlteonFiltersTableActionHandler.verifyFiltersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + filtersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Filters Disabled Table Action failed: " + filtersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify PatternMatchingGroup  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "patternMatchingGroupTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPatternMatchingGroupDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("patternMatchingGroupTableAction", patternMatchingGroupTableAction.getTableAction().toString());

            if (!(RBACAlteonFiltersTableActionHandler.verifyPatternMatchingGroupTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + patternMatchingGroupTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PatternMatchingGroup Disabled Table Action failed: " + patternMatchingGroupTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

    public BaseTableActions getPatternMatchingGroupTableAction() {
        return patternMatchingGroupTableAction;
    }

    public void setPatternMatchingGroupTableAction(BaseTableActions patternMatchingGroupTableAction) {
        this.patternMatchingGroupTableAction = patternMatchingGroupTableAction;
    }

    public BaseTableActions getFiltersTableAction() {
        return filtersTableAction;
    }

    public void setFiltersTableAction(BaseTableActions filtersTableAction) {
        this.filtersTableAction = filtersTableAction;
    }
}
