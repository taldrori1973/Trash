@TC106824
Feature: DPM Network Traffic Legend

  @SID_1
  Scenario: Login and navigate to network dashboard
    Then UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-reporting-module-ADC"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" findBy cellValue "Alteon_50.50.101.22"
    Then UI Click Button "NetworkTab"

  @SID_2
  Scenario: Validate ports order according to status and alphanumeric port name order
    # this step should be replaced by the step above after adding the port status as integer field in alteon side
    Then UI validate order of "PortsList" with elements prefix "port_" is equal to "01,02,03,04,05,16,17,18,19,20,10,06,07,08,09,11,12,13,14,15"
    # these steps should be replaced by the steps above after adding the port status as integer field in alteon side
    Then UI Validate icon "traffic port" with params "01" with status "up-icon"
    Then UI Validate icon "traffic port" with params "02" with status "up-icon"
    Then UI Validate icon "traffic port" with params "03" with status "up-icon"
    Then UI Validate icon "traffic port" with params "04" with status "up-icon"
    Then UI Validate icon "traffic port" with params "05" with status "up-icon"
    Then UI Validate icon "traffic port" with params "16" with status "unplugged-icon"
    Then UI Validate icon "traffic port" with params "17" with status "unplugged-icon"
    Then UI Validate icon "traffic port" with params "18" with status "unplugged-icon"
    Then UI Validate icon "traffic port" with params "19" with status "unplugged-icon"
    Then UI Validate icon "traffic port" with params "20" with status "unplugged-icon"
    Then UI Validate icon "traffic port" with params "10" with status "down-icon"
    Then UI Validate icon "traffic port" with params "06" with status "down-icon"
    Then UI Validate icon "traffic port" with params "07" with status "down-icon"
    Then UI Validate icon "traffic port" with params "08" with status "down-icon"
    Then UI Validate icon "traffic port" with params "09" with status "down-icon"
    Then UI Validate icon "traffic port" with params "11" with status "disabled-icon"
    Then UI Validate icon "traffic port" with params "12" with status "disabled-icon"
    Then UI Validate icon "traffic port" with params "13" with status "disabled-icon"
    Then UI Validate icon "traffic port" with params "14" with status "disabled-icon"
    Then UI Validate icon "traffic port" with params "15" with status "disabled-icon"

  @SID_3
  Scenario: Validate default port selection of first 8 ports
    # these steps should be replaced by the steps above after adding the port status as integer field in alteon side
    Then UI validate Checkbox by label "port" with extension "1" if Selected "true"
    Then UI validate Checkbox by label "port" with extension "2" if Selected "true"
    Then UI validate Checkbox by label "port" with extension "3" if Selected "true"
    Then UI validate Checkbox by label "port" with extension "4" if Selected "true"
    Then UI validate Checkbox by label "port" with extension "5" if Selected "true"
    Then UI validate Checkbox by label "port" with extension "16" if Selected "true"
    Then UI validate Checkbox by label "port" with extension "17" if Selected "true"
    Then UI validate Checkbox by label "port" with extension "18" if Selected "true"

  @SID_4
  Scenario: Validate port selection is enabled only for first 8 ports
    # these steps should be replaced by the steps above after adding the port status as integer field in alteon side
    Then UI is List item Enabled by selector id "Ports List" with label "port_1" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_2" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_3" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_4" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_5" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_16" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_17" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_18" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_19" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_20" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_10" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_6" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_7" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_8" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_9" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_11" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_12" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_13" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_14" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_15" "false"

  @SID_5
  Scenario: Validate port selection is limited to maximum 8 ports
# uncheck one of the default selected ports and then validate that all the others are enabled for selection
    Then UI Click List item by selector id "Ports List" with label "port_1" checkUncheck state "false"
# validate that all other ports becomes enabled due to former uncheck
    # these steps should be replaced by the steps above after adding the port status as integer field in alteon side
    Then UI is List item Enabled by selector id "Ports List" with label "port_1" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_2" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_3" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_4" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_5" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_16" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_17" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_18" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_19" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_20" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_10" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_6" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_7" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_8" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_9" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_11" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_12" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_13" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_14" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_15" "true"

# check one of the ports that wasn't selected by default and then validate that all the others are disabled for selection
    Then UI Click List item by selector id "Ports List" with label "port_19" checkUncheck state "true"
# validate that all other ports becomes disabled due to former check
    # these steps should be replaced by the steps above after adding the port status as integer field in alteon side
    Then UI is List item Enabled by selector id "Ports List" with label "port_1" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_2" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_3" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_4" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_5" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_16" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_17" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_18" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_19" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_20" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_10" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_6" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_7" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_8" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_9" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_11" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_12" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_13" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_14" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_15" "false"

  @SID_6
  Scenario: Validate user selection lasts after page refresh
    * Sleep "30"
    # these steps should be replaced by the steps above after adding the port status as integer field in alteon side
    Then UI is List item Enabled by selector id "Ports List" with label "port_1" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_2" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_3" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_4" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_5" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_16" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_17" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_18" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_19" "true"
    Then UI is List item Enabled by selector id "Ports List" with label "port_20" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_10" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_6" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_7" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_8" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_9" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_11" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_12" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_13" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_14" "false"
    Then UI is List item Enabled by selector id "Ports List" with label "port_15" "false"

  @SID_7
  Scenario: Validate port status changes are updated in dashboard after page refresh
# need to navigate to main devices page and select a real alteon for that test
    # set port to disable and wait 30 seconds for that change to take place
    * REST Customized API Request "PUT" for "DPM_Dashboard->disableenablePort" on device "Alteon" with index "14" url params "1" Body params "2"
    * Sleep "60"
    Then UI Logout
    Then UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "System and Network Dashboard" page via homePage
    Then UI click Table row by keyValue or Index with elementLabel "Devices table" findBy columnName "Device Name" with device attribute "deviceName" for "Alteon" Device with index 14
    Then UI Click Button "NetworkTab"

    # Validate that modified port changed to disabled
    Then UI Validate icon "traffic port" with params "1" with status "disabled-icon"
    Then UI Validate icon "traffic port" with params "2" with status "up-icon"
    Then UI Click List item by selector id "Ports List" with label "port_1" checkUncheck state "false"
    Then UI Click List item by selector id "Ports List" with label "port_2" checkUncheck state "false"

    # set port to up again and wait 30 seconds for that change to take place
    * REST Customized API Request "PUT" for "DPM_Dashboard->disableenablePort" on device "Alteon" with index "14" url params "1" Body params "1"
    * Sleep "60"
    # Validate that modified port changed to UP again
    Then UI Validate icon "traffic port" with params "1" with status "up-icon"
    Then UI Validate icon "traffic port" with params "2" with status "up-icon"
    Then UI validate Checkbox by label "port" with extension "1" if Selected "false"
    Then UI validate Checkbox by label "port" with extension "2" if Selected "false"

  @SID_8
  Scenario: Cleanup
    Then UI logout and close browser
