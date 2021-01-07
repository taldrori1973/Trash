@Functional @TC114371
Feature: RBAC Menu


  @SID_1
  Scenario: Login And Go to Vision
    Given UI Login with user "sys_admin" and password "radware"
    Given UI Go To Vision
    Given UI Navigate to page "System->User Management->Local Users"


  @SID_2
  Scenario Outline: Create users and verify
    When UI Create New User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" ,Password "<Password>"
    Then  UI User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" Exists
    Examples:
      | User Name             | Role                          | Scope | Password        |
      | adc_admin_certificate | ADC+Certificate Administrator | [ALL] | Radware1234!@#$ |
      | adc_admin             | ADC Administrator             | [ALL] | Radware1234!@#$ |
      | adc_operator          | ADC Operator                  | [ALL] | Radware1234!@#$ |
      | certificate_admin     | Certificate Administrator     | [ALL] | Radware1234!@#$ |
      | device_admin          | Device Administrator          | [ALL] | Radware1234!@#$ |
      | device_configurator   | Device Configurator           | [ALL] | Radware1234!@#$ |
      | device_operator       | Device Operator               | [ALL] | Radware1234!@#$ |
      | device_viewer         | Device Viewer                 | [ALL] | Radware1234!@#$ |
      | real_server_operator  | Real Server Operator          | [ALL] | Radware1234!@#$ |
      | security_admin        | Security Administrator        | [ALL] | Radware1234!@#$ |
      | security_monitor      | Security Monitor              | [ALL] | Radware1234!@#$ |
      | user_admin            | User Administrator            | [ALL] | Radware1234!@#$ |
      | vision_admin          | Vision Administrator          | [ALL] | Radware1234!@#$ |
      | vision_reporter       | Vision Reporter               | [ALL] | Radware1234!@#$ |
      | system_user           | System User                   | [ALL] | Radware1234!@#$ |


  @SID_3
  Scenario Outline: Scope "All" is required for User Definition
    When Scope Is "<enabled or disabled>" For Role "<Role>"
    Examples:
      | enabled or disabled | Role                          |
      | enabled             | ADC+Certificate Administrator |
      | enabled             | ADC Administrator             |
      | enabled             | ADC Operator                  |
      | enabled             | Certificate Administrator     |
      | enabled             | Device Administrator          |
      | enabled             | Device Configurator           |
      | enabled             | Device Operator               |
      | enabled             | Device Viewer                 |
      | enabled             | Real Server Operator          |
      | enabled             | Security Administrator        |
      | enabled             | Security Monitor              |
      | disabled            | User Administrator            |
      | disabled            | Vision Administrator          |
      | disabled            | Vision Reporter               |
      | disabled            | System User                   |

  @SID_4
  Scenario: Edit User Management Settings
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "Local" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"
    Then UI Logout

  @SID_5
  Scenario: ADC+Certificate Administrator
    When UI Login with user "adc_admin_certificate" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | no       |
      | APM                                         | yes      |
      | DPM                                         | yes      |
      | ANALYTICS ADC                               | yes      |
      | ANALYTICS AMS                               | no       |
      | DefensePro Behavioral Protections Dashboard | no       |
      | HTTPS Flood Dashboard                       | no       |
      | DefensePro Analytics Dashboard              | no       |
      | DefensePro Monitoring Dashboard             | no       |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | no       |
      | AMS Reports                                 | no       |
      | AMS Forensics                               | no       |
      | AMS Alerts                                  | no       |
      | vDirect                                     | yes      |
      | GEL Dashboard                               | yes      |
      | EAAF Dashboard                              | no       |
      | VISION SETTINGS                             | yes      |
    * UI Logout

  @SID_6
  Scenario: ADC Administrator
    When UI Login with user "adc_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | no       |
      | APM                                         | yes      |
      | DPM                                         | yes      |
      | ANALYTICS ADC                               | yes      |
      | ANALYTICS AMS                               | no       |
      | DefensePro Behavioral Protections Dashboard | no       |
      | HTTPS Flood Dashboard                       | no       |
      | DefensePro Analytics Dashboard              | no       |
      | DefensePro Monitoring Dashboard             | no       |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | no       |
      | AMS Reports                                 | no       |
      | AMS Forensics                               | no       |
      | AMS Alerts                                  | no       |
      | vDirect                                     | yes      |
      | GEL Dashboard                               | yes      |
      | EAAF Dashboard                              | no       |
      | VISION SETTINGS                             | yes      |
    * UI Logout

    #  Vdirect should not be display as  mentioned in table from user Guid
  @SID_7
  Scenario: ADC Operator
    When UI Login with user "adc_operator" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | no       |
      | APM                                         | yes      |
      | DPM                                         | yes      |
      | ANALYTICS ADC                               | yes      |
      | ANALYTICS AMS                               | no       |
      | DefensePro Behavioral Protections Dashboard | no       |
      | HTTPS Flood Dashboard                       | no       |
      | DefensePro Analytics Dashboard              | no       |
      | DefensePro Monitoring Dashboard             | no       |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | no       |
      | AMS Reports                                 | no       |
      | AMS Forensics                               | no       |
      | AMS Alerts                                  | no       |
      | vDirect                                     | no       |
      | GEL Dashboard                               | yes      |
      | EAAF Dashboard                              | no       |
      | VISION SETTINGS                             | yes      |
    * UI Logout

  @SID_8
  Scenario: Administrator
    When UI Login with user "radware" and password "radware"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | yes      |
      | APM                                         | yes      |
      | DPM                                         | yes      |
      | ANALYTICS ADC                               | yes      |
      | ANALYTICS AMS                               | yes      |
      | DefensePro Behavioral Protections Dashboard | yes      |
      | HTTPS Flood Dashboard                       | yes      |
      | DefensePro Analytics Dashboard              | yes      |
      | DefensePro Monitoring Dashboard             | yes      |
      | DefenseFlow Analytics Dashboard             | yes      |
      | AppWall Dashboard                           | yes      |
      | AMS Reports                                 | yes      |
      | AMS Forensics                               | yes      |
      | AMS Alerts                                  | yes      |
      | vDirect                                     | yes      |
      | GEL Dashboard                               | yes      |
      | EAAF Dashboard                              | yes      |
      | VISION SETTINGS                             | yes      |
    * UI Logout

  @SID_9
  Scenario: Certificate Administrator
    When UI Login with user "certificate_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | no       |
      | APM                                         | no       |
      | DPM                                         | no       |
      | ANALYTICS ADC                               | no       |
      | ANALYTICS AMS                               | no       |
      | DefensePro Behavioral Protections Dashboard | no       |
      | HTTPS Flood Dashboard                       | no       |
      | DefensePro Analytics Dashboard              | no       |
      | DefensePro Monitoring Dashboard             | no       |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | no       |
      | AMS\ Reports                                | no       |
      | AMS Forensics                               | no       |
      | AMS Alerts                                  | no       |
      | vDirect                                     | yes      |
      | GEL Dashboard                               | no       |
      | EAAF Dashboard                              | no       |
      | VISION SETTINGS                             | yes      |
    * UI Logout

  @SID_10
  Scenario: Device Administrator
    When UI Login with user "device_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | yes      |
      | APM                                         | yes      |
      | DPM                                         | yes      |
      | ANALYTICS ADC                               | yes      |
      | ANALYTICS AMS                               | yes      |
      | DefensePro Behavioral Protections Dashboard | yes      |
      | HTTPS Flood Dashboard                       | yes      |
      | DefensePro Analytics Dashboard              | yes      |
      | DefensePro Monitoring Dashboard             | yes      |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | yes      |
      | AMS Reports                                 | yes      |
      | AMS Forensics                               | yes      |
      | AMS Alerts                                  | yes      |
      | vDirect                                     | yes      |
      | GEL Dashboard                               | yes      |
      | EAAF Dashboard                              | yes      |
      | VISION SETTINGS                             | yes      |
    * UI Logout

  @SID_11
  Scenario: Device Configurator
    When UI Login with user "device_configurator" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | no       |
      | APM                                         | yes      |
      | DPM                                         | yes      |
      | ANALYTICS ADC                               | yes      |
      | ANALYTICS AMS                               | no       |
      | DefensePro Behavioral Protections Dashboard | no       |
      | HTTPS Flood Dashboard                       | no       |
      | DefensePro Analytics Dashboard              | no       |
      | DefensePro Monitoring Dashboard             | no       |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | no       |
      | AMS Reports                                 | no       |
      | AMS Forensics                               | no       |
      | AMS Alerts                                  | no       |
      | vDirect                                     | no       |
      | GEL Dashboard                               | yes      |
      | EAAF Dashboard                              | yes      |
      | VISION SETTINGS                             | yes      |
    * UI Logout

  @SID_12
  Scenario: Device Operator
    When UI Login with user "device_operator" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | no       |
      | APM                                         | yes      |
      | DPM                                         | yes      |
      | ANALYTICS ADC                               | yes      |
      | ANALYTICS AMS                               | yes      |
      | DefensePro Behavioral Protections Dashboard | yes      |
      | HTTPS Flood Dashboard                       | yes      |
      | DefensePro Analytics Dashboard              | yes      |
      | DefensePro Monitoring Dashboard             | yes      |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | yes      |
      | AMS Reports                                 | yes      |
      | AMS Forensics                               | yes      |
      | AMS Alerts                                  | yes      |
      | vDirect                                     | no       |
      | GEL Dashboard                               | yes      |
      | EAAF Dashboard                              | yes      |
      | VISION SETTINGS                             | yes      |
    * UI Logout

     #  Vdirect should not be display as  mentioned in table from user Guid
  @SID_13
  Scenario: Device Viewer
    When UI Login with user "device_viewer" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | yes      |
      | APM                                         | no       |
      | DPM                                         | yes      |
      | ANALYTICS ADC                               | yes      |
      | ANALYTICS AMS                               | no       |
      | DefensePro Behavioral Protections Dashboard | no       |
      | HTTPS Flood Dashboard                       | no       |
      | DefensePro Analytics Dashboard              | no       |
      | DefensePro Monitoring Dashboard             | no       |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | no       |
      | AMS Reports                                 | no       |
      | AMS Forensics                               | no       |
      | AMS Alerts                                  | no       |
      | vDirect                                     | no       |
      | GEL Dashboard                               | yes      |
      | EAAF Dashboard                              | yes      |
      | VISION SETTINGS                             | yes      |
    * UI Logout


   #  Vdirect should not be display as  mentioned in table from user Guid
  @SID_14
  Scenario: Real server Operator
    When UI Login with user "real_server_operator" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | no       |
      | APM                                         | no       |
      | DPM                                         | no       |
      | ANALYTICS ADC                               | no       |
      | ANALYTICS AMS                               | no       |
      | DefensePro Behavioral Protections Dashboard | no       |
      | HTTPS Flood Dashboard                       | no       |
      | DefensePro Analytics Dashboard              | no       |
      | DefensePro Monitoring Dashboard             | no       |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | no       |
      | AMS Reports                                 | no       |
      | AMS Forensics                               | no       |
      | AMS Alerts                                  | no       |
      | vDirect                                     | no       |
      | GEL Dashboard                               | no       |
      | EAAF Dashboard                              | no       |
      | VISION SETTINGS                             | yes      |
    * UI Logout

  @SID_15
  Scenario: Security Administrator
    When UI Login with user "security_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | yes      |
      | APM                                         | no       |
      | DPM                                         | no       |
      | ANALYTICS ADC                               | no       |
      | ANALYTICS AMS                               | yes      |
      | DefensePro Behavioral Protections Dashboard | yes      |
      | HTTPS Flood Dashboard                       | yes      |
      | DefensePro Analytics Dashboard              | yes      |
      | DefensePro Monitoring Dashboard             | yes      |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | yes      |
      | AMS Reports                                 | yes      |
      | AMS Forensics                               | yes      |
      | AMS Alerts                                  | yes      |
      | vDirect                                     | no       |
      | GEL Dashboard                               | no       |
      | EAAF Dashboard                              | yes      |
      | VISION SETTINGS                             | yes      |
    * UI Logout

  @SID_16
  Scenario: Security Monitor
    When UI Login with user "security_monitor" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | yes      |
      | APM                                         | no       |
      | DPM                                         | no       |
      | ANALYTICS ADC                               | no       |
      | ANALYTICS AMS                               | yes      |
      | DefensePro Behavioral Protections Dashboard | yes      |
      | HTTPS Flood Dashboard                       | yes      |
      | DefensePro Analytics Dashboard              | yes      |
      | DefensePro Monitoring Dashboard             | yes      |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | yes      |
      | AMS Reports                                 | yes      |
      | AMS Forensics                               | yes      |
      | AMS Alerts                                  | yes      |
      | vDirect                                     | no       |
      | GEL Dashboard                               | no       |
      | EAAF Dashboard                              | yes      |
      | VISION SETTINGS                             | yes      |
    * UI Logout

  @SID_17
  Scenario: User Administrator
    When UI Login with user "user_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | no       |
      | APM                                         | no       |
      | DPM                                         | no       |
      | ANALYTICS ADC                               | no       |
      | ANALYTICS AMS                               | no       |
      | DefensePro Behavioral Protections Dashboard | no       |
      | HTTPS Flood Dashboard                       | no       |
      | DefensePro Analytics Dashboard              | no       |
      | DefensePro Monitoring Dashboard             | no       |
      | DefenseFlow Analytics Dashboard             | no       |
      | AppWall Dashboard                           | no       |
      | AMS Reports                                 | no       |
      | AMS Forensics                               | no       |
      | AMS Alerts                                  | no       |
      | vDirect                                     | no       |
      | GEL Dashboard                               | no       |
      | EAAF Dashboard                              | no       |
      | VISION SETTINGS                             | yes      |
    * UI Logout

  @SID_18
  Scenario: Vision Administrator
    When UI Login with user "vision_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | yes      |
      | APM                                         | yes      |
      | DPM                                         | yes      |
      | ANALYTICS ADC                               | yes      |
      | ANALYTICS AMS                               | yes      |
      | DefensePro Behavioral Protections Dashboard | yes      |
      | HTTPS Flood Dashboard                       | yes      |
      | DefensePro Analytics Dashboard              | yes      |
      | DefensePro Monitoring Dashboard             | yes      |
      | DefenseFlow Analytics Dashboard             | yes      |
      | AppWall Dashboard                           | yes      |
      | AMS Reports                                 | yes      |
      | AMS Forensics                               | yes      |
      | AMS Alerts                                  | yes      |
      | vDirect                                     | yes      |
      | GEL Dashboard                               | yes      |
      | EAAF Dashboard                              | yes      |
      | VISION SETTINGS                             | yes      |
    * UI Logout

  @SID_19
  Scenario: Vision Reporter
    When UI Login with user "vision_reporter" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | AVR                                         | yes      |
      | APM                                         | yes      |
      | DPM                                         | yes      |
      | ANALYTICS ADC                               | yes      |
      | ANALYTICS AMS                               | yes      |
      | DefensePro Behavioral Protections Dashboard | yes      |
      | HTTPS Flood Dashboard                       | yes      |
      | DefensePro Analytics Dashboard              | yes      |
      | DefensePro Monitoring Dashboard             | yes      |
      | DefenseFlow Analytics Dashboard             | yes      |
      | AppWall Dashboard                           | yes      |
      | AMS Reports                                 | yes      |
      | AMS Forensics                               | yes      |
      | AMS Alerts                                  | yes      |
      | vDirect                                     | no       |
      | GEL Dashboard                               | yes      |
      | EAAF Dashboard                              | yes      |
      | VISION SETTINGS                             | yes      |
    * UI Logout


  @SID_20
  Scenario Outline: Delete All Users
    Given UI Login with user "sys_admin" and password "radware"
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
