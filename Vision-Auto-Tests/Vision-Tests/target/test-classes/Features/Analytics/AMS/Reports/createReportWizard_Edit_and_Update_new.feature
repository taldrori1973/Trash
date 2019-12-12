@VRM_Report2 @TC106010

Feature: Report Wizard edit and update - new form

  @SID_1
  Scenario: Login and navigate to the Reports Wizard
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    When UI Add "DefensePro" with index 10 on "Default" site
    Then Sleep "5"
    When UI Open Upper Bar Item "AMS"
    When UI Open "Reports" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_2
  Scenario: VRM Reports - new Report VRM_Edit_and_Update
    # defualt New report
    Given UI "Create" Report With Name "Edit_and_Update_Test_report"
      | reportType            | DefensePro Analytics Dashboard     |
      | devices               | index:10,ports:[1],policies:[BDOS] |
      | Time Definitions.Date | Quick:Today                        |
      | Schedule              | Run Every:Monthly,On Time:+2m      |

    Given UI "Edit" Report With Name "Edit_and_Update_Test_report"
      | share  | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
      | Format | Select: PDF                                                          |

#    Then UI Click Button "Edit" with value "Edit_and_Update_Test_report"
##    Then UI Click Button "Delivery Step" with value "initial"
#    Then UI Click Button "Email Enable" with value "Email"
#    Then UI Set Text Field "Email Recipients" To "automation.vision1@radware.com"
#    Then UI Set Text Field "Send Email Subject" To "mySubject"
#    Then UI Set Text Field "Send Email Body" To "myBody"
#    Then UI Click Button "Report Format PDF" with value "PDF"
#   # Then UI Click Button "Summary Card" with value "initial"
#    Then UI Click Button "Submit" with value "Submit"


  @SID_3
  Scenario: VRM validate report details
    Then UI "Validate" Report With Name "Edit_and_Update_Test_report"
      | reportType            | DefensePro Analaytic Dashboard                                       |
      | devices               | index:10,ports:[1],policies:[BDOS]                                   |
      | Time Definitions.Date | Quick:Today                                                          |
      | Schedule              | Run Every:Monthly,On Time:+2m                                        |
      | share                 | Email:[automation.vision1@radware.com],Subject:mySubject,Body:myBody |
      | Format                | Select: PDF                                                          |

#    Then UI Click Button "Edit" with value "Edit_and_Update_Test_report"
#    Then UI Click Button "Summary Card" with value "initial"
#    Then UI Validate Text field "Summary.Delivery" CONTAINS "Format: pdf"
#    Then UI Click Button "Close"



    ################################################
    #           Devices Test Edit/Update           #
    ################################################

  @SID_4
  Scenario: VRM Reports - Two devices Devices Test Edit/Update
    Given UI "Edit" Report With Name "Edit_and_Update_Test_report"
      | devices | index:11,ports:[1],policies:[BDOS] |

    Then UI "Validate" Report With Name "Edit_and_Update_Test_report"
      | devices | index:11,ports:[1],policies:[BDOS] |


  @SID_5
  Scenario: VRM Reports - ALL devices Devices Test Edit/Update
    Given UI "Edit" Report With Name "Edit_and_Update_Test_report"
      | devices |  |

    Then UI "Validate" Report With Name "Edit_and_Update_Test_report"
      | devices |  |


  @SID_6
  Scenario: VRM Reports - Schedule edit
    Given UI "Edit" Report With Name "Edit_and_Update_Test_report"
      | Schedule | Run Every:Daily,On Time:+10m |

    Then UI "Validate" Report With Name "Edit_and_Update_Test_report"
      | Schedule | Run Every:Daily,On Time:+10m |


  @SID_7
  Scenario: VRM Reports - edit time definitions
    Given UI "Edit" Report With Name "Edit_and_Update_Test_report"
      | Time Definitions.Date | Quick:15m |

    Then UI "Validate" Report With Name "Edit_and_Update_Test_report"
      | Time Definitions.Date | Quick:15m |


  Scenario: TC102942 - VRM - edit Delivery
    Given UI "Edit" Report With Name "Edit_and_Update_Test_report"
      | Share | Email:[automation.vision2@radware.com],Subject:mySubjectEdit,Body:myBodyEdit |

    Then UI "Validate" Report With Name "Edit_and_Update_Test_report"
      | Share | Email:[automation.vision2@radware.com],Subject:mySubjectEdit,Body:myBodyEdit |


  Scenario: TC102943 - VRM - edit Delivery with more than one email
    Given UI "Edit" Report With Name "Edit_and_Update_Test_report"
      | Share | Email:[automation.vision2@radware.com],Subject:mySubjectEdit,Body:myBodyEdit |

    Then UI "Validate" Report With Name "Edit_and_Update_Test_report"
      | Share | Email:[automation.vision2@radware.com],Subject:mySubjectEdit,Body:myBodyEdit |

  @SID_8
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |



