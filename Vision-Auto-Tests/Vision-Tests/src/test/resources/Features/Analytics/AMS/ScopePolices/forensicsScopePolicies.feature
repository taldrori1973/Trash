@TC122035
Feature: ScopePolicies in Forensics

  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_2
  Scenario: create new DefensePro Forensics
    Given UI "Create" Forensics With Name "DefensePro Forensics"
      | Product | DefensePro                   |
      | devices | index:10,policies:[BDOS,SSL] |
    Then UI "Validate" Forensics With Name "DefensePro Forensics"
      | Product | DefensePro                   |
      | devices | index:10,policies:[BDOS,SSL] |

  @SID_3
  Scenario: Validate scope policies for DefensePro Forensics
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI "Validate" Scope Polices
      | devices | type:DEVICES,index:10, policies:[BDOS,SSL] |
    Then UI Click Button "save"

  @SID_4
  Scenario: Edit DefensePro Forensics
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI "Select" Scope Polices
      | devices | type:DEVICES,index:10,policies:[SSL2,BDOS,T_Server] |
    Then UI Click Button "save"

  @SID_5
  Scenario: Validate scope policies after Edit DefensePro Forensics
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI "Validate" Scope Polices
      | devices | type:DEVICES,index:10,policies:[SSL2,BDOS,T_Server] |
    Then UI Click Button "save"

  @SID_6
  Scenario: Edit DefensePro Forensics and unselect one policy
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI "UnSelect" Scope Polices
      | devices | type:DEVICES,index:10,policies:[BDOS] |
    Then UI Click Button "save"

  @SID_7
  Scenario: Validate scope policies after unselect one policy
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI "Validate" Scope Polices
      | devices | type:DEVICES,index:10,policies:[SSL2,T_Server] |
    Then UI Click Button "save"

  @SID_8
  Scenario: Edit DefensePro Forensics and cancel the unselect
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI "Select" Scope Polices
      | devices | type:DEVICES,index:10,policies:[SSL2,BDOS,T_Server] |
    Then UI Click Button "save"
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI "UnSelect" Scope Polices
      | devices | type:DEVICES,index:10,policies:[T_Server,BDOS] |
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_9
  Scenario: Validate scope policies after cancel unselect
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI "Validate" Scope Polices
      | devices | type:DEVICES,index:10,policies:[SSL2,BDOS,T_Server] |
    Then UI Click Button "save"
    Then UI Delete Forensics With Name "DefensePro Forensics"

  @SID_10
  Scenario: Logout
    Then UI logout and close browser


