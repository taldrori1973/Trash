package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

import java.util.Comparator;

public class IpOrVersionsComparator implements Comparator<String> {
    @Override
    public int compare(String o1, String o2) {
        String [] firstStringList = getIPList(o1);
        String [] secondStringList = getIPList(o2);
        for (int i=0; (i<firstStringList.length) && (i<secondStringList.length); i++)
        {
            if (Integer.valueOf(firstStringList[i]) > Integer.valueOf(secondStringList[i]))
            {
                return 1;
            }
            if (Integer.valueOf(firstStringList[i]) < Integer.valueOf(secondStringList[i]))
            {
                return -1;
            }
        }
        if (firstStringList.length > secondStringList.length)
        {
            return 1;
        }
        else if (secondStringList.length > firstStringList.length)
        {
            return -1;
        }
        return 0;
    }
    private String [] getIPList(String ipText)
    {
        if (ipText.contains("Multiple"))
        {
            return new String[]{"9999", "9999", "9999", "9999"};
        }
        return ipText.split("\\.|\\:");
    }
}
