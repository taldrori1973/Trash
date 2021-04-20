package com.radware.vision.bddtests.visionsettings.system.generalSettings;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.testhandlers.system.generalsettings.licensemanagement.LicenseManagementHandler;
import com.radware.vision.infra.testresthandlers.visionLicense.AttackCapacityLicenseTestHandler;
import com.radware.vision.infra.testresthandlers.visionLicense.VisionLicenseTestHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.json.simple.parser.ParseException;

import java.io.IOException;
import java.util.*;

public class LicenseManagementSteps extends VisionUITestBase {
    public LicenseManagementSteps() throws Exception {
    }

    /**
     * vision-RTU96  --> To Add Manage More Devices
     * vision-perfreporter --> AVR license
     * vision-security-reporter --> DPM License
     * vision-reporting-module-AMS  --> AMS License
     *
     * @param licensePrefix
     */
    @When("^UI Generate And Add License \"([^\"]*)\"$")
    public void uiGenerateAndAddLicense(String licensePrefix) {

        LicenseManagementHandler.generateAndAddLicense(licensePrefix);

    }


    @Then("^UI License Of Type \"([^\"]*)\" Exists In The Table$")
    public void uiLicenseOfTypeExistsInTheTable(String licensePrefix) {
        if (!LicenseManagementHandler.checkIfLicenseExistsInTheTable(licensePrefix))
            ReportsUtils.reportAndTakeScreenShot("License Does Not Exist", Reporter.FAIL);
    }

    @Then("^Validate License \"([^\"]*)\" Parameters$")
    public void validateLicenseParameters(VisionLicenseTestHandler.SupportedLicenseTypes licenseType, Map<String, String> attributes) throws Throwable {
        VisionLicenseTestHandler visionLicenseTestHandler = VisionLicenseTestHandler.createInstanceByType(licenseType);

        List<String> errors = new ArrayList<>();

        for (String key : attributes.keySet()) {
            String actual = visionLicenseTestHandler.getValue(key) == null ? "null" : visionLicenseTestHandler.getValue(key);
            String expected = attributes.get(key);
            if (actual == null)
                errors.add(key + " value not exist, returns null");

            else if (actual.startsWith("[") && actual.endsWith("]")) {//array
                if (!(expected.startsWith("[") && expected.endsWith("]"))) {
                    errors.add(String.format("%s actual value is an array , please provide expected value as the following format \"[]\", for example [1,2,3]", key));
                    continue;
                }
                actual = actual.replaceAll("\\s+", "");
                expected = expected.replaceAll("\\s+", "");
                if (!validateArrays(actual, expected)) {
                    errors.add(String.format("%s actual value not equals to expected value\n\tExpected Value: %s\n\tActual Value: %s", key, expected, actual));

                }
            } else if (!expected.equals(actual))
                errors.add(String.format("%s actual value not equals to expected value\n\tExpected Value: %s\n\tActual Value: %s", key, expected, actual));
        }

        if (!errors.isEmpty())
            BaseTestUtils.report("Test Failed with the following errors:\n" + String.join("\n", errors), Reporter.FAIL);

    }

    /**
     * @param actual   String as Array
     * @param expected String as Array
     * @return return true if the two arrays have the same values
     */
    private boolean validateArrays(String actual, String expected) {
        actual = actual.replaceAll("\\[|\\]", "");
        expected = expected.replaceAll("\\[|\\]", "");
        List<String> actualSet = Arrays.asList(actual.trim().split(","));
        List<String> expectedSet = Arrays.asList(expected.trim().split(","));
        Collections.sort(actualSet);
        Collections.sort(expectedSet);
        return actualSet.equals(expectedSet);
    }


    /**
     * Need Vision Restart
     *
     * @param daysToBack
     * @throws Throwable
     */
    @Then("^Set Server Last Upgrade Time to (\\d+) Days Back From Now$")
    public void setServerLastUpgradeTimeToNumberDaysBackFromNow(long daysToBack) throws Throwable {
        AttackCapacityLicenseTestHandler.update_last_server_upgrade_time(daysToBack);
    }

    /**
     * Need Vision Restart
     *
     * @param status
     */
    @Then("^Set AVA_Grace_Period_Status to (Not Set|In Grace Period|No Grace Period)$")
    public void setAVA_Grace_Period_StatusTo(String status) throws Exception {
        AttackCapacityLicenseTestHandler.GracePeriodState state;
        switch (status) {
            case "Not Set":
                state = AttackCapacityLicenseTestHandler.GracePeriodState.NOT_SET;
                break;
            case "In Grace Period":
                state = AttackCapacityLicenseTestHandler.GracePeriodState.IN_GRACE;
                break;
            case "No Grace Period":
                state = AttackCapacityLicenseTestHandler.GracePeriodState.NO_GRACE;
                break;
            default:
                state = AttackCapacityLicenseTestHandler.GracePeriodState.NOT_SET;

        }

        AttackCapacityLicenseTestHandler.update_grace_period_state_at_db(state);
    }

    @Then("^Validate DefenseFlow is( NOT)? Licensed by Attack Capacity License$")
    public void validateDefenseFlowIsLicensed(String isNotLicensed) throws IOException, ParseException, NoSuchFieldException {
        boolean expected = isNotLicensed == null;
        AttackCapacityLicenseTestHandler visionLicense = new AttackCapacityLicenseTestHandler();
        if (visionLicense.isDefenseFlowLicensed() != expected) {
            if (visionLicense.isDefenseFlowLicensed())
                BaseTestUtils.report(String.format("The DefenseFlow is Licensed by Attack Capacity License , but expected to be not licensed "), Reporter.FAIL);
            else
                BaseTestUtils.report(String.format("The DefenseFlow is NOT Licensed by Attack Capacity License , but expected to be licensed "), Reporter.FAIL);
        }
    }
}
