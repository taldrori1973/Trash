@ADC_Report @TC105970

Feature: DPM - Edit and update Report wizard

  @SID_1
  Scenario: Login and navigate to the Reports Wizard
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
    When UI Open Upper Bar Item "ADC"
    When UI Open "Reports" Tab
    Then UI Validate Element Existence By Label "Add New" if Exists "true"

  @SID_2
  Scenario: ADC - new Report VRM_Edit_and_Update

    # defualt New report
    Given UI "Create" DPMReport With Name "ADCEdit_and_Update_Test_report"
      | devices               | virts:[Rejith_32326515:88]                                                     |
      | Schedule              | Run Every:Monthly,On Time:+2m                                                  |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |

    Then UI "Validate" DPMReport With Name "ADCEdit_and_Update_Test_report"
      | devices               | virts:[Rejith_32326515:88]                                                     |
      | Schedule              | Run Every:Monthly,On Time:+10m                                                 |
      | Share                 | Email:[automation.vision2@radware.com],Subject:myEdit subject,Body:myEdit body |



    ################################################
    #           Devices Test Edit/Update           #
    ################################################
#  @SID_3
#  Scenario: ADC - ALL devices Devices Test Edit/Update
#    Given UI "Edit" Report With Name "ADCEdit_and_Update_Test_report"
#      | devices |  |
#
#    Then UI "Validate" DPMReport With Name "ADCEdit_and_Update_Test_report"
#      | devices |  |

  @SID_4
  Scenario: ADC - Two devices Devices Test Edit/Update
    Given UI "Edit" DPMReport With Name "ADCEdit_and_Update_Test_report"
      | devices | virts:[1_32326515:80] |

    Then UI "Validate" DPMReport With Name "ADCEdit_and_Update_Test_report"
      | devices | virts:[1_32326515:80] |

  @SID_5
  Scenario: ADC - Schedule edit
    Given UI "Edit" Report With Name "ADCEdit_and_Update_Test_report"
      | Schedule | Run Every:Daily,On Time:+10m |

    Then UI "Validate" DPMReport With Name "ADCEdit_and_Update_Test_report"
      | Schedule | Run Every:Daily,On Time:+10m |


  @SID_6
  Scenario: ADC - edit time definitions
    Given UI "Edit" Report With Name "ADCEdit_and_Update_Test_report"
      | Time Definitions.Date | Quick:15m |

    Then UI "Validate" DPMReport With Name "ADCEdit_and_Update_Test_report"
      | Time Definitions.Date | Quick:15m |


  @SID_7
  Scenario: ADC - edit Delivery
    Given UI "Edit" Report With Name "ADCEdit_and_Update_Test_report"
      | Share | Email:[VisionQA3Edit@radware.com],Subject:ssss,Body:mmmm |

    Then UI "Validate" DPMReport With Name "ADCEdit_and_Update_Test_report"
      | Share | Email:[VisionQA3Edit@radware.com],Subject:ssss,Body:mmmm |


  @SID_8
  Scenario: ADC - edit Delivery with more than one email
    Given UI "Edit" Report With Name "ADCEdit_and_Update_Test_report"
      | Share | Email:[VisionQA3@radware.com,aaa@ggg.com],Subject:sasa,Body:dsds |

    Then UI "Validate" DPMReport With Name "ADCEdit_and_Update_Test_report"
      | Share | Email:[VisionQA3@radware.com,aaa@ggg.com],Subject:sasa,Body:dsds |

  @SID_9
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |



