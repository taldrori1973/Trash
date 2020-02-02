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

    And REST Vision Install License Request "vision-reporting-module-AMS"

    When Set Server Last Upgrade Time to 0 Days Back From Now
    When Set AVA_Grace_Period_Status to In Grace Period

    Then Service Vision restart and Wait 1 Minute

  @SID_2
  @run
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"


  @TC110252-Rest
  @SID_3
  @run
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
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab

#    Validate Message
    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "License Violation: The attack capacity required by devices managed by APSolute Vision exceeds the value permitted by the APSolute Vision Analytics - AMS license. Contact Radware Technical Support to purchase another license with more capacity within 30 days. After 30 days, the system will only support the attack capacity corresponding to the license. If there is no APSolute Vision Analytics - AMS license, AVA will be unavailable."

#    Validate Device List
    When UI Click Button by Class "ant-notification-notice-close"
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

#    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP BDoS Baseline" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Dashboard"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP Analytics" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics Dashboard"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "HTTPS Flood Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "header HTTPS" EQUALS "HTTPS Flood Dashboard"

  #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DefenseFlow Analytics Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Header" EQUALS "DefenseFlow Analytics Dashboard"

    #    Validate NO AppWall Dashboard Navigation
    When UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "AppWall Dashboard" if Exists "false"


#    Validate Reports Navigation
    Given UI Open "Reports" Tab
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Open "Forensics" Tab
    Then UI Validate Element Existence By Label "Add" if Exists "true"

#    Validate Alerts Navigation
    When UI Open "Alerts" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

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
    Then UI Open "Configurations" Tab
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab

    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "The attack capacity required by devices managed by APSolute Vision exceeds the permitted value by the APSolute Vision Analytics - AMS license. Contact Radware Technical Support to purchase another license with more capacity within 29 days. In 29 days, the system will only support the attack capacity corresponding to the license. If there is no APSolute Vision Analytics - AMS license, AVA will be unavailable."

    When UI Click Button by Class "ant-notification-notice-close"
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

    #    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP BDoS Baseline" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Dashboard"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP Analytics" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics Dashboard"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "HTTPS Flood Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "header HTTPS" EQUALS "HTTPS Flood Dashboard"

     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DefenseFlow Analytics Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Header" EQUALS "DefenseFlow Analytics Dashboard"

    #    Validate NO AppWall Dashboard Navigation
    When UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "AppWall Dashboard" if Exists "false"


#    Validate Reports Navigation
    Given UI Open "Reports" Tab
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Open "Forensics" Tab
    Then UI Validate Element Existence By Label "Add" if Exists "true"

#    Validate Alerts Navigation
    When UI Open "Alerts" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

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
    Then UI Open "Configurations" Tab
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab

    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "The attack capacity required by devices managed by APSolute Vision exceeds the permitted value by the APSolute Vision Analytics - AMS license. Contact Radware Technical Support to purchase another license with more capacity within 2 days. In 2 days, the system will only support the attack capacity corresponding to the license. If there is no APSolute Vision Analytics - AMS license, AVA will be unavailable."

    When UI Click Button by Class "ant-notification-notice-close"
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

    #    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP BDoS Baseline" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Dashboard"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP Analytics" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics Dashboard"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "HTTPS Flood Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "header HTTPS" EQUALS "HTTPS Flood Dashboard"

     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DefenseFlow Analytics Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Header" EQUALS "DefenseFlow Analytics Dashboard"

  #    Validate NO AppWall Dashboard Navigation
    When UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "AppWall Dashboard" if Exists "false"


#    Validate Reports Navigation
    Given UI Open "Reports" Tab
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Open "Forensics" Tab
    Then UI Validate Element Existence By Label "Add" if Exists "true"

#    Validate Alerts Navigation
    When UI Open "Alerts" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

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
    Then UI Open "Configurations" Tab
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab

    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "APSolute Vision Analytics - AMS license will expire within 1 day. Renew the license using the Radware customer portal, or contact Radware Technical Support to purchase a license."

    When UI Click Button by Class "ant-notification-notice-close"
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

       #    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP BDoS Baseline" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Dashboard"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP Analytics" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics Dashboard"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "HTTPS Flood Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "header HTTPS" EQUALS "HTTPS Flood Dashboard"

     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DefenseFlow Analytics Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Header" EQUALS "DefenseFlow Analytics Dashboard"

    #    Validate NO AppWall Dashboard Navigation
    When UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "AppWall Dashboard" if Exists "false"


#    Validate Reports Navigation
    Given UI Open "Reports" Tab
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Open "Forensics" Tab
    Then UI Validate Element Existence By Label "Add" if Exists "true"

#    Validate Alerts Navigation
    When UI Open "Alerts" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

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
    Then UI Open "Configurations" Tab
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab
#    Scope Selection
    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "Insufficient License"

    When UI Click Button by Class "ant-notification-notice-close"
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "true" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "true" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "true" with value "172.16.22.55"

#    Validate Tabs
    Then UI Open "Dashboards" Tab
    Then UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "DP Monitoring Dashboard" if Exists "false"


      #    Validate DefensePro Behavioral Protections Dashboard Navigation
    Then UI Validate Element Existence By Label "DP BDoS Baseline" if Exists "false"



#    Validate DefensePro Analytics Dashboard Navigation
    Then UI Validate Element Existence By Label "DP Analytics" if Exists "false"

#    Validate HTTPS Flood Dashboard Navigation
    Then UI Validate Element Existence By Label "HTTPS Flood Dashboard" if Exists "false"


#    Validate DefenseFlow Analytics Dashboard Navigation
    Then UI Validate Element Existence By Label "DefenseFlow Analytics Dashboard" if Exists "false"


#    Validate AppWall Dashboard Navigation
    Then UI Validate Element Existence By Label "AppWall Dashboard" if Exists "false"



#    Validate Reports Navigation
    When UI Open "Reports" Tab negative
    Then UI Validate Text field by id "gwt-debug-Dialog_Box_Caption" EQUALS "Functionality Restricted Due to Limited License"
    Then UI Validate Text field by id "gwt-debug-Dialog_Box_Message" EQUALS "The functionality that you have requested requires a license."
    Then UI Click Button by id "gwt-debug-Dialog_Box_Close"
#    Validate Forensics Navigation
    When UI Open "Forensics" Tab negative
    Then UI Validate Text field by id "gwt-debug-Dialog_Box_Caption" EQUALS "Functionality Restricted Due to Limited License"
    Then UI Validate Text field by id "gwt-debug-Dialog_Box_Message" EQUALS "The functionality that you have requested requires a license."
    Then UI Click Button by id "gwt-debug-Dialog_Box_Close"
#    Validate Alerts Navigation
    When UI Open "Alerts" Tab negative
    Then UI Validate Text field by id "gwt-debug-Dialog_Box_Caption" EQUALS "Functionality Restricted Due to Limited License"
    Then UI Validate Text field by id "gwt-debug-Dialog_Box_Message" EQUALS "The functionality that you have requested requires a license."
    Then UI Click Button by id "gwt-debug-Dialog_Box_Close"

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
    Then UI Open "Configurations" Tab
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab

    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "Insufficient License"

    When UI Click Button by Class "ant-notification-notice-close"
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "true" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "true" with value "172.16.22.55"

        #    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP BDoS Baseline" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Dashboard"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP Analytics" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics Dashboard"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "HTTPS Flood Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "header HTTPS" EQUALS "HTTPS Flood Dashboard"


     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DefenseFlow Analytics Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Header" EQUALS "DefenseFlow Analytics Dashboard"

    #    Validate NO AppWall Dashboard Navigation
    When UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "AppWall Dashboard" if Exists "false"


#    Validate Reports Navigation
    Given UI Open "Reports" Tab
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Open "Forensics" Tab
    Then UI Validate Element Existence By Label "Add" if Exists "true"

#    Validate Alerts Navigation
    When UI Open "Alerts" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

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
    Then UI Open "Configurations" Tab
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab


#    Validate Device List
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

#    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP BDoS Baseline" Sub Tab
    Then UI Validate Text field "Title" EQUALS "DefensePro Dashboard"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP Analytics" Sub Tab
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics Dashboard"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "HTTPS Flood Dashboard" Sub Tab
    Then UI Validate Text field "header HTTPS" EQUALS "HTTPS Flood Dashboard"


     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DefenseFlow Analytics Dashboard" Sub Tab
    Then UI Validate Text field "Header" EQUALS "DefenseFlow Analytics Dashboard"

   #    Validate NO AppWall Dashboard Navigation
    When UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "AppWall Dashboard" if Exists "false"


#    Validate Reports Navigation
    Given UI Open "Reports" Tab
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Open "Forensics" Tab
    Then UI Validate Element Existence By Label "Add" if Exists "true"

#    Validate Alerts Navigation
    When UI Open "Alerts" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

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
    Then UI Open "Configurations" Tab
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab

#    Validate Message
    Then UI Validate Text field with Class "ant-notification-notice-message" "Equals" To "Insufficient Attack-Capacity License"
    Then UI Validate Text field with Class "ant-notification-notice-description" "Equals" To "Insufficient License"

#    Validate Device List
    When UI Click Button by Class "ant-notification-notice-close"
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "true" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

#    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP BDoS Baseline" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Dashboard"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP Analytics" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics Dashboard"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "HTTPS Flood Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "header HTTPS" EQUALS "HTTPS Flood Dashboard"


     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DefenseFlow Analytics Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Header" EQUALS "DefenseFlow Analytics Dashboard"

    #    Validate NO AppWall Dashboard Navigation
    When UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "AppWall Dashboard" if Exists "false"


#    Validate Reports Navigation
    Given UI Open "Reports" Tab
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Open "Forensics" Tab
    Then UI Validate Element Existence By Label "Add" if Exists "true"

#    Validate Alerts Navigation
    When UI Open "Alerts" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

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
    Then UI Open "Configurations" Tab
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab


#    Validate Device List
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

#    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP BDoS Baseline" Sub Tab
    Then UI Validate Text field "Title" EQUALS "DefensePro Dashboard"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP Analytics" Sub Tab
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics Dashboard"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "HTTPS Flood Dashboard" Sub Tab
    Then UI Validate Text field "header HTTPS" EQUALS "HTTPS Flood Dashboard"
   #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DefenseFlow Analytics Dashboard" Sub Tab
    Then UI Validate Text field "Header" EQUALS "DefenseFlow Analytics Dashboard"

   #    Validate NO AppWall Dashboard Navigation
    When UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "AppWall Dashboard" if Exists "false"


#    Validate Reports Navigation
    Given UI Open "Reports" Tab
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Open "Forensics" Tab
    Then UI Validate Element Existence By Label "Add" if Exists "true"

#    Validate Alerts Navigation
    When UI Open "Alerts" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

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

    Then UI Open "Configurations" Tab
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Open "DP Monitoring Dashboard" Sub Tab


#    Validate Device List
    And UI Click Button "Device Selection"

    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.50" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.51" is "NOT CONTAINS" to "list-row-disabled"
    Then UI Validate the attribute "class" Of Label "Device Selection.Device List Item" With Params "172.16.22.55" is "NOT CONTAINS" to "list-row-disabled"

    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.50"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.51"
    Then UI Validate Element Existence By Label "Device Selection.Device Insufficient License" if Exists "false" with value "172.16.22.55"

#    Validate DefensePro Behavioral Protections Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP BDoS Baseline" Sub Tab
    Then UI Validate Text field "Title" EQUALS "DefensePro Dashboard"

#    Validate DefensePro Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DP Analytics" Sub Tab
    Then UI Validate Text field "Title" EQUALS "DefensePro Analytics Dashboard"

#    Validate HTTPS Flood Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "HTTPS Flood Dashboard" Sub Tab
    Then UI Validate Text field "header HTTPS" EQUALS "HTTPS Flood Dashboard"

     #    Validate DefenseFlow Analytics Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "DefenseFlow Analytics Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Header" EQUALS "DefenseFlow Analytics Dashboard"

   #    Validate AppWall Dashboard Navigation
    When UI Open "Dashboards" Tab
    When UI Open "AppWall Dashboard" Sub Tab
    When UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "AppWall Dashboard"

#    Validate Reports Navigation
    When UI Open "Reports" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

#    Validate Forensics Navigation
    When UI Open "Forensics" Tab
    Then UI Validate Element Existence By Label "Add" if Exists "true"

#    Validate Alerts Navigation
    When UI Open "Alerts" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_22
  @run
  Scenario: Logout
    Then UI logout and close browser