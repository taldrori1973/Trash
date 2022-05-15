@ADSAnalytics @TC126268
Feature: Verify ADS Analytics Screen

  Scenario: Login And Navigate to ADS Analytics Screen
    Given UI Login with user "radware" and password "radware"
    And UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.generalSettings.reportsettings"
    And UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.generalSettings.ADCRetentionTime"
    And UI Select "1H" from Vision dropdown by Id "gwt-debug-adcRetentionTime_Widget-input"
    And UI Select "1H" from Vision dropdown by Id "gwt-debug-adcMaxQueryWindow_Widget-input"
    And UI Select "1M" from Vision dropdown by Id "gwt-debug-adcEAAFAttackRetentionPeriod_Widget-input"
    And UI Select "True" from Vision dropdown by Id "gwt-debug-adcDeleteEventLogsByStorageSpace_Widget-input"
    And UI Select "2W" from Vision dropdown by Id "gwt-debug-adcEventLogsRetentionPeriod_Widget-input"
    And UI Click Button by id "gwt-debug-ConfigTab_EDIT_MgtServer.ADCRetentionTimeConfig_Submit"

  Scenario: Navigate back to refresh page with updated details
    And UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.generalSettings.AMSRetentionTime"
    And UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.generalSettings.ADCRetentionTime"

  Scenario: Validate if Text fields have Valid Data
    And UI Validate Text field by id "gwt-debug-adcRetentionTime_Widget-input" EQUALS "1H"
    And UI Validate Text field by id "gwt-debug-adcMaxQueryWindow_Widget-input" EQUALS "1H"
    And UI Validate Text field by id "gwt-debug-adcEAAFAttackRetentionPeriod_Widget-input" EQUALS "1M"
    And UI Validate Text field by id "gwt-debug-adcDeleteEventLogsByStorageSpace_Widget-input" EQUALS "True"
    And UI Validate Text field by id "gwt-debug-adcEventLogsRetentionPeriod_Widget-input" EQUALS "2W"

  Scenario: Logout and close browser
    Given UI logout and close browser