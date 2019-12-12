package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

import java.util.Comparator;

public class AlphaBeticalComparator implements Comparator<String> {
    @Override
    public int compare(String o1, String o2) { return Integer.compare(o1.toLowerCase().compareTo(o2.toLowerCase()), 0);
    }
}
