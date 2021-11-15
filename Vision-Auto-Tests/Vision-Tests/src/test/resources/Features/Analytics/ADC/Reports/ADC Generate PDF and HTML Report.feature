@TC118902
Feature: ADC Generate PDF and HTML Report


  @SID_1
  Scenario: Login and Navigate ADC Report
    Given UI Login with user "radware" and password "radware"
    And UI Navigate to "ADC Reports" page via homePage

  @SID_2
  Scenario: stop IPTABLES
    #Then CLI Run remote linux Command "service iptables stop" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: validate Ports Traffic Information-System and Network
    Then Validate Line Chart data "Ports Traffic Information-System and Network" with Label "port_20" in report "ADC System and Network Report Definition"
      | value | min |
      | 202   | 10  |

  @SID_4
  Scenario: validate Concurrent Connections-Application
    Then Validate Line Chart data "Concurrent Connections-Application" with Label "Concurrent Connections" in report "ADC Applications Report Definition"
      | value | min |
      | 14    | 10  |

  @SID_5
  Scenario: validate Connections per Second-Application
    Then Validate Line Chart data "Connections per Second-Application" with Label "Connections per Second" in report "ADC Applications Report Definition"
      | value | min |
      | 13    | 10  |

  @SID_6
  Scenario: validate End-to-End Time-Application
    Then Validate Line Chart data "End-to-End Time-Application" with Label "Client RTT" in report "ADC Applications Report Definition"
      | value | min |
      | 0.006 | 10  |
    Then Validate Line Chart data "End-to-End Time-Application" with Label "Server RTT" in report "ADC Applications Report Definition"
      | value | min |
      | 0.007 | 10  |
    Then Validate Line Chart data "End-to-End Time-Application" with Label "App Response Time" in report "ADC Applications Report Definition"
      | value       | min |
      | 2038114.218 | 10  |
    Then Validate Line Chart data "End-to-End Time-Application" with Label "Response Transfer Time" in report "ADC Applications Report Definition"
      | value     | min |
      | 74008.629 | 10  |

  @SID_7
  Scenario: validate Throughput (bps)-Application
    Then Validate Line Chart data "Throughput (bps)-Application" with Label "Throughput" in report "ADC Applications Report Definition"
      | value | min |
      | 11    | 10  |

  @SID_8
  Scenario: validate Requests per Second-Application
    Then Validate Line Chart data "Requests per Second-Application" with Label "HTTP 2" in report "ADC Applications Report Definition"
      | value | min |
      | 15    | 10  |
    Then Validate Line Chart data "Requests per Second-Application" with Label "HTTP 1.1" in report "ADC Applications Report Definition"
      | value | min |
      | 16    | 10  |
    Then Validate Line Chart data "Requests per Second-Application" with Label "HTTP 1.0" in report "ADC Applications Report Definition"
      | value | min |
      | 17    | 10  |

  @SID_9
  Scenario: validate Groups and Content Rules-Application
    Then Validate Line Chart data "Groups and Content Rules-Application" with Label "1" in report "ADC Applications Report Definition"
      | value | min |
      | 110   | 10  |

  @SID_10
  Scenario: start IPTABLES
    #Then CLI Run remote linux Command "service iptables start" on "ROOT_SERVER_CLI"

  @SID_11
  Scenario: Logout
    Then UI logout and close browser

