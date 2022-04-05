package com.radware.vision.automation.systemManagement.licenseManagement;

import java.util.regex.Pattern;

public enum VisionLicenses {
    ACTIVATION("activation", "vision-activation"),
    APM_REPORTER_SERVER("APM-reporter-server", "vision-APM-reporter-server"),
    AVA_APPWALL("AVA-AppWall", "vision-AVA-AppWall"),
    ATTACK_CAPACITY("AVA-attack-capacity", "vision-AVA-(\\d+)-Gbps-attack-capacity"),
    MAX_ATTACK_CAPACITY("AVA-Max-attack-capacity", "vision-AVA-Max-attack-capacity"),
    DEMO("demo", "vision-demo"),
    EVAL("eval", "vision-eval"),
    GEL_VIRTUAL_ADC("GEL", "vision-GEL"),
    DATABASE_ACCESS("none", "vision-database-access"),
    PERFREPORTER("perfreporter", "vision-perfreporter"),
    VRM_AMS("reporting-module-AMS", "vision-reporting-module-AMS"),
    VRM_ADC("reporting-module-ADC", "vision-reporting-module-ADC"),
    RTU("RTU", "vision-RTU(\\d+))"),
    RTUVA("RTUVA", "vision-RTU(\\d+)VA"),
    RTUMAX("RTUMAX", "vision-RTUMAX"),
    SECURITY_REPORTER("security-reporter", "vision-security-reporter");


    private String licenseFeatureName;
    private String licensePrefixPattern;

    private VisionLicenses(String licenseFeatureName, String licensePrefixPattern) {
        this.licenseFeatureName = licenseFeatureName;
        this.licensePrefixPattern = licensePrefixPattern;
    }

    public String getLicenseFeatureName() {
        return licenseFeatureName;
    }

    public String getLicensePrefixPattern() {
        return licensePrefixPattern;
    }

    public static String getFeatureName(String licensePrefix) {
        switch (licensePrefix) {
            case "vision-activation":
                return ACTIVATION.getLicenseFeatureName();
            case "vision-APM-reporter-server":
                return APM_REPORTER_SERVER.getLicenseFeatureName();
            case "vision-AVA-AppWall":
                return AVA_APPWALL.getLicenseFeatureName();
            case "vision-AVA-Max-attack-capacity":
                return MAX_ATTACK_CAPACITY.getLicenseFeatureName();
            case "vision-demo":
                return DEMO.getLicenseFeatureName();
            case "vision-eval":
                return EVAL.getLicenseFeatureName();
            case "vision-GEL":
                return GEL_VIRTUAL_ADC.getLicenseFeatureName();
            case "vision-database-access":
                return DATABASE_ACCESS.getLicenseFeatureName();
            case "vision-perfreporter":
                return PERFREPORTER.getLicenseFeatureName();
            case "vision-reporting-module-AMS":
                return VRM_AMS.getLicenseFeatureName();
            case "vision-reporting-module-ADC":
                return VRM_ADC.getLicenseFeatureName();
            case "vision-RTUMAX":
                return RTUMAX.getLicenseFeatureName();
            case "vision-security-reporter":
                return SECURITY_REPORTER.getLicenseFeatureName();
            default:
                Pattern avaAttackCapacityPattern = Pattern.compile("vision-AVA-(\\d+)-Gbps-attack-capacity");
                if (avaAttackCapacityPattern.matcher(licensePrefix).matches())
                    return ATTACK_CAPACITY.getLicenseFeatureName();

                Pattern rtuPattern = Pattern.compile("vision-RTU(\\d+)");
                if (rtuPattern.matcher(licensePrefix).matches()) return RTU.getLicenseFeatureName();

                Pattern rtuVaPattern = Pattern.compile("vision-RTU(\\d+)VA");
                if (rtuVaPattern.matcher(licensePrefix).matches()) return RTUVA.getLicenseFeatureName();
        }

        return null;
    }
}
