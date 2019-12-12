package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

import java.util.Comparator;

public class SystemStatusComparator implements Comparator<String> {

    private String getValueOfSystemStatus(String health) throws Exception {
        switch (health)
        {
            case "Up" :return "0";
            case "Down" : return "1";
            case "Maintenance" : return "2";
            case "Unknown" : return "3";
            default: throw new Exception("No status with name " + health);
        }
    }
    @Override
    public int compare(String o1, String o2) {
        try
        {
            o1 = getValueOfSystemStatus(o1);
            o2 = getValueOfSystemStatus(o2);
            return o1.compareTo(o2);
        }catch (Exception e)
        {}
        return 10;
    }
}
