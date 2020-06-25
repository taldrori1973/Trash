@DP_Analytics @TC105961

Feature: Alert Disk Space

  @SID_1
  Scenario: Disk Space Alert Basic Minor - bar icon
    # change alert threshold to 2% and restart vision
    Given CLI Run remote linux Command "sed -i 's/disk_space_alert_minor_threshold=[0-9]*/disk_space_alert_minor_threshold=2/g' /opt/radware/mgt-server/properties/disk_space_alert.properties" on "ROOT_SERVER_CLI"
    Then REST Delete ES index "alert"
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and wait 185 seconds
    # Set the quarts task to trigger in one minute from now
    Then CLI Run remote linux Command "mysql -prad123 quartz -e "update qrtz_triggers set NEXT_FIRE_TIME="$(expr $(date +%s%3N)+80000)" where JOB_NAME='CheckDiskSpaceName';"" on "ROOT_SERVER_CLI"
#    Given CLI Run remote linux Command "service mysql restart" on "ROOT_SERVER_CLI" and wait 120 seconds
    Then Sleep "205"

  @SID_2
  Scenario: Disk Space Alert Basic Minor - bar icon - Login to verify
    When UI Login with user "radware" and password "radware"
    Then Browser Refresh Page
    And UI Navigate to "VISION SETTINGS" page via homePage
    Then UI Validate Element Existence By GWT id "Disk Space Alert" if Exists "true" with value "Disk Space Alert"
    Then UI logout and close browser

  @SID_3
  Scenario: Disk Space Alert Debug commands
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -k -XGET -H "Cookie: JSESSIONID=$jsession" https://localhost:443/mgmt/system/config/item/diskspaceinfo > /opt/radware/storage/maintenance/disk_reply.log" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 quartz -e "select now();" > /opt/radware/storage/maintenance/lastrun.log" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 quartz -e "select from_unixtime(PREV_FIRE_TIME/1000) from qrtz_triggers where JOB_NAME='CheckDiskSpaceName';" >> /opt/radware/storage/maintenance/lastrun.log" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "echo $(df -hP) >> /opt/radware/storage/maintenance/lastrun.log" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "cat /opt/radware/mgt-server/properties/disk_space_alert.properties >> /opt/radware/storage/maintenance/lastrun.log" on "ROOT_SERVER_CLI"

  @SID_4
  Scenario: Disk Space Alert Basic Minor - Alert table
    Then CLI Run linux Command "curl -XPOST -s -d'{"query":{"bool":{"must":[{"match":{"module":"INSITE_GENERAL"}},{"match":{"severity":"MINOR"}},{"match":{"userName":"APSolute_Vision"}},{"wildcard":{"message":"*The APSolute Vision disk utilization of \"/dev/sda2\" is now*"}}]}},"from":0,"size":10}' localhost:9200/alert/_search | grep "hits\":{\"total\":1" |wc -l" on "ROOT_SERVER_CLI" and validate result EQUALS "1"

  @SID_5
  Scenario: Disk Space Alert RBAC
    When UI Login with user "sec_admin_all_pol" and password "radware"
    And UI Navigate to "VISION SETTINGS" page via homePage
    Then UI Validate Element Existence By GWT id "Disk Space Alert" if Exists "false"
    Then UI logout and close browser

  @SID_6
  Scenario: Disk Space Alert Basic Major - bar icon
    # change alert threshold to 2% and restart vision
    Given CLI Run remote linux Command "sed -i 's/disk_space_alert_major_threshold=[0-9]*/disk_space_alert_major_threshold=3/g' /opt/radware/mgt-server/properties/disk_space_alert.properties" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command "sed -i 's/disk_space_alert_minor_threshold=[0-9]*/disk_space_alert_minor_threshold=2/g' /opt/radware/mgt-server/properties/disk_space_alert.properties" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command "sed -i 's/disk_space_alert_critical_threshold=[0-9]*/disk_space_alert_critical_threshold=95/g' /opt/radware/mgt-server/properties/disk_space_alert.properties" on "ROOT_SERVER_CLI"
    Then REST Delete ES index "alert"
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and wait 185 seconds
    Then CLI Run remote linux Command "mysql -prad123 quartz -e "update qrtz_triggers set NEXT_FIRE_TIME="$(expr $(date +%s%3N)+80000)" where JOB_NAME='CheckDiskSpaceName';"" on "ROOT_SERVER_CLI"
#    Given CLI Run remote linux Command "service mysql restart" on "ROOT_SERVER_CLI" and wait 120 seconds
    Then Sleep "205"

  @SID_7
  Scenario: Disk Space Alert Basic Major - bar icon - Login to verify
    When UI Login with user "radware" and password "radware"
    Then Browser Refresh Page
    And UI Navigate to "VISION SETTINGS" page via homePage
    Then UI Validate Element Existence By GWT id "Disk Space Alert" if Exists "true" with value "Disk Space Alert"

  @SID_8
  Scenario: Disk Space Alert Debug commands
    Then CLI Run remote linux Command "mysql -prad123 quartz -e "select now();" > /opt/radware/storage/maintenance/lastrun2.log" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "mysql -prad123 quartz -e "select from_unixtime(PREV_FIRE_TIME/1000) from qrtz_triggers where JOB_NAME='CheckDiskSpaceName';" >> /opt/radware/storage/maintenance/lastrun2.log" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "echo $(df -hP) >> /opt/radware/storage/maintenance/lastrun2.log" on "ROOT_SERVER_CLI"
    Then CLI Run remote linux Command "cat /opt/radware/mgt-server/properties/disk_space_alert.properties >> /opt/radware/storage/maintenance/lastrun2.log" on "ROOT_SERVER_CLI"

  @SID_9
  Scenario: Disk Space Alert Basic Major - Alert table
    Then UI Validate Alert record Content by KeyValue with columnName "Message" with content "The APSolute Vision disk utilization of"
      | columnName   | value           |
      | Severity     | Major           |
      | User Name    | APSolute_Vision |
      | Product Name | Vision          |
      | Module       | Vision General  |
    Then UI logout and close browser

  @SID_10
  Scenario: Disk Space Alert Basic Critical - bar icon
    # change alert threshold to 2% and restart vision
    Given CLI Run remote linux Command "sed -i 's/disk_space_alert_critical_threshold=[0-9]*/disk_space_alert_critical_threshold=4/g' /opt/radware/mgt-server/properties/disk_space_alert.properties" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command "sed -i 's/disk_space_alert_minor_threshold=[0-9]*/disk_space_alert_minor_threshold=2/g' /opt/radware/mgt-server/properties/disk_space_alert.properties" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command "sed -i 's/disk_space_alert_major_threshold=[0-9]*/disk_space_alert_major_threshold=3/g' /opt/radware/mgt-server/properties/disk_space_alert.properties" on "ROOT_SERVER_CLI"
    Then REST Delete ES index "alert"
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and wait 185 seconds
    Then CLI Run remote linux Command "mysql -prad123 quartz -e "update qrtz_triggers set NEXT_FIRE_TIME="$(expr $(date +%s%3N)+80000)" where JOB_NAME='CheckDiskSpaceName';"" on "ROOT_SERVER_CLI"
#    Given CLI Run remote linux Command "service mysql restart" on "ROOT_SERVER_CLI" and wait 120 seconds
    Then Sleep "185"
    When UI Login with user "radware" and password "radware"
    Then CLI Run remote linux Command "result=`curl -ks -X "POST" "https://localhost/mgmt/system/user/login" -H "Content-Type: application/json" -d $"{\"username\": \"radware\",\"password\": \"radware\"}"`; jsession=`echo $result | tr "," "\n"|grep -i jsession|tr -d '"' | cut -d: -f2`; curl -k -XGET -H "Cookie: JSESSIONID=$jsession" https://localhost:443/mgmt/system/config/item/diskspaceinfo >> /opt/radware/storage/maintenance/disk_reply.log" on "ROOT_SERVER_CLI"
    Then Browser Refresh Page
    And UI Navigate to "VISION SETTINGS" page via homePage
    Then UI Validate Element Existence By GWT id "Disk Space Alert" if Exists "true" with value "Disk Space Alert"

  @SID_11
  Scenario: Disk Space Alert Basic Critical - Alert table
    Then UI Validate Alert record Content by KeyValue with columnName "Message" with content "The APSolute Vision disk utilization of"
      | columnName   | value           |
      | Severity     | Critical        |
      | User Name    | APSolute_Vision |
      | Product Name | Vision          |
      | Module       | Vision General  |
    Then UI logout and close browser

  @SID_12
  Scenario: Disk Space Alert Clear
    # change alert threshold to 2% and restart vision
    Given CLI Run remote linux Command "sed -i 's/disk_space_alert_minor_threshold=[0-9]*/disk_space_alert_minor_threshold=75/g' /opt/radware/mgt-server/properties/disk_space_alert.properties" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command "sed -i 's/disk_space_alert_major_threshold=[0-9]*/disk_space_alert_major_threshold=90/g' /opt/radware/mgt-server/properties/disk_space_alert.properties" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command "sed -i 's/disk_space_alert_critical_threshold=[0-9]*/disk_space_alert_critical_threshold=95/g' /opt/radware/mgt-server/properties/disk_space_alert.properties" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command "service vision restart" on "ROOT_SERVER_CLI" and wait 120 seconds
    When UI Login with user "radware" and password "radware"
    And UI Navigate to "VISION SETTINGS" page via homePage
    Then UI Validate Element Existence By GWT id "Disk Space Alert" if Exists "false"
    Then UI logout and close browser
