
@TC107946
Feature: HTTPS Scope Selection - Per Server selection

  @SID_8
  Scenario: Update Policies
    Given CLI Operations - Run Radware Session command "system vision-server start" timeout 600
    Given REST Login with user "radware" and password "radware"
    Then REST Update Policies for All DPs


  @SID_1
  Scenario: Login
    Given UI Login with user "sys_admin" and password "radware" negative
    And UI Navigate to "HTTPS Flood Dashboard" page via homePage

  @SID_2
  Scenario: Validate All Servers are Available at Server Selection List
    When UI Click Button "Servers Button"
    Then HTTPS Scope Selection Validate Servers List with Page Size 50

  @SID_3
  Scenario: Validate Servers Filtering
    When UI Click Button "Servers Button"
    Then HTTPS Scope Selection Validate Servers Filtering with Page Size 50

  @SID_4
  Scenario: Validate Servers Number Header
    When UI Click Button "Servers Button"
    Then HTTPS Scope Selection Validate Servers Number Header with Page Size 50

  @SID_5
  Scenario: Validate Servers Number Header When Filtering
    When UI Click Button "Servers Button"
    Then HTTPS Scope Selection Validate Servers Number Header on Filtering with Page Size 50

  @SID_6
  Scenario: Validate Servers is Clickable
    When UI Click Button "Servers Button"
    Then HTTPS Scope Selection Validate Servers are Clickable with Page Size 50

  @SID_7
  Scenario: Logout
    Then UI logout and close browser