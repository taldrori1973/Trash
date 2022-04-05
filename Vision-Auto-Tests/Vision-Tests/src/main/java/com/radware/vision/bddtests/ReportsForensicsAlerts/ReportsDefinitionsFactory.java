package com.radware.vision.bddtests.ReportsForensicsAlerts;

public class ReportsDefinitionsFactory {

    public static ReportsDefinitions getReportsDefinitions(String... args)
    {
        if(args == null || args.length == 0 || args[0] == null)
            return new ReportsDefinitions();

        if(args[0].contains("SetID"))
            return new ReportsDefinitionsSimulators(args[0]);

        return null;
    }
}
