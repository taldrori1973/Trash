@AMSAnalytics
Feature: Verify AMS Analytics Screen

#  Scenario: Run DP simulator PCAPs
#    Given CLI simulate 1000 attacks of type "many_attacks" on SetId "DefensePro_Set_1" and wait 90 seconds

  Scenario: Login And Navigate to AMS Analytics Screen
    Given UI Login with user "radware" and password "radware"
    And UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.generalSettings.reportsettings"
    And UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.generalSettings.AMSRetentionTime"
    And UI Select "1D" from Vision dropdown by Id "gwt-debug-amsShortTermRetenTionTime_Widget-input"
    And UI Select "3H" from Vision dropdown by Id "gwt-debug-amsShortTermQueryWindow_Widget-input"
    And UI Select "3M" from Vision dropdown by Id "gwt-debug-amsAttackRetentionPeriod_Widget-input"
    And UI Select "1M" from Vision dropdown by Id "gwt-debug-amsEAAFAttackRetentionPeriod_Widget-input"
    And UI Select "False" from Vision dropdown by Id "gwt-debug-amsCleanUpStorageSpace_Widget-input"
    And UI Select "2H" from Vision dropdown by Id "gwt-debug-genericAttackDataRawStoragePeriod_Widget-input"
    And UI Select "1D" from Vision dropdown by Id "gwt-debug-genericAttackDataFiveMinutesStoragePeriod_Widget-input"
    And UI Select "2W" from Vision dropdown by Id "gwt-debug-genericAttackDataHourlyStoragePeriod_Widget-input"
    And UI Select "2M" from Vision dropdown by Id "gwt-debug-genericAttackDataDailyStoragePeriod_Widget-input"
    And UI Click Button by id "gwt-debug-ConfigTab_EDIT_MgtServer.AMSRetentionTimeConfig_Submit"

  Scenario: Navigate back to refresh page with updated details
    And UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.generalSettings.ADCRetentionTime"
    And UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.generalSettings.AMSRetentionTime"

  Scenario: Validate if Text fields have Valid Data
    And UI Validate Text field by id "gwt-debug-amsShortTermRetenTionTime_Widget-input" EQUALS "1D"
    And UI Validate Text field by id "gwt-debug-amsShortTermQueryWindow_Widget-input" EQUALS "3H"
    And UI Validate Text field by id "gwt-debug-amsAttackRetentionPeriod_Widget-input" EQUALS "3M"
    And UI Validate Text field by id "gwt-debug-amsEAAFAttackRetentionPeriod_Widget-input" EQUALS "1M"
    And UI Validate Text field by id "gwt-debug-amsCleanUpStorageSpace_Widget-input" EQUALS "False"
    And UI Validate Text field by id "gwt-debug-genericAttackDataRawStoragePeriod_Widget-input" EQUALS "2H"
    And UI Validate Text field by id "gwt-debug-genericAttackDataFiveMinutesStoragePeriod_Widget-input" EQUALS "1D"
    And UI Validate Text field by id "gwt-debug-genericAttackDataHourlyStoragePeriod_Widget-input" EQUALS "2W"
    And UI Validate Text field by id "gwt-debug-genericAttackDataDailyStoragePeriod_Widget-input" EQUALS "2M"

  Scenario: Navigate to DefensePro Monitoring and Validate Max Window for Statistics Based on 5-Minute-Resolution Data
    Given UI Navigate to "DefensePro Monitoring Dashboard" page via homePage
    And UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "3H"
    Then Sleep "10"

    And New Request Specification from File "Vision/DpCpuUtilization" with label "Traffic Bandwidth"
    And The Request Body is the following Object with Time 3 hours ago
      | jsonPath                      | value          |
      | $.unit                        | "bps"          |
      | $.direction                   | "Inbound"      |
      | $.timeInterval.to             | null           |
      | $.selectedDevices[0].deviceId | "10.25.90.100" |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body has 5 minutes resolution data

  Scenario: Negative Scenario of Max Window for Statistics Based on 5-Minute-Resolution Data
    Given UI Do Operation "Select" item "Global Time Filter"
    And UI Do Operation "Select" item "Global Time Filter.Quick Range" with value "6H"
    Then Sleep "10"

    And New Request Specification from File "Vision/DpCpuUtilization" with label "Traffic Bandwidth"
    And The Request Body is the following Object with Time 6 hours ago
      | jsonPath                      | value          |
      | $.unit                        | "bps"          |
      | $.direction                   | "Inbound"      |
      | $.timeInterval.to             | null           |
      | $.selectedDevices[0].deviceId | "10.25.90.100" |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body has 60 minutes resolution data

  Scenario: Logout and close browser
    Given UI logout and close browser