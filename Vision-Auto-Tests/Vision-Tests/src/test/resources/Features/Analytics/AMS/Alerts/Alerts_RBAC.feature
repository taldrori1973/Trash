@VRM_Alerts @TC105983

Feature: VRM Alerts RBAC


  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "rt-alert-def-vrm"
    * CLI Clear vision logs
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15

  @SID_2
  Scenario: VRM - Login to VRM Alerts Tab
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "AMS Alerts" page via homePage

  @SID_3
  Scenario: Create alerts as sys_admin
     When UI "Create" Alerts With Name "Alert All All"
      | Criteria   | Event Criteria:Action,Operator:Equals,Value:[Proxy,Forward]; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                            |

    When UI "Create" Alerts With Name "Alert DP.10 All"
      | devices    | index:10                                                     |
      | Criteria   | Event Criteria:Action,Operator:Equals,Value:[Proxy,Forward]; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                            |

    When UI "Create" Alerts With Name "Alert DP.11 All"
      | devices    | index:11                                                     |
      | Criteria   | Event Criteria:Action,Operator:Equals,Value:[Proxy,Forward]; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                            |

    When UI "Create" Alerts With Name "Alert DP.10 Policy14 Policy15"
      | devices    | index:10,policies:[Policy14, Policy15];                      |
      | Criteria   | Event Criteria:Action,Operator:Equals,Value:[Proxy,Forward]; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                            |

    When UI "Create" Alerts With Name "Alert_DP.10_Policy14"
      | devices    | index:10 ,policies:[Policy14];                               |
      | Criteria   | Event Criteria:Action,Operator:Equals,Value:[Proxy,Forward]; |
      | Schedule   | checkBox:Trigger,alertsPerHour:60                            |

    Then UI Navigate to "VISION SETTINGS" page via homePage
    Then UI logout and close browser

  @SID_4
  Scenario: Login as sec_mon_all_pol and verify alert permissions
    Given UI Login with user "sec_mon_all_pol" and password "radware"
    And UI Navigate to "AMS Alerts" page via homePage
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Alert All All"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert DP.10 All"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Alert DP.11 All"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert DP.10 Policy14 Policy15"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert_DP.10_Policy14"

    Then UI Navigate to "VISION SETTINGS" page via homePage
    Then UI logout and close browser

  @SID_5
  Scenario: Login as sec_mon_Policy14 and verify alert permissions
    Given UI Login with user "sec_mon_Policy14" and password "radware"
    And UI Navigate to "AMS Alerts" page via homePage
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Alert All All"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Alert DP.10 All"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Alert DP.11 All"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "false" with value "Alert DP.10 Policy14 Policy15"
    Then UI Validate Element Existence By Label "Toggle Alerts" if Exists "true" with value "Alert_DP.10_Policy14"

    Then UI Navigate to "VISION SETTINGS" page via homePage
    Then UI logout and close browser

  @SID_6
  Scenario: Check logs
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
