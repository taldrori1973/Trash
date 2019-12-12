@TC111682
Feature: CLI System Statistics

  @SID_1
  Scenario: System Statistics menu
    When CLI Operations - Run Radware Session command "system statistics ?"
    Then CLI Operations - Verify that output contains regex "Displays system resources statistics."

  @SID_2
  Scenario: System Statistics menu
    When CLI Operations - Run Radware Session command "system statistics"
    Then CLI Operations - Verify that output contains regex ".*CPU User Mode.*"
    Then CLI Operations - Verify that output contains regex ".*CPU IO Wait.*"
    Then CLI Operations - Verify that output contains regex ".*Database disk usage.*"
    Then CLI Operations - Verify that output contains regex ".*RAM Utilization.*"
    Then CLI Operations - Verify that output contains regex ".*Network throughput.*"

  @SID_3
  Scenario: verify disk usage output is correct
    When CLI Run linux Command "if [ "$(/opt/radware/box/bin/system_statistics.sh |head -13|tail -1|awk '{print$10}')" == "$(df -hP /|tail -1|awk '{print$5}')" ]; then echo "statistics ok"; else echo "statistics not ok"; fi" on "ROOT_SERVER_CLI" and validate result EQUALS "statistics ok"

  @SID_4
  Scenario: verify no output errors
    When CLI Run linux Command "/opt/radware/box/bin/system_statistics.sh |grep -iE "error | fail" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0"
