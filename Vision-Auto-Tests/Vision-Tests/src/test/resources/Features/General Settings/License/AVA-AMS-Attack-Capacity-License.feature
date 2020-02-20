#By MohamadI
@TC110252
Feature: US62031 APSolute Vision Analytics - AMS - Attack Capacity License

  @TC110252-Rest
  @SID_1

  Scenario: Setup - Restore Server Status as After Upgrade without AVA License
    Given REST Vision DELETE License Request "vision-AVA-6-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-20-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-60-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-400-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-Max-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-AppWall"
    And REST Vision DELETE License Request "vision-demo"

    And REST Vision Install License Request "vision-reporting-module-AMS"

    When Set Server Last Upgrade Time to 0 Days Back From Now
    When Set AVA_Grace_Period_Status to In Grace Period

    Then Service Vision restart and Wait 1 Minute

  @TC110252-Rest
  @SID_3

  Scenario: Validate First Day of Grace Period
    When Set Server Last Upgrade Time to 0 Days Back From Now

    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 0                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | requiredDevicesAttackCapacityGbps | 18                                                                                                                                                                                                                                                                                                                                                                                                                                                |
      | licensedDefenseProDeviceIpsList   | [172.16.22.50,172.16.22.51,172.16.22.55]                                                                                                                                                                                                                                                                                                                                                                                                          |
      | hasDemoLicense                    | false                                                                                                                                                                                                                                                                                                                                                                                                                                             |
      | attackCapacityMaxLicenseExist     | false                                                                                                                                                                                                                                                                                                                                                                                                                                             |
      | licenseViolated                   | true                                                                                                                                                                                                                                                                                                                                                                                                                                              |
      | inGracePeriod                     | true                                                                                                                                                                                                                                                                                                                                                                                                                                              |
      | message                           | License Violation: The attack capacity required by devices managed by APSolute Vision exceeds the value permitted by the APSolute Vision Analytics - AMS license. Contact Radware Technical Support to purchase another license with more capacity within 30 days. After 30 days, the system will only support the attack capacity corresponding to the license. If there is no APSolute Vision Analytics - AMS license, AVA will be unavailable. |
      | timeToExpiration                  | 30                                                                                                                                                                                                                                                                                                                                                                                                                                                |

    And Validate DefenseFlow is Licensed by Attack Capacity License
    And Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |


  @SID_4
  Scenario:UI Validate First Day of Grace Period
    Given UI Login with user "sys_admin" and password "radware"
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


#    Validate Message
    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "License Violation: The attack capacity required by devices managed by APSolute Vision exceeds the value permitted by the APSolute Vision Analytics - AMS license. Contact Radware Technical Support to purchase another license with more capacity within 30 days. After 30 days, the system will only support the attack capacity corresponding to the license. If there is no APSolute Vision Analytics - AMS license, AVA will be unavailable."
    Then UI Click Button by Class "ant-notification-notice-close"

#    Validate Device List
    When UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

#    Validate DefensePro Behavioral Protections Dashboard Navigation

    When UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Behavioral Protections"

#    Validate DefensePro Analytics Dashboard Navigation

    When UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics"

#    Validate HTTPS Flood Dashboard Navigation

    When UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "HTTPS Flood"

  #    Validate DefenseFlow Analytics Dashboard Navigation

    When UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefenseFlow Analytics"

    #    Validate NO AppWall Dashboard Navigation

    Then Validate Navigation to "AppWall Dashboard" is disabled

#    Validate Reports Navigation
    When UI Navigate to "AMS Reports" page via homePage
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Add"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"

#    Validate Alerts Navigation
    When UI Navigate to "AMS Alerts" page via homePage
    And UI Click Button "Add New"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"

    Then UI Logout
  @TC110252-Rest
  @SID_5
  Scenario: Validate Grace Period of day 29

    When Set Server Last Upgrade Time to 1 Days Back From Now

    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 0                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | requiredDevicesAttackCapacityGbps | 18                                                                                                                                                                                                                                                                                                                                                                                                                          |
      | licensedDefenseProDeviceIpsList   | [172.16.22.50,172.16.22.51,172.16.22.55]                                                                                                                                                                                                                                                                                                                                                                                    |
      | hasDemoLicense                    | false                                                                                                                                                                                                                                                                                                                                                                                                                       |
      | attackCapacityMaxLicenseExist     | false                                                                                                                                                                                                                                                                                                                                                                                                                       |
      | licenseViolated                   | true                                                                                                                                                                                                                                                                                                                                                                                                                        |
      | inGracePeriod                     | true                                                                                                                                                                                                                                                                                                                                                                                                                        |
      | message                           | The attack capacity required by devices managed by APSolute Vision exceeds the permitted value by the APSolute Vision Analytics - AMS license. Contact Radware Technical Support to purchase another license with more capacity within 29 days. In 29 days, the system will only support the attack capacity corresponding to the license. If there is no APSolute Vision Analytics - AMS license, AVA will be unavailable. |
      | timeToExpiration                  | 29                                                                                                                                                                                                                                                                                                                                                                                                                          |

    And Validate DefenseFlow is Licensed by Attack Capacity License
    And Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_6
  Scenario: UI Validate Grace Period of day 29
    Given UI Login with user "sys_admin" and password "radware"
    Given UI Navigate to "HOME" page via homePage
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


#    Validate Message
    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "The attack capacity required by devices managed by APSolute Vision exceeds the permitted value by the APSolute Vision Analytics - AMS license. Contact Radware Technical Support to purchase another license with more capacity within 29 days. In 29 days, the system will only support the attack capacity corresponding to the license. If there is no APSolute Vision Analytics - AMS license, AVA will be unavailable."
    Then UI Click Button by Class "ant-notification-notice-close"

#    Validate Device List
    When UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

#    Validate DefensePro Behavioral Protections Dashboard Navigation

    When UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Behavioral Protections"

#    Validate DefensePro Analytics Dashboard Navigation

    When UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics"

#    Validate HTTPS Flood Dashboard Navigation

    When UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "HTTPS Flood"

  #    Validate DefenseFlow Analytics Dashboard Navigation

    When UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefenseFlow Analytics"

    #    Validate NO AppWall Dashboard Navigation

    Then Validate Navigation to "AppWall Dashboard" is disabled

#    Validate Reports Navigation
    When UI Navigate to "AMS Reports" page via homePage
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Add"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"

#    Validate Alerts Navigation
    When UI Navigate to "AMS Alerts" page via homePage
    And UI Click Button "Add New"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"
    Then UI Logout

  @TC110252-Rest
  @SID_7
  Scenario: Validate Grace Period of day 2

    When Set Server Last Upgrade Time to 28 Days Back From Now

    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 0                                                                                                                                                                                                                                                                                                                                                                                                                         |
      | requiredDevicesAttackCapacityGbps | 18                                                                                                                                                                                                                                                                                                                                                                                                                        |
      | licensedDefenseProDeviceIpsList   | [172.16.22.50,172.16.22.51,172.16.22.55]                                                                                                                                                                                                                                                                                                                                                                                  |
      | hasDemoLicense                    | false                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | attackCapacityMaxLicenseExist     | false                                                                                                                                                                                                                                                                                                                                                                                                                     |
      | licenseViolated                   | true                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | inGracePeriod                     | true                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | message                           | The attack capacity required by devices managed by APSolute Vision exceeds the permitted value by the APSolute Vision Analytics - AMS license. Contact Radware Technical Support to purchase another license with more capacity within 2 days. In 2 days, the system will only support the attack capacity corresponding to the license. If there is no APSolute Vision Analytics - AMS license, AVA will be unavailable. |
      | timeToExpiration                  | 2                                                                                                                                                                                                                                                                                                                                                                                                                         |

    And Validate DefenseFlow is Licensed by Attack Capacity License
    And Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_8
  Scenario: UI Validate Grace Period of day 2
    Given UI Login with user "sys_admin" and password "radware"
    Given UI Navigate to "HOME" page via homePage
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


#    Validate Message
    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "The attack capacity required by devices managed by APSolute Vision exceeds the permitted value by the APSolute Vision Analytics - AMS license. Contact Radware Technical Support to purchase another license with more capacity within 2 days. In 2 days, the system will only support the attack capacity corresponding to the license. If there is no APSolute Vision Analytics - AMS license, AVA will be unavailable."
    Then UI Click Button by Class "ant-notification-notice-close"

#    Validate Device List
    When UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

#    Validate DefensePro Behavioral Protections Dashboard Navigation

    When UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Behavioral Protections"

#    Validate DefensePro Analytics Dashboard Navigation

    When UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics"

#    Validate HTTPS Flood Dashboard Navigation

    When UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "HTTPS Flood"

  #    Validate DefenseFlow Analytics Dashboard Navigation

    When UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefenseFlow Analytics"

    #    Validate NO AppWall Dashboard Navigation

    Then Validate Navigation to "AppWall Dashboard" is disabled

#    Validate Reports Navigation
    When UI Navigate to "AMS Reports" page via homePage
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Add"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"

#    Validate Alerts Navigation
    When UI Navigate to "AMS Alerts" page via homePage
    And UI Click Button "Add New"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"
    Then UI Logout

  @TC110252-Rest
  @SID_9
  
  Scenario: Validate in Grace Period of Last Day
    When Set Server Last Upgrade Time to 29 Days Back From Now

    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 0                                                                                                                                                                                  |
      | requiredDevicesAttackCapacityGbps | 18                                                                                                                                                                                 |
      | licensedDefenseProDeviceIpsList   | [172.16.22.50,172.16.22.51,172.16.22.55]                                                                                                                                           |
      | hasDemoLicense                    | false                                                                                                                                                                              |
      | attackCapacityMaxLicenseExist     | false                                                                                                                                                                              |
      | licenseViolated                   | true                                                                                                                                                                               |
      | inGracePeriod                     | true                                                                                                                                                                               |
      | message                           | APSolute Vision Analytics - AMS license will expire within 1 day. Renew the license using the Radware customer portal, or contact Radware Technical Support to purchase a license. |
      | timeToExpiration                  | 1                                                                                                                                                                                  |

    And Validate DefenseFlow is Licensed by Attack Capacity License
    And Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_10
  
  Scenario: UI Validate in Grace Period of Last Day
    Given UI Login with user "sys_admin" and password "radware"
    Given UI Navigate to "HOME" page via homePage
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


#    Validate Message
    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "APSolute Vision Analytics - AMS license will expire within 1 day. Renew the license using the Radware customer portal, or contact Radware Technical Support to purchase a license."
    Then UI Click Button by Class "ant-notification-notice-close"

#    Validate Device List
    When UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

#    Validate DefensePro Behavioral Protections Dashboard Navigation

    When UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Behavioral Protections"

#    Validate DefensePro Analytics Dashboard Navigation

    When UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics"

#    Validate HTTPS Flood Dashboard Navigation

    When UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "HTTPS Flood"

  #    Validate DefenseFlow Analytics Dashboard Navigation

    When UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefenseFlow Analytics"

    #    Validate NO AppWall Dashboard Navigation

    Then Validate Navigation to "AppWall Dashboard" is disabled

#    Validate Reports Navigation
    When UI Navigate to "AMS Reports" page via homePage
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Add"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"

#    Validate Alerts Navigation
    When UI Navigate to "AMS Alerts" page via homePage
    And UI Click Button "Add New"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"
    Then UI Logout

#------------------------------------License Expired-----------------------------------------
  @SID_11

  @TC110252-Rest
  Scenario: Validate Grace Period Expiration
    When Set Server Last Upgrade Time to 30 Days Back From Now

    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 0                    |
      | requiredDevicesAttackCapacityGbps | 18                   |
      | licensedDefenseProDeviceIpsList   | []                   |
      | hasDemoLicense                    | false                |
      | attackCapacityMaxLicenseExist     | false                |
      | licenseViolated                   | true                 |
      | inGracePeriod                     | false                |
      | message                           | Insufficient License |
      | timeToExpiration                  | -1                   |

    And Validate DefenseFlow is NOT Licensed by Attack Capacity License
    And Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_12
  Scenario: UI Validate Grace Period Expiration
    Given UI Login with user "sys_admin" and password "radware"
    Given UI Navigate to "HOME" page via homePage
    Then Validate Navigation to "DefensePro Monitoring Dashboard" is disabled
    Then Validate Navigation to "DefensePro Behavioral Protections Dashboard" is disabled
    Then Validate Navigation to "DefensePro Analytics Dashboard" is disabled
    Then Validate Navigation to "HTTPS Flood Dashboard" is disabled
    Then Validate Navigation to "DefenseFlow Analytics Dashboard" is disabled
    Then Validate Navigation to "AppWall Dashboard" is disabled
    Then Validate Navigation to "AMS Reports" is disabled
    Then Validate Navigation to "AMS Forensics" is disabled
    Then Validate Navigation to "AMS Alerts" is disabled
    Then UI Logout


#-----------------------New License--------------------------------------------
  @TC110252-Rest
  @SID_13


  Scenario: Validate License of 6 Gbps When All Devices Are with Capacity of 6 Gbps
    Given REST Vision Install License Request "vision-AVA-6-Gbps-attack-capacity"
    And Change Platform Type of DefensePro by IP "172.16.22.50" to "DefensePro 6"
    And Change Platform Type of DefensePro by IP "172.16.22.51" to "DefensePro 6"
    And Change Platform Type of DefensePro by IP "172.16.22.55" to "Virtual"

    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 6                    |
      | requiredDevicesAttackCapacityGbps | 18                   |
      | licensedDefenseProDeviceIpsList   | [172.16.22.50]       |
      | hasDemoLicense                    | false                |
      | attackCapacityMaxLicenseExist     | false                |
      | licenseViolated                   | true                 |
      | inGracePeriod                     | false                |
      | message                           | Insufficient License |

    And Validate DefenseFlow is Licensed by Attack Capacity License
    And Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_14


  Scenario: UI Validate License of 6 Gbps When All Devices Are with Capacity of 6 Gbps
    Given UI Login with user "sys_admin" and password "radware"
    Given UI Navigate to "HOME" page via homePage
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "Insufficient License"
    Then UI Click Button by Class "ant-notification-notice-close"

    When UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "true" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "true" with value "172.16.22.55"

        #    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Behavioral Protections"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "HTTPS Flood"


     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefenseFlow Analytics"

    #    Validate NO AppWall Dashboard Navigation
    Then Validate Navigation to "AppWall Dashboard" is disabled


#    Validate Reports Navigation
    When UI Navigate to "AMS Reports" page via homePage
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Add"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"

#    Validate Alerts Navigation
    When UI Navigate to "AMS Alerts" page via homePage
    And UI Click Button "Add New"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"
    Then UI Logout

  @TC110252-Rest
  @SID_15
  Scenario: Validate License of 20 Gbps When All Devices Are with Capacity of 6 Gbps
    Given REST Vision DELETE License Request "vision-AVA-6-Gbps-attack-capacity"
    Given REST Vision Install License Request "vision-AVA-20-Gbps-attack-capacity"
    And Change Platform Type of DefensePro by IP "172.16.22.50" to "DefensePro 6"
    And Change Platform Type of DefensePro by IP "172.16.22.51" to "DefensePro 6"
    And Change Platform Type of DefensePro by IP "172.16.22.55" to "Virtual"

    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 20                                       |
      | requiredDevicesAttackCapacityGbps | 18                                       |
      | licensedDefenseProDeviceIpsList   | [172.16.22.50,172.16.22.51,172.16.22.55] |
      | hasDemoLicense                    | false                                    |
      | attackCapacityMaxLicenseExist     | false                                    |
      | licenseViolated                   | false                                    |
      | inGracePeriod                     | false                                    |
      | message                           | null                                     |

    And Validate DefenseFlow is Licensed by Attack Capacity License
    And Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_16
  Scenario: UI Validate License of 20 Gbps When All Devices Are with Capacity of 6 Gbps
    Given UI Login with user "sys_admin" and password "radware"
    Given UI Navigate to "HOME" page via homePage
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


#    Validate Device List
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"
    #    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "DefensePro Behavioral Protections"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "HTTPS Flood"


     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "DefenseFlow Analytics"

    #    Validate NO AppWall Dashboard Navigation
    Then Validate Navigation to "AppWall Dashboard" is disabled


#    Validate Reports Navigation
    When UI Navigate to "AMS Reports" page via homePage
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Add"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"

#    Validate Alerts Navigation
    When UI Navigate to "AMS Alerts" page via homePage
    And UI Click Button "Add New"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"
    Then UI Logout

  @TC110252-Rest
  @SID_17
  Scenario: Validate License of 20 Gbps When First Device Capacity is 60 Gbps
    Given REST Vision DELETE License Request "vision-AVA-6-Gbps-attack-capacity"
    Given REST Vision Install License Request "vision-AVA-20-Gbps-attack-capacity"
    And Change Platform Type of DefensePro by IP "172.16.22.50" to "DefensePro 60"
    And Change Platform Type of DefensePro by IP "172.16.22.51" to "DefensePro 6"
    And Change Platform Type of DefensePro by IP "172.16.22.55" to "Virtual"

    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 20                          |
      | requiredDevicesAttackCapacityGbps | 72                          |
      | licensedDefenseProDeviceIpsList   | [172.16.22.51,172.16.22.55] |
      | hasDemoLicense                    | false                       |
      | attackCapacityMaxLicenseExist     | false                       |
      | licenseViolated                   | true                        |
      | inGracePeriod                     | false                       |
      | message                           | Insufficient License        |

    And Validate DefenseFlow is Licensed by Attack Capacity License
    And Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_18
  Scenario: UI Validate License of 20 Gbps When First Device Capacity is 60 Gbps
    Given UI Login with user "sys_admin" and password "radware"
    Given UI Navigate to "HOME" page via homePage
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

#    Validate Message
    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "Insufficient License"
    Then UI Click Button by Class "ant-notification-notice-close"

#    Validate Device List
    When UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "true" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

 #    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Behavioral Protections"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "HTTPS Flood"


     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefenseFlow Analytics"

    #    Validate NO AppWall Dashboard Navigation
    Then Validate Navigation to "AppWall Dashboard" is disabled


#    Validate Reports Navigation
    When UI Navigate to "AMS Reports" page via homePage
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Add"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"

#    Validate Alerts Navigation
    When UI Navigate to "AMS Alerts" page via homePage
    And UI Click Button "Add New"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"
    Then UI Logout

  @TC110252-Rest
  @SID_19
  Scenario: Validate Max License
    Given REST Vision DELETE License Request "vision-AVA-6-Gbps-attack-capacity"
    Given REST Vision DELETE License Request "vision-AVA-20-Gbps-attack-capacity"
    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And Change Platform Type of DefensePro by IP "172.16.22.50" to "DefensePro 400"
    And Change Platform Type of DefensePro by IP "172.16.22.51" to "DefensePro 200"
    And Change Platform Type of DefensePro by IP "172.16.22.55" to "Virtual"

    Then Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 606                                      |
      | requiredDevicesAttackCapacityGbps | 606                                      |
      | licensedDefenseProDeviceIpsList   | [172.16.22.50,172.16.22.51,172.16.22.55] |
      | hasDemoLicense                    | false                                    |
      | attackCapacityMaxLicenseExist     | true                                     |
      | licenseViolated                   | false                                    |
      | inGracePeriod                     | false                                    |
      | message                           | null                                     |

    And Validate DefenseFlow is Licensed by Attack Capacity License
    And Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_20
  Scenario: UI Validate Max License
    Given UI Login with user "sys_admin" and password "radware"
    Given UI Navigate to "HOME" page via homePage
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


#    Validate Device List
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"


 #    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "DefensePro Behavioral Protections"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "HTTPS Flood"


     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "DefenseFlow Analytics"

    #    Validate NO AppWall Dashboard Navigation
    Then Validate Navigation to "AppWall Dashboard" is disabled


#    Validate Reports Navigation
    When UI Navigate to "AMS Reports" page via homePage
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Add"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"

#    Validate Alerts Navigation
    When UI Navigate to "AMS Alerts" page via homePage
    And UI Click Button "Add New"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "false"
    Then UI Logout

  @TC110252-Rest
  @SID_21
  Scenario: Tear Down
    Then REST Vision DELETE License Request "vision-AVA-6-Gbps-attack-capacity"
    Then REST Vision DELETE License Request "vision-AVA-20-Gbps-attack-capacity"
    Then REST Vision DELETE License Request "vision-AVA-60-Gbps-attack-capacity"
    Then REST Vision DELETE License Request "vision-AVA-400-Gbps-attack-capacity"
    Then REST Vision DELETE License Request "vision-AVA-Max-attack-capacity"
    Then REST Vision DELETE License Request "vision-reporting-module-AMS"

    Then Change Platform Type of DefensePro by IP "172.16.22.50" to "DefensePro 6"
    Then Change Platform Type of DefensePro by IP "172.16.22.51" to "DefensePro 6"
    Then Change Platform Type of DefensePro by IP "172.16.22.55" to "Virtual"

  @SID_23
  Scenario: Validate Demo License for DP/DF Dashboards
    Given REST Vision Install License Request "vision-demo"
    When Validate License "ATTACK_CAPACITY_LICENSE" Parameters
      | allowedAttackCapacityGbps         | 0                                        |
      | requiredDevicesAttackCapacityGbps | 18                                       |
      | licensedDefenseProDeviceIpsList   | [172.16.22.50,172.16.22.51,172.16.22.55] |
      | hasDemoLicense                    | true                                     |
      | attackCapacityMaxLicenseExist     | false                                    |
      | licenseViolated                   | true                                     |
      | inGracePeriod                     | false                                    |
      | message                           | Insufficient License                     |

    And Validate DefenseFlow is Licensed by Attack Capacity License
    And Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | true |

    Given UI Login with user "sys_admin" and password "radware"
    Given UI Navigate to "HOME" page via homePage
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


#    Validate Device List
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

 #    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Behavioral Protections"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Navigate to "HTTPS Flood Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "HTTPS Flood"


     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Navigate to "DefenseFlow Analytics Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefenseFlow Analytics"

   #    Validate AppWall Dashboard Navigation
    When UI Navigate to "AppWall Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "AppWall"

#    Validate Reports Navigation
    When UI Navigate to "AMS Reports" page via homePage
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "true"


#    Validate Forensics Navigation
    When UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Add"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "true"

#    Validate Alerts Navigation
    When UI Navigate to "AMS Alerts" page via homePage
    And UI Click Button "Add New"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "true"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "true"
    Then REST Vision DELETE License Request "vision-demo"
    Then UI Logout

  @SID_22

  Scenario: close browser
    Then UI close browser