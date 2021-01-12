@VisionSettings @TC106049

Feature: APSolute Vision Reporter Functionality

  @SID_1
  Scenario: Login and Navigate to APSolute Vision Reporter page
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->APSolute Vision Reporter"
    Then CLI Run remote linux Command "echo 'cleared' $(date) > /var/avr/diaglogs/mainenginediag.log" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: Set APSolute Vision Reporter - Parameters
    Then UI Select "16" from Vision dropdown "Data Retention Interval"
    Then UI Click Button "Submit"
    Then UI Select "17" from Vision dropdown "Data Retention Interval"
    Then UI Click Button "Submit"

  @SID_3
  Scenario: Validate AVR restart flag set
    Then CLI Run linux Command "ll /opt/radware/storage/maintenance/avr_need_to_restart.txt |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_4
  Scenario: Validate attack polling interval
    Then REST get APSolute Vision Reporter Parameters "attackPollingInterval"
    Then UI Validate Text field "Attack Polling Interval" EQUALS "5"

  @SID_5
  Scenario: Validate AVR parameter in config file
    Then CLI Run linux Command "cat /var/avr/config.txt |awk -F "DataRetentionInterval=" '{printf $2}';echo" on "ROOT_SERVER_CLI" and validate result EQUALS "17"

  @SID_6
  Scenario: Validate AVR restart flag cleared
    Then CLI Run linux Command "ll /opt/radware/storage/maintenance/avr_need_to_restart.txt |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "0" Retry 660 seconds

  @SID_7
  Scenario: Validate AVR restarted
    Then CLI Run linux Command "grep -o -a "Starting APSolute Vision Reporter Server" /var/avr/diaglogs/mainenginediag.log" on "ROOT_SERVER_CLI" and validate result EQUALS "Starting APSolute Vision Reporter Server" Retry 300 seconds

  @SID_8
  Scenario: Set APSolute Vision Reporter - Parameters
    Then UI Select "12" from Vision dropdown "Data Retention Interval"
    Then UI Click Button "Submit"

  @SID_9
  Scenario: Logout
    Then UI logout and close browser

