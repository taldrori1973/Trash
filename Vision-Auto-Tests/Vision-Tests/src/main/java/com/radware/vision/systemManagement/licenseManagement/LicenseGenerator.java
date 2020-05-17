package com.radware.vision.systemManagement.licenseManagement;

import com.radware.vision.base.TestBase;
import com.radware.vision.utils.ReflectionUtils;

/**
 * Created by ashrafa on 7/4/2017.
 * Copied to this Project and modified by MohamadI on 30/03/2020
 */
public class LicenseGenerator {
    private static String MAC_ADDRESS = TestBase.getVisionConfigurations().getManagementInfo().getMacAddress();

    /**
     *
     * @return Vision Activation License Key by the default MAC Address from TestBase.getVisionConfigurations().getManagementInfo().getMacAddress()
     */
    public static String generateVisionActivationLicenseKey(){
        return generateVisionActivationLicenseKey(MAC_ADDRESS);
    }
    /**
     *
     * @param macAddress    Vision Mac Address
     * @return              Vision Activation License Key
     * @throws Exception
     */
    public static String generateVisionActivationLicenseKey(String macAddress) {

        return generateLicense(macAddress,VisionLicenses.ACTIVATION.getLicensePrefixPattern());
    }


    /**
     *
     * @param licenseKeyPrefix could be one of two formats:
     *                         time based license : vision-AVA-6-Gbps-attack-capacity-03sep2019-29oct2020-wH8KbYLL
     *                         when the vision-AVA-6-Gbps-attack-capacity you can get from {@link VisionLicenses}
     * @return      licenseKeyPrefix License Key by the default MAC Address from TestBase.getVisionConfigurations().getManagementInfo().getMacAddress()
     */
    public static String generateLicense(String licenseKeyPrefix)  {
        return generateLicense(MAC_ADDRESS, licenseKeyPrefix);
    }

    public static String generateLicense(String macAddress, String licenseKeyPrefix)  {
        String licenseKey;
        licenseKey = licenseKeyPrefix + "-" + ReflectionUtils.invokePrivateMethod("generateLicenseString", macAddress, licenseKeyPrefix);
        return licenseKey;
    }

}
