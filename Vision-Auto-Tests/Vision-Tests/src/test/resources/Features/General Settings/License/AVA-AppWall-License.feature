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


  @SID_2
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"


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
    Then UI Open "Configurations" Tab
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
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


  @SID_7
  Scenario: Validate No AVA-AppWall License When AVA-AMS-Attack-Capacity License Installed
    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then Validate License "AVA_APPWALL_LICENSE" Parameters
      | valid | false |

  @SID_8
  Scenario:UI Validate No AVA-AppWall License When AVA-AMS-Attack-Capacity License Installed
    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Open "Configurations" Tab
    When UI Open Upper Bar Item "AMS"
    Then UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "AppWall Dashboard" if Exists "false"
#    Validate Reports Navigation
    Given UI Open "Reports" Tab
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "AppWall Template" if Exists "false"


#    Validate Forensics Navigation
    When UI Open "Forensics" Tab
    Then UI Validate Element Existence By Label "Add" if Exists "true"

#    Validate Alerts Navigation
    When UI Open "Alerts" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"


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
    When UI Open "Configurations" Tab
    And UI Open Upper Bar Item "AMS"
    And UI Open "Dashboards" Tab
    And UI Open "AppWall Dashboard" Sub Tab
    Then UI Validate Text field "Title" EQUALS "AppWall Dashboard"


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


    #    Validate Reports Navigation
    Given UI Open "Reports" Tab
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "AppWall Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "false"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "false"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "false"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "false"


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
    When UI Open "Configurations" Tab
    And UI Open Upper Bar Item "AMS"
    And UI Open "Dashboards" Tab
    And UI Open "AppWall Dashboard" Sub Tab
    Then UI Validate Text field "Title" EQUALS "AppWall Dashboard"


    Then UI Open "Dashboards" Tab
    Then UI Validate Element Existence By Label "DP Monitoring Dashboard" if Exists "true"


      #    Validate DefensePro Behavioral Protections Dashboard Navigation
    Then UI Validate Element Existence By Label "DP BDoS Baseline" if Exists "true"



#    Validate DefensePro Analytics Dashboard Navigation
    Then UI Validate Element Existence By Label "DP Analytics" if Exists "true"

#    Validate HTTPS Flood Dashboard Navigation
    Then UI Validate Element Existence By Label "HTTPS Flood Dashboard" if Exists "true"


#    Validate DefenseFlow Analytics Dashboard Navigation
    Then UI Validate Element Existence By Label "DefenseFlow Analytics Dashboard" if Exists "true"



     #    Validate Reports Navigation
    Given UI Open "Reports" Tab
    When UI Click Button "Add New"
    Then UI Click Button "Template" with value ""
    And UI Validate Element Existence By Label "AppWall Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Analytics Template" if Exists "true"
    And UI Validate Element Existence By Label "DefensePro Behavioral Protections Template" if Exists "true"
    And UI Validate Element Existence By Label "HTTPS Flood Template" if Exists "true"
    And UI Validate Element Existence By Label "DefenseFlow Analytics Template" if Exists "true"
#    Validate Forensics Navigation
    When UI Open "Forensics" Tab
    Then UI Validate Element Existence By Label "Add" if Exists "true"

#    Validate Alerts Navigation
    When UI Open "Alerts" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"


  @SID_22
  Scenario: Logout
    Then UI logout and close browser