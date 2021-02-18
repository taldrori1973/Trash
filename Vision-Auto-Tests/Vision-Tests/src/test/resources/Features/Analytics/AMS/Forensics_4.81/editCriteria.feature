@TC119781

Feature: Edit Criteria Testes

  @SID_1
  Scenario: Login and Navigate
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage

#    ------------------------------------- DefenseFlow------------------------------------------------------
  @SID_2
  Scenario: create new Forensics_DefenseFlow and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "DefenseFlow Forensics"
      | Product           | DefenseFlow                                                        |
      | Protected Objects | All                                                                |
      | Criteria          | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden |

  @SID_3
  Scenario: Edit the First condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "DefenseFlow Forensics"
    Then UI Click Button "Edit Forensics" with value "DefenseFlow Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Selected" with value "Action"
    Then UI Click Button "Criteria Attribute Selected" with value "Attack ID"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Edit Input" and params "1" To "123"
    Then UI Click Button "save"

  @SID_4
  Scenario: Edit the First condition on Criteria - Erorr edit
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "DefenseFlow Forensics"
    Then UI Click Button "Edit Forensics" with value "DefenseFlow Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Selected" with value "Action"
    Then UI Click Button "Criteria Attribute Selected" with value "Attack ID"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Edit Input" and params "1" To "test"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_5
  Scenario: Delete the first condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "DefenseFlow Forensics"
    Then UI Click Button "Edit Forensics" with value "DefenseFlow Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "true" with value "1"
    Then UI Click Button "Criteria Delete Condition" with value "1"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "false" with value "1"
    Then UI Click Button "save"


  @SID_6
  Scenario: add new Criteria that contains two conditions
    Then UI "Edit" Forensics With Name "DefenseFlow Forensics"
      | Criteria | Event Criteria:Packet Type,Operator:Equals,Value:SSL; Event Criteria:Risk,Operator:Not Equals,Value:Low; |

  @SID_7
  Scenario: Edit the second condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "DefenseFlow Forensics"
    Then UI Click Button "Edit Forensics" with value "DefenseFlow Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Selected" with value "Risk"
    Then UI Click Button "Criteria Attribute Selected" with value "Attack Name"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Edit Input" and params "2" To "Test"
    Then UI Click Button "save"

  @SID_8
  Scenario: Delete the Second condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "DefenseFlow Forensics"
    Then UI Click Button "Edit Forensics" with value "DefenseFlow Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "true" with value "2"
    Then UI Click Button "Criteria Delete Condition" with value "2"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "false" with value "2"
    Then UI Click Button "save"

  @SID_9
  Scenario: Delete DefenseFlow Forensics
    Then UI Delete Forensics With Name "DefenseFlow Forensics"


    #    ------------------------------------- DefensePro------------------------------------------------------
  @SID_10
  Scenario: create new Forensics_DefensePro and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "DefensePro Forensics"
      | Product  | DefensePro                                           |
      | devices  | All                                                  |
      | Criteria | Event Criteria:Protocol,Operator:Not Equals,Value:IP |

  @SID_11
  Scenario: Edit the First condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "DefensePro Forensics"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Selected" with value "Protocol"
    Then UI Click Button "Criteria Attribute Selected" with value "Source Port"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Click Button "Criteria Value select input" with value "Range"
    Then UI Set Text Field "Criteria Value Input Label" and params "port-from_1" To "3"
    Then UI Set Text Field "Criteria Value Input Label" and params "port-to_1" To "4"
    Then UI Click Button "save"


#     ----------------------- Ports bug


#  @SID_12
#  Scenario: Edit the First condition on Criteria
#    Then UI Click Button "My Forensics Tab"
#    Then UI Click Button "My Forensics" with value "DefensePro Forensics"
#    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
#    Then UI Click Button "Criteria Tab"
#    Then UI Click Button "Criteria Attribute Selected" with value "Protocol"
#    Then UI Click Button "Criteria Attribute Selected" with value "Source Port"
#    Then UI Click Button "Criteria Attribute Selected" with value "="
#    Then UI Click Button "Criteria Value select input" with value "Range"
#    Then UI Set Text Field "Criteria Value Input Label" and params "port-from" To "A"
#    Then UI Set Text Field "Criteria Value Input Label" and params "port-to" To "4"
#    Then UI Click Button "save"
#    Then UI Text of "Error message title" equal to "Unable to Save"
#    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
#    Then UI Click Button "errorMessageOK"
#    Then UI Click Button "cancel"
#    Then UI Click Button "No"
#
#  @SID_13
#  Scenario: Edit the First condition on Criteria
#    Then UI Click Button "My Forensics Tab"
#    Then UI Click Button "My Forensics" with value "DefensePro Forensics"
#    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
#    Then UI Click Button "Criteria Tab"
#    Then UI Click Button "Criteria Attribute Selected" with value "Protocol"
#    Then UI Click Button "Criteria Attribute Selected" with value "Source Port"
#    Then UI Click Button "Criteria Attribute Selected" with value "="
#    Then UI Click Button "Criteria Value select input" with value "Range"
#    Then UI Set Text Field "Criteria Value Input Label" and params "port-from" To "3"
#    Then UI Set Text Field "Criteria Value Input Label" and params "port-to" To "A"
#    Then UI Click Button "save"
#    Then UI Text of "Error message title" equal to "Unable to Save"
#    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
#    Then UI Click Button "errorMessageOK"
#    Then UI Click Button "cancel"
#    Then UI Click Button "No"
#
#  @SID_14
#  Scenario: Edit the First condition on Criteria
#    Then UI Click Button "My Forensics Tab"
#    Then UI Click Button "My Forensics" with value "DefensePro Forensics"
#    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
#    Then UI Click Button "Criteria Tab"
#    Then UI Click Button "Criteria Attribute Selected" with value "Protocol"
#    Then UI Click Button "Criteria Attribute Selected" with value "Source Port"
#    Then UI Click Button "Criteria Attribute Selected" with value "="
#    Then UI Click Button "Criteria Value select input" with value "Range"
#    Then UI Set Text Field "Criteria Value Input Label" and params "port-from" To "A"
#    Then UI Set Text Field "Criteria Value Input Label" and params "port-to" To "A"
#    Then UI Click Button "save"
#    Then UI Text of "Error message title" equal to "Unable to Save"
#    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
#    Then UI Click Button "errorMessageOK"
#    Then UI Click Button "cancel"
#    Then UI Click Button "No"


  @SID_15
  Scenario: Delete the first condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "DefensePro Forensics"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "true" with value "1"
    Then UI Click Button "Criteria Delete Condition" with value "1"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "false" with value "1"
    Then UI Click Button "save"

  @SID_16
  Scenario: add new Criteria that contians two conditions
    Then UI "Edit" Forensics With Name "DefensePro Forensics"
      | Criteria | Event Criteria:Duration,Operator:Equals,Value:1-5 min; Event Criteria:Direction,Operator:Not Equals,Value:Both; |

  @SID_17
  Scenario: Edit the First condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "DefensePro Forensics"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Selected" with value "Duration"
    Then UI Click Button "Criteria Attribute Selected" with value "Attack ID"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Edit Input" and params "1" To "123"
    Then UI Click Button "save"

  @SID_18
  Scenario: Delete the Second condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "DefensePro Forensics"
    Then UI Click Button "Edit Forensics" with value "DefensePro Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "true" with value "2"
    Then UI Click Button "Criteria Delete Condition" with value "2"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "false" with value "2"
    Then UI Click Button "save"

  @SID_19
  Scenario: Delete DefensePro Forensics
    Then UI Delete Forensics With Name "DefensePro Forensics"

        #    ------------------------------------- AppWall------------------------------------------------------

  @SID_20
  Scenario: create new Forensics_AppWall and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "AppWall Forensics"
      | Product      | AppWall                                              |
      | Applications | All                                                  |
      | Criteria     | Event Criteria:Tunnel,Operator:Not Equals,Value:123 |

  @SID_21
  Scenario: Edit the First condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "AppWall Forensics"
    Then UI Click Button "Edit Forensics" with value "AppWall Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Selected" with value "Tunnel"
    Then UI Click Button "Criteria Attribute Selected" with value "Web Application Name"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Edit Input" and params "1" To "Test"
    Then UI Click Button "save"

  @SID_22
  Scenario: Delete the first condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "AppWall Forensics"
    Then UI Click Button "Edit Forensics" with value "AppWall Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "true" with value "1"
    Then UI Click Button "Criteria Delete Condition" with value "1"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "false" with value "1"
    Then UI Click Button "save"

  @SID_23
  Scenario: add new Criteria that contians two conditions
    Then UI "Edit" Forensics With Name "AppWall Forensics"
      | Criteria | Event Criteria:Action,Operator:Not Equals,Value:Http 403 Forbidden; Event Criteria:Threat Category,Operator:Not Equals,Value:Dos; |

  @SID_24
  Scenario: Edit the First condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "AppWall Forensics"
    Then UI Click Button "Edit Forensics" with value "AppWall Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Selected" with value "Action"
    Then UI Click Button "Criteria Attribute Selected" with value "Transaction ID"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Edit Input" and params "1" To "123"
    Then UI Click Button "save"

  @SID_25
  Scenario: Delete the Second condition on Criteria
    Then UI Click Button "My Forensics Tab"
    Then UI Click Button "My Forensics" with value "AppWall Forensics"
    Then UI Click Button "Edit Forensics" with value "AppWall Forensics"
    Then UI Click Button "Criteria Tab"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "true" with value "2"
    Then UI Click Button "Criteria Delete Condition" with value "2"
    Then UI Validate Element Existence By Label "Criteria Delete Condition" if Exists "false" with value "2"
    Then UI Click Button "save"

  @SID_26
  Scenario: Delete AppWall Forensics
    Then UI Delete Forensics With Name "AppWall Forensics"

  @SID_27
  Scenario: Logout
    Then UI logout and close browser






