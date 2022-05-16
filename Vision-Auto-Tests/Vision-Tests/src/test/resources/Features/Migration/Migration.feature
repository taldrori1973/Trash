@Migration @TC126275
Feature: Migration from cVision to uVision

  Scenario: Prerequisites for Migration - Delete existing indices and activation license in uVision

    Given Prerequisite for Setup force

    Given CLI Operations - Run Radware Session command "net firewall open-port set 2049 open"
    Then CLI Operations - Run Radware Session command "net firewall open-port set 9200 open"

    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Licenses list"
      | ormID | $[?(@.description=='APSolute Vision Activation License')].ormID |

    And New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | visionlicense |
      | id   | ${ormID}      |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

    * REST Delete ES index "dp*"
    * REST Delete ES index "alteon*"
    * CLI Clear vision logs

  Scenario: Prerequisites for Migration - Delete existing indices, kill existing attacks and Simulate new attacks in cVision
    * CLI kill all simulator attacks on Secondary Server
    * REST Delete ES index "dp*" inSecondaryServer
    * REST Delete ES index "alteon*" inSecondaryServer

    Given CLI simulate 100 attacks of type "many_attacks" on DeviceID "DefensePro_172.16.22.50" and wait 90 seconds inSecondaryServer

  Scenario: Login to uVision and open NFS_Share
    Given CLI Operations - Run Root Session initial import command "/deploy/tools/data-migration/data-migrator.sh"

  Scenario: Login to cVision and export data
    Given CLI Operations - Run Root Session export command "/opt/radware/mgt-server/bin/es-mysql-data-exporter.sh"

  Scenario: Login to uVision and import data
    Given CLI Operations - Run Root Session command "ls -l /var/lib/docker/mnt/nfs_share/cvision/data-export/elasticsearch/"
    And CLI Operations - Using "root" User to Verify that output contains regex "snapshots"
    And CLI Operations - Using "root" User to Verify that output contains regex "snapshots.txt"

    Given CLI Operations - Run Root Session command "ls -l /var/lib/docker/mnt/nfs_share/cvision/data-export/config/"
    And CLI Operations - Using "root" User to Verify that output contains regex "device-drivers.zip"
    And CLI Operations - Using "root" User to Verify that output contains regex "es-config.zip"
    And CLI Operations - Using "root" User to Verify that output contains regex "lls-data.zip"
    And CLI Operations - Using "root" User to Verify that output contains regex "mac_addr.txt"
    And CLI Operations - Using "root" User to Verify that output contains regex "mgt-srv-props.zip"
    And CLI Operations - Using "root" User to Verify that output contains regex "mysql-data-dump.gz"
    And CLI Operations - Using "root" User to Verify that output contains regex "vdirect-data.zip"

    Given CLI Operations - Run Root Session import command "/deploy/tools/data-migration/data-migrator.sh"

  Scenario: Validate successful Config Migration
    Given UI Login with user "radware" and password "radware"

    And Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='vDirect')].ormID |

    And New Request Specification from File "Vision/SystemConfigItemList" with label "Get Local User"
    And The Request Path Parameters Are
      | id | ${ormID} |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

    And UI logout and close browser

  Scenario: Validate successful ES Migration
    Given CLI Operations - Run Root Session command "curl -XGET localhost:9200/_cat/indices?v | grep dp-*"
    And CLI Operations - Using "root" User to Verify that output contains regex "dp-attack-raw"

  Scenario: Upgrade vision from release -1
    Given Upgrade or Fresh Install Vision

  Scenario: Check upgrade logs
    Then CLI Check if logs contains
      | logType | expression                                                                                   | isExpected   |
      | UPGRADE | fatal                                                                                        | NOT_EXPECTED |
      | UPGRADE | fail to\|failed to                                                                           | NOT_EXPECTED |
      | UPGRADE | The upgrade of APSolute Vision server has completed successfully                             | EXPECTED     |
      | UPGRADE | Failed to connect to localhost port 8009: Connection refused                                 | IGNORE       |
      | UPGRADE | NOTE1: Some changes will not take effect until next login                                    | EXPECTED     |
      | UPGRADE | [ERROR]   WARNING: The script pysemver is installed in '/usr/local/bin' which is not on PATH | IGNORE       |

  Scenario: Login with activation
    Then UI Login with user "radware" and password "radware"

  Scenario: Navigate to general settings page
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Basic Parameters"
    When UI Do Operation "select" item "Software"
    Then REST get Basic Parameters "lastUpgradeStatus"
    Then UI Validate Text field "Upgrade Status" EQUALS "OK"
    And UI logout and close browser
