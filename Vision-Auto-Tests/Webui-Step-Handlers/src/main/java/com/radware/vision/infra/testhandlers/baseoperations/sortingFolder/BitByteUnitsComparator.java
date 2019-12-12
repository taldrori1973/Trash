package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

import java.util.Comparator;

public class BitByteUnitsComparator implements Comparator<String> {
    private long convertByteTextToString(String CellValue) {

        if(CellValue.contains(" "))
        {
            String[] tokens = CellValue.split(" ");
            String unit = tokens[1];
            double value = Double.valueOf(tokens[0]);
            switch (unit) {
                case "K":
                    return(long) (value * Math.pow(10, 3));
                case "M":
                    return(long) (value * Math.pow(10, 6));
                case "G":
                    return(long) (value * Math.pow(10, 9));
                case "T":
                    return(long) (value * Math.pow(10, 12));
                case "P":
                    return(long) (value * Math.pow(10, 15));
                case "E":
                    return(long) (value * Math.pow(10, 18));
                case "Z":
                    return(long) (value * Math.pow(10, 21));
                case "Y":
                    return(long) (value * Math.pow(10, 24));
            }
        }
        else
        {
            if(CellValue.equalsIgnoreCase(""))
            {
                return 0;
            }
            double value = Double.valueOf(CellValue);
            return(long) (value);
        }
        return 0;
    }
    
    @Override
    public int compare(String o1, String o2)
    {
        Long firstValue, secondValue;
        firstValue = convertByteTextToString(o1);
        secondValue = convertByteTextToString(o2);
        if (firstValue > secondValue)
            return 1;
        if (firstValue.doubleValue() == secondValue.doubleValue())
            return 0;
        return -1;
    }
}
