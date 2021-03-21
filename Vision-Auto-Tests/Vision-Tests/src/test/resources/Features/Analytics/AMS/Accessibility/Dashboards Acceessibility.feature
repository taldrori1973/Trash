@VRM_Report2 @TC105979

Feature: VRM AMS dashboard Accessibility

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
#    * REST Delete ES index "dp-traffic-*"
#    * REST Delete ES index "dp-https-stats-*"
#    * REST Delete ES index "dp-https-rt-*"
#    * REST Delete ES index "dp-five-*"
    * REST Delete ES index "dp-*"
    * Sleep "60"

  @SID_2
  Scenario: Login to main dashboard
    Given UI Login with user "sys_admin" and password "radware"
    * REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage

  @SID_3
  Scenario: validate Accessibility font size
    Given UI Click Button "Accessibility Open Menu"
    Then UI Click Button "Accessibility Font Size" with value "Font Sizes"
    Then UI Validate Text field "Accessibility Font Content0" CONTAINS "Newer browsers support either text resizing or page zooming, to allow users to increase the size of essential page content. After you select the text sizing or zoom level, refresh the browser window, because some headings will not resize until the window refreshes."
    Then UI Validate Text field "Accessibility Font Content1" CONTAINS "Microsoft Internet Explorer 11: Press the Alt key to display the menu bar, select View > Text size, and choose to make the text larger or smaller than the size on the screen."
    Then UI Validate Text field "Accessibility Font Content2" CONTAINS "Mozilla Firefox: On the menu at the top, select View > Zoom > Zoom Text Only. This makes the controls only change the size of text, not images."
    Then UI Validate Text field "Accessibility Font Content3" CONTAINS "Apple Safari (OS X): To enlarge the entire page, choose View > Zoom In, or press Command (⌘)-Plus (+). To enlarge only the text, choose View > Zoom Text Only, and then choose View > Zoom In"
    Then UI Validate Text field "Accessibility Font Content4" CONTAINS "Chrome: Click the Chrome menu on the browser toolbar. Select Settings. Click Show advanced settings. In the "Web Content" section, use the "Font size" drop-down menu to make adjustments."
    Then UI Click Button "Accessibility Font Close"
    Then UI Click Button "Accessibility Close"


  @SID_4
  Scenario: Verify Accessibility disabled state info
    Given UI Click Button "Accessibility Open Menu"
    Then UI Validate Text field "Accessibility Info" CONTAINS "Accessibility for APSolute Vision is disabled."
    Then UI Validate Text field "Accessibility Info" CONTAINS "You can select the Accessibility options from the following list and enable Accessibility later."
    Then UI Click Button "Accessibility Close"

  @SID_5
  Scenario: Validate Accessibility stop auto refresh
    Given UI Click Button "Accessibility Open Menu"
    Then UI Click Button "Accessibility Auto Refresh" with value "Stop Auto-Refresh"
    Then UI Click Button "Accessibility Close"
    Then CLI simulate 80 attacks of type "baselines_pol_1" on "DefensePro" 10 with loopDelay 15000 and wait 35 seconds
    Then UI Validate Element Existence By Label "Peace Time" if Exists "true"
    Then Sleep "63"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "true"

  @SID_6
  Scenario: Verify Accessibility enabled state info
    Given UI Click Button "Accessibility Open Menu"
    Then UI Validate Text field "Accessibility Info" CONTAINS "Accessibility for APSolute Vision is enabled."
    Then UI Validate Text field "Accessibility Info" CONTAINS "You can select the Accessibility options from the following list."
    Then UI Click Button "Accessibility Close"

  @SID_7
  Scenario: validate Accessibility clear settings
    Given UI Click Button "Accessibility Open Menu"
    Then UI Click Button "Accessibility Clear" with value "Quit Accessibility"
    Then UI Click Button "Accessibility Close"
    Then Sleep "2"
    Then UI Validate Element Existence By Label "Peace Time" if Exists "false"

  @SID_8
  Scenario: Set Accessibility patterns traffic graphs
    Given UI Click Button "Accessibility Open Menu"
    Then UI Click Button "Accessibility Color Patterns" with value "Use Patterns For Colors"
    Then UI Click Button "Accessibility Close"

  @SID_9
  Scenario: VRM - Validate Accessibility colors for "Traffic Bandwidth"
    Then UI Do Operation "Select" item "Traffic Bandwidth.pps"
    Then UI Validate Line Chart attributes "Traffic Bandwidth" with Label "Dropped"
      | attribute            | value                  |
      | color                | rgba(190, 30, 45, 0.2) |
      | shapeType            | cross                  |


    Then UI Validate Line Chart attributes "Traffic Bandwidth" with Label "Received"
      | attribute            | value                    |
      | color                | rgba(194, 218, 235, 0.1) |
      | shapeType            | plus                     |
      | hoverBackgroundColor | rgba(194, 218, 235, 0.4) |
      | hoverBorderColor     | rgba(194, 218, 235, 5)   |
      | borderColor          | rgba(194, 218, 235, 5)   |

  @SID_10
  Scenario: VRM - Validate Accessibility colors for "Concurrent Connections"
    Then UI Validate Line Chart attributes "Concurrent Connections" with Label "Concurrent Connections"
      | attribute            | value                        |
      | shapeType            | ["plus"]                     |
      | colors               | ["rgba(194, 218, 235, 0.5)"] |
      | hoverBackgroundColor | rgba(194, 218, 235, 0.4)     |
      | hoverBorderColor     | rgba(194, 218, 235, 5)       |
      | borderColor          | rgba(194, 218, 235, 5)       |

  @SID_11
  Scenario: VRM - Validate Accessibility colors for "Connections per Second"
    Then UI Validate Line Chart attributes "Connections Rate" with Label "Connections per Second"
      | attribute | value    |
      | shapeType | ["plus"] |

  @SID_12
  Scenario: VRM - Validate Accessibility colors for "BW by policy"
    Then UI Validate Pie Chart data "Bandwidth per Policy"
      | label | shapeType | colors           |
      | pol_1 | plus      | rgb(70, 91, 108) |

  @SID_13
 Scenario: VRM - Validate Accessibility colors for "Traffic Composition"
    Then UI Validate Pie Chart data "Traffic Composition"
      | label | shapeType |
      | UDP   | plus      |
      | TCP   | cross     |
      | ICMP  | dash      |

  @SID_14
  Scenario: validate Accessibility stays between dashboards
    Given UI click Table row by keyValue or Index with elementLabel "Protection Policies.Table" findBy index 0
    Then UI Validate Line Chart attributes "Policy Traffic Bandwidth" with Label "Received"
      | shapeType | dot-dash |
    Then UI Validate Line Chart attributes "Policy Traffic Bandwidth" with Label "Dropped"
      | shapeType | triangle-inverted |

  @SID_15
  Scenario: validate Accessibility patterns analytics
    Given UI Navigate to "DefensePro Analytics Dashboard" page via homePage
    Then UI Validate Pie Chart data "Attacks by Threat Category"
      | label         | shapeType | colors                   |
      | BehavioralDOS | plus      | rgba(70, 91, 108, 0.7)   |
      | DNS           | cross     | rgba(127, 205, 181, 0.7) |

  @SID_16
  Scenario: Go back to vision
    Then UI Navigate to "VISION SETTINGS" page via homePage
  @SID_17
  Scenario: TC105648 validate Accessibility patterns baselines
    When UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "2m"
    And UI Do Operation "Select" item "Device Selection"
    And UI VRM Select device from dashboard and Save Filter
      | index | ports | policies |
      | 10    |       | pol_1    |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Suspected Edge"
      | attribute  | value   |
      | shapeType  | square  |
      | color      | #ffa20d |
      | borderDash | [3]     |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Normal Edge"
      | attribute  | value   |
      | shapeType  | square  |
      | color      | #8cba46 |
      | borderDash | [0]     |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Attack Edge"
      | attribute  | value   |
      | shapeType  | square  |
      | color      | #ff4c4c |
      | borderDash | [6]     |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Legitimate Traffic"
      | attribute | value                    |
      | shapeType | cross                    |
      | color     | rgba(115, 134, 154, 0.1) |

    Then UI Validate Line Chart attributes "BDoS-TCP SYN" with Label "Total Traffic"
      | attribute | value                    |
      | shapeType | plus                     |
      | color     | rgba(141, 190, 214, 0.1) |
    Then UI Navigate to "VISION SETTINGS" page via homePage

  @SID_18
  Scenario: validate Accessibility clear settings
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    Given UI Click Button "Accessibility Open Menu"
    Then UI Click Button "Accessibility Clear" with value "Quit Accessibility"
    Then UI Click Button "Accessibility Close"

  @SID_19
    Scenario: Cleanup
      * CLI kill all simulator attacks on current vision
      Then UI logout and close browser


