package com.radware.vision.systemManagement.licenseManagement;

import com.radware.vision.utils.ReflectionUtils;
import com.radware.vision.vision_project_cli.RadwareServerCli;

/**
 * Created by ashrafa on 7/4/2017.
 * Copied to this Project and modified by MohamadI on 30/03/2020
 */
public class LicenseGenerator {
    public static String generateVisionActivationLicenseKey(String macAddress) throws Exception {
        String licenseKey;
        String licensePrefix = VisionLicenses.ACTIVATION.getLicensePrefixPattern();
        licenseKey = licensePrefix + "-" + ReflectionUtils.invokePrivateMethod("generateLicenseString", macAddress, licensePrefix);
        return licenseKey;
    }

    public static String generateLicense(RadwareServerCli radwareCli, String licenseKeyPrefix) throws Exception {
    return null;
    }

    }
