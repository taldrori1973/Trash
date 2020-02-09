@TC111765 @Test1
Feature: Report With Customized Options

  @SID_1
  Scenario: Run DP simulator
    * REST Delete ES index "dp-attack*"
    * CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10
    * CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 11 with attack ID
    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @SID_2
  Scenario: Login and Navigate to Reports
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_3
  Scenario: Create and validate new Report with logo existence and show tables
    Then UI "Create" Report With Name "New Report with Logo"
      | reportType         | DefensePro Analytics Dashboard               |
      | Customized Options | addLogo: reportLogoPNG.png ,  showTable:true |
    Then UI Generate and Validate Report With Name "New Report with Logo" with Timeout of 300 Seconds
    And UI Click Button "Log Preview" with value "New Report with Logo"
    Then UI Validate Element Existence By Label "Logo Exist" if Exists "true" with value "reportLogoPNG"
    Then UI Validate Element Existence By Label "Table Exist" if Exists "true"
    Then UI Validate Number Of Elements Label "Table Exist" With Params "" If Equal to 12

  @SID_4
  Scenario: Validate message with invalid size logo
    And UI Click Button "Add New"
    And UI Click Button "Customized Options"
    And Upload file "invalidSizePngReportLogo.png"
    Then UI Validate Text field "Logo Size Message" CONTAINS "The graphic file that you selected is invalid. Select a 100×100-pixel .png file and try again"

  @SID_5
  Scenario: Delete report and close browser
    When UI Click Button "Delete" with value "New Report with Logo"
    When UI Click Button "Delete.Approve"
    Then UI Validate Element Existence By Label "Reports List Item" if Exists "false" with value "New Report with Logo"
    Then UI logout and close browser





