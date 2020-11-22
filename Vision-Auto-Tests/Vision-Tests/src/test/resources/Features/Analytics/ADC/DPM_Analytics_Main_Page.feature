@Analytics_ADC @TC105964
Feature: DPM Analytics Main Page

  @SID_1 @Sanity
  Scenario: Import driver script and jar file
    Then CLI copy "/home/radware/Scripts/upload_DD.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.2.1.0-DD-1.00-110.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"
    Then CLI copy "/home/radware/Scripts/Alteon-32.4.0.0-DD-1.00-396.jar" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/opt/radware/storage"

  @SID_2 @Sanity
  Scenario: Upload Driver to vision
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.2.1.0-DD-1.00-110.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then CLI Run remote linux Command "/opt/radware/storage/upload_DD.sh /opt/radware/storage/Alteon-32.4.0.0-DD-1.00-396.jar" on "ROOT_SERVER_CLI" with timeOut 240
    Then Sleep "50"

  @SID_3 @Sanity
  Scenario: Validate server fetched all applications after upgrade
    Then CLI copy "/home/radware/Scripts/fetch_num_of_real_alteons_apps.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/root/"
    Then Validate existence of Real Alteon Apps
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -k -XPOST -H "Cookie: JSESSIONID=$jsession" -d '{}' https://localhost:443/mgmt/system/monitor/dpm/alteon/fetch" on "ROOT_SERVER_CLI"
    Then Sleep "25"

  @Sanity @SID_4
  Scenario: Login to ADC application dashboard
    Given CLI Reset radware password
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Then UI Login with user "ADC_Administrator_auto_fake" and password "radware"

    Then UI Navigate to "ADC Reports" page via homePage

    Then UI Navigate to "Application Dashboard" page via homePage

  @Sanity @SID_5
  Scenario: DPM - Validate device's amount and status
    #the space is another div that is part of css therefore we have no space
    Then UI Text of "Application Selection" equal to "APPLICATIONS10/10"
    Then UI Text of "upDevices" equal to "3"
    Then UI Text of "maintenanceDevices" equal to "0"
    Then UI Text of "downDevices" equal to "0"


# validate top charts section
  # validate main page with default values - before any selection
  # Status Chart validation
  @SID_6
  Scenario: TC104110: DPM - Validate Dashboards Charts data for all selected virtual service - default view
    Then UI Validate Pie Chart data "VIRTUAL SERVICES"
      | label      | data |
      | Down       | 2    |
      | Up         | 2    |
      | Warning    | 2    |
      | Admin Down | 2    |
      | Shutdown   | 2    |


  # Total statistics Chart validation
  @SID_7
  Scenario: Validate Dashboards "Total statistics" Chart data for all virtual service - default view
    Then UI Text of "Statistics.Summary" with extension "Throughput" equal to "6.57 M"
    Then UI Text of "Statistics.Summary" with extension "cps" equal to "858"
    Then UI Text of "Statistics.Summary" with extension "concurrenConnections" equal to "178"


  # Top Application by Throughput Chart validation
  @SID_8
  Scenario: Validate Dashboards "Top Application by Throughput" Chart data values for all virtual service - default view
    Then UI Text of "TopByThroughput_virtName" with extension "0" equal to "1_32326516:80"
    Then UI Text of "TopByThroughput_value" with extension "0" equal to "4.29 M"
    Then  UI Validate element "TopByThroughput_progress" attribute with param "0"
      | name  | value       |
      | style | width: 100% |
    Then UI Text of "TopByThroughput_virtName" with extension "1" equal to "1_32326515:80"
    Then UI Text of "TopByThroughput_value" with extension "1" equal to "2.29 M"
    Then  UI Validate element "TopByThroughput_progress" attribute with param "1"
      | name  | value      |
      | style | width: 53% |
    Then UI Text of "TopByThroughput_virtName" with extension "2" equal to "Rejith_32326516:443"
    Then UI Text of "TopByThroughput_value" with extension "2" equal to "38"
#    Then UI Text of "TopByThroughput_virtName" with extension "2" equal to "Rejith_32326516:80"
    Then UI Text of "TopByThroughput_value" with extension "3" equal to "31"
    Then UI Text of "TopByThroughput_value" with extension "4" equal to "31"
#
#
  # Top Application by Requests (per sec) Chart validation - TBD

  @SID_9
  Scenario: Validate Dashboards "Top Application by Request Per Second" Chart data values for all virtual service - default view
    Then UI Text of "TopByRPS_virtName" with extension "0" equal to "1_32326516:80"
    Then UI Text of "TopByRPS_value" with extension "0" equal to "454"
    Then UI Validate element "TopByRPS_progress" attribute with param "0"
      | name  | value       |
      | style | width: 100% |
    Then UI Text of "TopByRPS_virtName" with extension "1" equal to "1_32326515:80"
    Then UI Text of "TopByRPS_value" with extension "1" equal to "250"
    Then UI Validate element "TopByRPS_progress" attribute with param "1"
      | name  | value      |
      | style | width: 55% |
    Then UI Text of "TopByRPS_virtName" with extension "2" equal to "Rejith_32326516:443"
    Then UI Text of "TopByRPS_value" with extension "2" equal to "129"
    Then UI Validate element "TopByRPS_progress" attribute with param "2"
      | name  | value      |
      | style | width: 28% |
    Then UI Text of "TopByRPS_virtName" with extension "3" equal to "Rejith_32326516:80"
    Then UI Text of "TopByRPS_value" with extension "3" equal to "108"
    Then UI Validate element "TopByRPS_progress" attribute with param "3"
      | name  | value      |
      | style | width: 24% |
    Then UI Text of "TopByRPS_value" with extension "4" equal to "108"
    Then UI Validate element "TopByRPS_progress" attribute with param "4"
      | name  | value      |
      | style | width: 24% |

  # ---------------- Table tests ---------------------- #

  # table content


  @SID_10
  Scenario: Validate table row amount - default view
    Then UI Validate "virts table" Table rows count EQUALS to 10

  @SID_11
  Scenario: Validate table row content - default view
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1_32326516:80"
      | columnName             | value         |
      | Application Name       | 1_32326516:80 |
      | Protocol               | http          |
      | IP Address             | 101.41.1.100  |
      | Throughput(bps)        | 4.29 M        |
      | Connectionsper Second  | 446           |
      | ConcurrentConnections  | 3             |
      | Groups(Up/Total)       | 0/2           |
      | Real Servers(Up/Total) | 0/13          |
#    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:200"
#      | columnName             | value           |
#      | Application Name       | virtserver1:200 |
#      | Protocol               | basic-slb       |
#      | IP Address             | 66.66.66.66     |
#      | Throughput(bps)        | 0               |
#      | Connectionsper Second  | 0               |
#      | ConcurrentConnections  | 0               |
#      | Groups(Up/Total)       | 0/1             |
#      | Real Servers(Up/Total) | 0/3             |
#    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:443"
#      | columnName             | value           |
#      | Application Name       | virtserver1:443 |
#      | Protocol               | https           |
#      | IP Address             | 66.66.66.66     |
#      | Throughput(bps)        | 0               |
#      | Connectionsper Second  | 0               |
#      | ConcurrentConnections  | 0               |
#      | Groups(Up/Total)       | 0/1             |
#      | Real Servers(Up/Total) | 0/4             |
#    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:80"
#      | columnName             | value          |
#      | Application Name       | virtserver1:80 |
#      | Protocol               | http           |
#      | IP Address             | 66.66.66.66    |
#      | Throughput(bps)        | 0              |
#      | Connectionsper Second  | 0              |
#      | ConcurrentConnections  | 0              |
#      | Groups(Up/Total)       | 0/2            |
#      | Real Servers(Up/Total) | 0/7            |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326516:443"
      | columnName             | value                |
      | Application Name       | Rejith_32326516:443  |
      | Protocol               | https                |
      | IP Address             | 3000:0:0:0:0:0:0:144 |
      | Throughput(bps)        | 38                   |
      | Connectionsper Second  | 40                   |
      | ConcurrentConnections  | 41                   |
      | Groups(Up/Total)       | 0/1                  |
      | Real Servers(Up/Total) | 3/3                  |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234_32326516:80"
      | columnName             | value            |
      | Application Name       | 1234_32326516:80 |
      | Protocol               | http             |
      | IP Address             | 101.41.1.101     |
      | Throughput(bps)        | 6                |
      | Connectionsper Second  | 8                |
      | ConcurrentConnections  | 9                |
      | Groups(Up/Total)       | 0/1              |
      | Real Servers(Up/Total) | 0/12             |


  @SID_12
  Scenario: Validate Table record tooltip values
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1_32326516:80"
      | columnName       | value         |
      | Application Name | 1_32326516:80 |
#    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:200"
#      | columnName       | value           |
#      | Application Name | virtserver1:200 |
#    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:443"
#      | columnName       | value           |
#      | Application Name | virtserver1:443 |
#    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtserver1:80"
#      | columnName       | value          |
#      | Application Name | virtserver1:80 |
#    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:443"
#      | columnName       | value              |
#      | Application Name | virtualserver2:443 |
#    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver2:80"
#      | columnName       | value             |
#      | Application Name | virtualserver2:80 |
#    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:110"
#      | columnName       | value              |
#      | Application Name | virtualserver3:110 |
#    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:443"
#      | columnName       | value              |
#      | Application Name | virtualserver3:443 |
#    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:80"
#      | columnName       | value             |
#      | Application Name | virtualserver3:80 |
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1234_32326516:80"
      | columnName       | value            |
      | Application Name | 1234_32326516:80 |
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326515:80"
      | columnName       | value              |
      | Application Name | Rejith_32326515:80 |
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326515:88"
      | columnName       | value              |
      | Application Name | Rejith_32326515:88 |
    Then UI Validate Table record tooltip values with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326515:443"
      | columnName       | value               |
      | Application Name | Rejith_32326515:443 |

# Sort tests
  @SID_13
  Scenario: TC103709 - Validate virtual services table by StatusSorting - default view
    When UI Click Button "ApplicationNameSorting"
    Then UI Validate Table "virts table" is Sorted by
      | columnName       | order     | compareMethod |
      | Application Name | Ascending | ALPHABETICAL  |
    When UI Click Button "ThroughputSorting"
    When UI Click Button "ThroughputSorting"
    Then UI Validate Table "virts table" is Sorted by
      | columnName      | order      | compareMethod  |
      | Throughput(bps) | DESCENDING | BIT_BYTE_UNITS |
    When UI Click Button "CpsSorting"
    When UI Click Button "CpsSorting"
    Then UI Validate Table "virts table" is Sorted by
      | columnName            | order      | compareMethod |
      | Connectionsper Second | DESCENDING | NUMERICAL     |
    When UI Click Button "ConcurrentConnectionsSorting"
    When UI Click Button "ConcurrentConnectionsSorting"
    Then UI Validate Table "virts table" is Sorted by
      | columnName            | order      | compareMethod |
      | ConcurrentConnections | DESCENDING | NUMERICAL     |

# repeat tests after application selection
  @SID_14
  Scenario: Validate main page after application selection - virtual services
    When UI Do Operation "Select" item "Application Selection"
    Then UI Select scope from dashboard and Save Filter device type "Alteon"
      | 1_32326516:80       |
      | 1234_32326515:80    |
      | Rejith_32326516:443 |
      | Rejith_32326516:88  |
#      | virtualserver3:110  |
    Then UI Validate Pie Chart data "VIRTUAL SERVICES"
      | label      | data |
      | Down       | 1    |
      | Warning    | 1    |
      | Admin Down | 1    |
      | Up         | 1    |

# statistic summary widget

  @SID_15
  Scenario: Validate main page after application selection - summary widgets
#    Then UI Text of "Statistics.Summary" with extension "Throughput" equal to "4.29 M"
    Then UI Text of "Statistics.Summary" with extension "cps" equal to "525"
    Then UI Text of "Statistics.Summary" with extension "concurrenConnections" equal to "85"
  # Top Application by Throughput Chart validation
    Then UI Text of "TopByThroughput_virtName" with extension "0" equal to "1_32326516:80"
    Then UI Text of "TopByThroughput_value" with extension "0" equal to "4.29 M"
    Then UI Validate element "TopByThroughput_progress" attribute with param "0"
      | name  | value       |
      | style | width: 100% |
    Then UI Text of "TopByThroughput_virtName" with extension "1" equal to "Rejith_32326516:443"
    Then UI Text of "TopByThroughput_value" with extension "1" equal to "38"
    Then UI Text of "TopByThroughput_virtName" with extension "2" equal to "Rejith_32326516:88"
    Then UI Text of "TopByThroughput_value" with extension "2" equal to "31"
    Then UI Text of "TopByThroughput_virtName" with extension "3" equal to "1234_32326515:80"
    Then UI Text of "TopByThroughput_value" with extension "3" equal to "4"
    Then UI Validate Element Existence By Label "TopByThroughput_value" if Exists "false" with value "4"
  # Top Application by RPS Chart validation
    Then UI Text of "TopByRPS_virtName" with extension "0" equal to "1_32326516:80"
    Then UI Text of "TopByRPS_value" with extension "0" equal to "454"
    Then UI Validate element "TopByRPS_progress" attribute with param "0"
      | name  | value       |
      | style | width: 100% |
    Then UI Text of "TopByRPS_virtName" with extension "1" equal to "Rejith_32326516:443"
    Then UI Text of "TopByRPS_value" with extension "1" equal to "129"
    Then UI Validate element "TopByRPS_progress" attribute with param "1"
      | name  | value      |
      | style | width: 28% |
    Then UI Text of "TopByRPS_virtName" with extension "2" equal to "Rejith_32326516:88"
    Then UI Text of "TopByRPS_value" with extension "2" equal to "108"
    Then UI Validate element "TopByRPS_progress" attribute with param "2"
      | name  | value      |
      | style | width: 24% |
    Then UI Text of "TopByRPS_virtName" with extension "3" equal to "1234_32326515:80"
    Then UI Text of "TopByRPS_value" with extension "3" equal to "27"
    Then UI Validate element "TopByRPS_progress" attribute with param "3"
      | name  | value     |
      | style | width: 6% |
    Then UI Validate Element Existence By Label "TopByRPS_virtName" if Exists "false" with value "4"
#    validate table raw contents

  @SID_16
  Scenario: Validate main page after application selection - table content
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "1_32326516:80"
      | columnName             | value         |
      | Application Name       | 1_32326516:80 |
      | Protocol               | http          |
      | IP Address             | 101.41.1.100  |
      | Throughput(bps)        | 4.29 M        |
      | Connectionsper Second  | 446           |
      | ConcurrentConnections  | 3             |
      | Groups(Up/Total)       | 0/2           |
      | Real Servers(Up/Total) | 0/13          |
#    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "virtualserver3:110"
#      | columnName             | value              |
#      | Application Name       | virtualserver3:110 |
#      | Protocol               | pop3               |
#      | IP Address             | 9.9.9.10           |
#      | Throughput(bps)        | 0                  |
#      | Connectionsper Second  | 0                  |
#      | ConcurrentConnections  | 0                  |
#      | Groups(Up/Total)       | 0/1                |
#      | Real Servers(Up/Total) | 0/3                |
    Then UI Validate Table record values by columns with elementLabel "virts table" findBy columnName "Application Name" findBy cellValue "Rejith_32326516:88"
      | columnName             | value                |
      | Application Name       | Rejith_32326516:88   |
      | Protocol               | http                 |
      | IP Address             | 3000:0:0:0:0:0:0:144 |
      | Throughput(bps)        | 31                   |
      | Connectionsper Second  | 33                   |
      | ConcurrentConnections  | 34                   |
      | Groups(Up/Total)       | 0/1                  |
      | Real Servers(Up/Total) | 1/12                 |

  @SID_17
  Scenario: Validate main page after application selection - sorting name
    When UI Click Button "ApplicationNameSorting"
    Then UI Validate Table "virts table" is Sorted by
      | columnName       | order     | compareMethod |
      | Application Name | Ascending | ALPHABETICAL  |
  @SID_18
  Scenario: Validate main page after application selection - sorting Throughput
    When UI Click Button "ThroughputSorting"
    When UI Click Button "ThroughputSorting"
    Then UI Validate Table "virts table" is Sorted by
      | columnName      | order      | compareMethod  |
      | Throughput(bps) | DESCENDING | BIT_BYTE_UNITS |
  @SID_19
  Scenario: Validate main page after application selection - sorting CPS
    When UI Click Button "CpsSorting"
    When UI Click Button "CpsSorting"
    Then UI Validate Table "virts table" is Sorted by
      | columnName            | order      | compareMethod |
      | Connectionsper Second | DESCENDING | NUMERICAL     |
  @SID_20
  Scenario: Validate main page after application selection - sorting concurrent
    When UI Click Button "ConcurrentConnectionsSorting"
    When UI Click Button "ConcurrentConnectionsSorting"
    Then UI Validate Table "virts table" is Sorted by
      | columnName            | order      | compareMethod |
      | ConcurrentConnections | DESCENDING | NUMERICAL     |


# This Cleanup scenario restores the Alteons initial condition in case scenarios failed during this feature tests.
# it does that in addition to regular cleanup
  @Sanity @SID_21
  Scenario: Verify VRM ADC logout
    Then UI logout and close browser
