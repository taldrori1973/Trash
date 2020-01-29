@scale
Feature: Generate Scale Reports

  Scenario: Delete All Reports
    * REST Delete ES index "vrm-scheduled-report-*"
  Scenario: Login and Navigate to Reports
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"


  Scenario: Create New Report of DefensePro Analytics Dashboard with PDF Format
    Given UI "Create" Report With Name "PDF Analytics Scale"
      | reportType            | DefensePro Analytics Dashboard     |
      | Design                | Delete:[ALL], Add:[ALL]            |
      | Time Definitions.Date | Absolute:[01.01.2018 00:00:00,+0d] |

  Scenario: Create New Report of DefensePro Analytics Dashboard with HTML Format
    Given UI "Create" Report With Name "HTML Analytics Scale"
      | reportType            | DefensePro Analytics Dashboard     |
      | Design                | Delete:[ALL], Add:[ALL]            |
      | Time Definitions.Date | Absolute:[01.01.2018 00:00:00,+0d] |
      | Format                | Select: HTML                       |

  Scenario: Create New Report of DefensePro Analytics Dashboard with CSV Format
    Given UI "Create" Report With Name "CSV Analytics Scale"
      | reportType            | DefensePro Analytics Dashboard     |
      | Design                | Delete:[ALL], Add:[ALL]            |
      | Time Definitions.Date | Absolute:[01.01.2018 00:00:00,+0d] |
      | Format                | Select: CSV                        |


  Scenario: Create New Report of DefensePro Behavioral Protections Dashboard with PDF Format
    Given UI "Create" Report With Name "PDF Behavioral Scale"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | Design                | Delete:[ALL], Add:[ALL]                     |
      | Time Definitions.Date | Absolute:[01.01.2018 00:00:00,+0d]          |


  Scenario: Create New Report of DefensePro Behavioral Protections Dashboard with HTML Format
    Given UI "Create" Report With Name "HTML Behavioral Scale"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | Design                | Delete:[ALL], Add:[ALL]                     |
      | Time Definitions.Date | Absolute:[01.01.2018 00:00:00,+0d]          |
      | Format                | Select: HTML                                |


  Scenario: Create New Report of DefensePro Behavioral Protections Dashboard with CSV Format
    Given UI "Create" Report With Name "CSV Behavioral Scale"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | Design                | Delete:[ALL], Add:[ALL]                     |
      | Time Definitions.Date | Absolute:[01.01.2018 00:00:00,+0d]          |
      | Format                | Select: CSV                                 |


  Scenario: Generate Analytics Scale
    Then UI Generate and Validate Report With Name "PDF Analytics Scale" with Timeout of 18000 Seconds
    Then UI Generate and Validate Report With Name "HTML Analytics Scale" with Timeout of 18000 Seconds
    Then UI Generate and Validate Report With Name "CSV Analytics Scale" with Timeout of 18000 Seconds

  Scenario: Generate Behavioral Scale
    Then UI Generate and Validate Report With Name "PDF Behavioral Scale" with Timeout of 18000 Seconds
    Then UI Generate and Validate Report With Name "HTML Behavioral Scale" with Timeout of 18000 Seconds
    Then UI Generate and Validate Report With Name "CSV Behavioral Scale" with Timeout of 18000 Seconds