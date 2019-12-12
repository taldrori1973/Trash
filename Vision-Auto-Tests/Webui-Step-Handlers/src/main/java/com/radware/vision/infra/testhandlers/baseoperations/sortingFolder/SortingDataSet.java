package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

public class SortingDataSet {
    private String columnName;
    private String order;
    private String compareMethod;
    public SortingDataSet(String columnName, String order, String compareMethod)
    {
        this.columnName = columnName;
        this.order = order;
        this.compareMethod = compareMethod;
    }
    public String getColumnName(){return columnName;}
    public String getOrder(){return order.toUpperCase();}
    public String getCompareMethod(){return compareMethod.toUpperCase();}
}
