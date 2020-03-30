@VRM_Report2 @TC106007

Feature: Design Report Wizard


#  @SID_1
#  Scenario: VRM Reports Cleanup
#    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
#    * REST Delete ES index "vrm-scheduled-report-*"


  @SID_2
  Scenario: Login and navigate to the Reports WizardRamat HaHayal, Tel Aviv-Yafo
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"


  @SID_3
  Scenario: Design the Report - delete all widgets and add one widget
    Given UI "Create" Report With Name "DeleteAllReport"
      | reportType | DefensePro Analytics Dashboard  |
      | Design     | Delete:[ALL], Add:[Top Attacks] |
    #test report exist20



    * UI "Validate" Report With Name "DeleteAllReport"
      | reportType | DefensePro Analytics Dashboard |
      | Design     | Widgets:[Top Attacks]          |

  @SID_4
  Scenario: Design the Report - edit and delete the top widget
    Given UI "Create" Report With Name "TopWidgetsReport"
      | reportType | DefensePro Analytics Dashboard                           |
      | Design     | Delete:[ALL], Add:[Top Attacks,Top Attacks by Bandwidth] |



    * UI "Edit" Report With Name "TopWidgetsReport"
      | reportType | DefensePro Analytics Dashboard |
      | Design     | Add:[Top Scanners]             |

    * UI "Validate" Report With Name "TopWidgetsReport"
      | Design | Widgets:[Top Scanners] |

#  Scenario: TC103184 - Design the Report - Change position for widget
#    Given UI "Create" Report With Name "changePosition"
#      | reportType | DefensePro Analytics Dashboard                |
#      | Design     | Position:Attacks by Threat Category,X:0,Y:460 |

 # commented because there is no such feature as reposition in report
############## Multiple widget selection Validations.
  @SID_6
  Scenario: Design the Report - Analytics- Add 3 widgets with the same widget.
    Given UI "Create" Report With Name "3TopAttacks"
      | reportType | DefensePro Analytics Dashboard                                                   |
      | Design     | Delete:[ALL], Add:[Top Attacks,Top Attacks by Bandwidth,Top Attacks,Top Attacks] |

    * UI "Validate" Report With Name "3TopAttacks"
      | Design | Widgets:[Top Attacks,Top Attacks by Bandwidth,Top Attacks,Top Attacks] |

  @SID_7
  Scenario: Design the Report - Analytics- Add 3 widgets with the same widget.
    Given UI "Create" Report With Name "4Bandwidth"
      | reportType | DefensePro Analytics Dashboard                                                                                          |
      | Design     | Delete:[ALL], Add:[Top Attacks by Bandwidth,Top Attacks by Bandwidth,Top Attacks by Bandwidth,Top Attacks by Bandwidth] |

    * UI "Validate" Report With Name "4Bandwidth"
      | Design | Widgets:[Top Attacks by Bandwidth,Top Attacks by Bandwidth,Top Attacks by Bandwidth,Top Attacks by Bandwidth] |

  @SID_8
  Scenario: Design the Report - Analytics- Add 3 widgets and 2 widgets with the same widget.
    Given UI "Create" Report With Name "3TopAttacks2Bandwidth"
      | reportType | DefensePro Analytics Dashboard                                                                            |
      | Design     | Delete:[ALL], Add:[Top Attacks,Top Attacks by Bandwidth,Top Attacks,Top Attacks,Top Attacks by Bandwidth] |

    * UI "Validate" Report With Name "3TopAttacks2Bandwidth"
      | Design | Widgets:[Top Attacks,Top Attacks by Bandwidth,Top Attacks,Top Attacks,Top Attacks by Bandwidth] |

  @SID_9
  Scenario: Design the Report - Analytics- multiple widgets
    Given UI "Create" Report With Name "multipleWidgets"
      | reportType | DefensePro Analytics Dashboard                                                                                                                                                                                                                                                                    |
      | Design     | Delete:[ALL], Add:[Top Attack Sources,Top Scanners,Traffic Bandwidth,Top Attack Destination,Connections Rate,Top Attack Sources,Top Scanners,Traffic Bandwidth,Top Attack Destination,Connections Rate,Top Attack Sources,Top Scanners,Traffic Bandwidth,Top Attack Destination,Connections Rate] |

    * UI "Validate" Report With Name "multipleWidgets"
      | Design | Widgets:[Top Attack Sources,Top Scanners,Traffic Bandwidth,Top Attack Destination,Connections Rate,Top Attack Sources,Top Scanners,Traffic Bandwidth,Top Attack Destination,Connections Rate,Top Attack Sources,Top Scanners,Traffic Bandwidth,Top Attack Destination,Connections Rate] |

  @SID_10
  Scenario: Design the Report - Behavioral- Add 3 widgets with the same widget.
    Given UI "Create" Report With Name "2BehavioralDuplicated"
      | reportType | DefensePro Behavioral Protections Dashboard                                     |
      | Design     | Delete:[ALL], Add:[BDoS-TCP SYN,BDoS-TCP SYN ACK,BDoS-TCP SYN,BDoS-TCP SYN ACK] |

    * UI "Validate" Report With Name "2BehavioralDuplicated"
      | Design | Widgets:[BDoS-TCP SYN,BDoS-TCP SYN ACK,BDoS-TCP SYN,BDoS-TCP SYN ACK] |


  @SID_5
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |

