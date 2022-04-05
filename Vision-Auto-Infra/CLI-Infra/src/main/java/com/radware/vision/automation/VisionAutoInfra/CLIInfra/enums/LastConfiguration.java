package com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums;

/**
 * Created by moaada on 6/6/2017.
 */
public enum LastConfiguration {


    NA("na"),
    DATE("date");

    private String lastConfiguration;

    LastConfiguration(String lastConfiguration) {
        this.lastConfiguration= lastConfiguration;
    }

    public static LastConfiguration getConstant(String lastConfiguration){
        lastConfiguration=lastConfiguration.toLowerCase();
        switch (lastConfiguration){
            case "na":return NA;
            case "date":return DATE;
            default:return null;
        }

    }
}
