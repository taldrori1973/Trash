@TC122012
Feature: Dashboards Selected Policies


  ###################### DP monitoring dashboard #################################
  @SID_1
  Scenario: Login and Navigate to AMS DP monitoring dashboard page
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


  @SID_2
  Scenario: Select three policies
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_3
  Scenario: Validate the selected policies
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_4
  Scenario: Unselect one policy
    Then UI "UnSelect" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[BDOS] |

  @SID_5
  Scenario: Validate that the unselected policy isn't selected
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,SSL] |


  @SID_6
  Scenario: Select one more policy and Validate that only one policy is selected
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Behavioral Protections,index:10,policies:[SSL2] |
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[SSL2] |

  @SID_7
  Scenario: select and cancel with out saving
    Then UI Click Button "Device Selection"
    And UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,T_Server"
    Then UI Click Button "Device Selection.Cancel"
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[] |


################################## DefensePro Analytics Dashboard ########################################################################
  @SID_8
  Scenario: navigate to DP analytics dashboard
    And UI Navigate to "DefensePro Analytics Dashboard" page via homePage


  @SID_9
  Scenario: Select three policies
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_10
  Scenario: Validate the selected policies
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_11
  Scenario: Unselect one policy
    Then UI "UnSelect" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[BDOS] |

  @SID_12
  Scenario: Validate that the unselected policy isn't selected
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,SSL] |


  @SID_13
  Scenario: Select one more policy and Validate that only one policy is selected
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Behavioral Protections,index:10,policies:[SSL2] |
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[SSL2] |

  @SID_14
  Scenario: select and cancel with out saving
    Then UI Click Button "Device Selection"
    And UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,T_Server"
    Then UI Click Button "Device Selection.Cancel"
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[] |


#################################### DefensePro Behavioral Protections Dashboard ########################################
  @SID_15
  Scenario: Navigate to "DefensePro Behavioral Protections Dashboard" page and select policies
   Then UI Navigate to "DefensePro Behavioral Protections Dashboard" page via homePage
    Then Sleep "1"
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics, index:10,policies:[pol1,BDOS,SSL] |

    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics, index:10,policies:[pol1,BDOS,SSL] |



  @SID_16
  Scenario: Unselect one policy
    Then UI "UnSelect" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[BDOS] |

    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,SSL] |


  @SID_17
  Scenario: Select one more policy and Validate that only one policy is selected
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Behavioral Protections,index:10,policies:[SSL2] |
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[SSL2] |

  @SID_18
  Scenario: select and cancel with out saving
    Then UI Click Button "Device Selection"
    And UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,T_Server"
    Then UI Click Button "Device Selection.Cancel"
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[] |
