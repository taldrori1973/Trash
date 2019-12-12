package com.radware.vision.infra.enums;

/**
 * Created by ashrafa on 8/2/2017.
 */
public enum ToolboxActionsEnum {
    ALTEON_CHECK_CERTIFICATE_VALIDITY("Alteon_Check_Certificate_Validity","ADC Check Certificate Validity"),
    ALTEON_CHECK_POLICY_COMPLIANCE("Alteon_Check_Policy_Compliance","ADC Check Policy Compliance"),
    ADC_DELETE_USERS("ADC_Delete_Users","ADC Delete Users"),
    ADC_CREATE_USERS("ADC_Create_Users","ADC Create Users"),
    ALTEON_FIND_APPLY_PENDING("Alteon_Find_Apply_Pending","ADC Find Apply Pending"),
    ALTEON_FIND_SAVE_PENDING("Alteon_Find_Save_Pending","ADC Find Save Pending"),
    ALTEON_SETUP_DEVICE("Alteon_Setup_Device","ADC Setup Device"),
    ADC_UPDATE_USERS("ADC_Update_Users","ADC Update Users"),
    ADC_TURNOFFON_ALL_REAL_SERVERS("ADC_TurnOffOn_All_Real_Servers","Alteon Enable/Disable Real Servers"),
    Alteon_Set_TOR_Feed("Alteon_Set_TOR_Feed","Alteon Specify ERT IP Reputation Feed Source"),
    ALTEON_TURNOFFON_ALL_VIRTUAL_SERVERS("Alteon_TurnOffOn_All_Virtual_Servers","Alteon Enable/Disable Virtual Servers"),
    ALTEON_EXECUTE_CMD_ON_ALL_OBJECTS("Alteon_Execute_Cmd_On_All_Objects","Alteon Execute CLI Command on All Entities"),
    ALTEON_FIND_UNUSED_ENTITIES("Alteon_Find_Unused_Entities","Alteon Find Unused Entities"),
    ALTEON_HA_CONFIGURATION("Alteon_HA_Configuration","Alteon High-Availability Configuration"),
    DEFENSEPRO_DEPLOY_NETWORK_POLICY_6_X("DefensePro_Deploy_Network_Policy_6_x","DefensePro 6.x Deploy Network Protection Policy for Enterpris"),
    DEFENSEPRO_6_X_SETUP_DEVICE("DefensePro_6_x_Setup_Device","DefensePro 6.x Setup Device"),
    DEFENSEPRO_ADD_NETWORK_CLASSES_BY_MASK("DefensePro_Add_Network_Classes_by_Mask","DefensePro Add Network Classes by Mask"),
    DEFENSEPRO_ADD_NETWORK_CLASSES_BY_RANGE("DefensePro_Add_Network_Classes_by_Range","DefensePro Add Network Classes by Range"),
    DEFENSEPRO_ADD_NETWORK_CLASSES_WITH_COMMON_MASK("DefensePro_Add_Network_Classes_with_Common_Mask","DefensePro Add Network Classes with Common Mask"),
    DEFENSEPRO_BLOCK_REPUTATION_IPS("DefensePro_Block_Reputation_IPs","DefensePro Block Reputation IPs"),
    DEFENSEPRO_BLOCK_COUNTRY("DefensePro_Block_Country","DefensePro Block Country"),
    DEFENSEPRO_CHECK_NETWORK_POLICY_COMPLIANCE("DefensePro_Check_Network_Policy_Compliance","DefensePro Check Network Policy Compliance"),
    DEFENSEPRO_CREATE_USERS("DefensePro_Create_Users","DefensePro Create Users"),
    DEFENSEPRO_DELETE_ERT_ACTIVE_ATTACKERS_FEED_BLACKLIST("DefensePro_Delete_Attackers_Feed_BlackList","DefensePro Delete Active Attackers Feed BlackList"),
    DEFENSEPRO_DELETE_USERS("DefensePro_Delete_Users","DefensePro Delete Users"),
    DEFENSEPRO_DEPLOY_POLICIES_FOR_MSSP("DefensePro_Deploy_Policies_For_MSSP","DefensePro Deploy Network Protection Policy for MSSP"),
    DEFENSEPRO_TOGGLE_POLICY_STATE_BASED_ON_POLICY_REGEX("DefensePro_Toggle_Policy_State_Based_On_Policy-regex","DefensePro Enable/Disable Policies"),
    DEFENSEPRO_EXPORT_AND_IMPORT_POLICY("DefensePro_Export_And_Import_Policy","DefensePro Export/Import Policies"),
    DEFENSEPRO_FIND_UPDATE_POLICY_PENDING("DefensePro_Find_Update_Policy_Pending","DefensePro Find Update Policy Pending"),
    DEFENSEPRO_SEARCH_SIGNATURE("DefensePro_Search_Signature","DefensePro Locate Policies and Profiles with Specified Signature"),
    DEFENSEPRO_RESET_BDOS_POLICY_BASELINES("DefensePro_Reset_BDoS_Policy_Baselines","DefensePro Reset BDoS Policy Baselines"),
    DEFENSEPRO_RESET_DNS_POLICY_BASELINES("DefensePro_Reset_DNS_Policy_Baselines","DefensePro Reset DNS Policy Baselines"),
    DEFENSEPRO_TUNE_BDOS_PROFILE("DefensePro_Tune_BDos_Profile","DefensePro Tune BDoS Profiles"),
    DEFENSEPRO_UPDATE_USERS("DefensePro_Update_Users","DefensePro Update Users"),
    VALIDATE_ALL_APM_SERVICES("Validate_All_Apm_Services","Validate All APM Services");

    private String actionID;
    private String actionName;

    ToolboxActionsEnum(String actionID, String actionName) {
        this.actionID = actionID; this.actionName = actionName;
    }

    public static ToolboxActionsEnum getActionByName(String actionName){
        for (ToolboxActionsEnum action : ToolboxActionsEnum.values()) {
            if(action.actionName.equals(actionName)){
                return action;
            }
        }
        return null;
    }

    public String getActionID() {
        return this.actionID;
    }
    public String getActionName(){ return this.actionName; }
}
