Feature: Edit  tests

  @SID_1
  Scenario: Clean data before the test
#    * REST Delete ES index "dp-*"
#    * REST Delete ES index "df-traffic*"
#    * REST Delete ES index "appwall-v2-attack*"

  @SID_2
  Scenario: Login
    Then UI Login with user "sys_admin" and password "radware"

  @SID_3
  Scenario: Run DP simulator PCAPs for "DP attacks", "DF attacks" ,"HTTPS Flood attacks"
#    Given CLI simulate 1 attacks of type "many_attacks" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds
#    Given CLI simulate 1 attacks of type "HTTPS" on "DefensePro" 11 with loopDelay 15000 and wait 60 seconds
#    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
#      | "/home/radware/curl_DF_attacks-auto_PO_100.sh " |
#      | #visionIP                                       |
#      | " Terminated"                                   |
#    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER"
#      | "/home/radware/curl_DF_attacks-auto_PO_200.sh " |
#      | #visionIP                                       |
#      | " Terminated"                                   |
#    When CLI Run remote linux Command on "GENERIC_LINUX_SERVER" and wait 30 seconds
#      | "/home/radware/curl_DF_attacks-auto_PO_300.sh " |
#      | #visionIP                                       |
#      | " Terminated"                                   |

  @SID_4
  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "ADC REPORTS" page via homepage
    Then UI Click Button "New Report Tab"
