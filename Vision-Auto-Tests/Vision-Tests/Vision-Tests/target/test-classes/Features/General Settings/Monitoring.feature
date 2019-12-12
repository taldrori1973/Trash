@VisionSettings @TC106060

Feature: Monitoring basic Functionality

  @SID_1
  Scenario: Add DP and Navigate to Monitoring page
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Add "DefensePro" with index 5 on "Default" site
    Then UI Wait For Device To Show Up In The Topology Tree "DefensePro" device with index 5 with timeout 300
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Monitoring"

  @SID_2
  Scenario: Monitoring - set timeout Parameters
    Then UI Set Text Field "Timeout for Device Status Poll" To "4000"
  @SID_3
  Scenario: Monitoring - set polling Parameters
    Then UI Set Text Field "Polling Interval for Device Status" To "20"
    Then UI Set Text Field "Polling Interval for Reports" To "16"
    Then UI Click Button "Submit"
  @SID_4
  Scenario: Monitoring - read to validate polling Parameters
    Then REST get Monitoring Parameters "deviceStatusPollSnmpTimeout" Expected result "4000"
    Then UI Validate Text field "Timeout for Device Status Poll" EQUALS ""
    Then REST get Monitoring Parameters "monIntervalForReports" Expected result "16"
    Then UI Validate Text field "Polling Interval for Reports" EQUALS ""
  @SID_5
  Scenario: Monitoring - verify device status every 20 sec
    Then Sleep "85"
#    Then CLI tcpDump Interval Validation with command "timeout 50 tcpdump -s 0 -i G1 -X port 161 and dst host 172.16.22.31 | grep sysObjectID" by Interval "10" with Threshold "1"
    Then CLI Run linux Command "logs;echo $(date --date=$(cat synchronization.log|grep "iteration started"|tail -1|awk '{print$2}') +"%s")-$(date --date=$(cat synchronization.log|grep "iteration started"|tail -2|head -1|awk '{print$2}') +"%s")|bc" on "ROOT_SERVER_CLI" and validate result EQUALS "20"
    Then CLI Run remote linux Command "logs; cp synchronization.log /opt/radware/storage/" on "ROOT_SERVER_CLI"
    Then CLI Check if logs contains
      | logType | expression                     | isExpected |
      | JBOSS   | deviceInspectionInterval is 20 | EXPECTED   |
  @SID_6
  Scenario: Monitoring - set polling Parameters
    Then UI Set Text Field "Polling Interval for Device Status" To "15"
    Then UI Set Text Field "Polling Interval for Reports" To "15"
    Then UI Click Button "Submit"
#    Then UI Validate Text field "Timeout for Device Status Poll" EQUALS ""

  @SID_7
  Scenario: Delete DP and logout
#    Then UI Delete "DefensePro" device with index 5 from topology tree
    Then UI Logout
    

