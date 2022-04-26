@TC110292
Feature: Update GEO Location Feed Scheduler Task

  @SID_1
  Scenario: Login
    Given UI Login with user "sys_admin" and password "radware"

  @SID_2
  Scenario: Remove "RadwareLocationBasedUpdates" File from Server
    Then CLI Run remote linux Command "docker exec -it config_kvision-configuration-service_1 sh -c "rm -f /opt/radware/storage/mis/geoip/RadwareLocationBasedUpdates.tar.gz"" on "ROOT_SERVER_CLI"

  @SID_3
  Scenario: Add New "Update GEO Location Feed" Task
    When UI Remove All Tasks with tha Value "Geolocation Feed" at Column "Task Type"
    Then UI Add New 'Update GEO Location Feed' Task with Name "GEO Location Feed" , Schedule Run Daily at Time "01:55:00" , and the Target Device List are:
      | DefensePro_172.17.50.50 |

  @SID_4
  Scenario: Run Task and Validate the File was Downloaded
    Given CLI Run linux Command "docker exec -it config_kvision-configuration-service_1 sh -c "ls /opt/radware/storage/mis/geoip/" | wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
    Then UI Run task with name "GEO Location Feed"
    Then CLI Run linux Command "docker exec -it config_kvision-configuration-service_1 sh -c "ls /opt/radware/storage/mis/geoip/"" on "ROOT_SERVER_CLI" and validate result EQUALS "RadwareLocationBasedUpdates.tar.gz"


      # check DefenseFlow succeed to get GEO location
  #@SID_10

      # Test schedule task success + Alert
  @SID_11
  Scenario: validate task succed
    When UI Navigate to "SCHEDULER" page via homePage
    Then UI validate Vision Table row by keyValue with elementLabel "scheduledTasks" findBy columnName "Name" findBy KeyValue "GEO Location Feed"
      | columnName            | value   | isDate |
      | Last Execution Status | Success | false  |


      # Add lalt DP devices
  @SID_12
  Scenario: Add lalt DP devices
    When REST Add "DefensePro" Device To topology Tree with Name "DefensePro_50.50.100.1" and Management IP "50.50.100.1" into site "Default"
      | attribute | value |
#    Then REST Add "DefensePro" Device To topology Tree with Name "FakeDP" and Management IP "4.4.4.5" into site "Default"
#      | attribute | value |
    When Sleep "30"
    And Browser Refresh Page

    When UI Remove All Tasks with tha Value "Geolocation Feed" at Column "Task Type"
    Then UI Add New 'Update GEO Location Feed' Task with Name "GEO Location Feed" , Schedule Run Daily at Time "01:55:00" , and the Target Device List are:
      | DefensePro_50.50.100.1 |


      # Test schedule task Failed + Alert
  @SID_13
  Scenario: validate task succed
    When UI Navigate to "SCHEDULER" page via homePage
    Then UI validate Vision Table row by keyValue with elementLabel "scheduledTasks" findBy columnName "Name" findBy KeyValue "GEO Location Feed"
      | columnName            | value          | isDate |
      | Last Execution Status | Never Executed | false  |

    # to do - fix alerts after failure - failure will be needed for critical alerts popup.
#    Then UI Validate that after "testFeed" DDos feed task finished we have alert with message
#      | M_01088: Failed to run task logic for task GEO Location Feed. |



  @SID_5
  Scenario: verify MIS request only for DPs version 8.19 and above when their status is UP
    When CLI copy "/home/radware/Scripts/validDPsOnGeoIPTaskValidation.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    Then CLI Run linux Command "/validDPsOnGeoIPTaskValidation.sh" on "ROOT_SERVER_CLI" and validate result EQUALS "Success"

  @SID_6
  Scenario: Logout
    Then UI logout and close browser
