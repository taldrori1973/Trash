@TC108167
Feature: ADC System Dashboard

  @SID_1
  Scenario: Login and update drivers
    Given CLI Reset radware password
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.4.0.0-DD-1.00-396.jar" on "ROOT_SERVER_CLI" with timeOut 240
    When CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    Then UI Login with user "radware" and password "radware"

  @SID_2
  Scenario: Go into system dashboard
    When UI Navigate to "ANALYTICS ADC" page via homePage
    Then Sleep "30"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"

  @SID_3
  Scenario: Validate Throughput widget
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "2m"
    Then UI Validate Line Chart data "THROUGHPUT" with LabelTime
      | value     | count | countOffset |
      | 9045000000.0 | 4     | 1           |
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "1m"
    Then UI Validate Line Chart data "THROUGHPUT" with LabelTime
      | value     | count | countOffset |
      | 9045000000.0 | 2     | 1           |

  @SID_4
  Scenario: Validate CPS widget
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "2m"
    Then UI Validate Line Chart data "CPS" with LabelTime
      | value | count | countOffset |
      | 40.0  | 4     | 1           |
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "1m"
    Then UI Validate Line Chart data "CPS" with LabelTime
      | value | count | countOffset |
      | 40.0  | 2     | 1           |

  @SID_5
  Scenario: Validate CPU Usage
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "2m"
    Then UI Validate StackBar Timedata with widget "CPUUSAGE"
      | value | count | countOffset | label          |
      | 99.0  | 4     | 1           | Average SP CPU |
    Then UI Validate StackBar Timedata with widget "CPUUSAGE"
      | value | count | countOffset | label  |
      | 9.0   | 4     | 1           | MP CPU |
    Then UI Validate StackBar Timedata with widget "CPUUSAGE"
      | value | count | countOffset | label          |
      | 33.0  | 4     | 1           | Highest SP CPU |
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "1m"
    Then UI Validate StackBar Timedata with widget "CPUUSAGE"
      | value | count | countOffset | label          |
      | 99.0  | 2     | 1           | Average SP CPU |
    Then UI Validate StackBar Timedata with widget "CPUUSAGE"
      | value | count | countOffset | label  |
      | 9.0   | 2     | 1           | MP CPU |
    Then UI Validate StackBar Timedata with widget "CPUUSAGE"
      | value | count | countOffset | label          |
      | 33.0  | 2     | 1           | Highest SP CPU |

  @SID_6
  Scenario: Validate Memory usage
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "2m"
    Then UI Validate StackBar Timedata with widget "MEMORYUSAGE"
      | value | count | countOffset | label          |
      | 0.0   | 4     | 1           | Average SP Mem |
    Then UI Validate StackBar Timedata with widget "MEMORYUSAGE"
      | value | count | countOffset | label          |
      | 40.0  | 4     | 1           | Highest SP Mem |
    Given UI Click Button "Global Time Filter"
    When UI Click Button "Global Time Filter.Quick Range" with value "1m"
    Then UI Validate StackBar Timedata with widget "MEMORYUSAGE"
      | value | count | countOffset | label          |
      | 0.0   | 2     | 1           | Average SP Mem |
    Then UI Validate StackBar Timedata with widget "MEMORYUSAGE"
      | value | count | countOffset | label          |
      | 40.0  | 2     | 1           | Highest SP Mem |

  @SID_7
  Scenario: validate current charts
    Then UI Validate Text field "Throughput Usage" EQUALS "90.45%"
    Then UI Validate Text field "SP CPU" EQUALS "99%"
    Then UI Validate Text field "SP Memory" EQUALS "0%"
    Then UI Validate Text field "MP CPU" EQUALS "9%"

  @SID_8
  Scenario: Logout
    Then UI logout and close browser