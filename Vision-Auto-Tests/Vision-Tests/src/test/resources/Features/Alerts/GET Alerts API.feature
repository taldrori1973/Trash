@TC108470
Feature: GET Alert API

  @SID_1
  Scenario:  Clear data and set TACACS login
    When REST Delete ES index "alert"
    When CLI Clear vision logs
    Then CLI Operations - Run Radware Session command "system user authentication-mode set TACACS+"
    # copy current vision management IP to the generic linux VM
    Then CLI Run remote linux Command "ip -f inet -o addr |grep -oP "172.17.1(\d{0,2}).(\d{1,3})" > /tmp/myip" on "ROOT_SERVER_CLI"
#    Then CLI copy "/tmp/myip" from "ROOT_SERVER_CLI" to "GENERIC_LINUX_SERVER" "/tmp"

  @SID_2
  Scenario:  Generate alert of type lock device
    Then REST Login with user "sys_admin" and password "radware"
    Then REST Unlock Action on "DefensePro_Set_1"
    Then REST Lock Action on "DefensePro_Set_1"


  @SID_3
  Scenario:  Verify correct result for filter MODULE,SEVERITY,DEVICE TYPE
    # vision IPv4 if omitted then /tmp/myip
    # module
    # severity
    # message
    # deviceType
    # max number of results
    # raisedTime
    # printf delimiter
    Then CLI Run linux Command "/home/radware/Scripts/GET_alert_API.sh "" "DEVICE_GENERAL" "INFO" "" "DEFENSE_PRO" "1" "2019-01-01" "message"" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "locked by user sys_admin" Retry 200 seconds

  @SID_4
  Scenario:  Verify correct result for filter NUMBER OF RESULTS
    When REST Delete ES index "alert"
    Then REST Unlock Action on "DefensePro_Set_1"
    Then Sleep "2"
    Then REST Lock Action on "DefensePro_Set_1"
    Then CLI Run linux Command "/home/radware/Scripts/GET_alert_API.sh "" "DEVICE_GENERAL" "INFO" "" "DEFENSE_PRO" "1" "2019-01-01" "" |grep -o "locked by"|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2" Retry 200 seconds
    Then CLI Run linux Command "/home/radware/Scripts/GET_alert_API.sh "" "DEVICE_GENERAL" "INFO" "" "DEFENSE_PRO" "20" "2019-01-01" "" |grep -o "locked by"|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "4"

  @SID_5
  Scenario:  Verify correct result for filter RAISED TIME
    Then CLI Run linux Command "/home/radware/Scripts/GET_alert_API.sh "" "DEVICE_GENERAL" "INFO" "" "DEFENSE_PRO" "2" "2119-01-01" "" |grep "locked by"|wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "0"

  @SID_6
  Scenario:  Verify correct result for filter max allowed results message
    Then CLI Run linux Command "/home/radware/Scripts/GET_alert_API.sh "" "DEVICE_GENERAL" "INFO" "" "DEFENSE_PRO" "301" "2019-01-01" "message"" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "The allowed \"maxrows\" parameter value should be between 1 and 300"

  @SID_7
  Scenario:  Verify correct result for filter MESSAGE
    Then CLI Run linux Command "/home/radware/Scripts/GET_alert_API.sh "" "" "" "locked%20by%20user%20sys_admin" "" "1" "2019-01-01" "message"" on "GENERIC_LINUX_SERVER" and validate result CONTAINS "locked by user sys_admin"

