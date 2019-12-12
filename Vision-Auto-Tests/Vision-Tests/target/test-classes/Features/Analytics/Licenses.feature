@VRM @TC106016
@License_validation
Feature: VRM License validation
####   AMS And ADC

  @SID_1
  Scenario: Login UI
    When UI Login with user "sys_admin" and password "radware"

#   The Following Scenarios , are deprecated , because was covered under AVA Max Attack Capacity and AVA Appwall Licenses


#  @SID_2
#  Scenario: Remove AMS license and validate error message Analytics
#    Given REST Vision DELETE License Request "vision-reporting-module-AMS"
#    Given REST Vision DELETE License Request "vision-AVA"
#    And UI Open Upper Bar Item "AMS"
#    And UI Open "Dashboards" Tab
#    And UI Open "DP Analytics" Sub Tab negative
#    Then UI Validate Popup Dialog Box, have value "Functionality Restricted Due to Limited License" with text Type "CAPTION"
#    Given UI Open "Configurations" Tab
#
#  @SID_3
#  Scenario: Remove AMS license and validate error message Baseline
#    And UI Open Upper Bar Item "AMS"
#    And UI Open "Dashboards" Tab
#    And UI Open "DP DNS Baseline" Sub Tab negative
#    Then UI Validate Popup Dialog Box, have value "Functionality Restricted Due to Limited License" with text Type "CAPTION"
#    Given UI Open "Configurations" Tab
#
#  @SID_4
#  Scenario: Remove AMS license and validate error message Alerts
#    And UI Open Upper Bar Item "AMS"
#    And UI Open "Alerts" Tab negative
#    Then UI Validate Popup Dialog Box, have value "Functionality Restricted Due to Limited License" with text Type "CAPTION"
#    Given UI Open "Configurations" Tab
#
#  @SID_5
#  Scenario: Remove AMS license and validate error message Forensic
#    And UI Open Upper Bar Item "AMS"
#    And UI Open "Forensics" Tab negative
#    Then UI Validate Popup Dialog Box, have value "Functionality Restricted Due to Limited License" with text Type "CAPTION"
#    Given UI Open "Configurations" Tab
#
#  @SID_6
#  Scenario: Add AMS License and validate no error message
#    Given UI Open "Configurations" Tab
#    When REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    And UI Open Upper Bar Item "AMS"
#    And UI Open "Forensics" Tab
#    And UI Open "Alerts" Tab
#    And UI Open "Dashboards" Tab
#    And UI Open "DP Analytics" Sub Tab
#    And UI Open "Dashboards" Tab
#    And UI Open "DP Monitoring Dashboard" Sub Tab
#    And UI Open "Dashboards" Tab
#    Then UI Open "DP BDoS Baseline" Sub Tab
#    Then UI Open "Configurations" Tab

  @SID_7
  Scenario: Remove ADC license and validate error message
    * REST Vision DELETE License Request "vision-reporting-module-ADC"
    * UI Open Upper Bar Item "ADC" negative
    * UI Validate Popup Dialog Box, have value "Functionality Restricted Due to Limited License" with text Type "CAPTION"
#    * UI Click Web element with id "gwt-debug-Dialog_Box_Close"

  @SID_8
  Scenario: Remove ADC license and validate error message Application Dashboard
    * UI Open "Configurations" Tab
    * UI Open Upper Bar Item "ADC" negative
    * UI Validate Popup Dialog Box, have value "Functionality Restricted Due to Limited License" with text Type "CAPTION"
#    * UI Click Web element with id "gwt-debug-Dialog_Box_Close"
    * UI Open "Dashboards" Tab
    * UI Validate Element Existence By Label "Application Dashboard" if Exists "false"

  @SID_9
  Scenario: Remove ADC license and validate error message Application Dashboard
    * UI Open "Configurations" Tab
    * UI Open Upper Bar Item "ADC" negative
    * UI Validate Popup Dialog Box, have value "Functionality Restricted Due to Limited License" with text Type "CAPTION"
#    * UI Click Web element with id "gwt-debug-Dialog_Box_Close"
    * UI Open "Dashboards" Tab
    * UI Validate Element Existence By Label "System & Network Dashboard" if Exists "false"

  @SID_10
  Scenario: Add ADC License and validate no error message
    * UI Open "Configurations" Tab
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    When UI Open Upper Bar Item "ADC"

  @SID_11
  Scenario: Add ADC license and validate no error message for Application Dashboard
    Given UI Open "Configurations" Tab
    When UI Open Upper Bar Item "ADC"
    And UI Open "Dashboards" Tab
    And UI Open "Application Dashboard" Sub Tab

  @SID_12
  Scenario: Add ADC license and validate no error message for Network and System Dashboard
    Given UI Open "Configurations" Tab
    When UI Open Upper Bar Item "ADC"
    And UI Open "Dashboards" Tab
    And UI Open "Network and System Dashboard" Sub Tab
    Given UI Open "Configurations" Tab

  @SID_13
  Scenario: Logout
    * UI logout and close browser

