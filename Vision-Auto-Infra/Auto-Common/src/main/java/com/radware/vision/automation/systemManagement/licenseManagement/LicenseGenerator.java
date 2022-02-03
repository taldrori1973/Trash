package com.radware.vision.automation.systemManagement.licenseManagement;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.ReflectionUtils;
import com.radware.vision.automation.base.TestBase;

/**
 * Created by ashrafa on 7/4/2017.
 * Copied to this Project and modified by MohamadI on 30/03/2020
 */
public class LicenseGenerator {
    public static String MAC_ADDRESS ;

    /**
     * @return Vision Activation License Key by the default MAC Address from TestBase.getVisionConfigurations().getManagementInfo().getMacAddress()
     */
    public static String generateVisionActivationLicenseKey() {
        return generateVisionActivationLicenseKey(MAC_ADDRESS);
    }

    /**
     * @param macAddress Vision Mac Address
     * @return Vision Activation License Key
     */
    public static String generateVisionActivationLicenseKey(String macAddress) {

        return generateLicense(macAddress, VisionLicenses.ACTIVATION.getLicensePrefixPattern());
    }


    /**
     * @param licenseKeyPrefix could be one of two formats:
     *                         time based license : vision-AVA-6-Gbps-attack-capacity-03sep2019-29oct2020
     *                              when the vision-AVA-6-Gbps-attack-capacity you can get from {@link VisionLicenses} and the from to dates are added with the format above.
     *                         <p>
     *                         Or
     *                         <p>
     *                         not time based license :vision-AVA-400-Gbps-attack-capacity
     *                              when the vision-AVA-6-Gbps-attack-capacity you can get from {@link VisionLicenses} without the from to dates.
     * @return licenseKeyPrefix License Key by the default MAC Address from TestBase.getVisionConfigurations().getManagementInfo().getMacAddress()
     */
    public static String generateLicense(String licenseKeyPrefix) {
        String license = null;
        try {
            if(MAC_ADDRESS == null)
                TestBase.setManagementInfo();

            license = generateLicense(MAC_ADDRESS, licenseKeyPrefix);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        return license;
    }
    /**
     *
     * @param macAddress        Vision Mac Address
     * @param licenseKeyPrefix  could be one of two formats:
     *      *                         time based license : vision-AVA-6-Gbps-attack-capacity-03sep2019-29oct2020
     *      *                              when the vision-AVA-6-Gbps-attack-capacity you can get from {@link VisionLicenses} and the from to dates are added with the format above.
     *      *                         <p>
     *      *                         Or
     *      *                         <p>
     *      *                         not time based license :vision-AVA-400-Gbps-attack-capacity
     *      *                              when the vision-AVA-6-Gbps-attack-capacity you can get from {@link VisionLicenses} without the from to dates.
     * @return                  licenseKeyPrefix License Key
     */
    public static String generateLicense(String macAddress, String licenseKeyPrefix) {
        String licenseKey;
        licenseKey = licenseKeyPrefix + "-" + ReflectionUtils.invokePrivateMethod("generateLicenseString", macAddress, licenseKeyPrefix);
        return licenseKey;
    }

}
