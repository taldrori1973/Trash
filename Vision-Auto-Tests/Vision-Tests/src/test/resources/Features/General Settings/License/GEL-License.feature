@TC108205

Feature: GEL-License

  @SID_1
  Scenario:  Activate Gel-License for 8 Months, and Verify Activation license Exist in license page
    Given CLI Run linux Command "iptables -L -n |grep -w tcp | grep -w "dpt:7070"" on "ROOT_SERVER_CLI" and validate result CONTAINS "ACCEPT"
    * REST Vision DELETE License Request "vision-reporting-module-ADC"
    * REST Vision Install License Request "vision-GEL" from date "-4M" to date "+4M"
    Given UI Login with user "radware" and password "radware"
    When UI Go To Vision
    When UI Navigate to page "System->General Settings->License Management"
    Then UI validate Vision Table row by keyValue with elementLabel "VisionLicense" findBy columnName "Item" findBy KeyValue "Right to use – manage unlimited additional virtual ADC devices"
      | columnName      | value | isDate |
      | Expiration Date | +4M   | true   |

  @SID_2
  Scenario: Verify that the user can Access to Analytics ADC with a GEL-License of 1 year.
    And UI Navigate to "ADC Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"
    And UI logout and close browser

  @SID_3
  Scenario: Verify that during the last 30 days to Expiration Date to GEL-License, Vision show License Alert.
    * REST Vision Install License Request "vision-GEL" from date "-4M" to date "+20d"
    Given UI Login with user "radware" and password "radware"
    Then UI Validate Popup Dialog Box, have value "The system is under a license violation:" with text Type "CAPTION"
    Then UI Validate Text field by id "gwt-debug-Dialog_Box_Message" CONTAINS "vision-GEL license will expire within 21 days. Contact Radware Support to purchase a new license."
    Then UI Click Button by id "gwt-uid-10"
    Then UI Click Button by id "gwt-debug-Dialog_Box_Confirm"


  @SID_4
  Scenario: Verify that during the last 30 days to Expiration Date to GEL-License, user can Access to Analytics ADC
    And UI Navigate to "ADC Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"
    And UI logout and close browser

  @SID_5
  Scenario: Verify that during the last 2 days to Expiration Date to GEL-License, Vision show License Alert.
    * REST Vision Install License Request "vision-GEL" from date "-4M" to date "+1d"
    Given UI Login with user "radware" and password "radware"
    Then UI Validate Popup Dialog Box, have value "The system is under a license violation:" with text Type "CAPTION"
    Then UI Validate Text field by id "gwt-debug-Dialog_Box_Message" CONTAINS "vision-GEL license will expire within 2 days"
    Then UI Click Button by id "gwt-uid-10"
    Then UI Click Button by id "gwt-debug-Dialog_Box_Confirm"


  @SID_6
  Scenario: Verify that during the last 2 days to Expiration Date to GEL-License, user can Access to Analytics ADC
    And UI Navigate to "ADC Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"
    Then UI logout and close browser

  @SID_7
  Scenario:  Activate Gel-License for 1 YEAR, and Verify Activation license Exist in license page
    * REST Vision Install License Request "vision-GEL" from date "-0d" to date "+12M"
    Given UI Login with user "radware" and password "radware"
    When UI Go To Vision
    When UI Navigate to page "System->General Settings->License Management"
    Then UI validate Vision Table row by keyValue with elementLabel "VisionLicense" findBy columnName "Item" findBy KeyValue "Right to use – manage unlimited additional virtual ADC devices"
      | columnName      | value | isDate |
      | Expiration Date | +12M  | true   |

  @SID_8
  Scenario: Verify that the user can Access to Analytics ADC
    And UI Navigate to "ADC Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"
    Then UI logout and close browser


  @SID_10
  Scenario: Remove ADC license and validate error message
    * REST Vision DELETE License Request "vision-reporting-module-ADC"
    * REST Vision DELETE License Request "vision-GEL"
    Given UI Login with user "radware" and password "radware"
    * UI Navigate to "ADC Reports" page via homePage
    * UI Validate Popup Dialog Box, have value "Functionality Restricted Due to Limited License" with text Type "CAPTION"
    * UI Navigate to "DEVICES CONFIGURATIONS" page via homePage
  @SID_9
  Scenario: Logout
    Then UI logout and close browser
