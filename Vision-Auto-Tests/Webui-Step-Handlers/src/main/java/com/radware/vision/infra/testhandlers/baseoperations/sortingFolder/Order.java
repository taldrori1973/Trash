package com.radware.vision.infra.testhandlers.baseoperations.sortingFolder;

public enum Order {

//    DEFAULT("DEFAULT"),
//    REVERSED("REVERSED"),
    ASCENDING("ASCENDING"),
    DESCENDING("DESCENDING");

    private Order(String orderType) {
        this.orderType = orderType;
    }

    private String orderType;

    public String getOrderType() {
        return orderType;
    }

    public static Order getOrderType(String method){

        switch (method.toUpperCase()){
//            case "DEFAULT": return DEFAULT;
//            case "REVERSED": return REVERSED;
            case "ASCENDING": return ASCENDING;
            case "DESCENDING": return DESCENDING;
        }

        return null;
    }
}