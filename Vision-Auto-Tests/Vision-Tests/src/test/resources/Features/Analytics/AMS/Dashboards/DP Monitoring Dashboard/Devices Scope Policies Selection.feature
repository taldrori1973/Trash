@TC122847
Feature: Device Scope Policies Selection

  @SID_1
  Scenario:  login to vision and navigate DP Monitoring
    Given UI Login with user "radware" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    Then UI Navigate to "DefensePro Monitoring Dashboard" page via homepage


  @SID_2
  Scenario: select in device and validate in policy
    Given UI Click Button "Device Selection"

    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS] |
    Given UI Click Button "Device Selection"
    Given UI Click Button "Devices Policies"
    Then UI Validate the attribute "data-debug-checked" Of Label "Policy Selection" With Params "RealDPs_Version_8_site,DefensePro_172.16.22.50,BDOS" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Policy Selection" With Params "RealDPs_Version_8_site,DefensePro_172.16.22.50,pol1" is "EQUALS" to "true"

  @SID_3
  Scenario: unselect all device and select spicific policy then validate in policy
    Given UI Click Button "Device Selection"
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "true"
    Given UI Click Button "Device Selection.Save Filter"
    Given UI Click Button "Device Selection"
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Given UI Click Button "Device Selection.Save Filter"
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS] |
    Given UI Click Button "Device Selection"
    Given UI Click Button "Devices Policies"
    Then UI Validate the attribute "data-debug-checked" Of Label "Policy Selection" With Params "RealDPs_Version_8_site,DefensePro_172.16.22.50,BDOS" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Policy Selection" With Params "RealDPs_Version_8_site,DefensePro_172.16.22.50,pol1" is "EQUALS" to "true"

    Given UI Click Button "Device Selection.Save Filter"

  @SID_4
  Scenario: select all policies in device and validate unselected checkbox in policies tab
    Given UI Click Button "Device Selection"
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "true"
    Given UI Click Button "Device Selection.Save Filter"
    Given UI Click Button "Device Selection"

    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:12,policies:[Ahlam69] |
    Given UI Click Button "Device Selection"
    Given UI Click Button "Devices Policies"
    Then UI validate Checkbox by label "Device Selection.All Devices Selection" with extension "" if Selected "false"


  @SID_5
  Scenario: Select Policies and Validate in Device
    Given UI Click Button "Devices select"
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "true"
    Given UI Click Button "Device Selection.Save Filter"

    Then UI Select Policy and save
      | name                   | device                  | policy  |
      | RealDPs_Version_8_site | DefensePro_172.16.22.50 | BDOS    |
      | RealDPs_Version_8_site | DefensePro_172.16.22.50 | 0000    |
      | VA_DPs_Version_8_site  | DefensePro_172.16.22.55 | Ahlam69 |


    Given UI Click Button "Device Selection"

    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[BDOS,0000] |

    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:12,policies:[Ahlam69] |

  @SID_6
  Scenario: Unselect device , select all policies , check all selected device
    Given UI Click Button "Device Selection"
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "true"
    Given UI Click Button "Device Selection.Save Filter"
    Given UI Click Button "Device Selection"
    Then UI UnSelect Element with label "Device Selection Check Box" and params "DefensePro_172.16.22.50"
    Given UI Click Button "Device Selection.Save Filter"
    Given UI Click Button "Device Selection"
    Given UI Click Button "Devices Policies"
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "true"
    Given UI Click Button "Device Selection.Save Filter"
    Given UI Click Button "Device Selection"
    Then UI validate Checkbox by label "Device Selection Check Box" with extension "DefensePro_172.16.22.50" if Selected "true"
    Given UI Click Button "Device Selection.Save Filter"

  @SID_7
  Scenario: unselect all in devices and select all  in polices then validate selected checkbox in devices

    Given UI Click Button "Device Selection"
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "true"
    Given UI Click Button "Device Selection.Save Filter"
    Given UI Click Button "Device Selection"
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Given UI Click Button "Devices Policies"
    Given UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "true"
    Given UI Click Button "Device Selection.Save Filter"
    Given UI Click Button "Device Selection"
    Then UI validate Checkbox by label "Device Selection.All Devices Selection" with extension "" if Selected "true"

  @SID_8
  Scenario: number of devices
    Then UI Click Button "Device Selection"
    Then UI Text of "Device Selection.Available Devices header" with extension "" equal to "Devices4/4"
    Given UI Click Button "Device Selection.Save Filter"

  @SID_9
  Scenario: select from device and validate that all checkbox in policies is not selected
    Given UI Click Button "Device Selection"

    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS] |
    Given UI Click Button "Device Selection"
    Given UI Click Button "Devices Policies"
    Then UI validate Checkbox by label "Device Selection.All Devices Selection" with extension "" if Selected "false"
    Given UI Click Button "Device Selection.Save Filter"

  @SID_10
  Scenario: deleted items is not in policies tab
  Given UI Click Button "Device Selection"
    When UI Select device from dashboard device type "DefensePro"
      | index |
      | 10    |

    When UI Click Button "Show Deleted Policies" with params
      | index |
      | 10    |
    Then UI validate if policy is Exist
      | index | policies | isExist |
      | 10    | 1234     | true    |

    Given UI Click Button "Devices Policies"

  Then UI validate if policy is Exist
    | index | policies | isExist |
    | 10    | 1234     | false    |

    Then UI Click Button "Device Selection.Cancel"

  @SID_11
  Scenario: Logout and close browser
    Given UI logout and close browser


