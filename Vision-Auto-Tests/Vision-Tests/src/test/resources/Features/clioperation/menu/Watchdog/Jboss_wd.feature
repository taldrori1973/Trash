@TC117279
Feature: JBOSS WATCHDOG

  @SID_1
  Scenario: setup
    Given CLI Reset radware password
    #Remove previous setting if remained
    Given CLI Run remote linux Command "sed -i 's/#\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/g' /var/spool/cron/root" on "ROOT_SERVER_CLI" with timeOut 10
    #stop JBOSS cron schedule
    Given CLI Run remote linux Command "sed -i 's/\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/#\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/g' /var/spool/cron/root" on "ROOT_SERVER_CLI" with timeOut 10
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    And New Request Specification from File "Vision/Monitoring/Monitoring Settings" with label "Set Monitoring Settings"
    And The Request Body is the following Object
      | jsonPath                   | value |
      | $.deviceInspectionInterval | 3600  |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

  @SID_2
  Scenario: Stop service
    Given CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI" with timeOut 120
    When CLI Clear vision logs
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh" on "ROOT_SERVER_CLI" with timeOut 30
    Then CLI Check if logs contains
      | logType  | expression                   | isExpected   |
      | JBOSS_WD | Health check successful      | NOT_EXPECTED |
      | JBOSS_WD | Need to restart jboss        | NOT_EXPECTED |
      | JBOSS_WD | Jboss server is down         | NOT_EXPECTED |
      | JBOSS_WD | Restarting jboss             | NOT_EXPECTED |
      | JBOSS_WD | Jboss service is not running | EXPECTED     |

  @SID_3
  Scenario: Start service
    Given CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI" with timeOut 120
    When CLI Run linux Command "service vision status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Application Server is running." with timeOut 150
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh" on "ROOT_SERVER_CLI" with timeOut 120
    Then CLI Check if logs contains
      | logType  | expression                     | isExpected   |
      | JBOSS_WD | start jboss_watchdog_execution | EXPECTED     |
      | JBOSS_WD | Health check successful        | EXPECTED     |
      | JBOSS_WD | Number of threads .*           | EXPECTED     |
      | JBOSS_WD | Jboss server is up             | NOT_EXPECTED |
      | JBOSS_WD | Restarting jboss               | NOT_EXPECTED |

  @SID_4
  Scenario: WD killing process
    Given CLI Run remote linux Command "kill -9 $(lsof -t -i:8080)" on "ROOT_SERVER_CLI" with timeOut 120
    When CLI Clear vision logs
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh" on "ROOT_SERVER_CLI" with timeOut 30
    Then CLI Check if logs contains
      | logType  | expression                   | isExpected   |
      | JBOSS_WD | Jboss service is not running | EXPECTED     |
      | JBOSS_WD | Health check failed          | NOT_EXPECTED |
      | JBOSS_WD | Need to restart jboss        | NOT_EXPECTED |
      | JBOSS_WD | Jboss server is down         | NOT_EXPECTED |
      | JBOSS_WD | Restarting jboss             | NOT_EXPECTED |
      | JBOSS_WD | Number of threads .*         | NOT_EXPECTED |

  @SID_5
  Scenario: Block port 8080
    Given CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI" with timeOut 120
    Then CLI Run linux Command "service vision status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Application Server is running." with timeOut 150
    Given CLI Run remote linux Command "iptables -I RH-Firewall-1-INPUT 1 -p tcp --dport 8080 -d 127.0.0.1 -j DROP" on "ROOT_SERVER_CLI"
    When CLI Clear vision logs
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh" on "ROOT_SERVER_CLI" with timeOut 300
    Then CLI Check if logs contains
      | logType  | expression            | isExpected |
      | JBOSS_WD | Health check failed   | EXPECTED   |
      | JBOSS_WD | Need to restart jboss | EXPECTED   |
      | JBOSS_WD | Restarting jboss      | EXPECTED   |
      | JBOSS_WD | Jboss server is up    | EXPECTED   |

  @SID_6
  Scenario: Return to Normal
    Given CLI Run remote linux Command "iptables -D RH-Firewall-1-INPUT -p tcp --dport 8080 -d 127.0.0.1 -j DROP" on "ROOT_SERVER_CLI"
    When CLI Clear vision logs
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh" on "ROOT_SERVER_CLI" with timeOut 120
    Then CLI Check if logs contains
      | logType  | expression                     | isExpected   |
      | JBOSS_WD | Number of threads .*           | EXPECTED     |
      | JBOSS_WD | start jboss_watchdog_execution | EXPECTED     |
      | JBOSS_WD | Health check successful        | EXPECTED     |
      | JBOSS_WD | Jboss server is up             | NOT_EXPECTED |
      | JBOSS_WD | Restarting jboss               | NOT_EXPECTED |

  @SID_7
  Scenario: SNMP within limits
    Given CLI Run remote linux Command "echo "2" > /opt/radware/storage/maintenance/cancellation_exc_amount.txt" on "ROOT_SERVER_CLI"
    When CLI Clear vision logs
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh" on "ROOT_SERVER_CLI" with timeOut 30
    Then CLI Check if logs contains
      | logType  | expression                               | isExpected   |
      | JBOSS_WD | Number of threads .*                     | EXPECTED     |
      | JBOSS_WD | Cancellation file was found with value 2 | EXPECTED     |
      | JBOSS_WD | start jboss_watchdog_execution           | EXPECTED     |
      | JBOSS_WD | Health check successful                  | EXPECTED     |
      | JBOSS_WD | Jboss server is up                       | NOT_EXPECTED |
      | JBOSS_WD | Restarting jboss                         | NOT_EXPECTED |

  @SID_8
  Scenario: SNMP exceeding limits
    Given CLI Run remote linux Command "echo "3" > /opt/radware/storage/maintenance/cancellation_exc_amount.txt" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh" on "ROOT_SERVER_CLI" with timeOut 300
    Then CLI Check if logs contains
      | logType  | expression                               | isExpected |
      | JBOSS_WD | Cancellation file was found with value 3 | EXPECTED   |
      | JBOSS_WD | Need to restart jboss                    | EXPECTED   |
      | JBOSS_WD | Restarting jboss                         | EXPECTED   |
      | JBOSS_WD | Jboss server is up                       | EXPECTED   |

  @SID_9
  Scenario: Number of Threads exceeds the limit
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh | grep 'Number of threads'| cut -d ' ' -f 4" on "ROOT_SERVER_CLI" and validate result GTE "200" with timeOut 120
          # Change number of threads tor restart
    Given CLI Run remote linux Command "sed -i 's/watchdog.jboss.threads_threshold=2000/watchdog.jboss.threads_threshold=150/g' /opt/radware//mgt-server/properties/watchdogs.properties" on "ROOT_SERVER_CLI" with timeOut 10
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/watchdogs.sh" on "ROOT_SERVER_CLI" with timeOut 300
    Then CLI Check if logs contains
      | logType  | expression            | isExpected |
      | JBOSS_WD | Number of threads .*  | EXPECTED   |
      | JBOSS_WD | Need to restart jboss | EXPECTED   |
      | JBOSS_WD | Restarting jboss      | EXPECTED   |
      | JBOSS_WD | Jboss server is up    | EXPECTED   |

  @SID_10
  Scenario: Revert all back to normal
    Given CLI Run remote linux Command "sed -i 's/#\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/g' /var/spool/cron/root" on "ROOT_SERVER_CLI" with timeOut 10
    Given CLI Run remote linux Command "sed -i 's/watchdog.jboss.threads_threshold=150/watchdog.jboss.threads_threshold=2000/g' /opt/radware//mgt-server/properties/watchdogs.properties" on "ROOT_SERVER_CLI" with timeOut 10
    Then CLI Run linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh | grep 'Number of threads'| cut -d ' ' -f 4" on "ROOT_SERVER_CLI" and validate result GTE "200" with timeOut 120
    Given That Current Vision is Logged In With Username "radware" and Password "radware"
    And New Request Specification from File "Vision/Monitoring/Monitoring Settings" with label "Set Monitoring Settings"
    And The Request Body is the following Object
      | jsonPath                   | value |
      | $.deviceInspectionInterval | 15    |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
