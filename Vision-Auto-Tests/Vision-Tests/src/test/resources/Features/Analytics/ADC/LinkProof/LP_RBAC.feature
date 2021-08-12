@TC121727
Feature: LinkProof RBAC

  @SID_1
  Scenario: Login And Go to Vision
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.6.5.0-DD-1.00-10.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.6.5.0-DD-1.00-10.jar" on "ROOT_SERVER_CLI" with timeOut 240
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    Then UI Login with user "radware" and password "radware"
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
  Scenario: Validate DF not appears for adc_admin_certificate
    Given UI Login with user "adc_admin_certificate" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | yes       |

  @SID_6
  Scenario: Go into system dashboard and validate device have LinkProof tab for adc_admin_certificate user
    When UI Navigate to "System and Network Dashboard" page via homePage
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | All |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "LP_simulator_101"
    Then UI Validate Element Existence By Label "LinkProofTab" if Exists "true" with value "LinkProof"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "false"
    Then UI Click Button "LinkProofTab"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "true"

    ## add scenario to Add Report


  @SID_7
  Scenario: Validate DF not appears for adc_admin
    Given UI Login with user "adc_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | yes       |

  @SID_8
  Scenario: Go into system dashboard and validate device have LinkProof tab for adc_admin user
    When UI Navigate to "System and Network Dashboard" page via homePage
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | All |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "LP_simulator_101"
    Then UI Validate Element Existence By Label "LinkProofTab" if Exists "true" with value "LinkProof"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "false"
    Then UI Click Button "LinkProofTab"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "true"

    ## add scenario to Add Report

  @SID_9
  Scenario: Validate DF not appears for adc_operator
    Given UI Login with user "adc_operator" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | yes       |

  @SID_10
  Scenario: Go into system dashboard and validate device have LinkProof tab for adc_operator user
    When UI Navigate to "System and Network Dashboard" page via homePage
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | All |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "LP_simulator_101"
    Then UI Validate Element Existence By Label "LinkProofTab" if Exists "true" with value "LinkProof"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "false"
    Then UI Click Button "LinkProofTab"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "true"
    ## add scenario to Add Report


  @SID_11
  Scenario: Validate DF not appears for certificate_admin
    Given UI Login with user "certificate_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | no       |

    ## add scenario to Add Report



  @SID_12
  Scenario: Validate DF not appears for device_admin
    Given UI Login with user "device_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | yes       |

  @SID_13
  Scenario: Go into system dashboard and validate device have LinkProof tab for device_admin user
    When UI Navigate to "System and Network Dashboard" page via homePage
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | All |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "LP_simulator_101"
    Then UI Validate Element Existence By Label "LinkProofTab" if Exists "true" with value "LinkProof"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "false"
    Then UI Click Button "LinkProofTab"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "true"

    ## add scenario to Add Report

  @SID_14
  Scenario: Validate DF not appears for device_configurator
    Given UI Login with user "device_configurator" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | yes       |

  @SID_15
  Scenario: Go into system dashboard and validate device have LinkProof tab for device_configuration user
    When UI Navigate to "System and Network Dashboard" page via homePage
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | All |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "LP_simulator_101"
    Then UI Validate Element Existence By Label "LinkProofTab" if Exists "true" with value "LinkProof"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "false"
    Then UI Click Button "LinkProofTab"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "true"

    ## add scenario to Add Report

  @SID_16
  Scenario: Validate DF not appears for device_operator
    Given UI Login with user "device_operator" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | yes       |

  @SID_17
  Scenario: Go into system dashboard and validate device have LinkProof tab for device_operator user
    When UI Navigate to "System and Network Dashboard" page via homePage
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | All |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "LP_simulator_101"
    Then UI Validate Element Existence By Label "LinkProofTab" if Exists "true" with value "LinkProof"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "false"
    Then UI Click Button "LinkProofTab"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "true"

    ## add scenario to Add Report

  @SID_18
  Scenario: Validate DF not appears for device_viewer
    Given UI Login with user "device_viewer" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | yes       |

  @SID_19
  Scenario: Go into system dashboard and validate device have LinkProof tab for device_viewer user
    When UI Navigate to "System and Network Dashboard" page via homePage
    Given UI Click Button "Device Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | All |
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "LP_simulator_101"
    Then UI Validate Element Existence By Label "LinkProofTab" if Exists "true" with value "LinkProof"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "false"
    Then UI Click Button "LinkProofTab"
    Then UI Validate the attribute "data-debug-checked" Of Label "LinkProofTab" is "EQUALS" to "true"
    ## add scenario to Add Report


  @SID_20
  Scenario: Validate DF not appears for real_server_operator
    Given UI Login with user "real_server_operator" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | no       |

    ## add scenario to Add Report

  @SID_21
  Scenario: Validate DF not appears for security_admin
    Given UI Login with user "security_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | no       |

    ## add scenario to Add Report

  @SID_22
  Scenario: Validate DF not appears for security_monitor
    Given UI Login with user "security_monitor" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | no       |

    ## add scenario to Add Report

  @SID_23
  Scenario: Validate DF not appears for user_admin
    Given UI Login with user "user_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | no       |

    ## add scenario to Add Report

  @SID_24
  Scenario: Validate DF not appears for vision_admin
    Given UI Login with user "vision_admin" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | yes       |

    ## add scenario to Add Report

  @SID_25
  Scenario: Validate DF not appears for vision_reporter
    Given UI Login with user "vision_reporter" and password "Radware1234!@#$"
    Then UI Validate user rbac
      | operations                                  | accesses |
      | ANALYTICS ADC                               | yes       |

    ## add scenario to Add Report



  @SID_26
  Scenario: Login And Go to Vision to change Authentication Mode
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision
    Then UI Navigate to page "System->User Management->Authentication Mode"
    Then UI Select "TACACS+" from Vision dropdown "Authentication Mode"
    Then UI Click Button "Submit"


  @SID_27
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression                                    | isExpected   |
      | ALL     | fatal                                         | NOT_EXPECTED |
      | JBOSS   | Not authorized operation launched by the user | IGNORE       |
