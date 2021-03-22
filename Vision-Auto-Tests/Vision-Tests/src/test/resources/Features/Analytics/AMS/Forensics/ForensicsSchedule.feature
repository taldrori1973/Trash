@VRM_Alerts @TC106004

Feature: Forensics Schedule

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    Given CLI Reset radware password
#    * REST Delete ES index "dp-*"
    * REST Delete ES index "forensics-*"
    * REST Delete ES index "dpforensics-*"
    * CLI Clear vision logs
    Then CLI copy "/home/radware/Scripts/get_scheduled_forensic_value.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |

  @SID_2
  Scenario: VRM - Loging to VRM "Wizard" Test
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_3
  Scenario: VRM - Add New Forensics view Daily schedule
    When UI "Create" Forensics With Name "Daily Report"
      | Schedule | Run Every:Daily,On Time:10:00 AM |
    When UI "Validate" Forensics With Name "Daily Report"
      | Schedule | Run Every:Daily,On Time:10:00 AM |

  @SID_4
  Scenario: VRM - Add New Forensics Report schedule (current time + 2 min)-once
    When UI "Create" Forensics With Name "Once Report"
      | Time Definitions.Date | Quick:This Month            |
      | Schedule              | Run Every:Once, On Time:+2m |
    When UI "Validate" Forensics With Name "Once Report"
      | Time Definitions.Date | Quick:This Month            |
      | Schedule              | Run Every:Once, On Time:+2m |


  @SID_5
  Scenario: VRM - Add New Forensics Report schedule (current time + 2 min)-daily
    When UI "Create" Forensics With Name "daily Forensic"
      | Time Definitions.Date | Quick:This Month             |
      | Schedule              | Run Every:Daily, On Time:+2m |
    When UI "Validate" Forensics With Name "daily Forensic"
      | Time Definitions.Date | Quick:This Month             |
      | Schedule              | Run Every:Daily, On Time:+2m |

  @SID_6
  Scenario: VRM - Add New Forensics Report schedule (Any day at 19:30) - weekly
    When UI "Create" Forensics With Name "weekly_Forensic"
      | Time Definitions.Date | Quick:This Month                   |
      | Schedule              | Run Every:Weekly, On Time:07:30 PM |
    When UI "Validate" Forensics With Name "weekly_Forensic"
      | Time Definitions.Date | Quick:This Month                   |
      | Schedule              | Run Every:Weekly, On Time:07:30 PM |

  @SID_7
  Scenario: VRM - Edit weekly schedule Wednesday
    Then UI Click Button "Edit Forensics" with value "weekly_Forensic"
    Then UI Click Button "Schedule Tab"
    Then UI Click Button "Schedule Forensics" with value "weekly"
    Then UI Click Button "Schedule Day" with value "WED"
    Then UI Click Button "save"

  @SID_8
  Scenario: VRM - Edit and validate weekly schedule When renaming report
    When UI "Edit" Forensics With Name "weekly_Forensic"
      | Basic Info | Description: Test,forensics name:weekly_Forensic1 |

  @SID_9
  Scenario: VRM - Add New Forensics Report schedule (current time + 2 min) - monthly
    When UI "Create" Forensics With Name "monthly Forensic"
      | Time Definitions.Date | Quick:This Month               |
      | Schedule              | Run Every:Monthly, On Time:+2m |
    When UI "Validate" Forensics With Name "monthly Forensic"
      | Time Definitions.Date | Quick:This Month               |
      | Schedule              | Run Every:Monthly, On Time:+2m |

  @SID_10
  Scenario: VRM Forensic schedule - sleep to let report generation
    And Sleep "240"
    Then UI Navigate to "AMS Reports" page via homePage
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_11
  Scenario: VRM Forensic schedule - validate report once was generated
    Then UI Click Button "My Forensics" with value "Once Report"
    Then UI Validate Element Existence By Label "Views.Forensic" if Exists "true" with value "Once Report,0"

  @SID_12
  Scenario: VRM Forensic schedule - validate report daily was generated
    Then UI Click Button "My Forensics" with value "daily Forensic"
    Then UI Validate Element Existence By Label "Views.Forensic" if Exists "true" with value "daily Forensic,0"

  @SID_13
  Scenario: VRM Forensic schedule - validate report monthly was generated
    Then UI Click Button "My Forensics" with value "monthly Forensic"
    Then UI Validate Element Existence By Label "Views.Forensic" if Exists "true" with value "monthly Forensic,0"

  @SID_14
  Scenario:Delete Forensics
    Then UI Delete Forensics With Name "Daily Report"
    Then UI Delete Forensics With Name "Once Report"
    Then UI Delete Forensics With Name "daily Forensic"
    Then UI Delete Forensics With Name "weekly_Forensic"
    Then UI Delete Forensics With Name "monthly Forensic"

  @SID_15
  Scenario: Cleanup and check logs
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
