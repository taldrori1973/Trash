@TC122036
Feature: ScopePolicies in Reports

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS REPORTS" page via homepage

  @SID_2
  Scenario: create new DefensePro Behavioral Protections Report
    Given UI "Create" Report With Name "DefensePro Behavioral Protections Report"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{SetId:DefensePro_Set_2, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Months,3]                                                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                   |
      | Format                | Select: CSV                                                                                                                                      |
    Then UI "Validate" Report With Name "DefensePro Behavioral Protections Report"
      | Template              | reportType:DefensePro Behavioral Protections , Widgets:[{BDoS-TCP SYN:[IPv4,bps,Inbound]}] ,devices:[{SetId:DefensePro_Set_2, devicePolicies:[1_https]}] |
      | Time Definitions.Date | Relative:[Months,3]                                                                                                                              |
      | Schedule              | Run Every:Daily,On Time:+2m                                                                                                                      |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body                                                                   |
      | Format                | Select: CSV                                                                                                                                      |

  @SID_3
  Scenario: Validate scope policies for DefensePro Behavioral Protections Report
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "DefensePro Behavioral Protections Report"
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Behavioral Protections,SetId:DefensePro_Set_2, policies:[1_https] |
    Then UI Click Button "save"
    Then UI Delete Report With Name "DefensePro Behavioral Protections Report"

  @SID_4
  Scenario: create new DefensePro Analytics Report
    Given UI "Create" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{SetId:DefensePro_Set_1, devicePolicies:[BDOS,SSL]}],showTable:true |
    Then UI "Validate" Report With Name "DefensePro Analytics Report"
      | Template | reportType:DefensePro Analytics,Widgets:[Top Attack Destinations],devices:[{SetId:DefensePro_Set_1, devicePolicies:[BDOS,SSL]}],showTable:true |

  @SID_5
  Scenario: Validate scope policies for DefensePro Analytics Report
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_1,policies:[BDOS,SSL] |
    Then UI Click Button "save"

  @SID_6
  Scenario: Edit DefensePro Analytics Report
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_1,policies:[SSL2,BDOS,T_Server] |
    Then UI Click Button "save"

  @SID_7
  Scenario: Validate scope policies after Edit DefensePro Analytics Report
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_1,policies:[SSL2,BDOS,T_Server] |
    Then UI Click Button "save"


  @SID_8
  Scenario: Edit DefensePro Analytics Report and unselect one policy
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
    Then UI "UnSelect" Scope Polices
      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_1,policies:[T_Server] |
    Then UI Click Button "save"

  @SID_9
  Scenario: Validate scope policies after unselect one policy
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_1,policies:[SSL2,BDOS] |
    Then UI Click Button "save"

  @SID_10
  Scenario: Edit DefensePro Analytics Report and cancel the unselect
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_1,policies:[SSL2,BDOS,T_Server] |
    Then UI Click Button "save"
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
    Then UI "UnSelect" Scope Polices
      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_1,policies:[T_Server,BDOS] |
    Then UI Click Button "cancel"
    Then UI Text of "Save Change Message" contains "Do you want to save "DefensePro Analytics Report"?"
    Then UI Click Button "No"

  @SID_11
  Scenario: Validate scope policies after cancel unselect
    Then UI Click Button "My Report Tab"
    Then UI Click Button "Edit Report" with value "DefensePro Analytics Report"
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,SetId:DefensePro_Set_1,policies:[SSL2,BDOS,T_Server] |
    Then UI Click Button "save"
    Then UI Delete Report With Name "DefensePro Analytics Report"


  @SID_12
  Scenario: Logout
    Then UI logout and close browser


