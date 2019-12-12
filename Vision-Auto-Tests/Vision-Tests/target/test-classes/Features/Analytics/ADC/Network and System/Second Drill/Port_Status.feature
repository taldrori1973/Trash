@TC106811

Feature: Port Status Widget

  @SID_1
  Scenario: Login
    Then REST Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Dashboards" Tab
    Then UI Open "Application Dashboard" Sub Tab
    Then UI Open "Configurations" Tab
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Dashboards" Tab
    Then UI Open "Network and System Dashboard" Sub Tab
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_2
  Scenario: Validate attributes of port status widget
    Then UI Validate Pie Chart data "port-status-container"
      | label     | backgroundcolor        |
      | Up        | rgba(16, 130, 130, 1)  |
      | Down      | rgba(244, 20, 20, 1)   |
      | Disabled  | rgba(151, 151, 151, 1) |
      | Unplugged | rgba(32, 36, 39, 1)    |

  @SID_3
  Scenario: Validate ports status of selected device
    Then UI Validate Pie Chart data "port-status-container"
      | label     | data |
      | Down      | 5    |
      | Disabled  | 5    |
      | Unplugged | 5    |
      | Up        | 5    |

  @SID_4
  Scenario: Validate values update due to refresh
    # set port to disable and wait 30 seconds for that change to take place
    * REST Customized API Request "PUT" for "DPM_Dashboard->disableenablePort" on device "Alteon" with index "14" url params "1" Body params "2"
    * Sleep "180"
    # W/A in case of navigation issues. there is a different tests set to validate that
    Then UI Open "Configurations" Tab
    Then UI logout and close browser
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Dashboards" Tab
    Then UI Open "Network and System Dashboard" Sub Tab
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" with device attribute "deviceName" for "Alteon" Device with index 14
    Then UI Click Button "NetworkTab"
    Then UI Validate Pie Chart data "port-status-container"
      | label    | data |
      | Disabled | 1    |
      | Up       | 1    |
    * REST Customized API Request "PUT" for "DPM_Dashboard->disableenablePort" on device "Alteon" with index "14" url params "1" Body params "1"
    * Sleep "180"
    Then UI Validate Pie Chart data "port-status-container"
      | label | data |
      | Up    | 2    |

  @SID_5
  Scenario: Cleanup
    Then UI logout and close browser







