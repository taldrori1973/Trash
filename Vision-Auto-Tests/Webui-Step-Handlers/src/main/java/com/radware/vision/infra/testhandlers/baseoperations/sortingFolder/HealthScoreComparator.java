package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

import java.util.Comparator;

public class HealthScoreComparator implements Comparator<String> {

    private String getValueOfHealth(String health) throws Exception {
        switch (health)
        {
            case "Down" :return "0";
            case "Warning" : return "1";
            case "Shutdown" : return "2";
            case "disable" : return "3";
            case "unplugged" : return "4";
            case "Up" : return "5";
            case "Admin Down" : return "6";
            default: throw new Exception("No status with name " + health);
        }
    }
    @Override
    public int compare(String o1, String o2) {
        try
        {
            o1 = getValueOfHealth(o1);
            o2 = getValueOfHealth(o2);
            return o1.compareTo(o2);
        }catch (Exception e)
        {}
        return 10;
    }
}
