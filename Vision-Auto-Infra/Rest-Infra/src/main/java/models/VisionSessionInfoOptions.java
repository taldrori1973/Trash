package models;

public enum VisionSessionInfoOptions implements SessionInfoOptions {

    NETWORK_POLICIES("networkpolicies"),
    LAST_LOGIN("lastlogin"),
    ROLES("roles"),
    WARNINGS("warnings"),
    LOCALE("locale"),
    GLOBAL_LANDING_PAGE("globalLandingPage"),
    USERNAME("username"),
    LOGICAL_GROUP_ROLES("logicalGroupRoles");

    private String fieldName;

    VisionSessionInfoOptions(String fieldName) {
        this.fieldName = fieldName;
    }

    public String getFieldName() {
        return fieldName;
    }
}
