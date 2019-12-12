@VRM_Report2
@TC107945
Feature: Report Template Selection

  @SID_1
  Scenario: login and go to AMS reports
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Reports" Tab

  @SID_2
  Scenario: DefensePro Analytics Dashboard D&D 3 widgets
    Then UI Click Button "Add New"
    Given UI Validate Reports Design Drag and Drop
      | reportType | DefensePro Analytics Dashboard                          |
      | Design     | Add:[Top Attack Sources,Top Scanners,Traffic Bandwidth] |
    Then UI Validate Text field "Template Header" with params "DefensePro Analytics Dashboard" EQUALS "DefensePro Analytics Dashboard"
    #Then UI Validate Search Numbering With text: "T" And Element Label: "Widget Select" In Search Label "Widget Filter Custom" If this equal to 20

  @SID_3
  Scenario: Undo DefensePro Analytics Dashboard D&D 3 widgets using custom button.
    Then UI Undo Widgets with label "Widget Undo Custom"
      | Top Attack Sources |
      | Top Scanners       |
      | Traffic Bandwidth  |
    Then UI Click Button "Template Apply"
    Then UI Click Button "Cancel"

  @SID_4
  Scenario: DefensePro Analytics Dashboard D&D 5 widgets
    Then UI Click Button "Add New"
    Given UI Validate Reports Design Drag and Drop
      | reportType | DefensePro Analytics Dashboard                                                                  |
      | Design     | Add:[Top Attack Sources,Top Scanners,Traffic Bandwidth,Top Attack Destination,Connections Rate] |
    Then UI Validate Text field "Template Header" with params "DefensePro Analytics Dashboard" EQUALS "DefensePro Analytics Dashboard"

  @SID_5
  Scenario: Undo DefensePro Analytics Dashboard D&D 5 widgets
    Then UI Undo Widgets with label "Widget Undo"
      | Top Attack Sources     |
      | Top Scanners           |
      | Traffic Bandwidth      |
      | Top Attack Destination |
      | Connections Rate       |
    Then UI Click Button "Template Apply"
    Then UI Click Button "Cancel"


  @SID_6
  Scenario: DefensePro Analytics Dashboard D&D all widgets
    Then UI Click Button "Add New"
    Given UI Validate Reports Design Drag and Drop
      | reportType | DefensePro Analytics Dashboard |
      | Design     | Add:[ALL]                      |
    Then UI Validate Text field "Template Header" with params "DefensePro Analytics Dashboard" EQUALS "DefensePro Analytics Dashboard"

    Then UI Click Button "Undo All"
   # Then UI Validate Search Numbering With text: "" And Element Label: "Widget Select" In Search Label "Widget Filter Custom" If this equal to 0
    Then UI Click Button "Template Apply"
    Then UI Click Button "Cancel"

  @SID_7
  Scenario: DefensePro Behavioral Dashboard D&D 2 widgets with options.
    Then UI Click Button "Add New"
    Given UI Validate Reports Design Drag and Drop
      | reportType | DefensePro Behavioral Protections Dashboard                  |
      | Design     | {"Add":[{"BDoS-TCP SYN":["pps","IPv6"]},"BDoS-TCP SYN ACK"]} |
    Then UI Validate Text field "Template Header" with params "DefensePro Behavioral Protections Dashboard" EQUALS "DefensePro Behavioral Protections Dashboard"
    #Then UI Validate Search Numbering With text: "BDoS" And Element Label: "Widget Select" In Search Label "Widget Filter Custom" If this equal to 20

  @SID_8
  Scenario: Undo DefensePro Behavioral Dashboard D&D 2 widgets using custom button.
    Then UI Undo Widgets with label "Widget Undo Custom"
      | BDoS-TCP SYN ACK |
      | BDoS-TCP SYN     |
    Then UI Click Button "Template Apply"
    Then UI Click Button "Cancel"

  @SID_9
  Scenario: DefensePro Behavioral Dashboard D&D 5 widgets with options.
    Then UI Click Button "Add New"
    Given UI Validate Reports Design Drag and Drop
      | reportType | DefensePro Behavioral Protections Dashboard                                                                                                                    |
      | Design     | {"Add":[{"BDoS-TCP SYN":["pps","IPv6"]},"BDoS-TCP SYN ACK",{"BDoS-TCP FIN ACK":["pps","IPv6","Outbound"]},{"BDoS-UDP":["pps","IPv6","Outbound"]},"BDoS-ICMP"]} |
    Then UI Validate Text field "Template Header" with params "DefensePro Behavioral Protections Dashboard" EQUALS "DefensePro Behavioral Protections Dashboard"
   # Then UI Validate Search Numbering With text: "BDoS" And Element Label: "Widget Select" In Search Label "Widget Filter Custom" If this equal to 23

  @SID_10
  Scenario: Undo DefensePro Behavioral Dashboard D&D 5 widgets using custom button.
    Then UI Undo Widgets with label "Widget Undo Custom"
      | BDoS-TCP SYN     |
      | BDoS-TCP SYN ACK |
      | BDoS-TCP FIN ACK |
      | BDoS-UDP         |
      | BDoS-ICMP        |
    Then UI Click Button "Template Apply"
    Then UI Click Button "Cancel"

  @SID_11
  Scenario: DefensePro Behavioral Dashboard D&D all widgets
    Then UI Click Button "Add New"
    Given UI Validate Reports Design Drag and Drop
      | reportType | DefensePro Behavioral Protections Dashboard |
      | Design     | Add:[ALL]                                   |
    Then UI Validate Text field "Template Header" with params "DefensePro Behavioral Protections Dashboard" EQUALS "DefensePro Behavioral Protections Dashboard"
    Then UI Click Button "Undo All"
   # Then UI Validate Search Numbering With text: "" And Element Label: "Widget Select" In Search Label "Widget Filter Custom" If this equal to 0
    Then UI Click Button "Template Apply"
    Then UI Click Button "Cancel"

@SID_12
  Scenario: Cleanup
    Given UI logout and close browser
  * CLI Check if logs contains
    | logType | expression | isExpected   |
    | ALL     | fatal      | NOT_EXPECTED |