package com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection.enums;

public enum DeleteOrLeaveIt {


    YES_DELETE_IT("Yes,delete", "ngr-delete-item-confirm"),
    LEAVE_IT("Leave it", "ngr-delete-item-cancel");


    private String value;
    private String dataDebugId;

    DeleteOrLeaveIt(String value, String dataDebugId) {
        this.value = value;
        this.dataDebugId = dataDebugId;
    }

    public static DeleteOrLeaveIt getDeleteOrLeaveItEnum(String deleteOrLeaveIt) {

        switch (deleteOrLeaveIt) {


            case "Yes,delete":
                return YES_DELETE_IT;
            case "Leave it":
                return LEAVE_IT;
        }
        return null;
    }

    public String getValue() {
        return value;
    }

    public String getDataDebugId() {
        return dataDebugId;
    }


}
