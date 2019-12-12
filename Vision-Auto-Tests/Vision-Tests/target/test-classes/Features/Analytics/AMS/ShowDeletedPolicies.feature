@TC111824

Feature: Show Deleted Policies


  @SID_1
  Scenario: Login and Add Policy
    Given REST Login with user "radware" and password "radware"
    Given REST Vision Install License Request "vision-AVA-Max-attack-capacity"
#    Given Rest Add Policy "DeletePolTest" To DP "172.16.22.55" if Not Exist
    Given Rest Add Policy "DeletePolTest" To DP if Not Exist
      | index |
      | 10    |
    Then Sleep "120"
    Given UI Login with user "sys_admin" and password "radware"
    When UI Open Upper Bar Item "AMS"


  @SID_2
  Scenario: check policy appears in dashboard devices list
    When UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI Click Button "Device Selection"
    When UI Select device from dashboard
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10    | DeletePolTest  | true   |
    Then UI Click Button "Device Selection.Cancel"


  @SID_3
  Scenario: check policy appears in Reports devices list
    When UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI open devices list of "Reports"
    When UI Select device from dashboard
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10   | DeletePolTest  | true   |

  @SID_4
  Scenario: check policy appears in Alerts devices list
    When UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI open devices list of "Alerts"
    When UI Select device from dashboard
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10    | DeletePolTest  | true   |


  @SID_5
  Scenario: check policy appears in Forensics devices list
    Then UI open devices list of "Forensics"
    When UI Select device from dashboard
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10    | DeletePolTest  | true   |


  @SID_6
  Scenario: Delete Policy
    Given REST Login with user "radware" and password "radware"
#    Given Rest delete Policy "DeletePolTest" To DP "172.16.22.55" if Exist
    Given Rest delete Policy "DeletePolTest" from DP if Exist
      | index |
      | 10    |
    Then Sleep "120"

  @SID_7
  Scenario: Logout
    Given UI Logout


  @SID_8
  Scenario: Login
    Given UI Login with user "sys_admin" and password "radware"
    When UI Open Upper Bar Item "AMS"


  @SID_9
  Scenario: check policy NOT appears in dashboard devices list
    When UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI Click Button "Device Selection"
    When UI Select device from dashboard
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10    | DeletePolTest  | false   |
#    When UI Click Button "Show Deleted Policies" with value "172.16.22.55"
    When UI Click Button "Show Deleted Policies" with params
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10    | DeletePolTest  | true   |
    Then UI Click Button "Device Selection.Cancel"

  @SID_10
  Scenario: check policy NOT appears in Reports devices list
    When UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI open devices list of "Reports"
    When UI Select device from dashboard
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10    | DeletePolTest  | false   |
    When UI Click Button "Show Deleted Policies" with params
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10    | DeletePolTest  | true   |

  @SID_11
  Scenario: check policy NOT appears in Alerts devices list
    When UI Open "Dashboards" Tab
    And UI Open "DP Monitoring Dashboard" Sub Tab
    Then UI open devices list of "Alerts"
    When UI Select device from dashboard
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10    | DeletePolTest  | false   |
    When UI Click Button "Show Deleted Policies" with params
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10    | DeletePolTest  | true   |

  @SID_12
  Scenario: check policy NOT appears in Forensics devices list
    Then UI open devices list of "Forensics"
    When UI Select device from dashboard
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10    | DeletePolTest  | false   |
    When UI Click Button "Show Deleted Policies" with params
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist|
      | 10    | DeletePolTest  | true   |

  @SID_13
  Scenario: Logout and close browser
    Given UI logout and close browser
    Given UI Logout