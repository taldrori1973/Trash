@TC119417
Feature: Landing Forensics

  @SID_1
  Scenario: Login and Navigate to NEW ForensicsS page
    * REST Delete ES index "forensics-*"
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage

  @SID_2
  Scenario: create new DefensePro Forensics and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "DefensePro Forensics"
      | Product | DefensePro                                                                     |
      | devices | All                                                                            |
      | Share   | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format  | Select: CSV                                                                    |
      | Output  | Action                                                                         |
    Given UI "Validate" Forensics With Name "DefensePro Forensics"
      | Product | DefensePro                                                                     |
      | devices | All                                                                            |
      | Share   | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format  | Select: CSV                                                                    |
      | Output  | Action                                                                         |

  @SID_3
  Scenario: Change from New Forensics to My Forensics
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label             | param | value |
      | New Forensics Tab |       | false |
      | My Forensics Tab  |       | true  |

  @SID_4
  Scenario: Validate Forensics Type
    Then UI Text of "Forensics Type Text" equal to "Type:"
    Then UI Text of "Forensics Type Product Value" with extension "DefensePro" equal to "DefensePro"

  @SID_5
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "DefensePro Forensics"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "DefensePro Forensics"
    Then Sleep "35"

  @SID_6
  Scenario: Validate tooltip values
    Then UI Do Operation "hover" item "INFO Forensics" with value "DefensePro Forensics"
    Then Sleep "2"
    Then UI Text of "ToolTip Forensics" with extension "DefensePro Forensics" equal to "ScopeDevice:172.16.22.50Number of policies:0Number of ports:0Device:172.16.22.51Number of policies:0Number of ports:0Device:172.16.22.55Number of policies:0Number of ports:0Time Period1 DayFilter CriteriaNot SelectedOutput FieldsAction; ScheduleNot SelectedFormatCSVDeliveryDelivery:emailRecipients:automation.vision2@radware.comSubject:myEdit subject"

  @SID_7
  Scenario: Deletion Forensics Instance
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "DefensePro Forensics_0"

  @SID_8
  Scenario: Edit Forensics and validate
    Given UI "Edit" Forensics With Name "DefensePro Forensics"
      | Format | Select: HTML |
    Given UI "Validate" Forensics With Name "DefensePro Forensics"
      | Format | Select: HTML |

  @SID_9
  Scenario: Delete Forensics
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "DefensePro Forensics"
    Then UI Delete Forensics With Name "DefensePro Forensics"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "DefensePro Forensics"

  @SID_10
  Scenario: Logout
    Then UI logout and close browser


