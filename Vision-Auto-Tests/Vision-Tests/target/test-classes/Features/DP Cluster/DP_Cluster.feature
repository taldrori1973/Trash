@TopologyTree @TC106043

Feature: Create DP Cluster

  @SID_1
  Scenario: Login and add DPs
    Given UI Login with user "radware" and password "radware"
    Then UI open Topology Tree view "SitesAndClusters" site
    Then UI Add "DefensePro" with index 7 on "Default" site
    Then UI Add "DefensePro" with index 6 on "Default" site
    Then UI Wait For Device To Show Up In The Topology Tree "DefensePro" device with index 7 with timeout 300
    Then UI Wait For Device To Show Up In The Topology Tree "DefensePro" device with index 6 with timeout 300
    Then UI Logout

  @SID_2
  Scenario: Remove security signature from DPs and reboot
    Given UI Login with user "radware" and password "radware"
    Then UI Remove Security Signature File from DP Device with index 6 with filePathToDelete ""
    Then UI perform Device ResetShutDown Operation with deviceType "DefensePro" with index 6 by operationToPerform "Reset"
    Then UI Wait for "DefensePro" device with index 6
    Then UI Remove Security Signature File from DP Device with index 7 with filePathToDelete ""
    Then UI perform Device ResetShutDown Operation with deviceType "DefensePro" with index 7 by operationToPerform "Reset"
    Then UI Wait for "DefensePro" device with index 7

#  @SID_3
#  Scenario: Update security signature on both DPs
#    Then UI Update security signatures for DefensePro number 6
#    Then UI Update security signatures for DefensePro number 7
#    Then UI Open Upper Bar Item "Refresh"
  @SID_4
  Scenario: Create DP cluster
    Then UI Create DP cluster with Name "Auto_Cluster" with primary 6 and secondary 7
    Then UI Timeout in seconds "400"
  @SID_5
  Scenario: Verify cluster created
    Then UI verify dpHaDeviceStatus "PrimaryInactive" with device index 6
    Then UI verify dpHaDeviceStatus "SecondaryInActive" with device index 7
  @SID_6
  Scenario: verify cluster members roles
    Then UI verify dp Cluster device "Auto_Cluster" with device index 6 by haStatus "Primary"
    Then UI verify dp Cluster device "Auto_Cluster" with device index 7 by haStatus "Secondary"
    Then UI Logout

  @SID_7
  Scenario: DP Cluster perform SwitchOver
    Given UI Login with user "radware" and password "radware"
    Then UI click Tree Element - By device Names "Auto_Cluster"
    Then UI Lock Selected Device
    Then UI dp Cluster Switchover "Auto_Cluster"
    Then UI Unlock Selected Device
    Then UI Timeout in seconds "30"
  @SID_8
  Scenario: DP Cluster verify roles after SwitchOver
    Then UI verify dpHaDeviceStatus "SecondaryInActive" with device index 7
    Then UI verify dpHaDeviceStatus "PrimaryInactive" with device index 6
    Then UI verify dp Cluster device "Auto_Cluster" with device index 7 by haStatus "Secondary"
    Then UI verify dp Cluster device "Auto_Cluster" with device index 6 by haStatus "Primary"
    Then UI Timeout in seconds "400"

#    Then UI click Tree Element - By device Names "Auto_Cluster"
#    Then UI Lock Selected Device
#    Then UI dp Cluster Switchover "Auto_Cluster"
#    Then UI Unlock Selected Device
#    Then UI Timeout in seconds "30"
#    Then UI verify dpHaDeviceStatus "SecondaryInActive" with device index 7
#    Then UI verify dpHaDeviceStatus "PrimaryInactive" with device index 6
#    Then UI verify dp Cluster device "Auto_Cluster" with device index 6 by haStatus "Primary"
#    Then UI verify dp Cluster device "Auto_Cluster" with device index 7 by haStatus "Secondary"
#    Then UI Logout

  @SID_9
  Scenario: DP Break Cluster
    Given UI Login with user "radware" and password "radware"
    Then UI Brake "Auto_Cluster" DP cluster
    Then UI Timeout in seconds "300"
    Then UI is Tree Node Exists - By device Names "Auto_Cluster" negative
    Then UI click Tree Element - By device Names "172.16.22.92"
    Then UI click Tree Element - By device Names "172.16.22.93"
#    Then UI Logout

  @SID_10
  Scenario: Delete DP devices
#    Given UI Login with user "radware" and password "radware"
#    Then UI Delete "DefensePro" device with index 6 from topology tree
#    Then UI Delete "DefensePro" device with index 7 from topology tree

    @SID_11
    Scenario: Quit
      Given UI logout and close browser

