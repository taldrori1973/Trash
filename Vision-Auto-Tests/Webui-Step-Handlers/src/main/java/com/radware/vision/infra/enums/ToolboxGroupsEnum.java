package com.radware.vision.infra.enums;

/**
 * Created by ashrafa on 8/2/2017.
 */
public enum ToolboxGroupsEnum {
    //please don't change the enum order
    RECENTLY_USED("recently-used","Recently Used"),
    FAVORITES("favorites","Favorites"),
    CONFIGURATION("configuration","Configuration"),
    MONITORING("monitoring","Monitoring"),
    OPERATIONS("operations","Operations"),
    HIGH_AVAILABILITY("high-availability","High Availability"),
    DATA_EXPORT("data-export","Data Export"),
    EMERGENCY("emergency","Emergency"),
    UNASSIGNED("unassigned","Unassigned");

    private String groupID;
    private String groupName;

    ToolboxGroupsEnum(String groupID, String groupName) {
        this.groupID = groupID;
        this.groupName = groupName;
    }

    public static ToolboxGroupsEnum getGroupByName(String groupName){
        for (ToolboxGroupsEnum group : ToolboxGroupsEnum.values()) {
            if(group.groupName.equals(groupName)){
                return group;
            }
        }
        return null;
    }

    public String toString() {
        return this.groupID;
    }
    public String getGroupName(){ return this.groupName; }
}
