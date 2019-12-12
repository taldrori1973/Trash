@TC106017
Feature: Jobs setups

  @NewVmTest @SID_1
  Scenario: Stop Machine
    When Stop VM Machine
      | VmMachinePrefix                     |
      | VisionAuto-WebUI-Sanity-4.10.00     |
      | VisionAuto-WebUI-Sanity-XXX-4.10.00 |
    Then first Time wizard
      | JenkinsJobName | FileNamePrefix | NewVmName                                 |
      | Vision-4.10    | Vision-4.10.00 | VisionAuto-WebUI-Sanity-4.10.00-Ramez     |
      | Vision-4.10    | Vision-4.10.00 | VisionAuto-WebUI-Sanity-XXX-4.10.00-Ramez |


  @Test @SID_2
  Scenario: Test
    * first Time wizard
      | JenkinsJobName | FileNamePrefix | NewVmName                                 |
      | Vision-4.10    | Vision-4.10.00 | Test                                      |
      | Vision-4.10    | Vision-4.10.00 | VisionAuto-WebUI-Sanity-XXX-4.10.00-Ramez |

  @jenkinsDebug @SID_3
  Scenario:Trying Debug
    Then UI Login with user "radware" and password "radware"
    And UI Open Upper Bar Item "ADC"
    And UI Open "Dashboards" Tab
    And UI Open "Application Dashboard" Sub Tab


  @VrmSetup @SID_4
  Scenario: Revert Vision1 to snapshot and run traffic
    * Revert Vision number 1 to "3.110-GA" snapshot
#    Clear history
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * CLI Clear vision logs
    #Attack
    Given CLI simulate 1 attacks of type "rest_dos_pps" on "DefensePro" 10 and wait 80 seconds
    Then CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}]}},"from":0,"size":1000}' >> /opt/radware/storage/maintenance/attack-raw-index-before-upgrade.txt" on "ROOT_SERVER_CLI"

  @AmsSetup @SID_5
  Scenario: Revert Vision2 to snapshot and run traffic
    * Revert Vision number 1 to "3.110-GA" snapshot
#    Clear history
    Then CLI kill all simulator attacks on current vision
    Then REST Delete ES index "dp-*"
    Then CLI Clear vision logs
    #Attack
    And Sleep "4"
    Given CLI simulate 1 attacks of type "rest_dos_pps" on "DefensePro" 10 and wait 80 seconds
    * CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}]}},"from":0,"size":1000}' >> /opt/radware/storage/maintenance/attack-raw-index-before-upgrade.txt" on "ROOT_SERVER_CLI"

  @VrmSetup @SID_6
  Scenario: Upgrade to latest
    * Upgrade vision to version "4.00", build ""
    When REST Vision Install License Request "vision-AVA-Max-attack-capacity"

  @AmsSetup @SID_7
  Scenario: Upgrade to latest
    * Upgrade vision to version "4.20", build ""
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    * CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}]}},"from":0,"size":1000}' >> /opt/radware/storage/maintenance/attack-raw-index-after-upgrade1.txt" on "ROOT_SERVER_CLI"

  @VrmSetup @SID_8
  @AmsSetup
  Scenario: Validate attack after upgrade
    * CLI Run remote linux Command "curl -X POST localhost:9200/dp-attack-raw-*/_search -d '{"query":{"bool":{"must":[{"match_all":{}}]}},"from":0,"size":1000}' >> /opt/radware/storage/maintenance/attack-raw-index-after-upgrade2.txt" on "ROOT_SERVER_CLI"
    Given UI Login with user "sys_admin" and password "radware"
    When UI Open Upper Bar Item "AMS"
    And UI Open "Dashboards" Tab
    And UI Open "DP Analytics" Sub Tab
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "1H"
    Then UI Validate StackBar data with widget "Top Attacks"
      | label              | value | legendName     |
      | pph_9Pkt_lmt_252.1 | 1     | pkt_rate_lmt_9 |

  @AmsSetup @SID_9
  @VrmSetup
  @jenkinsDebug
  Scenario: Cleanup
    Then UI logout and close browser

 ###################################     4.10    ###########################################



