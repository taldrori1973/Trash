@TC110176
Feature: IPv6 Analytics test

  @SID_1
  Scenario: Login and cleanup
    Then CLI Run remote linux Command "curl -XDELETE localhost:9200/adc-system-raw-*" on "ROOT_SERVER_CLI"
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
#    Then REST Vision Install License Request "vision-reporting-module-ADC"
    Given UI Login with user "radware" and password "radware"

  @SID_2
  Scenario: Add new Alteon to site
    Then CLI Operations - Run Radware Session command "net ip delete G2"
    Then CLI Operations - Run Radware Session command "y"

    Then CLI Operations - Run Radware Session command " net ip set 5000::172:17:164:111 64 G2"
    Then CLI Operations - Run Radware Session command " net ip get"
    Then Sleep "2"
    Then CLI Run remote linux Command "ping6 -c 3 5000::50:50:101:21" on "ROOT_SERVER_CLI"
    Then REST Add "Alteon" Device To topology Tree with Name "Alteon_5000::50:50:101:21" and Management IP "5000::50:50:101:21" into site "Alteons_for_DPM-Fakes"
      | attribute     | value |
      | visionMgtPort | G2    |
    Then Browser Refresh Page
    Then UI Click Web element with id "gwt-debug-Global_Refresh"
    Then Sleep "240"

  @SID_3
  Scenario: Go to ADC network dashboard and enter device details
    Then UI Open Upper Bar Item "ADC"
    Then UI Open "Dashboards" Tab
    Then UI Open "Network and System Dashboard" Sub Tab
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_5000::50:50:101:21"

  @SID_4
  Scenario: Validate Throughput widget
    Then UI Click Button "Global Time Filter"
    Then UI Click Button "Global Time Filter.Quick Range" with value "2m"
    Then UI Click Button "Global Time Filter"
    Then UI Click Button "Global Time Filter.Quick Range" with value "2m"



    Then UI Validate Line Chart data "THROUGHPUT" with LabelTime
      | value      | count | countOffset |
      | 9045000000 | 4     | 2           |

#    Given UI Click Button "Global Time Filter"
#    When UI Click Button "Global Time Filter.Quick Range" with value "1m"
#    Then UI Validate Line Chart data "THROUGHPUT" with LabelTime
#      | value     | count | countOffset |
#      | 7545000.0 | 2     | 1           |

  @SID_5
  Scenario: Open ADC application dashboard
    Then UI Open "Reports" Tab
    Then UI Open "Dashboards" Tab
    Then UI Open "Application Dashboard" Sub Tab

  @SID_6
  Scenario: Delete Alteon devices from tree
    Then UI Open "Configurations" Tab
    Then UI open Topology Tree view "SitesAndClusters" site
    Then REST Delete Device By IP "5000::50:50:101:21"
    Then CLI Operations - Run Radware Session command "net ip delete G2"
    Then CLI Operations - Run Radware Session command "y"

  @SID_7
  Scenario: Logout
    Then UI logout and close browser