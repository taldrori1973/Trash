@VisionSettings @TC106062
Feature: Server Alarm Functionality

  @SID_1
  Scenario: Navigate to Server Alarm page
    Given UI Login with user "radware" and password "radware"

  @SID_2
  Scenario Outline: Set and validate Server Alarm - Error/Warning for Raising and Falling thresholds
    Then UI clear All Alerts
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Server Alarm"
    Then UI Click Web element with id "gwt-debug-WarningThresholdsEntry_RowID_0_CellID_enabled"
    Then UI Click Web element with id "gwt-debug-WarningThresholdsEntry_EDIT"
    Then UI Set Checkbox "Enabled" To "true"
    Then UI Set Text field with id "<id>" with "<value>"
    Then UI Click Button "Submit"

    Then UI Click Web element with id "gwt-debug-WarningThresholdsEntry_RowID_0_CellID_enabled"
    Then UI Click Web element with id "gwt-debug-WarningThresholdsEntry_EDIT"
    Then UI Validate Text field by id "<id>" EQUALS "<value>"

    Then UI Timeout in seconds "<timeOut>"
    Then UI Validate existing alert with columnName "Message" have value "<message>"

    Examples:
      | id                                      | value | message                                      | timeOut |
      | gwt-debug-risingWarningThreshold_Widget | 1     | M_00892: Rising: CPU utilization is high.    | 300     |
      | gwt-debug-risingErrorThreshold_Widget   | 1     | M_00892: Rising: CPU utilization is high.    | 350     |
      | gwt-debug-risingErrorThreshold_Widget   | 94    | M_00891: Falling: CPU utilization is normal. | 300     |
      | gwt-debug-risingWarningThreshold_Widget | 90    | M_00891: Falling: CPU utilization is normal. | 310     |

  @SID_3
  Scenario: Go to vision settings page
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Server Alarm"

  @SID_4
  Scenario: Validate memory utilization alerts
    Then Validate Memory Utilization

  @SID_5
  Scenario: Logout
    Then UI logout and close browser




