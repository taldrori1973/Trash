@CLI_Positive @TC106034

Feature: Config-Sync

  @SID_1
  Scenario: system config-sync help
    When CLI Operations - Run Radware Session command "system config-sync ?"
    Then CLI Operations - Verify that output contains regex "intervals+Manages the configuration-synchronization interval."
    Then CLI Operations - Verify that output contains regex "mail_recipients\s+Manages the comma-separated list of email recipients who get notified about synchronization-process failures."
    Then CLI Operations - Verify that output contains regex "manuals+Manually starts a configuration-synchronization action."
    Then CLI Operations - Verify that output contains regex "missed_syncs\s+Manages the number of configuration synchronizations that can be missed before the system starts sending email notifications."
    Then CLI Operations - Verify that output contains regex "mode\s+Manages the configuration-synchronization mode."
    Then CLI Operations - Verify that output contains regex "peer\s+Manages the peer address."
    Then CLI Operations - Verify that output contains regex "status\s+Displays the configuration-synchronization status."

  @SID_2
  Scenario: system config-sync interval help
    When CLI Operations - Run Radware Session command "system config-sync interval ?"
    Then CLI Operations - Verify that output contains regex "get\s+Displays the configuration-synchronization interval \(in minutes\)."
    Then CLI Operations - Verify that output contains regex "set\s+Sets the configuration-synchronization interval \(in minutes\)."

  @SID_3
  Scenario: system config-sync interval set help
    When CLI Operations - Run Radware Session command "system config-sync interval set ?"
    Then CLI Operations - Verify that output contains regex "Usage: system config-sync interval set  <interval in minutes>"
    Then CLI Operations - Verify that output contains regex "Sets the configuration-synchronization interval \(in minutes\)."
    Then CLI Operations - Verify that output contains regex "Minimum allowed interval: 1 \(minute\)"
    Then CLI Operations - Verify that output contains regex "Maximum allowed interval: 1440 \(minutes = 24 hours\)"

  @SID_4
  Scenario: system config-sync interval set
    When CLI Operations - Run Radware Session command "system config-sync interval set 1"
    When CLI Operations - Run Radware Session command "system config-sync interval get"
    Then CLI Operations - Verify that output contains regex "Interval: 1\(Minutes\)"

  @SID_5
  Scenario: system config-sync interval get help
    When CLI Operations - Run Radware Session command "system config-sync interval get ?"
    Then CLI Operations - Verify that output contains regex "Usage: system config-sync interval get"
    Then CLI Operations - Verify that output contains regex "Displays the configuration-synchronization interval \(in minutes\)."

  @SID_6
  Scenario: system config-sync interval get
    When CLI Operations - Run Radware Session command "system config-sync interval set 2"
    When CLI Operations - Run Radware Session command "system config-sync interval get"
    Then CLI Operations - Verify that output contains regex "Interval: 2\(Minutes\)"
    When CLI Operations - Run Radware Session command "system config-sync interval set 3"
    When CLI Operations - Run Radware Session command "system config-sync interval get"
    Then CLI Operations - Verify that output contains regex "Interval: 3\(Minutes\)"

  @SID_7
  Scenario: system config-sync mode help
    When CLI Operations - Run Radware Session command "system config-sync mode ?"
    Then CLI Operations - Verify that output contains regex "get\s+Displays the configuration-synchronization mode."
    Then CLI Operations - Verify that output contains regex "set\s+Sets the configuration-synchronization mode."

  @SID_8
  Scenario: system config-sync mode set help
    When CLI Operations - Run Radware Session command "system config-sync mode set ?"
    Then CLI Operations - Verify that output contains regex "Sets the configuration-synchronization mode."
    Then CLI Operations - Verify that output contains regex "active\s+Sets the server mode to active."
    Then CLI Operations - Verify that output contains regex "disabled\s+Disables configuration synchronization."
    Then CLI Operations - Verify that output contains regex "standbys+Sets the server mode to standby."

  @SID_9
  Scenario: system config-sync mode get help
    When CLI Operations - Run Radware Session command "system config-sync mode get ?"
    Then CLI Operations - Verify that output contains regex ".*Usage: system config-sync mode get.*"
    Then CLI Operations - Verify that output contains regex ".*Displays the configuration-synchronization mode..*"


  @SID_10
  Scenario: system config-sync mode set disabled
    When CLI Set Config Sync Hosts
    When CLI Set config sync mode to "disabled" with timeout 3000
    When CLI Operations - Run Radware Session command "system config-sync mode get"
    Then CLI Operations - Verify last output contains
    |Mode: disabled|


  @SID_11
  Scenario: system config-sync mode set standby
    When CLI Set both visions disabled with timeout 3000
    When CLI Operations - Run Radware Session command "system config-sync mode set standby" timeout 60
    Then CLI Operations - Verify that output contains regex ".*Selecting the standby mode will stop the configuration service on the APSolute Vision server..*"
    Then CLI Operations - Verify that output contains regex ".*Continue?.*\(y/n\).*"
    When CLI Operations - Run Radware Session command "y" timeout 60
    When CLI Operations - Run Radware Session command "system config-sync mode get"
    Then CLI Operations - Verify last output contains
      |Mode: standby|


  @SID_12
  Scenario: system config-sync mode set active
    When CLI Server Start
    When CLI Operations - Run Radware Session command "system config-sync mode set disabled" timeout 3000
    When CLI Set config sync mode to "active" with timeout 300
    When CLI Operations - Run Radware Session command "system config-sync mode get"
    Then CLI Operations - Verify last output contains
      |Mode: active|


  @SID_13
  Scenario: system config-sync manual after disabled
    When CLI Set both visions disabled with timeout 3000
    When CLI Operations - Run Radware Session command "system config-sync manual" timeout 1000
    Then CLI Operations - Verify last output contains
      |Setting configuration-synchronization mode to active|


  @SID_14
  Scenario: system config-sync manual after active
    When CLI Set both visions disabled with timeout 3000
    When CLI Set config sync mode to "active" with timeout 1000
    When CLI Operations - Run Radware Session command "system config-sync manual" timeout 250
    Then CLI Operations - Verify that output contains regex ".*.*"

  @SID_15
  Scenario: system config-sync manual after standby
    When CLI Operations - Run Radware Session command "system config-sync mode set standby"
    When CLI Operations - Run Radware Session command "y" timeout 1000
    When CLI Operations - Run Radware Session command "system config-sync manual" timeout 250
    Then CLI Operations - Verify that output contains regex "Setting configuration-synchronization mode to active"


  @SID_16
  Scenario: system config-sync manual help
    When CLI Operations - Run Radware Session command "system config-sync manual ?" timeout 250
    Then CLI Operations - Verify that output contains regex "Usage: system config-sync manual"
    Then CLI Operations - Verify that output contains regex "Manually starts a configuration-synchronization action."

  @SID_17
  Scenario: system config-sync status help
    When CLI Operations - Run Radware Session command "system config-sync status ?"
    Then CLI Operations - Verify that output contains regex "Usage: system config-sync status"
    Then CLI Operations - Verify that output contains regex "Displays the configuration-synchronization status."

  @SID_18
  Scenario: system config-sync status disabled
    When CLI Operations - Run Radware Session command "system config-sync mode set disabled"
    When CLI Operations - Run Radware Session command "y" timeout 3000
    When CLI Operations - Run Radware Session command "system config-sync interval set 1"
    When CLI Operations - Run Radware Session command "system config-sync peer set 0.0.0.0"
    When CLI Operations - Run Radware Session command "system config-sync status"
    Then CLI Operations - Verify that output contains regex "Mode: disabled"
    Then CLI Operations - Verify that output contains regex "Interval: 1 \(Minutes\)"
    Then CLI Operations - Verify that output contains regex "Peer Address: 0.0.0.0"
    Then CLI Operations - Verify that output contains regex "Last Configuration Sync Date: NA"
    Then CLI Operations - Verify that output contains regex "Last Configuration Sync Timestamp: NA"

  @SID_19
  Scenario: system config-sync status active
    When CLI Set both visions disabled with timeout 3000
    When CLI Set config sync mode to "ACTIVE" with timeout 1000
    When CLI Operations - Run Radware Session command "system config-sync interval set 1"
    When CLI Operations - Run Radware Session command "system config-sync peer set 0.0.0.0"
    When CLI Operations - Run Radware Session command "system config-sync status"
    Then CLI Operations - Verify that output contains regex "Mode: active"
    Then CLI Operations - Verify that output contains regex "Interval: 1 \(Minutes\)"
    Then CLI Operations - Verify that output contains regex "Peer Address: 0.0.0.0"
    Then CLI Operations - Verify that output contains regex "Last Configuration Sync Date: \d+/\d+/\d+\s\d+:\d+:\d+"
    Then CLI Operations - Verify that output contains regex "Last Configuration Sync Timestamp:\d+"


  @SID_20
  Scenario: system config-sync peer help
    When CLI Operations - Run Radware Session command "system config-sync peer ?"
    Then CLI Operations - Verify that output contains regex "Manages the peer IP address or hostname."
    Then CLI Operations - Verify that output contains regex "get\s+Displays the peer address."
    Then CLI Operations - Verify that output contains regex "set\s+Sets the peer address."

  @SID_21
  Scenario: system config-sync peer set help
    When CLI Operations - Run Radware Session command "system config-sync peer set ?"
    Then CLI Operations - Verify that output contains regex "Usage: system config-sync peer set <address>"
    Then CLI Operations - Verify that output contains regex "Sets the peer IP address or hostname."

  @SID_22
  Scenario: system config-sync peer get help
    When CLI Operations - Run Radware Session command "system config-sync peer get ?"
    Then CLI Operations - Verify that output contains regex "Usage: system config-sync peer get <address>"
    Then CLI Operations - Verify that output contains regex "Displays the peer IP address or hostname."

  @SID_23
  Scenario: system config-sync peer set & get
    When CLI Operations - Run Radware Session command "system config-sync peer set 1.1.1.1"
    When CLI Operations - Run Radware Session command "system config-sync peer get"
    Then CLI Operations - Verify that output contains regex "Peer Address: 1.1.1.1"


  @SID_24
  Scenario: system config-sync mail_recipients help
    When CLI Operations - Run Radware Session command "system config-sync mail_recipients ?"
    Then CLI Operations - Verify that output contains regex "Manages the comma-separated list of email recipients who get notified about synchronization-process failures."
    Then CLI Operations - Verify that output contains regex "get\s+Displays the comma-separated list of email recipients who get notified about synchronization-process failures."
    Then CLI Operations - Verify that output contains regex "set\s+Sets the comma-separated list of email recipients who get notified about synchronization-process failures."

  @SID_25
  Scenario: system config-sync mail_recipients set help
    When CLI Operations - Run Radware Session command "system config-sync mail_recipients set ?"
    Then CLI Operations - Verify that output contains regex "Usage: system config-sync mail_recipients set  <mail list>"
    Then CLI Operations - Verify that output contains regex "Sets the comma-separated list of email recipients who get notified about synchronization-process failures."
    Then CLI Operations - Verify that output contains regex "Example:"
    Then CLI Operations - Verify that output contains regex "system config-sync mail_recipients set abc@corporation.com,johnd@corporation.com"

  @SID_26
  Scenario: system config-sync mail_recipients get help
    When CLI Operations - Run Radware Session command "system config-sync mail_recipients get ?"
    Then CLI Operations - Verify that output contains regex "Usage: system config-sync mail_recipients get"
    Then CLI Operations - Verify that output contains regex "Displays the comma-separated list of email recipients who get notified about synchronization-process failures."

  @SID_27
  Scenario: system config-sync mail_recipients set & get
    When CLI Operations - Run Radware Session command "system config-sync mail_recipients set 10"
    When CLI Operations - Run Radware Session command "system config-sync mail_recipients get"
    Then CLI Operations - Verify that output contains regex "Mail Recipients: 10"

  @SID_28
  Scenario: system config-sync missed_syncs help
    When CLI Operations - Run Radware Session command "system config-sync missed_syncs ?"
    Then CLI Operations - Verify that output contains regex "Manages the number of configuration synchronizations that can be missed before the system starts sending email notifications."
    Then CLI Operations - Verify that output contains regex "Valid values: 0-20"
    Then CLI Operations - Verify that output contains regex "get\s+Displays the number of configuration synchronizations that can be missed before the system starts sending email notifications."
    Then CLI Operations - Verify that output contains regex "set\s+Sets the number of configuration synchronizations that can be missed before the system starts sending email notifications."

  @SID_29
  Scenario: system config-sync missed_syncs set help
    When CLI Operations - Run Radware Session command "system config-sync missed_syncs set ?"
    Then CLI Operations - Verify that output contains regex "Usage: system config-sync missed_syncs set  <amount>"
    Then CLI Operations - Verify that output contains regex "Sets the number of configuration synchronizations that can be missed before the system starts sending email notifications."
    Then CLI Operations - Verify that output contains regex "Valid values: 0-20"


  @SID_30
  Scenario: system config-sync missed_syncs get help
    When CLI Operations - Run Radware Session command "system config-sync missed_syncs get ?"
    Then CLI Operations - Verify that output contains regex "Usage: system config-sync missed_syncs get"
    Then CLI Operations - Verify that output contains regex "Displays the number of configuration synchronizations that can be missed before the system starts sending email notifications."


  @SID_31
  Scenario: system config-sync missed_syncs set & get
    When CLI Operations - Run Radware Session command "system config-sync missed_syncs set 0"
    When CLI Operations - Run Radware Session command "system config-sync missed_syncs get"
    Then CLI Operations - Verify that output contains regex "Missed Syncs: 0"
    When CLI Operations - Run Radware Session command "system config-sync missed_syncs set 20"
    When CLI Operations - Run Radware Session command "system config-sync missed_syncs get"
    Then CLI Operations - Verify that output contains regex "Missed Syncs: 20"
    When CLI Operations - Run Radware Session command "system config-sync missed_syncs set 21"
    Then CLI Operations - Verify that output contains regex "Error. Values for "missed_syncs" must be in the range 0-20."
    When CLI Operations - Run Radware Session command "system config-sync missed_syncs set -1"
    Then CLI Operations - Verify that output contains regex "Error. Values for "missed_syncs" must be in the range 0-20."
    When CLI Operations - Run Radware Session command "system config-sync missed_syncs set 10"
    When CLI Operations - Run Radware Session command "system config-sync missed_syncs get"
    Then CLI Operations - Verify that output contains regex "Missed Syncs: 10"

  @SID_32
  Scenario: Verify services are running
    Then CLI validate service "all" status is "up" and health is "healthy" retry for 600 seconds

  @SID_33
  Scenario: set config-sync mode to disabled
    Then CLI Set both visions disabled with timeout 3000

