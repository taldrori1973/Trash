package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

import java.util.Comparator;

public class NumericalComparator implements Comparator<String> {
    @Override
    public int compare(String o1, String o2) {
        int firstNumber, secondNumber;
        firstNumber = getNumericalNumber(o1);
        secondNumber = getNumericalNumber(o2);
        if (firstNumber > secondNumber)
            return 1;
        if (firstNumber == secondNumber)
            return 0;
        return -1;
    }

    private int getNumericalNumber(String numText) {
        if(numText.equalsIgnoreCase(""))
        {
            return  0;
        }
        else
        {
            return Integer.valueOf(numText.replaceAll(",", ""));
        }
    }
}
