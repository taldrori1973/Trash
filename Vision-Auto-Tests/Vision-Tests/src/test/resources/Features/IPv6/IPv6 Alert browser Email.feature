@TC112397
Feature: IPv6 Alert Browser Email

  @SID_1
  Scenario: IPv6 Login and go to email settings
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    And UI Go To Vision
    Then UI Navigate to page "System->General Settings->Alert Settings->Alert Browser"

  @SID_2
  Scenario: IPv6 Configure email settings
    When UI Do Operation "select" item "Email Reporting Configuration"
    Then UI Set Checkbox "Enable Detailed Auditing of APSolute Vision Activity" To "false"
    Then UI Set Checkbox "Enable" To "true"
    Then UI Set Text Field "SMTP Server Address" To "200a::172:17:164:10"
    Then UI Set Text Field "SMTP User Name" To "ipv6@automation.local"
    Then UI Set Text Field "Subject Header" To "This is ipv6 automated test"
    Then UI Set Text Field "From Header" To "Automation system"
    Then UI Set Text Field "Recipient Email Address" To "ipv6@adc.local"
    Then UI Click Button "Submit"

  @SID_3
  Scenario: Clear email server logs
    Then CLI Run remote linux Command "echo "cleared" $(date) > /var/spool/mail/adcuser" on "GENERIC_LINUX_SERVER"

  @SID_4
  Scenario: IPv6 generate alert
    Then UI Set Checkbox "Enable Detailed Auditing of APSolute Vision Activity" To "true"
    Then UI Click Button "Submit"
    Then Sleep "32"

  @SID_5
  Scenario: IPv6 verify alert details in email server
    Then CLI Run linux Command "grep "Received" /var/spool/mail/adcuser" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Received: from vision.radware (ipv6.1.automation [IPv6:200a::172:17:164:111])"
    Then CLI Run linux Command "grep "Subject" /var/spool/mail/adcuser" on "GENERIC_LINUX_SERVER" and validate result EQUALS "Subject: This is ipv6 automated test"
    Then CLI Run linux Command "grep "User radware changed the detailed APSolute Vision activity auditing alerts feature to enabled" /var/spool/mail/adcuser |wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

  @SID_6
  Scenario: IPv6 disable alerts emails
    Then UI Set Checkbox "Enable" To "false"
    Then UI Click Button "Submit"

  @SID_7
  Scenario: IPv6 Cleanup
    Then UI Logout
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |
      | ALL     | error      | NOT_EXPECTED |
      | ALL     | fail       | NOT_EXPECTED |