@TC119417

Feature: Landing Forensics

  @SID_1
  Scenario: Login and Navigate to NEW ForensicsS page
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage

#-------------------------- DefensePro----------------------------------------
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
    Then UI Click Button "My Forensics" with value "DefensePro Forensics"
    Then UI Text of "Forensics Type Text" equal to "Type:DefensePro"
    Then UI Text of "Forensics Type Product Value" with extension "DefensePro" equal to "DefensePro"

  @SID_5
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "DefensePro Forensics"
    Then Sleep "35"

  @SID_6
  Scenario: Deletion Forensics Instance
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "DefensePro Forensics_0"

  @SID_7
  Scenario: Edit Forensics and validate
    Given UI "Edit" Forensics With Name "DefensePro Forensics"
      | Format | Select: HTML |
    Given UI "Validate" Forensics With Name "DefensePro Forensics"
      | Format | Select: HTML |

#  @SID_8
#  Scenario: Validate tooltip values
#    Then UI Do Operation "hover" item "INFO Forensics" with value "DefensePro Forensics"
#    Then Sleep "3"
#    Then UI Text of "ToolTip Forensics" with extension "DefensePro Forensics" equal to "ScopeDevice:172.16.22.50Number of policies:49Number of ports:8Device:172.16.22.51Number of policies:49Number of ports:8Device:172.16.22.55Number of policies:1Number of ports:1Time Period1 DayFilter CriteriaNot SelectedOutput FieldsActionScheduleNot SelectedFormatHTMLDeliveryDelivery:emailRecipients:automation.vision2@radware.comSubject:myEdit subject"

  @SID_9
  Scenario: Delete Forensics
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "DefensePro Forensics"
    Then UI Delete Forensics With Name "DefensePro Forensics"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "DefensePro Forensics"

    #-------------------------- DefenseFlow----------------------------------------
  @SID_10
  Scenario: create new DefenseFlow Forensics and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "DefenseFlow Forensics"
      | Product           | DefenseFlow                                                                    |
      | Protected Objects | All                                                                            |
      | Share             | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format            | Select: CSV                                                                    |
      | Output            | Action                                                                         |
    Given UI "Validate" Forensics With Name "DefenseFlow Forensics"
      | Product           | DefenseFlow                                                                    |
      | Protected Objects | All                                                                            |
      | Share             | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format            | Select: CSV                                                                    |
      | Output            | Action                                                                         |

  @SID_11
  Scenario: Change from New Forensics to My Forensics
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label             | param | value |
      | New Forensics Tab |       | false |
      | My Forensics Tab  |       | true  |

  @SID_12
  Scenario: Validate Forensics Type
    Then UI Click Button "My Forensics" with value "DefenseFlow Forensics"
    Then UI Text of "Forensics Type Text" equal to "Type:DefenseFlow"
    Then UI Text of "Forensics Type Product Value" with extension "DefenseFlow" equal to "DefenseFlow"

  @SID_13
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "DefenseFlow Forensics"
    Then Sleep "35"

  @SID_14
  Scenario: Deletion Forensics Instance
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "DefenseFlow Forensics_0"

  @SID_15
  Scenario: Edit Forensics and validate
    Given UI "Edit" Forensics With Name "DefenseFlow Forensics"
      | Format | Select: HTML |
    Given UI "Validate" Forensics With Name "DefenseFlow Forensics"
      | Format | Select: HTML |

  @SID_16
  Scenario: Delete Forensics
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "DefenseFlow Forensics"
    Then UI Delete Forensics With Name "DefenseFlow Forensics"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "DefenseFlow Forensics"



#-------------------------- AppWall----------------------------------------
  @SID_17
  Scenario: create new AppWall Forensics and validate
    Then UI Click Button "New Forensics Tab"
    When UI "Create" Forensics With Name "AppWall Forensics"
      | Product      | AppWall                                                                        |
      | Applications | A1                                                                             |
      | Share        | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format       | Select: CSV                                                                    |
      | Output       | Action                                                                         |
    Given UI "Validate" Forensics With Name "AppWall Forensics"
      | Product           | AppWall                                                                        |
      | Protected Objects | A1                                                                             |
      | Share             | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |
      | Format            | Select: CSV                                                                    |
      | Output            | Action                                                                         |

  @SID_18
  Scenario: Change from New Forensics to My Forensics
    Then UI Validate the attribute of "data-debug-checked" are "EQUAL" to
      | label             | param | value |
      | New Forensics Tab |       | false |
      | My Forensics Tab  |       | true  |

  @SID_19
  Scenario: Validate Forensics Type
    Then UI Click Button "My Forensics" with value "AppWall Forensics"
    Then UI Text of "Forensics Type Text" equal to "Type:AppWall"
    Then UI Text of "Forensics Type Product Value" with extension "AppWall" equal to "AppWall"

  @SID_20
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "AppWall Forensics"
    Then Sleep "35"

  @SID_21
  Scenario: Deletion Forensics Instance
    Then UI Validate Deletion of Forensics instance "Deletion Forensics Instance" with value "AppWall Forensics_0"

  @SID_22
  Scenario: Edit Forensics and validate
    Given UI "Edit" Forensics With Name "AppWall Forensics"
      | Format | Select: HTML |
    Given UI "Validate" Forensics With Name "AppWall Forensics"
      | Format | Select: HTML |

  @SID_23
  Scenario: Delete Forensics
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "AppWall Forensics"
    Then UI Delete Forensics With Name "AppWall Forensics"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "AppWall Forensics"

  @SID_24
  Scenario: Logout
    Then UI logout and close browser


