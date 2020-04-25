package com.radware.vision.infra.testhandlers.system.generalsettings.licensemanagement;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.base.pages.system.generalsettings.licensemanagement.LicenseManagement;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.GeneralUtils;

import static testhandlers.vision.system.generalSettings.LicenseManagementHandler.generateLicense;

public class LicenseManagementHandler {


    public static void generateAndAddLicense(String licensePrefix) {
        String license = "";
        //generate the license
        try {
            license = generateLicense(BaseHandler.restTestBase.getRadwareServerCli(), licensePrefix);
        } catch (Exception e) {
            BaseTestUtils.report("Could Not Generate License .  Cause : " + e.getMessage(), Reporter.FAIL);
            return;
        }
        //Add the license
        LicenseManagement lisLicenseManagement = new LicenseManagement();
        lisLicenseManagement.getLicenseManagementTable().addRow();
        lisLicenseManagement.getContainer().getTextField("License String").type(license);
        GeneralUtils.submitAndWait(15);
    }


    public static boolean checkIfLicenseExistsInTheTable(String licensePrefix) {
        LicenseManagement lisLicenseManagement = new LicenseManagement();
        return lisLicenseManagement.getLicenseManagementTable().findRowByKeyValue("License String", licensePrefix, true) == -1 ? false : true;
    }
}
