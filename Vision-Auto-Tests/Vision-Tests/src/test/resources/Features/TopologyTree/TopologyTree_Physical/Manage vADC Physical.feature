@TopologyTree @TC106073

Feature: Manage vADC device Physical Functionality

  @SID_1
  Scenario: Login and clean logs
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then CLI Clear vision logs

  @SID_2
  Scenario: Add VX Alteon
#    Then UI Add physical "Alteon" with index 6 on "Default (Physical)" site
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI open Topology Tree view "PhysicalContainers" site
#    Then UI Wait For Device To Show Up In The Topology Tree physical "Alteon" device with index 6 with timeout 180
  @SID_3
  Scenario: Manage single vADC
    Then UI manage single vADC with index 6 from topology tree
      | manageVadcLocation           | Default      |
   #   | snmpV3Username               |              |
   #   | useSnmpV3Authentication      | false        |
   #   | snmpV3AuthenticationProtocol | MD5          |
   #   | snmpV3AuthenticationPassword | admin        |
   #   | useSnmpV3Privacy             | false        |
   #   | snmpV3PrivacyPassword        | admin        |
   #   | snmpVersion                  | SNMP_V2      |
      | readCommunity                | public       |
      | writeCommunityAlteon         | private      |
   #   | verifyHttpAccess             | true         |
      | verifyHttpsAccess            | true         |
      | httpUserName                 | admin        |
      | httpPassword                 | admin        |
   #   | httpPort                     | 80           |
      | httpsPort                    | 443          |
      | sshUserName                  | admin        |
      | sshPassword                  | admin        |
      | sshPort                      | 22           |
   #   | registerVisionServer         | true         |
   #   | removeTargets                | false        |
   #   | visionMgtPort                | G1           |
      | manageDeviceNames            | Alt_172.16.62.60_vADC-2 |
      | deviceIPs                    | 172.16.160.2 |

    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI Lock Device "Alteon_Set_5" under "Sites And Devices"
    Then UI Timeout in seconds "30"
    Then UI verify Device Status "Alteon_Set_5" if Expected device Status "Up or Maintenance"

  @SID_4
  Scenario: Delete vADC from organization tree
    Then UI open Topology Tree view "SitesAndClusters" site
#    Then UI Delete "Alteon" device with index 7 from topology tree
  @SID_5
  Scenario: Delete VX from physical tree
    Then UI open Topology Tree view "PhysicalContainers" site
#    Then UI Delete physical "Alteon" device with index 6 from topology tree
  @SID_6
  Scenario: Logout
    Then UI Logout


