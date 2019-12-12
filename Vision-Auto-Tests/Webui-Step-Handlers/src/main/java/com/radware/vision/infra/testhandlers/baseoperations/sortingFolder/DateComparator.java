package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Comparator;

public class DateComparator implements Comparator<String> {
    @Override
    public int compare(String o1, String o2) {
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("dd.MM.yyyy, HH:mm:ss");
        LocalDateTime firstDate = LocalDateTime.parse(o1, inputFormatter);
        LocalDateTime secondDate = LocalDateTime.parse(o2, inputFormatter);
        if (firstDate.isAfter(secondDate))
        {
            return 1;
        }
        if (firstDate.isBefore(secondDate))
        {
            return -1;
        }
        return 0;
    }
}
