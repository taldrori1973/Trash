@VRM_Report2 @TC108165
Feature: Sorting Attacks Tables

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-attack-raw-*"
    * REST Delete ES index "forensics-*"
    * REST Delete ES index "dpforensics-*"
    * CLI Clear vision logs
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |

  @SID_2
  Scenario: Run DP simulator
    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10
    And CLI simulate 1 attacks of type "rest_black_ip46" on "DefensePro" 20 with attack ID
    And CLI simulate 2 attacks of type "https_new2" on "DefensePro" 11 with loopDelay 15000 and wait 120 seconds

  @SID_3
  Scenario: VRM - Login and go to forensic tab
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_4
  Scenario: VRM - Create and generate forensic tables
    Given UI "Create" Forensics With Name "First Output Fields"
      | Time Definitions.Date | Quick:1Y                                                              |
      | Criteria              | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:0; |
      | Output                | Action,Start Time,Threat Category,Risk                                |
    Given UI "Create" Forensics With Name "Second Output Fields"
      | Time Definitions.Date | Quick:1Y                                                              |
      | Criteria              | Event Criteria:Source Port,Operator:Equals,portType:Port,portValue:0; |
      | Output                | Device IP Address,Direction,Packets,Policy Name                       |
    And UI Click Button "Views.Expand" with value "First Output Fields"
    And UI Click Button "Views.Generate Now" with value "First Output Fields"
    And Sleep "30"
    And UI Click Button "Views.report" with value "First Output Fields"

  @SID_5
  Scenario: Validate Sorting By Start Time Column
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName | order      | compareMethod |
      | Start Time | Descending | DATE          |

    When UI Click Button "Sorting" with value "Start Time"
    And UI Click Button "Sorting" with value "Start Time"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName | order     | compareMethod |
      | Start Time | Ascending | DATE          |

##########################################################
  @SID_6
  Scenario: Validate Sorting By Threat Category Column
    When UI Click Button "Sorting" with value "Threat Category"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName      | order     | compareMethod |
      | Threat Category | Ascending | ALPHABETICAL  |

    When UI Click Button "Sorting" with value "Threat Category"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName      | order      | compareMethod |
      | Threat Category | Descending | ALPHABETICAL  |

##########################################################
  @SID_7
  Scenario: Validate Sorting By Action Column
    When UI Click Button "Sorting" with value "Action"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName | order     | compareMethod |
      | Action     | Ascending | ALPHABETICAL  |

    When UI Click Button "Sorting" with value "Action"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName | order      | compareMethod |
      | Action     | Descending | ALPHABETICAL  |
##########################################################
  @SID_8
  Scenario: Validate Sorting By Risk Column
    When UI Click Button "Sorting" with value "Risk"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName | order     | compareMethod |
      | Risk       | Ascending | ALPHABETICAL  |

    When UI Click Button "Sorting" with value "Risk"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName | order      | compareMethod |
      | Risk       | Descending | ALPHABETICAL  |
##########################################################
# 2 : Second Output Fields
  @SID_9
  Scenario: Validate Sorting By Direction Column
    When UI Click Button "Views.Expand" with value "Second Output Fields"
    And UI Click Button "Views.Generate Now" with value "Second Output Fields"
    And UI Click Button "Views.report" with value "Second Output Fields"
    And UI Click Button "Sorting" with value "Direction"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName | order     | compareMethod |
      | Direction  | Ascending | ALPHABETICAL  |

    When UI Click Button "Sorting" with value "Direction"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName | order      | compareMethod |
      | Direction  | Descending | ALPHABETICAL  |
##########################################################
  @SID_10
  Scenario: Validate Sorting By Policy Name Column
    When UI Click Button "Sorting" with value "Policy Name"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName  | order     | compareMethod |
      | Policy Name | Ascending | ALPHABETICAL  |

    When UI Click Button "Sorting" with value "Policy Name"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName  | order      | compareMethod |
      | Policy Name | Descending | ALPHABETICAL  |
##########################################################
  @SID_11
  Scenario: Validate Sorting By Packets Column
    When UI Click Button "Sorting" with value "Packets"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName | order     | compareMethod |
      | Packets    | Ascending | NUMERICAL     |

    When UI Click Button "Sorting" with value "Packets"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName | order      | compareMethod |
      | Packets    | Descending | NUMERICAL     |
##########################################################
  @SID_12
  Scenario: Validate Sorting By Device IP Address Column
    When UI Click Button "Sorting" with value "Device IP Address"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName        | order     | compareMethod |
      | Device IP Address | Ascending | IPORVERSIONS  |

    When UI Click Button "Sorting" with value "Device IP Address"
    Then UI Validate Table "Report.Table" is Sorted by
      | columnName        | order      | compareMethod |
      | Device IP Address | Descending | IPORVERSIONS  |
##########################################################
  @SID_13
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
