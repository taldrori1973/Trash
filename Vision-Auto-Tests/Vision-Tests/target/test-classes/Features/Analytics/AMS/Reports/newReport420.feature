Feature: new report


  Scenario: login
    Given UI Login with user "radware" and password "radware"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Reports" Tab
    And CLI simulate 1 attacks of type "rest_dos" on "DefensePro" 10
    And CLI simulate 1 attacks of type "rest_anomalies" on "DefensePro" 10 and wait 22 seconds
  Given CLI simulate 0 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 10 with loopDelay 15000
  Given CLI simulate 0 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 11 with loopDelay 15000
  Given CLI simulate 0 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 20 with loopDelay 15000
  Given CLI simulate 0 attacks of type "rest_traffic_diff_Policy15out" on "DefensePro" 21 with loopDelay 15000 and wait 120 seconds



  Scenario: validate error message without report name
    When UI Click Button "Add New"
    When UI Click Button "Submit"
    Then UI Validate Text field "Error Title" EQUALS "Unable to submit form"
    Then UI Validate Text field "Error Message" EQUALS "To submit, you must fill in all marked fields*"
    When UI Click Button "Error Ok"
    When UI Click Button "Close"

  Scenario: validate error message with report name
    When UI Click Button "Add New"
    When UI Set Text Field "Wizard Report Name" To "Error"
    When UI Click Button "Scope Selection"
    When UI Click Button "Submit"
    Then UI Validate Text field "Error Title" EQUALS "Unable to submit form"
    Then UI Validate Text field "Error Message" EQUALS "To submit, you must fill in all marked fields*"
    When UI Click Button "Error Ok"
    When UI Click Button "Close"


  Scenario: Validate Expand
    When UI Click Button "Add New"
    Then UI Validate Expand
    When UI Click Button "Cancel"


  Scenario: VRM Reports - Scope Selection
    Given UI "Create" Report With Name "new"
      | devices | index:10,ports:[1],policies:[BDOS] |
    When UI Validate Element Existence By Label "Reports List Item" if Exists "true" with value "new"
    Then UI "Validate" Report With Name "new"
      | devices | index:10,ports:[1],policies:[BDOS] |

  Scenario: Validate Scope Selection Search
    Then UI Validate Scope Selection Search With Element Type "DefensePro" And Device index 10


  Scenario: VRM Reports - Time Selection - Quick Range
    Given UI "Create" Report With Name "new"
      | Time Definitions.Date | Quick:15m |
    Then UI "Validate" Report With Name "new"
      | Time Definitions.Date | Quick:15m |


  Scenario: VRM Reports - Time Selection - Absolute
    Given UI "Create" Report With Name "new"
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +1d] |
    Then UI "Validate" Report With Name "new"
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +1d] |


  Scenario: VRM Reports - Time Selection - Absolute - To date less than from date - Negative Test
    Given UI "Create" Report With Name "new"
      | Time Definitions.Date | Absolute:[Today, -1d] |
    Then UI Validate Text field "Error Title" EQUALS "Unable to submit form"
    Then UI Validate Text field "Error Message" EQUALS "To submit, you must fill in all marked fields*"
    When UI Click Button "Error Ok"
    When UI Click Button "Close"

  Scenario: AMS Reports - Validate Search Filter Via Text Of Element
    When UI Click Button "Add New"
    When UI Click Button "Template"
    When UI Click Button "DefensePro Analytics Template"
    Then UI Validate Search With Label: "Widget Select" and param: "Top Attacks by Duration" in Search Label "Widget Filter Default" if this elements exist take label text
    And UI Click Button "Widget Close"
    When UI Click Button "Discard Changes"
    Then UI Click Button "Cancel"

  Scenario: AMS Reports - Validate Search Filter With Expected Elements
    When UI Click Button "Add New"
    When UI Click Button "Template"
    When UI Click Button "DefensePro Analytics Template"
    Then UI Validate Search The Text "Top Attacks by" in Search Label "Widget Filter Default" if this elements exist
      | label         | param                    |
      | Widget Select | Top Attacks by Duration  |
      | Widget Select | Top Attacks by Bandwidth |
      | Widget Select | Top Attacks by Protocol  |
    And UI Click Button "Widget Close"
    When UI Click Button "Discard Changes"
    Then UI Click Button "Cancel"

  Scenario: AMS Reports - Validate Search Filter With Expected Elements Number
    When UI Click Button "Add New"
    When UI Click Button "Template"
    When UI Click Button "DefensePro Analytics Template"
    Then UI Validate Search Numbering With text: "Top Attacks by" And Element Label: "Widget Select" In Search Label "Widget Filter Default" If this equal to 3
    And UI Click Button "Widget Close"
    When UI Click Button "Discard Changes"
    Then UI Click Button "Cancel"

  Scenario: VRM Reports - Time Selection - Relative
    Given UI "Create" Report With Name "new"
      | Time Definitions.Date | Relative:[Hours,2] |
    Then UI "Validate" Report With Name "new"
      | Time Definitions.Date | Relative:[Hours,2] |


  Scenario: Create DefensePro Analytics Dashboard Report with all the widgets
    Given UI "Create" Report With Name "DeleteAllReport"
      | reportType | DefensePro Analytics Dashboard |
      | Design     | Delete:[ALL], Add:[ALL]        |
    Then UI Click Button "Widgets Selection Cancel"
    Then UI Click Button "Cancel"

  Scenario: Create Behavioral Protections Report with all the widgets
    Given UI "Create" Report With Name "aaaa"
      | reportType | DefensePro Behavioral Protections Dashboard |
      | Design     | Delete:[ALL], Add:[ALL]                     |
    Then UI Click Button "Widgets Selection Cancel"
    Then UI Click Button "Cancel"


  Scenario: Create DefensePro Analytics Dashboard Report with all the widgets
    Given UI "Create" Report With Name "DeleteAllReport"
      | reportType | DefensePro Analytics Dashboard                           |
      | Design     | Delete:[ALL], Add:[Top Attacks,Top Attacks by Bandwidth] |
    Then UI Click Button "Widgets Selection Cancel"
    Then UI Click Button "Cancel"


  Scenario: AMS Reports - Save widgets after click on Cancel button
    Given UI Validate Reports Design Drag and Drop
      | reportType | DefensePro Analytics Dashboard                          |
      | Design     | Add:[Top Attack Sources,Top Scanners,Traffic Bandwidth] |
    Then UI Click Button "Widgets Selection Cancel"
    Then UI Validate Text field "Confirm Save Title" EQUALS "Cancel"
    Then UI Validate Text field "Confirm Save Message" EQUALS "Cancel"





#  Scenario: VRM - enabling emailing and go to VRM Reports Tab
#    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    Given UI Login with user "radware" and password "radware"
#    And UI Go To Vision
#    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"
#    Then UI Do Operation "select" item "Email Reporting Configuration"
#    Then UI Set Checkbox "Enable" To "true"
#    Then UI Set Text Field "SMTP Server Address" To "176.200.120.120"
##    Then UI Set Text Field "SMTP User Name" To "qa_test@Radware.com"
#    Then UI Set Checkbox "Enable" To "false"
#    Then UI Click Button "Submit"
##    And UI Navigate to page "System->General Settings->APSolute Vision Analytics Settings->Email Reporting Configurations"
##    And UI Set Checkbox "Enable" To "true"
##    And UI Set Text Field "SMTP Server Address" To "176.200.120.120"
##    And UI Set Text Field "SMTP Port" To "25"
##    And UI Click Button "Submit"
#    And UI Open Upper Bar Item "AMS"
#    And UI Open "Reports" Tab
#
#
#
#  Scenario: share mail validate
#    When UI Click Button "Add New"
#    Given UI "Create" Report With Name "Mail"
#      | Share | Email:[automation.vision1@radware.com],Subject:report delivery Subject |
#    And UI Click Button "Views.Expand" with value "Mail"
#    And UI Click Button "Generate Now" with value "Mail"
#    Then UI Validate Report Mail With Subject "report delivery Subject" And Content ""
  #/////////////////////////////////////////////////////////////////////////////////////////////


  Scenario: Report Form Header with name
    When UI Click Button "Add New"
    When UI Set Text Field "Wizard Report Name" To "name"
    And UI Click Button "Arrow Toggle"
    Then UI validate arrow with label "Title Template" and params "" if "COLLAPSED"
    Then UI Validate Text field "Name Of Collapsed" EQUALS "name"
    When UI Click Button "Cancel"


  Scenario: Report Form Header without name
    When UI Click Button "Add New"
    And UI Click Button "Arrow Toggle"
    Then UI Validate the attribute "Class" Of Label "Collapsed Name" With Params "" is "CONTAINS" to "name-error"
    Then UI validate arrow with label "Title Template" and params "" if "COLLAPSED"
    When UI Click Button "Cancel"

