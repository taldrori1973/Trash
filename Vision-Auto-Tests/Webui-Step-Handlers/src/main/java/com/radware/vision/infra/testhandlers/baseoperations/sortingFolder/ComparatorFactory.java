package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

public class ComparatorFactory {
    public static Map<CompareMethod, Comparator<String>> mapOfComparators = new HashMap<>();
    public static Comparator getComparator(CompareMethod method)
    {
        return mapOfComparators.get(method);
    }
}
