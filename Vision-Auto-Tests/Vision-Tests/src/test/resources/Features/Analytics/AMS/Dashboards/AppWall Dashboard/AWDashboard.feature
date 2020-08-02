@TC111423
Feature: VRM AppWall dashboard

  @SID_1 @Sanity
  Scenario: Clean system data
    Given CLI kill all simulator attacks on current vision
    Given REST Vision Install License Request "vision-AVA-AppWall"
    Given REST Delete ES index "appwall-v2-attack*"

  @SID_2 @Sanity
  Scenario: login
    Given UI Login with user "sys_admin" and password "radware"
    * REST Delete ES index "aw-web-application"
    * REST Delete Device By IP "172.17.164.30"
    * Browser Refresh Page
    And Sleep "10"

  @SID_3 @Sanity
  Scenario: configure the AW in vision
    Then REST Add "AppWall" Device To topology Tree with Name "Appwall_SA_172.17.164.30" and Management IP "172.17.164.30" into site "AW_site"
      | attribute     | value    |
      | httpPassword  | 1qaz!QAZ |
      | httpsPassword | 1qaz!QAZ |
      | httpsUsername | user1    |
      | httpUsername  | user1    |
      | visionMgtPort | G1       |
    And Sleep "10"
    * CLI Clear vision logs

  @SID_4
  Scenario:run AW attacks
    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                     |
      | #visionIP                                                         |
      | " 172.17.164.30 5 "/home/radware/AW_Attacks/AppwallAttackTypes/"" |

    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "cat /home/radware/AW_Attacks/AppwallAttackTypes/Injection3 \| netcat " |
      | #visionIP                                                               |
      | " 2215"                                                                 |

    Then Sleep "40"

    Then CLI Operations - Run Root Session command "curl -XPOST -H "Content-type: application/json" -s "localhost:9200/appwall-v2-attack-raw-*/_update_by_query/?conflicts=proceed&refresh" -d '{"query":{"bool":{"must":{"term":{"tunnel":"tun_HTTP"}}}},"script":{"source":"ctx._source.receivedTimeStamp='$(echo $(date +%s%3N)-7200000|bc)L';"}}'"
    Then CLI Operations - Run Root Session command "curl -XPOST -H "Content-type: application/json" -s "localhost:9200/appwall-v2-attack-raw-*/_update_by_query/?conflicts=proceed&refresh" -d '{"query":{"bool":{"must":{"term":{"tunnel":"Default Web Application"}}}},"script":{"source":"ctx._source.receivedTimeStamp='$(echo $(date +%s%3N)-7200000|bc)L';"}}'"

    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
      | "/home/radware/AW_Attacks/sendAW_Attacks.sh "                     |
      | #visionIP                                                         |
      | " 172.17.164.30 5 "/home/radware/AW_Attacks/AppwallAttackTypes/"" |
    Then Sleep "40"

  @SID_5 @Sanity
  Scenario: Go TO AW dashboard
    And UI Navigate to "AppWall Dashboard" page via homePage
    Then Sleep "5"
    Then UI Validate Element Existence By Label "Top Sources Widget" if Exists "true"

  @SID_6
  Scenario: validate 3 upper widgets
    Then UI Text of "blocked Events value" equal to "145"
    Then UI Text of "reported Events value" equal to "5"
    Then UI Text of "modified Events value" equal to "5"

  @SID_7
  Scenario: validate OWASP Top 10
    Then UI Validate Pie Chart data "OWASPCATEGORY"
      | label | data |
      | A1    | 65   |
      | A5    | 55   |
      | A6    | 5    |
      | A7    | 30   |

  @SID_8
  Scenario: validate Top Attack Category
    Then UI Validate Text field "TopAttackCategory_value" with params "Injections" EQUALS "60"
    Then UI Validate Text field "TopAttackCategory_value" with params "Access Control" EQUALS "55"
    Then UI Validate Text field "TopAttackCategory_value" with params "Cross Site Scripting" EQUALS "30"
    Then UI Validate Text field "TopAttackCategory_value" with params "Misconfiguration" EQUALS "5"
    Then UI Validate Text field "TopAttackCategory_value" with params "HTTP RFC Violations" EQUALS "5"

  @SID_9
  Scenario: validate Top Sources
    Then UI Validate Text field "TopSources_value" with params "2.56.36.1" EQUALS "30"
    Then UI Validate Text field "TopSources_value" with params "2.88.0.1" EQUALS "30"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.109" EQUALS "30"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.149" EQUALS "30"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.217" EQUALS "30"

  @SID_10
  Scenario: validate Attack by Action
    Then UI Validate Pie Chart data "ACTION"
      | label    | data |
      | Blocked  | 145  |
      | Modified | 5    |
      | Reported | 5    |

  @SID_11
  Scenario: validate Attack Severity
    Then UI Validate Pie Chart data "SEVERITY"
      | label    | data |
      | High     | 135  |
      | Critical | 5    |
      | Info     | 5    |
      | Low      | 5    |
      | Warning  | 5    |

  @SID_12
  Scenario: validate Top Attack Hosts
    Then UI Validate Text field "AttackHosts_value" with params "172.17.154.195" EQUALS "155"

  @SID_13
  Scenario: validate Geo Location
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "SAU" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "SOM" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "IRQ" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "YEM" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "RWA" is "CONTAINS" to "fill: rgb(244, 20, 20)"

  @SID_14
  Scenario: select part of Application
    When UI Do Operation "Select" item "Applications"
    Then UI Select scope from dashboard and Save Filter device type "appwall"
      | Default Web Application |

  @SID_15
  Scenario: validate 3 upper widgets - part apps
    Then UI Text of "blocked Events value" equal to "10"
    Then UI Text of "reported Events value" equal to "0"
    Then UI Text of "modified Events value" equal to "0"

  @SID_16
  Scenario: validate OWASP Top 10 -part Apps
    Then UI Validate Pie Chart data "OWASPCATEGORY"
      | label | data |
      | A1    | 5    |
      | A5    | 5    |

  @SID_17
  Scenario: validate Top Attack Category - part apps
    Then UI Validate Text field "TopAttackCategory_value" with params "Access Control" EQUALS "5"
    Then UI Validate Text field "TopAttackCategory_value" with params "HTTP RFC Violations" EQUALS "5"
    Then UI Validate Element Existence By Label "TopAttackCategory_value" if Exists "false" with value "Misconfiguration"
    Then UI Validate Element Existence By Label "TopAttackCategory_value" if Exists "false" with value "Cross Site Scripting"
    Then UI Validate Element Existence By Label "TopAttackCategory_value" if Exists "false" with value "Injections"

  @SID_18
  Scenario: validate Top Sources - part apps
    Then UI Validate Text field "TopSources_value" with params "2.56.36.1" EQUALS "2"
    Then UI Validate Text field "TopSources_value" with params "2.88.0.1" EQUALS "2"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.109" EQUALS "2"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.149" EQUALS "2"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.217" EQUALS "2"

  @SID_19
  Scenario: validate Attack by Action - part apps
    Then UI Validate Pie Chart data "ACTION"
      | label   | data |
      | Blocked | 10   |

  @SID_20
  Scenario: validate Attack Severity - part apps
    Then UI Validate Pie Chart data "SEVERITY"
      | label | data |
      | High  | 10   |

  @SID_21
  Scenario: validate Top Attack Hosts - part apps
    Then UI Validate Text field "AttackHosts_value" with params "172.17.154.195" EQUALS "10"

  @SID_22
  Scenario: validate Geo Location
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "SAU" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "SOM" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "IRQ" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "YEM" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "RWA" is "CONTAINS" to "fill: rgb(244, 20, 20)"

  @SID_23
  Scenario: select part of Application
    When UI Do Operation "Select" item "Applications"
    Then UI Select scope from dashboard and Save Filter device type "appwall"
      | tun_http |

  @SID_24
  Scenario: validate 3 upper widgets - part apps
    Then UI Text of "blocked Events value" equal to "135"
    Then UI Text of "reported Events value" equal to "5"
    Then UI Text of "modified Events value" equal to "5"

  @SID_25
  Scenario: validate OWASP Top 10 - part apps
    Then UI Validate Pie Chart data "OWASPCATEGORY"
      | label | data |
      | A1    | 60   |
      | A5    | 50   |
      | A6    | 5    |
      | A7    | 30   |

  @SID_26
  Scenario: validate Top Attack Category - part apps
    Then UI Validate Text field "TopAttackCategory_value" with params "Injections" EQUALS "60"
    Then UI Validate Text field "TopAttackCategory_value" with params "Access Control" EQUALS "50"
    Then UI Validate Text field "TopAttackCategory_value" with params "Cross Site Scripting" EQUALS "30"
    Then UI Validate Text field "TopAttackCategory_value" with params "Misconfiguration" EQUALS "5"
    Then UI Validate Element Existence By Label "TopAttackCategory_value" if Exists "false" with value "HTTP RFC Violations"

  @SID_27
  Scenario: validate Top Sources - part apps
    Then UI Validate Text field "TopSources_value" with params "2.56.36.1" EQUALS "28"
    Then UI Validate Text field "TopSources_value" with params "2.88.0.1" EQUALS "28"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.109" EQUALS "28"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.149" EQUALS "28"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.217" EQUALS "28"

  @SID_28
  Scenario: validate Attack by Action - part apps
    Then UI Validate Pie Chart data "ACTION"
      | label    | data |
      | Blocked  | 135  |
      | Modified | 5    |
      | Reported | 5    |

  @SID_29
  Scenario: validate Attack Severity - part apps
    Then UI Validate Pie Chart data "SEVERITY"
      | label    | data |
      | High     | 125  |
      | Critical | 5    |
      | Info     | 5    |
      | Low      | 5    |
      | Warning  | 5    |

  @SID_30
  Scenario: validate Top Attack Hosts - part apps
    Then UI Validate Text field "AttackHosts_value" with params "172.17.154.195" EQUALS "145"

  @SID_31
  Scenario: validate Geo Location
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "SAU" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "SOM" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "IRQ" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "YEM" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "RWA" is "CONTAINS" to "fill: rgb(244, 20, 20)"

  @SID_32
  Scenario: select all Applications
    When UI Do Operation "Select" item "Applications"
    Then UI Select scope from dashboard and Save Filter device type "appwall"
      | All |

  @SID_33
  Scenario: Change time selection and verify no attack
    Then UI Do Operation "Select" item "Global Time Filter"
    Then UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"


  @SID_34
  Scenario: validate 3 upper widgets
    Then UI Text of "blocked Events value" equal to "291"
    Then UI Text of "reported Events value" equal to "10"
    Then UI Text of "modified Events value" equal to "10"

  @SID_35
  Scenario: validate OWASP Top 10
    Then UI Validate Pie Chart data "OWASPCATEGORY"
      | label | data |
      | A1    | 131  |
      | A5    | 110  |
      | A6    | 10   |
      | A7    | 60   |

  @SID_36
  Scenario: validate Top Attack Category
    Then UI Validate Text field "TopAttackCategory_value" with params "Injections" EQUALS "121"
    Then UI Validate Text field "TopAttackCategory_value" with params "Access Control" EQUALS "110"
    Then UI Validate Text field "TopAttackCategory_value" with params "Cross Site Scripting" EQUALS "60"
    Then UI Validate Text field "TopAttackCategory_value" with params "Misconfiguration" EQUALS "10"
    Then UI Validate Text field "TopAttackCategory_value" with params "HTTP RFC Violations" EQUALS "10"

  @SID_37
  Scenario: validate Top Sources
    Then UI Validate Text field "TopSources_value" with params "2.56.36.1" EQUALS "60"
    Then UI Validate Text field "TopSources_value" with params "2.88.0.1" EQUALS "60"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.109" EQUALS "60"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.149" EQUALS "60"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.217" EQUALS "60"

  @SID_38
  Scenario: validate Attack by Action
    Then UI Validate Pie Chart data "ACTION"
      | label    | data |
      | Blocked  | 291  |
      | Modified | 10   |
      | Reported | 10   |

  @SID_39
  Scenario: validate Attack Severity
    Then UI Validate Pie Chart data "SEVERITY"
      | label    | data |
      | High     | 271  |
      | Critical | 10   |
      | Info     | 10   |
      | Low      | 10   |
      | Warning  | 10   |

  @SID_40
  Scenario: validate Top Attack Hosts
    Then UI Validate Text field "AttackHosts_value" with params "172.17.154.195" EQUALS "311"

  @SID_41
  Scenario: validate Geo Location
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "SAU" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "SOM" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "IRQ" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "YEM" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "RWA" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "FRA" is "CONTAINS" to "fill: rgb(244, 20, 20)"

  @SID_42
  Scenario: select part of Application
    When UI Do Operation "Select" item "Applications"
    Then UI Select scope from dashboard and Save Filter device type "appwall"
      | Default Web Application |

  @SID_43
  Scenario: validate 3 upper widgets - part apps
    Then UI Text of "blocked Events value" equal to "20"
    Then UI Text of "reported Events value" equal to "0"
    Then UI Text of "modified Events value" equal to "0"

  @SID_44
  Scenario: validate OWASP Top 10 -part Apps
    Then UI Validate Pie Chart data "OWASPCATEGORY"
      | label | data |
      | A1    | 10   |
      | A5    | 10   |

  @SID_45
  Scenario: validate Top Attack Category - part apps
    Then UI Validate Text field "TopAttackCategory_value" with params "Access Control" EQUALS "10"
    Then UI Validate Text field "TopAttackCategory_value" with params "HTTP RFC Violations" EQUALS "10"
    Then UI Validate Element Existence By Label "TopAttackCategory_value" if Exists "false" with value "Misconfiguration"
    Then UI Validate Element Existence By Label "TopAttackCategory_value" if Exists "false" with value "Cross Site Scripting"
    Then UI Validate Element Existence By Label "TopAttackCategory_value" if Exists "false" with value "Injections"

  @SID_46
  Scenario: validate Top Sources - part apps
    Then UI Validate Text field "TopSources_value" with params "2.56.36.1" EQUALS "4"
    Then UI Validate Text field "TopSources_value" with params "2.88.0.1" EQUALS "4"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.109" EQUALS "4"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.149" EQUALS "4"
    Then UI Validate Text field "TopSources_value" with params "5.62.61.217" EQUALS "4"

  @SID_47
  Scenario: validate Attack by Action - part apps
    Then UI Validate Pie Chart data "ACTION"
      | label   | data |
      | Blocked | 20   |

  @SID_48
  Scenario: validate Attack Severity - part apps
    Then UI Validate Pie Chart data "SEVERITY"
      | label | data |
      | High  | 20   |

  @SID_49
  Scenario: validate Top Attack Hosts - part apps
    Then UI Validate Text field "AttackHosts_value" with params "172.17.154.195" EQUALS "20"

  @SID_50
  Scenario: validate Geo Location
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "SAU" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "SOM" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "IRQ" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "YEM" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "RWA" is "CONTAINS" to "fill: rgb(244, 20, 20)"
    And UI Validate the attribute "style" Of Label "Map.Country" With Params "FRA" is "CONTAINS" to "fill: rgb(93, 95, 97)"


  @SID_51 @Sanity
  Scenario: Cleanup
#    Then REST Delete Device By IP "172.17.164.30"
    Then UI logout and close browser
    Then CLI Check if logs contains
      | logType     | expression                                              | isExpected   |
      | ES          | fatal\|error                                            | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error                                            | NOT_EXPECTED |
      | JBOSS       | fatal                                                   | NOT_EXPECTED |
      | TOMCAT      | fatal\|error                                            | NOT_EXPECTED |
      | TOMCAT2     | fatal\|error                                            | NOT_EXPECTED |
      | TOMCAT      | parsing data error for device:50.50                     | IGNORE       |
      | TOMCAT      | failed to get response from device=172.17.164.17        | IGNORE       |
      | TOMCAT      | failed to get response from device=172.17.164.18        | IGNORE       |
      | MAINTENANCE | /ErrorPages/HTTP50                                      | IGNORE       |
      | MAINTENANCE | /ErrorPages/HTTP40                                      | IGNORE       |
      | MAINTENANCE | /opt/radware/storage/mgt-server/third-party/nginx/error | IGNORE       |
      | TOMCAT2     | HeapDumpOnOutOfMemoryError                              | IGNORE       |
      | MAINTENANCE | redirect the virtual ErrorPages path the real path      | IGNORE       |
      | TOMCAT2     | authentication.okta.jwt                                 | IGNORE       |

