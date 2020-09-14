#@VRM_Report
@Analytics_ADC @TC106012


Feature: Report Wizard_Time_Definitions

#  @vrm_time_1
  @SID_1
  Scenario: Clean DB and generate attacks
    When CLI kill all simulator attacks on current vision
    Given REST Delete ES index "dp-*"
    When CLI Clear vision logs
    And CLI simulate 1 attacks of type "rest_dos" on "DefensePro" 10
    And CLI simulate 1 attacks of type "rest_anomalies" on "DefensePro" 10 and wait 22 seconds
#  @VRM_Time_1
  @SID_2
  Scenario: Clean system data before test
    Given CLI Reset radware password
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    * REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |

  @SID_3
  Scenario: Run DP simulator PCAPs for TOP FORWARDED ATTACK SOURCES
#    Given CLI simulate 1 attacks of type "VRM_attacks" on "DefensePro" 10 and wait 180 seconds with attack ID
#    Given CLI simulate 100 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 140 seconds

  @SID_4
  Scenario: Login and navigate to the Reports Wizard
    Given UI Login with user "sys_admin" and password "radware"
    And UI Navigate to "AMS Reports" page via homePage
    Then UI Validate Element Existence By Label "Add New" if Exists "true"


  @SID_5
  Scenario: Add new Report 15 mim from type DefensePro Analytics Dashboard
   # move Anomalies start time 10 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-600000'"}}'" on "ROOT_SERVER_CLI"

    # "TimeFrame 15 mim"
    Given UI "Create" Report With Name "testReport_15m"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:15m                      |

    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_15m"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:15m                      |

    #ToDo verify data displayed in the report

   # move Anomalies start time + 6 min -> 16 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-360000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report



  @SID_6
  Scenario: Add new Report 30 mim from type DefensePro Analytics Dashboard

   # move Anomalies start time 25 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-1500000'"}}'" on "ROOT_SERVER_CLI"

    # "TimeFrame 30 mim"
    Given UI "Create" Report With Name "testReport_30m"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:30m                      |

    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_30m"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:30m                      |


    #ToDo verify data displayed in the report

   # move Anomalies start time + 6 min -> 31 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-360000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report


  @SID_7
  Scenario: Add new Report 1 Hour from type DefensePro Analytics Dashboard

   # move Anomalies start time 55 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-3300000'"}}'" on "ROOT_SERVER_CLI"

    # "TimeFrame 1 Hour"
    Given UI "Create" Report With Name "testReport_1H"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:1H                       |

    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_1H"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:1H                       |

    #ToDo verify data displayed in the report

   # move Anomalies start time + 6 min -> 1 HOur 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-360000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report






  @SID_8
  Scenario: Add new Report 1 Day from type DefensePro Analytics Dashboard
    # "TimeFrame 1 Day"

   # move Anomalies start time 23 houirs 55 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-86100000'"}}'" on "ROOT_SERVER_CLI"

    Given UI "Create" Report With Name "testReport_1D"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:1D                       |
    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_1D"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:1D                       |

    #ToDo verify data displayed in the report

   # move Anomalies start time + 6 min -> 1 Day 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-360000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report



  @SID_9
  Scenario:  Add new Report 1 Week from type DefensePro Analytics Dashboard
    # "TimeFrame 1 Week"

   # move Anomalies start time 6 Days 23 houirs 55 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-604500000'"}}'" on "ROOT_SERVER_CLI"

    Given UI "Create" Report With Name "testReport_1W"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:1W                       |

    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_1W"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:1W                       |

    #ToDo verify data displayed in the report

   # move Anomalies start time + 6 min -> 7 Day 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-360000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report



  @SID_10
  Scenario: Add new Report 1 Month from type DefensePro Analytics Dashboard
    # "TimeFrame 1 Month"

   # move Anomalies start time 27 Days 23 houirs 55 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-2336100000'"}}'" on "ROOT_SERVER_CLI"

    Given UI "Create" Report With Name "testReport_1M"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:1M                       |
    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_1M"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:1M                       |

    #ToDo verify data displayed in the report

   # move Anomalies start time + 4 days 6 min -> 1 month 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-348900000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report


  @SID_11
  Scenario: Add new Report 3 Month from type DefensePro Baseline BDOS Dashboard
    # "TimeFrame 3 Month"

   # move Anomalies start time 27 + 30 + 31 = 89 Days 23 houirs 55 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-7692900000'"}}'" on "ROOT_SERVER_CLI"

    Given UI "Create" Report With Name "testReport_3M"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:3M                       |
    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_3M"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:3M                       |

    #ToDo verify data displayed in the report

   # move Anomalies start time + 5 days 6 min -> 3 month 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-432360000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report


  @SID_12
  Scenario: Add new Report Today from type DefensePro Baseline BDOS Dashboard
    ## "TimeFrame Today"
    Given UI "Create" Report With Name "testReport_Today"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:Today                    |
    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_Today"
      | reportType            | DefensePro Analytics Dashboard |
      | devices               | index:10                       |
      | Time Definitions.Date | Quick:Today                    |

    #ToDo verify data displayed in the report

   # move Anomalies start time + 1 days 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-86460000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report


  @SID_13
  Scenario: Add new Report This Week from type DefensePro Baseline BDOS Dashboard
    # "TimeFrame This Week"
    Given UI "Create" Report With Name "testReport_This_Week"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Quick:This Week                             |
    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_This_Week"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Quick:This Week                             |

    #ToDo verify data displayed in the report

    # move Anomalies start time + 1 week 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-604860000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report


  @SID_14
  Scenario: Add new Report test This month from type DefensePro BDOS Dashboard
    Given UI "Create" Report With Name "testReport_This_Month"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Quick:This Month                            |
    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_This_Month"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Quick:This Month                            |

    #ToDo verify data displayed in the report

       # move Anomalies start time + 1 month (31 day) 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-2678460000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report


  @SID_15
  Scenario: Add new Report Quarter from type DefensePro Baseline BDOS Dashboard
    # "TimeFrame Quarter"
    Given UI "Create" Report With Name "testReport_This_Quarter"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10,policies:[BDOS]                    |
      | Time Definitions.Date | Quick:Quarter                               |

    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_This_Quarter"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10,policies:[BDOS]                    |
      | Time Definitions.Date | Quick:Quarter                               |

    #ToDo verify data displayed in the report

    # move Anomalies start time + 3 month (31+30+31=91 day) 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-7862460000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report



  @SID_16
  Scenario: Add new Report Absolute from type DefensePro Baseline DNS Dashboard
    # "TimeFrame Absolute"
    Given UI "Create" Report With Name "testReport_Absolute"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]         |
    Then Sleep "3"
    Then UI "Validate" Report With Name "testReport_Absolute"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
#    Time validation is from now, It is not stable validation.
#      | Time Definitions.Date | Absolute:[27.02.1971 01:00:00, +0d]         |


  @SID_17
  Scenario: Add new Report Relative 2 hour from type DefensePro Baseline DNS Dashboard
    # "TimeFrame Relative 2 Hours"

   # move Anomalies start time 55 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-6900000'"}}'" on "ROOT_SERVER_CLI"

    Given UI "Create" Report With Name "Relative_2_Hour"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Relative:[Hours,2]                          |
    Then Sleep "3"
    Then UI "Validate" Report With Name "Relative_2_Hour"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Relative:[Hours,2]                          |

    #ToDo verify data displayed in the report

   # move Anomalies start time + 6 min -> 2 Hour 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-360000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report


  @SID_18
  Scenario: Add new Report Relative 2 Days from type DefensePro Baseline DNS Dashboard
    # "TimeFrame Relative 2 Days"

   # move Anomalies start time 45 houirs 55 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-172500000'"}}'" on "ROOT_SERVER_CLI"

    Given UI "Create" Report With Name "Relative_2_Days"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Relative:[Days,2]                           |
    Then Sleep "3"
    Then UI "Validate" Report With Name "Relative_2_Days"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Relative:[Days,2]                           |

    #ToDo verify data displayed in the report

   # move Anomalies start time + 6 min -> 2 Days 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-360000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report


  @SID_19
  Scenario: Add new Report Relative 2 Weeks from type DefensePro Baseline DNS Dashboard
    # "TimeFrame Relative 3 Weeks"

   # move Anomalies start time 13 Days 55 houirs 55 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-1209300000'"}}'" on "ROOT_SERVER_CLI"

    Given UI "Create" Report With Name "Relative_2_Weeks"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Relative:[Weeks,2]                          |
    Then Sleep "3"
    Then UI "Validate" Report With Name "Relative_2_Weeks"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Relative:[Weeks,2]                          |

    #ToDo verify data displayed in the report

   # move Anomalies start time + 6 min -> 14 Days 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-360000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report



  @SID_20
  Scenario: Add new Report Relative 2 Month from type DefensePro Baseline DNS Dashboard
    # "TimeFrame Relative 4 Month"

   # move Anomalies start time 28+30=58 Days 23 houirs 55 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-5097300000'"}}'" on "ROOT_SERVER_CLI"

    Given UI "Create" Report With Name "Relative_2_Months"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Relative:[Months,2]                         |
    Then Sleep "3"
    Then UI "Validate" Report With Name "Relative_2_Months"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Relative:[Months,2]                         |

    #ToDo verify data displayed in the report

   # move Anomalies start time 5 Days + 6 min -> 62 Days 1 min backwards
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-348900000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report


  @SID_21
  Scenario: VRM - Add new Report Previous Month from type DefensePro Baseline DNS Dashboard
    # "TimeFrame Quick Previous Month"

   # move Anomalies start time 28 Days backwards
    # we should not find any data
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-2419200000'"}}'" on "ROOT_SERVER_CLI"

    Given UI "Create" Report With Name "Previous Month"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Quick:Previous Month                        |
    Then Sleep "3"
    Then UI "Validate" Report With Name "Previous Month"
      | reportType            | DefensePro Behavioral Protections Dashboard |
      | devices               | index:10                                    |
      | Time Definitions.Date | Quick:Previous Month                        |

    #ToDo verify data displayed in the report

    # move Anomalies start time 4 Days -> 32 Days backwards
    # we should!! find data
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-345600000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report


    # move Anomalies start time 31 Days -> 63 Days backwards
    # No data should be find
    When CLI Run remote linux Command "curl -XPOST localhost:9200/dp-attack-raw-*/_update_by_query/?pretty -d '{"query": {"match": {"attackIpsId": "4-1402580209"}},"script": {"source": "ctx._source.startTime = 'ctx._source.startTime-2678400000'"}}'" on "ROOT_SERVER_CLI"

    #ToDo verify data displayed in the report

#  @SID_23
#  Scenario: VRM Reports - Time Selection - Relative Out Of Range
#    When UI Click Button "Add New"
#    When UI Click Button "Time Area"
#    When UI Click Button "Relative"
#    When UI Click Button "Time Relative Period" with value "Hours"
#    And UI Set Text Field "Time Relative Period Input" and params "Hours" To "8761"
#    Then UI Validate Text field "Warning Message" EQUALS "Please select less than 8760 Hours"
#    When UI Click Button "Time Relative Period" with value "Days"
#    And UI Set Text Field "Time Relative Period Input" and params "Days" To "366"
#    Then UI Validate Text field "Warning Message" EQUALS "Please select less than 366 Days"
#    When UI Click Button "Time Relative Period" with value "Weeks"
#    And UI Set Text Field "Time Relative Period Input" and params "Weeks" To "53"
#    Then UI Validate Text field "Warning Message" EQUALS "Please select less than 52 Weeks"
#    And UI Set Text Field "Time Relative Period Input" and params "Months" To "13"
#    Then UI Validate Text field "Warning Message" EQUALS "Please select less than 12 Months"
#    And UI Click Button "Cancel"

  @SID_22
  Scenario: Cleanup
    Given UI logout and close browser
    * CLI kill all simulator attacks on current vision
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
