@TC108230 @manual
Feature: Create AppWall iFrame
  @SID_1
  Scenario: Clear logs and login as sys admin
    When UI Login with user "sys_admin" and password "radware"
    Then CLI Clear vision logs
  @SID_2
  Scenario: Add AppWall iFrame to tree
    Then REST Add "AppWall" Device To topology Tree with Name "Appwall_SA_172.17.164.30" and Management IP "172.17.164.30" into site "Default"
      | attribute     | value    |
      | httpPassword  | 1qaz!QAZ |
      | httpsPassword | 1qaz!QAZ |
      | httpsUsername | user1    |
      | httpUsername  | user1    |
      | visionMgtPort | G2       |
  @SID_3
  Scenario: Navigate into iframe and verify state
    Then UI Navigate to iFrame by "Id" Equals to "appwall-webui-frame" of Device "Appwall_SA_172.17.164.30" in Topology Tree Tab "SitesAndClusters"
    Then UI Do Operation "Select" item "AppWall Dashboard"
    Then UI Do Operation "Select" item "AppWall Forensics"
    Then UI Do Operation "Select" item "AppWall Auto Discovery"
    Then UI Do Operation "Select" item "AppWall Security Policy"
    Then UI Do Operation "Select" item "AppWall Configuration"
    Then UI Do Operation "Select" item "AppWall System"
    Then UI Validate Text field "AppWall System.Current Status" EQUALS "Running"

  @SID_4
  Scenario: Navigate out of iframe
    Then UI Navigate Back to Vision from iFrame
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Basic Parameters"
    Then UI Validate Text field "Hardware Platform" EQUALS "Virtual"

  @SID_5
  Scenario: Delete Appwall from Tree
#    Then REST Delete "AppWall" device with index 2 from topology tree
    Then REST Delete Device By IP "172.17.164.30"

  @SID_6
  Scenario: logout and check logs
    Then UI logout and close browser
    Then CLI Check if logs contains
      | logType     | expression   | isExpected   |
      | ES          | fatal\|error | NOT_EXPECTED |
      | MAINTENANCE | fatal\|error | NOT_EXPECTED |
      | JBOSS       | fatal        | NOT_EXPECTED |
      | TOMCAT      | fatal        | NOT_EXPECTED |
      | TOMCAT2     | fatal        | NOT_EXPECTED |