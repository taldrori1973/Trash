package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 10/23/2014.
 */
public enum UserRoles {
    ADC_ADMINISTRATOR("ADC Administrator"),
    ADC_OPERATOR("ADC Operator"),
    ADC_CERTIFICATE_ADMINISTRATOR("ADC+Certificate Administrator"),
    ADMINISTRATOR("Administrator"),
    CERTIFICATE_ADMINISTRATOR("Certificate Administrator"),
    DEVICE_ADMINISTRATOR("Device Administrator"),
    DEVICE_CONFIGURATOR("Device Configurator"),
    DEVICE_OPERATOR("Device Operator"),
    DEVICE_VIEWER("Device Viewer"),
    SECURITY_ADMINISTRATOR("Security Administrator"),
    SECURITY_MONITOR("Security Monitor"),
    USER_ADMINISTRATOR("User Administrator"),
    VISION_ADMINISTRATOR("Vision Administrator"),
    VISION_REPORTER("Vision Reporter"),
    REAL_SERVER_OPERATOR("Real Server Operator"),
    SYSTEM_USER("System User");

    private String role;

    private UserRoles(String role) {
        this.role = role;
    }

    public static UserRoles getEnumValue(String role) {

        for (UserRoles currentRole : UserRoles.values()) {

            if (currentRole.getUserRole().equals(role))
                return currentRole;
        }
        return null;
    }

    public String getUserRole() {
        return this.role;
    }

}

