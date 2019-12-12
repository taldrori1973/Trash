
@TC111204
Feature: DefenseFlow Alert

  @SID_1
  Scenario: Clear logs and alerts history
    Then CLI Clear vision logs
    Then CLI kill all simulator attacks on current vision
    Then REST Delete ES index "alert"

  @SID_2
  Scenario: generate DefenseFlow alert by login
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_alert.sh " |
      | #visionIP                         |

  @SID_3
  Scenario: generate DefenseFlow alert by basic auth
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/curl_DF_alert_login.sh " |
      | #visionIP                               |

  @SID_4
  Scenario: Login as sys_admin and verify the alert
    Then REST Login with user "sys_admin" and password "radware"
    Then REST Request "GET" for "Alert Browser->Vision Alerts API"
      | type                 | value                                                                                                              |
      | params               | filter=deviceType:DEFENSE_FLOW,severity:INFO,module:DEVICE_GENERAL,userName:APSolute_Vision,deviceName:DefenseFlow |
      | params               | filtertype=any                                                                                                     |
      | params               | maxrows=1                                                                                                         |
      | result               | "message": "attack started on network 1.1.1.2/32"                                                                  |
      | result               | "deviceType": "DEFENSE_FLOW"                                                                                       |
      | result               | "deviceName": "DefenseFlow"                                                                                        |
      | Returned status code | 200                                                                                                                |

  @SID_5
  Scenario: Logout
    Then Sleep "5"
    Then REST Request "POST" for "Vision Authentication->Logout"
      | type                 | value|
      | Returned status code | 200  |

  @SID_6
  Scenario: Login as non-admin user to verify alert is not seen
    Then REST Login with user "sec_mon_all_pol" and password "radware"
    Then REST Request "GET" for "Alert Browser->Vision Alerts API"
      | type                 | value                                                                                                              |
      | params               | filter=deviceType:DEFENSE_FLOW,severity:INFO,module:DEVICE_GENERAL,userName:APSolute_Vision,deviceName:DefenseFlow |

  @SID_7
  Scenario: Cleanup
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |