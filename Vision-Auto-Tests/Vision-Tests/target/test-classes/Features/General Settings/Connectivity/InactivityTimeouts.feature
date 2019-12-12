@VisionSettings @TC106056
Feature: Connectivity Inactivity Timeouts Functionality

  @SID_1
  Scenario: Login add Alteon and Navigate to Connectivity page
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Add "Alteon" with index 2 on "Default" site
    Then UI Wait For Device To Show Up In The Topology Tree "Alteon" device with index 2 with timeout 300
    Then UI Add "DefensePro" with index 11 on "Default" site
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Connectivity"

  @SID_2
  Scenario: Set inactivity Timeouts to 2 and 3 minutes
    When UI Do Operation "select" item "Inactivity Timeouts"
    Then UI Set Text Field "Inactivity Timeout for Configuration and Monitoring Perspectives" To "2"
    Then UI Set Text Field "Inactivity Timeout for Security Monitoring Perspective, APM, and DPM" To "3"
    Then UI Click Button "Submit"

    Then REST get Connectivity Parameters "sessionInactivTimeoutConfiguration"
    Then UI Validate Text field "Inactivity Timeout for Configuration and Monitoring Perspectives" EQUALS ""
    Then REST get Connectivity Parameters "sessionInactivTimeoutMonitoring"
    Then UI Validate Text field "Inactivity Timeout for Security Monitoring Perspective, APM, and DPM" EQUALS ""

  @SID_3
  Scenario: Logout and re-login
    Then UI Logout
    Then UI Login with user "radware" and password "radware"
    Then UI Go To Vision

  @SID_4
  Scenario: verify logout after two minute in monitoring prespective
    Then UI select Topology Element "Alteon" device with index 2 from topology tree
    Then UI Navigate to page "Monitoring"
    Then Sleep "150"
    Then REST Request "GET" for "Device Tree->Get NGR Devices"
      | type | value |
    Then UI validate Login dialogBox existence "true"

  @SID_5
  Scenario: verify logout after one minute in configuration prespective
    Then UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI select Topology Element "Alteon" device with index 2 from topology tree
    Then UI Navigate to page "Configuration"
    Then UI Timeout in seconds "150"
    Then REST Request "GET" for "Device Tree->Get Tree"
      | type | value |
    Then UI validate Login dialogBox existence "true"

  @SID_6
  Scenario: verify logout after two minute in security monitoring prespective
    Then UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI select Topology Element "DefensePro" device with index 11 from topology tree
    Then UI Navigate to page "security monitoring"
    Then UI Timeout in seconds "230"
    Then UI validate Login dialogBox existence "true"

  @SID_7
  Scenario: Back to Default settings
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then REST Request "PUT" for "Connectivity->Inactivity Timeout for Configuration"
      | type | value                                 |
      | body | sessionInactivTimeoutConfiguration=60 |
      | body | sessionInactivTimeoutMonitoring=1440  |
#    Then UI Go To Vision
#    Then UI Navigate to page "System->General Settings->Connectivity"
#    When UI Do Operation "select" item "Inactivity Timeouts"
#    Then UI Set Text Field "Inactivity Timeout for Configuration and Monitoring Perspectives" To "20"
#    Then UI Set Text Field "Inactivity Timeout for Security Monitoring Perspective, APM, and DPM" To "1440"
#    Then UI Click Button "Submit"
#    Then UI Delete "Alteon" device with index 2 from topology tree

  @SID_8
  Scenario: Logout
    Then UI logout and close browser

