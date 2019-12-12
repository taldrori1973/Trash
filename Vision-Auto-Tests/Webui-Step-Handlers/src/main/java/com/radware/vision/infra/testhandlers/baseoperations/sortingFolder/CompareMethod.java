package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

public enum CompareMethod {
    BIT_BYTE_UNITS("BIT_BYTE_UNITS"),
    ALPHABETICAL("ALPHABETICAL"),
    NUMERICAL("NUMERICAL"),
    HEALTH_SCORE("HEALTH_SCORE"),
    SYSTEM_STATUS("SYSTEM_STATUS"),
    IPORVERSIONS("IPORVERSIONS"),
    DATE("DATE");

    private CompareMethod(String compareMethod) {
        this.compareMethod = compareMethod;
    }

    private String compareMethod;

    public String getCompareMethod() {
        return compareMethod;
    }

    public static CompareMethod getEnumByString(String method){

        switch (method.toUpperCase()){
            case "BIT_BYTE_UNITS": return BIT_BYTE_UNITS;
            case "ALPHABETICAL": return ALPHABETICAL;
            case "NUMERICAL": return NUMERICAL;
            case "HEALTH_SCORE": return HEALTH_SCORE;
            case "SYSTEM_STATUS": return SYSTEM_STATUS;
            case "IPORVERSIONS": return IPORVERSIONS;
            case "DATE": return DATE;
        }

        return null;
    }
}
