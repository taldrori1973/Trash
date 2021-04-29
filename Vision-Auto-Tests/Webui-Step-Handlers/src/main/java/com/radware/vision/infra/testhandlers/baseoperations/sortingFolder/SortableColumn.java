package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

import java.util.Comparator;
import java.util.List;

import static com.radware.vision.infra.testhandlers.baseoperations.sortingFolder.CompareMethod.*;

public class SortableColumn {
    List<String> columnData;
    Comparator comparator;
    SortingDataSet columnMetaData;

    public String isSorted() throws Exception {
        String sortingResult = "";
        for (int i = 0; i < (columnData.size() - 1); i++) {
            if (towValuesIsSorted(i, i + 1) == -1)
                sortingResult = sortingResult + "In column '" + columnMetaData.getColumnName() + "': the value -->(" + columnData.get(i) + ") in index -->(" + i + ") isn't sorted with value -->("
                        + columnData.get(i + 1) + ") in index -->(" + (i + 1) + ")\n";
        }
        return sortingResult;
    }

    public int towValuesIsSorted(int firstIndex, int secondIndex) throws Exception {
        if (firstIndex < 0 || firstIndex >= (columnData.size() - 1) && secondIndex < 1 || secondIndex >= (columnData.size())) {
            throw new Exception("firstIndex should be between 0 and " + (columnData.size() - 1));
        }
        return columnMetaData.getOrder().equalsIgnoreCase("ASCENDING") ? comparator.compare(columnData.get(firstIndex), columnData.get(secondIndex)) * (-1)
                : comparator.compare(columnData.get(firstIndex), columnData.get(secondIndex));
    }

    public SortableColumn(List<String> columnData, SortingDataSet columnMetaData) throws Exception {
        this.columnData = columnData;
        this.columnMetaData = columnMetaData;
        setComparator();
    }

    private void setComparator() throws Exception {
        if (ComparatorFactory.getComparator(CompareMethod.getEnumByString(this.columnMetaData.getCompareMethod())) == null) {
            if (CompareMethod.getEnumByString(this.columnMetaData.getCompareMethod()) != null) {
                switch (CompareMethod.getEnumByString(this.columnMetaData.getCompareMethod())) {
                    case BIT_BYTE_UNITS: {
                        ComparatorFactory.mapOfComparators.put(BIT_BYTE_UNITS, new BitByteUnitsComparator());
                        break;
                    }
                    case ALPHABETICAL: {
                        ComparatorFactory.mapOfComparators.put(ALPHABETICAL, new AlphaBeticalComparator());
                        break;
                    }
                    case NUMERICAL: {
                        ComparatorFactory.mapOfComparators.put(NUMERICAL, new NumericalComparator());
                        break;
                    }
                    case HEALTH_SCORE: {
                        ComparatorFactory.mapOfComparators.put(HEALTH_SCORE, new HealthScoreComparator());
                        break;
                    }
                    case SYSTEM_STATUS: {
                        ComparatorFactory.mapOfComparators.put(SYSTEM_STATUS, new SystemStatusComparator());
                        break;
                    }
                    case WAN_LINK_STATUS: {
                        ComparatorFactory.mapOfComparators.put(WAN_LINK_STATUS, new WANLinkStatusComparator());
                        break;
                    }

                    case IPORVERSIONS: {
                        ComparatorFactory.mapOfComparators.put(IPORVERSIONS, new IpOrVersionsComparator());
                        break;
                    }
                    case DATE:
                        ComparatorFactory.mapOfComparators.put(DATE, new DateComparator());
                    default: {
                    }
                }
            }
            else
                {
                    throw new Exception("No Comparator with name " + CompareMethod.getEnumByString(this.columnMetaData.getCompareMethod()).name());
                }
        }
        this.comparator = ComparatorFactory.getComparator(CompareMethod.getEnumByString(this.columnMetaData.getCompareMethod()));
    }
}
