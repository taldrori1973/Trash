@TC122821
Feature: Edit snmp1

  @SID_1
  Scenario:deletes and adds a device, and then edits the values

    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI Delete "DefensePro" device with index 1 from topology tree
    Then UI Add "DefensePro" with index 1 on "Default" site
    Then UI Edit DP device with index 1 from topology tree expected status "OK"
      | snmpVersion        | SNMP_V1    |
      | snmpWriteCommunity | public new |
      | snmpReadCommunity  | public     |
      | verifyHttpsAccess  | true       |
      | httpUserName       | radware    |
      | httpPassword       | radware    |
      | httpPort           | 80         |
      | httpsPort          | 443        |
      | sshPort            | 22         |