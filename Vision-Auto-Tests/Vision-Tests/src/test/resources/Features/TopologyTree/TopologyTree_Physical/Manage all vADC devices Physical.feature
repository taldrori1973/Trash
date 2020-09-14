@TopologyTree @TC106072

Feature: Manage all vADC devices Physical Functionality

  @SID_1
  Scenario: Open the Physical Containers
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "PhysicalContainers" site
    Then CLI Clear vision logs

  @SID_2
  Scenario: Add Alteon VX
    Then UI Add physical "Alteon" with index 6 on "Default (Physical)" site
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI open Topology Tree view "PhysicalContainers" site
    Then UI Wait For Device To Show Up In The Topology Tree physical "Alteon" device with index 6 with timeout 180
  @SID_3
  Scenario: Manage all vADCs
    Then UI manage All vADC with index 6 from topology tree
      | manageVadcLocation           | Default                                             |
      | snmpV3Username               |                                                     |
      | useSnmpV3Authentication      | false                                               |
      | snmpV3AuthenticationProtocol | MD5                                                 |
      | snmpV3AuthenticationPassword | admin                                               |
      | useSnmpV3Privacy             | false                                               |
      | snmpV3PrivacyPassword        | admin                                               |
      | snmpVersion                  | SNMP_V2                                             |
      | readCommunity                | public                                              |
      | writeCommunityAlteon         | private                                             |
      | verifyHttpAccess             | true                                                |
      | verifyHttpsAccess            | true                                                |
      | httpUserName                 | admin                                               |
      | httpPassword                 | admin                                               |
      | httpPort                     | 80                                                  |
      | httpsPort                    | 443                                                 |
      | sshUserName                  | admin                                               |
      | sshPassword                  | admin                                               |
      | sshPort                      | 22                                                  |
      | registerVisionServer         | true                                                |
      | removeTargets                | false                                               |
      | visionMgtPort                | G1                                                  |
      | manageDeviceNames            | Alt_172.16.62.60_vADC-2,Alt_172.16.62.60_vADC-3,Alt_172.16.62.60_vADC-4,Alt_172.16.62.60_vADC-5 |
      | deviceIPs                    | 172.16.160.2,172.16.160.3,172.16.160.4,172.16.160.5 |

    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI open Topology Tree view "PhysicalContainers" site
    Then UI Lock Device with type "Alteon" and Index 6 by Tree Tab "Physical Containers"
    Then UI verify Device Status physical with deviceType "Alteon" with index 6 if Expected device Status "Up or Maintenance"
#    Then UI verify Device Status with deviceType "Alteon" with index 7 if Expected device Status "Up or Maintenance"

  @SID_4
  Scenario Outline: Delete all vADC devices
    Then UI Delete TopologyTree Element "<siteName>" by topologyTree Tab "Sites And Devices"
    Examples:
      | siteName |
      | Alt_172.16.62.60_vADC-2 |
      | Alt_172.16.62.60_vADC-3 |
      | Alt_172.16.62.60_vADC-4 |
      | Alt_172.16.62.60_vADC-5 |

  @SID_5
  Scenario: Delete VX device
    Then UI open Topology Tree view "PhysicalContainers" site
#    Then UI Delete physical "Alteon" device with index 6 from topology tree
    Then UI ExpandAll Sites And Clusters

  @SID_6
  Scenario: logout and check logs
    When UI logout and close browser
    * CLI Check if logs contains
      | logType | expression | isExpected   |
      | ALL     | fatal      | NOT_EXPECTED |

