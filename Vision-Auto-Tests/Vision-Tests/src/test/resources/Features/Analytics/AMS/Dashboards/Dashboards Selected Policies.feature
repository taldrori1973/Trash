@TC122012
Feature: Dashboards Selected Policies
  ###################### DP monitoring dashboard #################################
  @SID_1
  Scenario: Login and Navigate to AMS DP monitoring dashboard page
    Given UI Login with user "sys_admin" and password "radware"
    Then REST Vision Install License Request "vision-AVA-Max-attack-capacity"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


  @SID_2
  Scenario: Select three policies in DP monitoring dashboard
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_3
  Scenario: Validate the selected policies in DP monitoring dashboard
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_4
  Scenario: Unselect one policy in DP monitoring dashboard
    Then UI "UnSelect" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[BDOS] |

  @SID_5
  Scenario: Validate that the unselected policy isn't selected in DP monitoring dashboard
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,SSL] |


  @SID_6
  Scenario: Select one more policy and Validate that only one policy is selected in DP monitoring dashboard
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Behavioral Protections,index:10,policies:[SSL2] |
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[SSL2] |

  @SID_7
  Scenario: select and cancel with out saving in DP monitoring dashboard
    Then UI Click Button "Device Selection"
    And UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Set Text Field "Filter Policies" and params "DefensePro_172.16.22.50" To "T_Server"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,T_Server"
    Then UI Click Button "Device Selection.Cancel"
#    Then UI "Validate" Scope Polices
#      | devices | type:DefensePro Analytics,index:10,policies:[] |


################################## DefensePro Analytics Dashboard ########################################################################
  @SID_8
  Scenario: navigate to DP analytics dashboard
    And UI Navigate to "DefensePro Analytics Dashboard" page via homePage
  @SID_9
  Scenario: Select three policies in DefensePro Analytics Dashboard
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_10
  Scenario: Validate the selected policies in DefensePro Analytics Dashboard
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_11
  Scenario: Unselect one policy in DefensePro Analytics Dashboard
    Then UI "UnSelect" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[BDOS] |

  @SID_12
  Scenario: Validate that the unselected policy isn't selected in DefensePro Analytics Dashboard
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,SSL] |


  @SID_13
  Scenario: Select one more policy and Validate that only one policy is selected in DefensePro Analytics Dashboard
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Behavioral Protections,index:10,policies:[SSL2] |
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[SSL2] |

  @SID_14
  Scenario: select and cancel with out saving in DefensePro Analytics Dashboard
    Then UI Click Button "Device Selection"
    And UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Set Text Field "Filter Policies" and params "DefensePro_172.16.22.50" To "T_Server"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,T_Server"
    Then UI Click Button "Device Selection.Cancel"
#    Then UI "Validate" Scope Polices
#      | devices | type:DefensePro Analytics,index:10,policies:[] |


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
  Scenario: Unselect one policy in DefensePro Behavioral Protections Dashboard
    Then UI "UnSelect" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[BDOS] |

    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,SSL] |


  @SID_17
  Scenario: Select one more policy and Validate that only one policy is selected in DefensePro Behavioral Protections Dashboard
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Behavioral Protections,index:10,policies:[SSL2] |
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[SSL2] |

  @SID_18
  Scenario: select and cancel with out saving in DefensePro Behavioral Protections Dashboard
    Then UI Click Button "Device Selection"
    And UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Set Text Field "Filter Policies" and params "DefensePro_172.16.22.50" To "T_Server"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,T_Server"
    Then UI Click Button "Device Selection.Cancel"
#    Then UI "Validate" Scope Polices
#      | devices | type:DefensePro Analytics,index:10,policies:[] |





  #################################### DefensePro Attacks Dashboard ########################################
  @SID_19
  Scenario: Navigate to "DefensePro Behavioral Protections Dashboard" page and select policies
    Given UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "DefensePro Attacks" page via homePage
    Then Sleep "1"
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Attacks, index:10,policies:[pol1,BDOS,SSL] |

    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Attacks, index:10,policies:[pol1,BDOS,SSL] |

  @SID_20
  Scenario: Unselect one policy in DefensePro Behavioral Protections Dashboard
    Then UI "UnSelect" Scope Polices
      | devices | type:DefensePro Attacks,index:10,policies:[BDOS] |

    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Attacks,index:10,policies:[pol1,SSL] |


  @SID_21
  Scenario: Select one more policy and Validate that only one policy is selected in DefensePro Behavioral Protections Dashboard
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Attacks,index:10,policies:[SSL2] |
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Attacks,index:10,policies:[SSL2] |

  @SID_22
  Scenario: select and cancel with out saving in DefensePro Behavioral Protections Dashboard
    Then UI Click Button "Device Selection"
    And UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Then UI Click Button "DefensePro Attacks_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Set Text Field "Filter Policies" and params "DefensePro_172.16.22.50" To "T_Server"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,T_Server"
    Then UI Click Button "Device Selection.Cancel"
#    Then UI "Validate" Scope Polices
#      | devices | type:DefensePro Analytics,index:10,policies:[] |


  @SID_23
  Scenario: Log out
    Then UI Logout