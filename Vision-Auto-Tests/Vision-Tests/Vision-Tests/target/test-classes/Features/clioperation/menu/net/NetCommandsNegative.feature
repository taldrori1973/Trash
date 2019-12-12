@CLI_Negative @TC106027

Feature: Net Tests Negative

  @SID_1
  Scenario: Net Negative Functional Test
    Given CLI Net Negative

  @SID_2
  Scenario: net route set net output test negative
    When CLI Operations - Run Radware Session command "net route delete 172.17.0.0 255.255.0.0 172.17.0.5 G1"
    When CLI Operations - Run Radware Session command "net route set net 172.17.0.0 255.255.0.0 172.17.0.5 G1"
    Then CLI Operations - Verify that output contains regex ".*Failed setting route.*" negative

  @SID_3
  Scenario: net dns delete negative
    When CLI Operations - Run Radware Session command "net dns set primary 4.4.4.4"
    When CLI Operations - Run Radware Session command "net dns set secondary 5.5.5.5"
    When CLI Operations - Run Radware Session command "net dns set tertiary 6.6.6.6"
    When CLI Operations - Run Radware Session command "net dns delete tertiary"
    When CLI Operations - Run Radware Session command "net dns get"
    Then CLI Operations - Verify that output contains regex ".*6.6.6.6.*" negative
    When CLI Operations - Run Radware Session command "net dns delete secondary"
    When CLI Operations - Run Radware Session command "net dns get"
    Then CLI Operations - Verify that output contains regex ".*5.5.5.5.*" negative
    When CLI Operations - Run Radware Session command "net dns delete primary"
    Then CLI Operations - Verify that output contains regex ".*4.4.4.4.*" negative

  @SID_4
  Scenario: net firewall open-port set & list - close
    When CLI Operations - Run Radware Session command "net firewall open-port set 1500 open"
    When CLI Operations - Run Radware Session command "net firewall open-port set 1500 close"
    When CLI Operations - Run Radware Session command "net firewall open-port list"
    Then CLI Operations - Verify that output contains regex ".*1500.*" negative

  @SID_5
  Scenario: net ip delete negative
    When CLI Operations - Run Radware Session command "net ip set 172.17.173.2 255.255.0.0 G2"
    When CLI Operations - Run Radware Session command "net ip delete G2"
    When CLI Operations - Run Radware Session command "y"
    When CLI Operations - Run Radware Session command "net ip get"
    Then CLI Operations - Verify that output contains regex ".*G2.*172.17.173.2.*255.255.0.0.*00:50:56:9E:1A:D4.*" negative

  @SID_6
  Scenario: net route set & get & delete negative
    When CLI Operations - Run Radware Session command "net route set net 172.17.0.0 255.255.0.0 172.17.0.5 G1"
    When CLI Operations - Run Radware Session command "net route delete 172.17.0.0 255.255.0.0 172.17.0.5 G1"
    When CLI Operations - Run Radware Session command "net route get"
    Then CLI Operations - Verify that output contains regex ".*172.17.0.0.*172.17.0.5.*255.255.0.0.*UG.*0.*0.*0.*G1.*" negative
    When CLI Operations - Run Radware Session command "net route set host 172.17.0.0 172.17.2.2 G1"
    When CLI Operations - Run Radware Session command "net route delete 172.17.0.0 255.255.255.255 172.17.2.2 G1"
    When CLI Operations - Run Radware Session command "net route get"
    Then CLI Operations - Verify that output contains regex ".*172.17.0.0.*172.17.2.2.*255.255.255.255.*UGH.*0.*0.*0.*G1.*" negative


