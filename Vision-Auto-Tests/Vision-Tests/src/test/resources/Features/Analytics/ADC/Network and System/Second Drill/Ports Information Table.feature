@TC106799
Feature: ADC network ports Information Table

  @SID_1
  Scenario: Login and go to device network screen
    Given CLI Reset radware password
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.4.0.0-DD-1.00-396.jar" on "ROOT_SERVER_CLI" with timeOut 240

    Then UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"
    Then UI Click Button "accessibility button" with value ""
    Then UI Click Button "Auto-refresh" with value ""
    Then UI Click Button "Close accessibility" with value ""
    Then UI Click Button "Show all ports table" with value ""

  @SID_2
  Scenario: validate if there is a popup table
    Then UI Validate Element Existence By Label "Ports Information Table" if Exists "true" with value ""

  @SID_3
  Scenario: validate Ascending sort status
    When UI Click Button "column sort button" with value "Status"
    Then UI Validate Table "Ports information" is Sorted by
      | columnName | order      | compareMethod |
      | Status     | Descending | HEALTH_SCORE  |
      | Port Name  | Ascending  | Alphabetical  |

  @SID_4
  Scenario: validate Descending sort status
    When UI Click Button "column sort button" with value "Status"
    Then UI Validate Table "Ports information" is Sorted by
      | columnName | order     | compareMethod |
      | Status     | Ascending | HEALTH_SCORE  |
      | Port Name  | Ascending | Alphabetical  |

  @SID_5
  Scenario: validate Ascending sort status
    When UI Click Button "column sort button" with value "Port Name"
    Then UI Validate Table "Ports information" is Sorted by
      | columnName | order     | compareMethod |
      | Port Name  | Ascending | Alphabetical  |

  @SID_6
  Scenario: validate Descending sort status
    When UI Click Button "column sort button" with value "Port Name"
    Then UI Validate Table "Ports information" is Sorted by
      | columnName | order      | compareMethod |
      | Port Name  | Descending | Alphabetical  |

  @SID_7
  Scenario: validate port_02 Throughput
    Then UI Validate column chart "Throughput_transmit" for Line Chart attributes "ports_info_popup_port_02" with Label "port_02"
      | attribute       | value   |
      | shapes          | plus    |
      | backgroundColor | #6296BA |

  @SID_8
  Scenario: validate port_2 Packets
    Then UI Validate column chart "Pps_transmit" for Line Chart attributes "ports_info_popup_port_02" with Label "port_02"
      | attribute       | value   |
      | shapes          | plus    |
      | backgroundColor | #6296BA |

  @SID_9
  Scenario: validate if the popup table disappear
    When UI Click Button "Close Ports Information Table" with value ""
    Then UI Validate Element Existence By Label "Ports Information Table" if Exists "false" with value ""

  @SID_10
  Scenario: CleanUp
    Then UI logout and close browser
