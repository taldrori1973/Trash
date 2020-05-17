package com.radware.vision.systemManagement.licenseManagement;

import com.radware.vision.base.TestBase;
import com.radware.vision.utils.ReflectionUtils;

/**
 * Created by ashrafa on 7/4/2017.
 * Copied to this Project and modified by MohamadI on 30/03/2020
 */
public class LicenseGenerator {
    private static String MAC_ADDRESS = TestBase.getVisionConfigurations().getManagementInfo().getMacAddress();

    public static String generateVisionActivationLicenseKey(String macAddress) throws Exception {
        String licenseKey;
        String licensePrefix = VisionLicenses.ACTIVATION.getLicensePrefixPattern();
        licenseKey = licensePrefix + "-" + ReflectionUtils.invokePrivateMethod("generateLicenseString", macAddress, licensePrefix);
        return licenseKey;
    }


    public static String generateLicense(String licenseKeyPrefix) throws Exception {
        return generateLicense(MAC_ADDRESS, licenseKeyPrefix);
    }

    public static String generateLicense(String macAddress, String licenseKeyPrefix) throws Exception {
        return null;
    }

}
