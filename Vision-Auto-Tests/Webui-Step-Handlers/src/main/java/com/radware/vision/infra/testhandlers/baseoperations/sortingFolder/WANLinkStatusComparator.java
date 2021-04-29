package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

import java.util.Comparator;

public class WANLinkStatusComparator implements Comparator<String> {

    private String getValueOfSystemStatus(String health) throws Exception {
        switch (health)
        {
            case "Running" :return "0";
            case "Failed" : return "1";
            case "Disabled" : return "2";
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







