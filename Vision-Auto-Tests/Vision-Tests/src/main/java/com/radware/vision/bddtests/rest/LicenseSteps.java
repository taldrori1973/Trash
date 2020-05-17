package com.radware.vision.bddtests.rest;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.DatabaseStepHandlers.mariaDB.client.JDBCConnectionException;
import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.systemManagement.licenseManagement.LicenseManagement;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class LicenseSteps extends BddRestTestBase {
    /**
     * @param licensePrefix - such as ->
     *                      vision-demo
     *                      vision-RTU96  --> To Add Manage More Devices
     *                      vision-perfreporter --> AVR license
     *                      vision-security-reporter --> DPM License
     *                      vision-reporting-module-AMS  --> AMS License
     */
    @Given("^REST Vision Install License Request \"([^\"]*)\"(?: from date \"([+-]\\d+[dMY])\" to date \"([+-]\\d+[dMY])\")?$")
    public void installLicenses(String licensePrefix, String fromDate, String toDate) {
        try {
            LicenseManagement licenseManagement;
            if (fromDate != null ^ toDate != null)
                BaseTestUtils.report(String.format("from date and to date should be both null or NOT null"), Reporter.FAIL);

            if (fromDate == null)
                licenseManagement = new LicenseManagement(licensePrefix, null, null);

            else {
                Pattern pattern = Pattern.compile("([+-]\\d+)([dMY])");
                Matcher fromMatcher = pattern.matcher(fromDate);
                Matcher toMatcher = pattern.matcher(toDate);
                LocalDate from = null;
                LocalDate to = null;
                if (fromMatcher.find()) {
                    from = LocalDate.now().plus(Long.parseLong(fromMatcher.group(1)), TimeUtils.getChronoUnit(fromMatcher.group(2)));
                }
                if (toMatcher.find()) {
                    to = LocalDate.now().plus(Long.parseLong(toMatcher.group(1)), TimeUtils.getChronoUnit(toMatcher.group(2)));
                }

                licenseManagement = new LicenseManagement(licensePrefix, from, to);

            }
            licenseManagement.install();
        } catch (JDBCConnectionException e) {
            BaseTestUtils.report(
                    String.format("Can't create \"LicenseManagement\" Object due to the following Exception:\n%s\n\n%s", e.getMessage(), Arrays.toString(e.getStackTrace())),
                    Reporter.FAIL
            );
        } catch (Exception e) {
            BaseTestUtils.report(
                    e.getMessage(),
                    Reporter.FAIL
            );
        }
    }

    @When("^REST Vision DELETE License Request \"(.*)\"$")
    public void deleteLicense(String licensePrefix) {
        try {
            LicenseManagement licenseManagement = new LicenseManagement(licensePrefix, null, null);
            licenseManagement.delete();
        } catch (JDBCConnectionException e) {
            BaseTestUtils.report(
                    String.format("Can't create \"LicenseManagement\" Object due to the following Exception:\n%s\n\n%s", e.getMessage(), Arrays.toString(e.getStackTrace())),
                    Reporter.FAIL
            );
        }
    }

    @Then("^REST Vision Install License Request vision-activation with expired date$")
    public void expireActivationLicense() throws Exception {
        String pureActivationLicense = "vision-activation"; // activation license without expired date

        //Generate activation license and add it, after that we delete it
        LicenseManagement pureActivationLicenseManagement = new LicenseManagement(pureActivationLicense, null, null);
        pureActivationLicenseManagement.install();

        LicenseManagement activationLicenseWithDateEntity = new LicenseManagement(pureActivationLicense, LocalDate.now().minusMonths(4), LocalDate.now().minusDays(1));
        try {
            activationLicenseWithDateEntity.install();
        } catch (Exception e) {
            //Validation - failed to login with expired date
            pureActivationLicenseManagement.install();// here we return the license without date
            BaseTestUtils.report("The user can't login with expired activation license", Reporter.PASS);
            return;
        }
        //login with expired date has succeed, so we should throw error message
        pureActivationLicenseManagement.install();// here we return the license without date
        BaseTestUtils.report("The user can login with expired activation license", Reporter.FAIL);
    }

}
