#By Mohamadi
@TC111827
Feature: US58313 APSolute Vision Analytics - AppWall - License

  @SID_1
  Scenario: Setup - Remove all AMS Licenses
    Given REST Vision DELETE License Request "vision-AVA-6-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-20-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-60-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-400-Gbps-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-Max-attack-capacity"
    And REST Vision DELETE License Request "vision-AVA-AppWall"
    And REST Vision DELETE License Request "vision-reporting-module-AMS"
    And REST Vision DELETE License Request "vision-demo"



  @SID_3
  Scenario:Validate No AVA-AppWall License
    Given REST Vision DELETE License Request "vision-AVA-AppWall"
    Then Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_4
  Scenario:UI Validate No AVA-AppWall License
    Given REST Vision DELETE License Request "vision-AVA-AppWall"
    Given UI Login with user "sys_admin" and password "radware"
    Then Validate Navigation to "AppWall Dashboard" is disabled
    Then Validate Navigation to "AMS Reports" is disabled
    Then Validate Navigation to "AMS Forensics" is disabled
    Then Validate Navigation to "AMS Alerts" is disabled
    Then UI Logout



  @SID_5
  Scenario: Validate No AVA-AppWall License When Legacy AMS License Installed
    Given REST Vision Install License Request "vision-reporting-module-AMS"
    Then Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_6
  Scenario: UI Validate No AVA-AppWall License When Legacy AMS License Installed
    Given REST Vision Install License Request "vision-reporting-module-AMS"
    Given UI Login with user "sys_admin" and password "radware"
    Then Validate Navigation to "AppWall Dashboard" is disabled
    Then Validate Navigation to "AMS Reports" is disabled
    Then Validate Navigation to "AMS Forensics" is disabled
    Then Validate Navigation to "AMS Alerts" is disabled
    Then UI Logout


  @SID_7
  Scenario: Validate No AVA-AppWall License When AVA-AMS-Attack-Capacity License Installed
    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_8
  Scenario:UI Validate No AVA-AppWall License When AVA-AMS-Attack-Capacity License Installed
    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given UI Login with user "sys_admin" and password "radware"
    Then Validate Navigation to "AppWall Dashboard" is disabled
    Then UI Logout


  @SID_9
  Scenario:Validate AVA-AppWall License is Valid When No AVA-AMS-Attack-Capacity License Installed
    Given REST Vision DELETE License Request "vision-AVA-Max-attack-capacity"
    Given REST Vision Install License Request "vision-AVA-AppWall"

    Then Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | true |

  @SID_10
  Scenario: UI Validate AVA-AppWall License is Valid When No AVA-AMS-Attack-Capacity License Installed
    Given REST Vision DELETE License Request "vision-AVA-Max-attack-capacity"
    And REST Vision Install License Request "vision-AVA-AppWall"
    Given UI Login with user "sys_admin" and password "radware"

   #    Validate AppWall Dashboard Navigation
    When UI Navigate to "AppWall Dashboard" page via homePage
    Then UI Click Button by Class "ant-notification-notice-close"
    Then UI Validate Text field "Title" EQUALS "AppWall"

    Then Validate Navigation to "DefensePro Monitoring Dashboard" is disabled
    Then Validate Navigation to "DefensePro Behavioral Protections Dashboard" is disabled
    Then Validate Navigation to "DefensePro Analytics Dashboard" is disabled
    Then Validate Navigation to "HTTPS Flood Dashboard" is disabled
    Then Validate Navigation to "DefenseFlow Analytics Dashboard" is disabled


    #    Validate Reports Navigation
    When UI Navigate to "AMS Reports" page via homePage
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "AppWall Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "false"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "false"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "false"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "false"

    #    Validate Forensics Navigation
    When UI Navigate to "AMS Forensics" page via homePage
    And UI Click Button "Add"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "false"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "false"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "true"

#    Validate Alerts Navigation
    When UI Navigate to "AMS Alerts" page via homePage
    And UI Click Button "Add New"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defensepro" is Enabled "false"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "defenseflow" is Enabled "false"
    Then UI Validate Element EnableDisable status By Label "Select Product" and Value "appwall" is Enabled "true"
    Then UI Logout


  @SID_11
  Scenario: Validate AVA-AppWall License is Valid When Both AVA-AppWall License AND AVA-AMS-Attack-Capacity License Installed
    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given REST Vision Install License Request "vision-AVA-AppWall"
    Then Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | true |

  @SID_12
  Scenario: UI Validate AVA-AppWall License is Valid When Both AVA-AppWall License AND AVA-AMS-Attack-Capacity License Installed
    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given REST Vision Install License Request "vision-AVA-AppWall"
    Given UI Login with user "sys_admin" and password "radware"
   #    Validate AppWall Dashboard Navigation
    When UI Navigate to "AppWall Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "AppWall"

    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Then UI Validate Text field "Title" EQUALS "DefensePro Monitoring"


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
    Then UI Logout
  @SID_22
  Scenario: close browser
    Then UI close browser