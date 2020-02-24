@VRM_Report2
@TC107944

Feature: create AMS Report New Form

  @SID_1
  Scenario: Login and navigate to the AMS Reports Wizard
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then CLI Run remote linux Command "mysql -prad123 vision_ng -e "select license_str,is_expired+0 from vision_license;"" on "ROOT_SERVER_CLI"
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
    Given UI Login with user "sys_admin" and password "radware"
    # to overcome license delayed reply
    Then Sleep "5"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_2
  Scenario: Add new AMS Report "New Report"
    Then UI "Create" Report With Name "New Report"
      | reportType            | DefensePro Analytics Dashboard                                                                  |
      | Design                | Add:[Traffic Bandwidth,Connections Rate,Top Attack Sources,Top Scanners,Top Attack Destination] |
      | devices               | index:10,ports:[1],policies:[BDOS]                                                              |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                             |
      | Format                | Select: HTML                                                                                    |

  @SID_3
  Scenario: Validate AMS Report "New Report"
    Then UI "Validate" Report With Name "New Report"
      | reportType            | DefensePro Analytics Dashboard                                                                      |
      | Design                | Widgets:[Top Attack Sources,Top Scanners,Traffic Bandwidth,Top Attack Destination,Connections Rate] |
      | devices               | index:10,ports:[1],policies:[BDOS]                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                 |
      | Format                | Select: HTML                                                                                        |

  @SID_4
  Scenario: Edit AMS Report "New Report", by changing the format
    Then UI "Edit" Report With Name "New Report"
      | Format | Select: PDF |

  @SID_5
  Scenario: Validate Report "New Report", after Edit format
    Then UI "Validate" Report With Name "New Report"
      | reportType            | DefensePro Analytics Dashboard                                                                      |
      | Design                | Widgets:[Top Attack Sources,Top Scanners,Traffic Bandwidth,Top Attack Destination,Connections Rate] |
      | devices               | index:10,ports:[1],policies:[BDOS]                                                                  |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                 |
      | Format                | Select: PDF                                                                                         |

  @SID_6
  Scenario: Validate Report Existence
    Then UI Validate VRM Report Existence by Name "New Report" if Exists "true"

  @SID_7
  Scenario: Add new Report "New Report2"
    Then UI "Create" Report With Name "New Report2"
      | reportType            | DefensePro Behavioral Protections Dashboard                                                                                                                    |
      | Design                | {"Add":[{"BDoS-TCP SYN":["pps","IPv6"]},"BDoS-TCP SYN ACK",{"BDoS-TCP FIN ACK":["pps","IPv6","Outbound"]},{"BDoS-UDP":["pps","IPv6","Outbound"]},"BDoS-ICMP"]} |
      | devices               | index:10,ports:[1],policies:[BDOS]                                                                                                                             |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                                                                                                            |
      | Format                | Select: CSV                                                                                                                                                    |

  @SID_8
  Scenario: Validate Report "New Report2"
    Then UI "Validate" Report With Name "New Report2"
      | reportType            | DefensePro Behavioral Protections Dashboard                                 |
      | Design                | Widgets:[BDoS-TCP SYN,BDoS-TCP SYN ACK,BDoS-TCP FIN ACK,BDoS-UDP,BDoS-ICMP] |
      | devices               | index:10,ports:[1],policies:[BDOS]                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                         |
      | Format                | Select: CSV                                                                 |

  @SID_9
  Scenario: Edit Report "New Report2", by changing the format
    Then UI "Edit" Report With Name "New Report2"
      | Format | Select: PDF |

  @SID_10
  Scenario: Validate Report "New Report2", after Edit format
    Then UI "Validate" Report With Name "New Report2"
      | reportType            | DefensePro Behavioral Protections Dashboard                                 |
      | Design                | Widgets:[BDoS-TCP SYN,BDoS-TCP SYN ACK,BDoS-TCP FIN ACK,BDoS-UDP,BDoS-ICMP] |
      | devices               | index:10,ports:[1],policies:[BDOS]                                          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]                                         |
      | Format                | Select: PDF                                                                 |

  @SID_11
  Scenario: Edit Report "New Report2", by changing Design
    Then UI "Edit" Report With Name "New Report2"
      | reportType | DefensePro Behavioral Protections Dashboard                  |
      | Design     | {"Add":[{"BDoS-TCP SYN":["pps","IPv6"]},"BDoS-TCP SYN ACK"]} |

  @SID_12
  Scenario: Validate Report "New Report2", after Edit Design
    Then UI "Validate" Report With Name "New Report2"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | Design                | Widgets:[BDoS-TCP SYN,BDoS-TCP SYN ACK]     |
      | devices               | index:10,ports:[1],policies:[BDOS]          |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]         |
      | Format                | Select: PDF                                 |

  @SID_13
  Scenario: Delete Reports
    Then UI Click Button "Delete" with value "New Report"
    Then UI Click Button "Delete.Approve"
    Then UI Click Button "Delete" with value "New Report2"
    Then UI Click Button "Delete.Approve"

  @SID_14
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression                                    | isExpected   |
      | ALL     | fatal                                         | NOT_EXPECTED |
      | JBOSS   | Not authorized operation launched by the user | IGNORE       |

  @SID_15
  Scenario: login
    Given UI Login with user "sys_admin" and password "radware"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Reports" Tab

  @SID_16
  Scenario: validate error message without report name
    When UI Click Button "Add New"
    When UI Click Button "Submit"
    Then UI Validate Text field "Error Title" EQUALS "Unable to submit form"
    Then UI Validate Text field "Error Message" EQUALS "To submit, you must fill in all marked fields*"
    When UI Click Button "Error Ok"
    When UI Click Button "Close"

  @SID_17
  Scenario: validate error message with report name
    When UI Click Button "Add New"
    When UI Set Text Field "Wizard Report Name" To "Error"
    When UI Click Button "Scope Selection"
    When UI Click Button "Submit"
    Then UI Validate Text field "Error Title" EQUALS "Unable to submit form"
    Then UI Validate Text field "Error Message" EQUALS "To submit, you must fill in all marked fields*"
    When UI Click Button "Error Ok"
    When UI Click Button "Close"

  @SID_18
  Scenario: Validate Expand
    When UI Click Button "Add New"
    Then UI Validate Expand
    When UI Click Button "Cancel"

  @SID_19
  Scenario: VRM Reports - Scope Selection
    Given UI "Create" Report With Name "new"
      | devices | index:10,ports:[1],policies:[BDOS] |
    When UI Validate Element Existence By Label "Reports List Item" if Exists "true" with value "new"
    Then UI "Validate" Report With Name "new"
      | devices | index:10,ports:[1],policies:[BDOS] |

  @SID_20
  Scenario: Validate Scope Selection Search
    Then UI Click Button "Edit" with value "new"
#    When UI "Edit" Report With Name "new"
    Then UI Validate Scope Selection Search With Element Type "DefensePro" And Device index 10

  @SID_21
  Scenario: VRM Reports - Time Selection - Quick Range
    Given UI "Create" Report With Name "new"
      | Time Definitions.Date | Quick:15m |
    Then UI "Validate" Report With Name "new"
      | Time Definitions.Date | Quick:15m |

  @SID_22
  Scenario: VRM Reports - Time Selection - Absolute
    Given UI "Create" Report With Name "new"
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d] |
    Then UI "Validate" Report With Name "new"
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d] |

  @SID_23
  Scenario: VRM Reports - Time Selection - Absolute - To date less than from date - Negative Test
    Given UI "Create" Report With Name "new"
      | Time Definitions.Date | Absolute:[Today, -1d] |

    Then UI Validate Text field "Error Title" EQUALS "Unable to submit form"
    Then UI Validate Text field "Error Message" EQUALS "To submit, you must fill in all marked fields*"
    Then UI Click Button "Error Ok"
#    Then UI Click Button "Close Message"
    Then UI Click Button "Close"

  @SID_24
  Scenario: AMS Reports - Validate Search Filter Via Text Of Element
    When UI Click Button "Add New"
    When UI Click Button "Select Template"
    When UI Click Button "DefensePro Analytics Template"
    Then UI Validate Search With Label: "Widget Select" and param: "Top Attacks by Duration" in Search Label "Widget Filter Default" if this elements exist take label text
    Then UI Click Button "Widget Close"
    Then UI Click Button "Discard Changes"
    Then UI Click Button "Cancel"

  @SID_25
  Scenario: AMS Reports - Validate Search Filter With Expected Elements
    When UI Click Button "Add New"
    When UI Click Button "Select Template"
    When UI Click Button "DefensePro Analytics Template"
    Then UI Validate Search The Text "Top Attacks by" in Search Label "Widget Filter Default" if this elements exist
      | label         | param                    |
      | Widget Select | Top Attacks by Duration  |
      | Widget Select | Top Attacks by Bandwidth |
      | Widget Select | Top Attacks by Protocol  |
    Then UI Click Button "Widget Close"
    Then UI Click Button "Discard Changes"
    Then UI Click Button "Cancel"

  @SID_26
  Scenario: AMS Reports - Validate Search Filter With Expected Elements Number
    When UI Click Button "Add New"
    When UI Click Button "Select Template"
    When UI Click Button "DefensePro Analytics Template"
    Then UI Validate Search Numbering With text: "Top Attacks by" And Element Label: "Widget Select" In Search Label "Widget Filter Default" If this equal to 3
    Then UI Click Button "Widget Close"
    Then UI Click Button "Discard Changes"
    Then UI Click Button "Cancel"

  @SID_27
  Scenario: VRM Reports - Time Selection - Relative
    Given UI "Create" Report With Name "new"
      | Time Definitions.Date | Relative:[Hours,2] |
    Then UI "Validate" Report With Name "new"
      | Time Definitions.Date | Relative:[Hours,2] |

  @SID_28
  Scenario: Create DefensePro Analytics Dashboard Report with all the widgets
    Given UI "Create" Report With Name "DeleteAllReport"
      | reportType | DefensePro Analytics Dashboard |
      | Design     | Delete:[ALL], Add:[ALL]        |
    Then UI Click Button "Widgets Selection Cancel"
    Then UI Click Button "Cancel"

  @SID_29
  Scenario: Create Behavioral Protections Report with all the widgets
    Given UI "Create" Report With Name "aaaa"
      | reportType | DefensePro Behavioral Protections Dashboard |
      | Design     | Delete:[ALL], Add:[ALL]                     |
#    Then UI Click Button "Widgets Selection Cancel"
#    Then UI Click Button "Cancel"

  @SID_30
  Scenario: Create DefensePro Analytics Dashboard Report with all the widgets
    Given UI "Create" Report With Name "DeleteAllReport"
      | reportType | DefensePro Analytics Dashboard                           |
      | Design     | Delete:[ALL], Add:[Top Attacks,Top Attacks by Bandwidth] |
#    Then UI Click Button "Widgets Selection Cancel"
#    Then UI Click Button "Cancel"

#  @SID_31
#  Scenario: AMS Reports - Save widgets after click on Cancel button
#    Given UI Validate Reports Design Drag and Drop
#      | reportType | DefensePro Analytics Dashboard                          |
#      | Design     | Add:[Top Attack Sources,Top Scanners,Traffic Bandwidth] |
#    Then UI Click Button "Widgets Selection Cancel"
#    Then UI Validate Text field "Confirm Save Title" EQUALS "Cancel"
#    Then UI Validate Text field "Confirm Save Message" EQUALS "Cancel"

  @SID_32
  Scenario: Report Form Header with name
    When UI Click Button "Add New"
    When UI Set Text Field "Wizard Report Name" To "name"
    And UI Click Button "Arrow Toggle"
    Then UI validate arrow with label "Title Template" and params "" if "COLLAPSED"
    Then UI Validate Text field "Name Of Collapsed" EQUALS "name"
    When UI Click Button "Cancel"

  @SID_33
  Scenario: Report Form Header without name
    When UI Click Button "Add New"
    And UI Click Button "Arrow Toggle"
    Then UI Validate the attribute "Class" Of Label "Collapsed Name" With Params "" is "CONTAINS" to "name-error"
    Then UI validate arrow with label "Title Template" and params "" if "COLLAPSED"
    When UI Click Button "Cancel"

  @SID_34
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression                                    | isExpected   |
      | ALL     | fatal                                         | NOT_EXPECTED |
      | JBOSS   | Not authorized operation launched by the user | IGNORE       |
