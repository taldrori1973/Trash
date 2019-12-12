package com.radware.vision.infra.enums;

/**
 * This enum include all relevant Vision Projects IDs on rally
 */
public enum ProjectRefEnum {

    Radware("/project/25036419115"),

    Cloud_And_Managemant("/project/28863967553"),

    Vision_On_Prem("/project/28863967597"),

    Vision_Automation("/project/28863967868"),

    Vision_Client("/project/58720415419"),

    Vision_Documentation("/project/31121365916"),

    Vision_Manual_QA("/project/28863967910"),

    Vision_SLA_Management("/project/28863967784"),

    Vision_Server("/project/28863967696"),

    Vision_Smeagol("/project/52366054933"),

    Vision_VRM("/project/192956291788");


    private final String projectRef;


    ProjectRefEnum(String projectRef){
        this.projectRef=projectRef;
    }

    public String getValue(){
        return projectRef;
    }

}
