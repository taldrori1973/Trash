@TC117279
Feature: JBOSS WATCHDOG

  @SID_1
  Scenario: Stop service
    #Remove previous setting if remained
    Given CLI Run remote linux Command "sed -i 's/#\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/g' /var/spool/cron/root" on "ROOT_SERVER_CLI" with timeOut 10
    Given CLI Run remote linux Command "service vision stop" on "ROOT_SERVER_CLI" with timeOut 120
    When CLI Clear vision logs
    Then CLI Check if logs contains
      | logType  | expression              | isExpected   |
      | JBOSS_WD | Health check successful | NOT_EXPECTED |
    #stop JBOSS cron schedule
    Given CLI Run remote linux Command "sed -i 's/\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/#\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/g' /var/spool/cron/root" on "ROOT_SERVER_CLI" with timeOut 10

  @SID_2
  Scenario: Start service
    Given CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI" with timeOut 120
    When CLI Run linux Command "service vision status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Application Server is running." with timeOut 150
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh" on "ROOT_SERVER_CLI" with timeOut 30
    Then CLI Run linux Command "grep -c "start jboss_watchdog_execution" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 700
    Then CLI Run linux Command "grep -c "Health check successful" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 10
    Then CLI Run linux Command "grep -c "Jboss server is up" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 10

  @SID_3
  Scenario: WD killing process
    Given CLI Run remote linux Command "kill -9 $(lsof -t -i:8080)" on "ROOT_SERVER_CLI" with timeOut 120
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh" on "ROOT_SERVER_CLI" with timeOut 30
    Then CLI Run linux Command "grep -c "Health check failed" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 10
    Then CLI Run linux Command "grep -c "Need to restart jboss" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result EQUALS "1" with timeOut 10
    Then CLI Run linux Command "grep -c "Jboss server is down" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 10

  @SID_4
  Scenario: Block port 8080
    Given CLI Run remote linux Command "service vision start" on "ROOT_SERVER_CLI" with timeOut 120
    Then CLI Run linux Command "service vision status" on "ROOT_SERVER_CLI" and validate result EQUALS "APSolute Vision Application Server is running." with timeOut 150
    Given CLI Run remote linux Command "iptables -I RH-Firewall-1-INPUT 1 -p tcp --dport 8080 -d 127.0.0.1 -j DROP" on "ROOT_SERVER_CLI"
    When CLI Clear vision logs
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh" on "ROOT_SERVER_CLI" with timeOut 300
    Then CLI Run linux Command "grep -c "Health check failed" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 90
    #service restart will occur after three attempts and with timeout of 1 min each.
    Then CLI Run linux Command "grep -c "Need to restart jboss" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result EQUALS "1" with timeOut 270
    Then CLI Run linux Command "grep -c "Restarting jboss" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result EQUALS "1" with timeOut 60
    Then CLI Run linux Command "grep -c "Jboss server is up" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 60

  @SID_5
  Scenario: Return to Normal
    Given CLI Run remote linux Command "iptables -D RH-Firewall-1-INPUT -p tcp --dport 8080 -d 127.0.0.1 -j DROP" on "ROOT_SERVER_CLI"
    When CLI Clear vision logs
    When CLI Run remote linux Command "/opt/radware/mgt-server/bin/watchdogs/jboss_watchdog.sh" on "ROOT_SERVER_CLI" with timeOut 30
    Then CLI Run linux Command "grep -c "start jboss_watchdog_execution" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 700
    Then CLI Run linux Command "grep -c "Health check successful" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 60
    Then CLI Run linux Command "grep -c "Jboss server is up" /opt/radware/storage/maintenance/logs/jboss_watchdog.log" on "ROOT_SERVER_CLI" and validate result GTE "1" with timeOut 60

  @SID_6
  Scenario: Revert all back to normal
      Given CLI Run remote linux Command "sed -i 's/#\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/\*\/10 \* \* \* \* \/opt\/radware\/mgt-server\/bin\/watchdogs\/reporting_engine_watchdog.sh/g' /var/spool/cron/root" on "ROOT_SERVER_CLI" with timeOut 10