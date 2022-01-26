@Functional @TCtestRBAC
Feature: RBAC Menu


  @SID_1
  Scenario: Login And Go to Vision
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Given UI Navigate to page "System->User Management->Local Users"


  @SID_2
  Scenario Outline: Create users and verify
    When UI Create New User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" ,Password "<Password>"
    Then  UI User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" Exists
    Examples:
      | User Name         | Role                   | Scope | Password        |
      | ADC_ANALYTICS     | ADC Analytics User     | [ALL] | Radware1234!@#$ |
      | AMS_ANALYTICS     | AMS Analytics User     | [ALL] | Radware1234!@#$ |
      | APPWALL_ANALYTICS | AppWall Analytics User | [ALL] | Radware1234!@#$ |

#  @SID_3
#  Scenario Outline: Scope "All" is required for User Definition
#    When Scope Is "<enabled or disabled>" For Role "<Role>"
#    Examples:
#      | enabled or disabled | Role                          |
#      | enabled             | ADC+Certificate Administrator |
#      | enabled             | ADC Administrator             |
#      | enabled             | ADC Operator                  |
#      | enabled             | Certificate Administrator     |
#      | enabled             | Device Administrator          |
#      | enabled             | Device Configurator           |
#      | enabled             | Device Operator               |
#      | enabled             | Device Viewer                 |
#      | enabled             | Real Server Operator          |
#      | enabled             | Security Administrator        |
#      | enabled             | Security Monitor              |
#      | disabled            | User Administrator            |
#      | disabled            | Vision Administrator          |
#      | disabled            | Vision Reporter               |
#      | disabled            | System User                   |

  @SID_4
  Scenario: Edit User Management Settings
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "Local" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then UI Logout


  @SID_////////
  Scenario: ADC_ANALYTICS_Viewer RBAC Validation
    When UI Login with user "ADC_ANALYTICS" and password "Radware1234!@#$"
    And Sleep "10"
    Then UI Validate user rbac
      | operations          | accesses |
      | HOME                | yes      |
      | VISIONSETTINGS_ITEM | no       |
  #ANALYTICS ADC
      | ANALYTICS ADC       | yes      |
#      | ADC_APPLICATION_ITEM                        | yes      |
#      | ADC_NETWORK_AND_SYSTEM_ITEM                 | yes      |
#      | ALTEON_EAAF_ITEM                            | yes      |
#      | ADC_REPORTS_ITEM                            | yes      |
#ANALYTICS AMS
      | ANALYTICS AMS       | no       |
#      | AMS Reports                                 | no      |
#      | AMS Forensics                               | no      |
#      | AMS Alerts                                  | no      |
#      | EAAF Dashboard                              | no       |
#      | DefensePro Behavioral Protections Dashboard | no       |
#      | HTTPS Flood Dashboard                       | no       |
#      | DefensePro Analytics Dashboard              | no       |
#      | DefensePro Monitoring Dashboard             | no       |
#      | AppWall Dashboard                           | no       |
#      | DefenseFlow Analytics Dashboard             | no       |

#APPLICATIONS
      | APPLICATIONS_ITEM   | no       |
#      | vDirect                                     | no       |
#      | GEL Dashboard                               | no       |
#      | AVR                                         | no       |
#      | DPM                                         | no       |

#AUTOMATION
      | AUTOMATION_ITEM     | no       |
#DEFENSEFLOW
      | DEFENSEFLOW_ITEM    | no       |
#SCHEDULER
      | SCHEDULER_ITEM      | no       |


  @SID_////////
  Scenario: ADC_ANALYTICS_Viewer RBAC Validation
    When UI Login with user "AMS_ANALYTICS" and password "Radware1234!@#$"
    And Sleep "10"
    Then UI Validate user rbac
      | operations          | accesses |
      | HOME                | yes      |
      | VISIONSETTINGS_ITEM | no       |
  #ANALYTICS ADC
      | ANALYTICS ADC       | no       |
#      | ADC_APPLICATION_ITEM                        | no      |
#      | ADC_NETWORK_AND_SYSTEM_ITEM                 | no      |
#      | ALTEON_EAAF_ITEM                            | no      |
#      | ADC_REPORTS_ITEM                            | no      |
#ANALYTICS AMS
      | ANALYTICS AMS       | yes      |
#      | AMS Reports                                 | yes      |
#      | AMS Forensics                               | yes      |
#      | AMS Alerts                                  | yes      |
#      | EAAF Dashboard                              | yes       |
#      | DefensePro Behavioral Protections Dashboard | yes       |
#      | HTTPS Flood Dashboard                       | yes       |
#      | DefensePro Analytics Dashboard              | yes       |
#      | DefensePro Monitoring Dashboard             | yes       |
      | AppWall Dashboard   | no       |
#      | DefenseFlow Analytics Dashboard             | yes       |

#APPLICATIONS
      | APPLICATIONS_ITEM   | no       |
#      | vDirect                                     | no       |
#      | GEL Dashboard                               | no       |
#      | AVR                                         | no       |
#      | DPM                                         | no       |

#AUTOMATION
      | AUTOMATION_ITEM     | no       |
#DEFENSEFLOW
      | DEFENSEFLOW_ITEM    | no       |
#SCHEDULER
      | SCHEDULER_ITEM      | no       |

  @SID_////////
  Scenario: ADC_ANALYTICS_Viewer RBAC Validation
    When UI Login with user "APPWALL_ANALYTICS" and password "Radware1234!@#$"
    And Sleep "10"
    Then UI Validate user rbac
      | operations          | accesses |
      | HOME                | yes      |
      | VISIONSETTINGS_ITEM | no       |
  #ANALYTICS ADC
      | ANALYTICS ADC       | yes      |
#      | ADC_APPLICATION_ITEM                        | yes      |
#      | ADC_NETWORK_AND_SYSTEM_ITEM                 | yes      |
#      | ALTEON_EAAF_ITEM                            | yes      |
#      | ADC_REPORTS_ITEM                            | yes      |
#ANALYTICS AMS
      | ANALYTICS AMS       | yes      |
#      | AMS Reports                                 | no      |
#      | AMS Forensics                               | no      |
#      | AMS Alerts                                  | no      |
#      | EAAF Dashboard                              | no       |
#      | DefensePro Behavioral Protections Dashboard | no       |
#      | HTTPS Flood Dashboard                       | no       |
#      | DefensePro Analytics Dashboard              | no       |
#      | DefensePro Monitoring Dashboard             | no       |
#      | AppWall Dashboard                           | no       |
#      | DefenseFlow Analytics Dashboard             | no       |

#APPLICATIONS
      | APPLICATIONS_ITEM   | no       |
#      | vDirect                                     | no       |
#      | GEL Dashboard                               | no       |
#      | AVR                                         | no       |
#      | DPM                                         | no       |

#AUTOMATION
      | AUTOMATION_ITEM     | no       |
#DEFENSEFLOW
      | DEFENSEFLOW_ITEM    | no       |
#SCHEDULER
      | SCHEDULER_ITEM      | no       |


  @SID_////
  Scenario Outline: Delete All Users
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Given UI Navigate to page "System->User Management->Local Users"
    When UI Delete User With User Name "<User Name>"
    Examples:
      | User Name             |
      | adc_admin_certificate |
      | adc_admin             |
      | adc_operator          |
      | certificate_admin     |
      | device_admin          |
      | device_configurator   |
      | device_operator       |
      | device_viewer         |
      | real_server_operator  |
      | security_admin        |
      | security_monitor      |
      | user_admin            |
      | vision_admin          |
      | vision_reporter       |
      | system_user           |

  @SID_21
  Scenario: Login And Go to Vision
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "TACACS+" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then UI logout and close browser
