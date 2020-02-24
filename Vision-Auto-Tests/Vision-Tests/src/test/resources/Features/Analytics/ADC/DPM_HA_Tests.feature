@ADC @TC105965
Feature: DPM HA Tests

  @SID_1
  Scenario: Login
    * REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "Application Dashboard" page via homePage

  @SID_2
  Scenario: Validate virtual services table only for active machine
    When UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter device type "Alteon"
      | index | ports | policies |
      | 14    |       |          |
      | 15    |       |          |
    Then UI Validate "virts table" Table rows count equal to 5
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Virtual Service Name" findBy cellValue "virtualserver3:80"
      | columnName | value |
      | Protocol   | http  |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Virtual Service Name" findBy cellValue "virtualserver3:443"
      | columnName | value |
      | Protocol   | https |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Virtual Service Name" findBy cellValue "virtualserver3:110"
      | columnName | value |
      | Protocol   | pop3  |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Virtual Service Name" findBy cellValue "virtualserver2:443"
      | columnName | value |
      | Protocol   | https |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Virtual Service Name" findBy cellValue "virtualserver2:80"
      | columnName | value |
      | Protocol   | http  |

  @SID_3
  Scenario: Validate virtual services charts only for active machine
    Then UI Total Pie Chart data "virtual-service Chart"
      | size | offset |
      | 1    | 0      |
    Then UI Validate Pie Chart data "virtual-service Chart"
      | label | data |
      | Down  | 5    |
    Then UI Total Pie Chart data "server-group Chart"
      | size | offset |
      | 1    | 0      |
    Then UI Validate Pie Chart data "server-group Chart"
      | label | data |
      | Down  | 5    |
    Then UI Total Pie Chart data "real-server Chart"
      | size | offset |
      | 1   | 0      |
    Then UI Validate Pie Chart data "real-server Chart"
      | label | data |
      | Down  | 17   |

  @SID_4
  Scenario: Validate virtual services table for new active machine after switchover
    When REST Login with user "sys_admin" and password "radware"
    And REST Lock Action on "Alteon" 14
    And REST Put Scalar on "Alteon" 14 values "haOperSwitchBackup=2"
    And REST Unlock Action on "Alteon" 14
    And Sleep "30"
    Then UI Validate "virts table" Table rows count equal to 5
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Virtual Service Name" findBy cellValue "virtualserver3:80"
      | columnName | value |
      | Protocol   | http  |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Virtual Service Name" findBy cellValue "virtualserver3:443"
      | columnName | value |
      | Protocol   | https |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Virtual Service Name" findBy cellValue "virtualserver3:110"
      | columnName | value |
      | Protocol   | pop3  |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Virtual Service Name" findBy cellValue "virtualserver2:443"
      | columnName | value |
      | Protocol   | https |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Virtual Service Name" findBy cellValue "virtualserver2:80"
      | columnName | value |
      | Protocol   | http  |

  @SID_5
  Scenario: Validate virtual services charts for new active machine after switchover
    Then UI Total Pie Chart data "virtual-service Chart"
      | size | offset |
      | 1    | 0      |
    Then UI Validate Pie Chart data "virtual-service Chart"
      | label | data |
      | Down  | 5    |
    Then UI Total Pie Chart data "server-group Chart"
      | size | offset |
      | 1    | 0      |
    Then UI Validate Pie Chart data "server-group Chart"
      | label | data |
      | Down  | 5    |
    Then UI Total Pie Chart data "real-server Chart"
      | size | offset |
      | 1   | 0      |
    Then UI Validate Pie Chart data "real-server Chart"
      | label | data |
      | Down  | 17   |

  @SID_6
  Scenario: Cleanup
    When REST Login with user "sys_admin" and password "radware"
    And REST Lock Action on "Alteon" 15
    And REST Put Scalar on "Alteon" 15 values "haOperSwitchBackup=2"
    And REST Unlock Action on "Alteon" 15
    Then UI logout and close browser
