@run1213
Feature:Selected policies in dashboard

  @SID_1
  Scenario: Login and Navigate to AMS DP monitoring dashboard page
    Then UI Login with user "radware" and password "radware"
    And UI Navigate to "DefensePro Monitoring Dashboard" page via homePage


  @SID_2
  Scenario: Select three policies
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_3
  Scenario: Validate the selected policies
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_3
  Scenario: Unselect one policy
    Then UI "UnSelect" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[BDOS] |

  @SID_4
  Scenario: Validate that the unselected policy isn't selected
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,SSL] |


  @SID_5
  Scenario: Select one more policy and Validate that only one policy is selected
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Behavioral Protections,index:10,policies:[SSL2] |
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[SSL2] |

  @SID_6
  Scenario: select and cancel with out saving
    Then UI Click Button "Device Selection"
    And UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,T_Server"
    Then UI Click Button "Device Selection.Cancel"
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[] |



  @SID_7
  Scenario: navigate to DP analytics dashboard
    And UI Navigate to "DefensePro Analytics Dashboard" page via homePage


  @SID_8
  Scenario: Select three policies
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_9
  Scenario: Validate the selected policies
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,BDOS,SSL] |

  @SID_10
  Scenario: Unselect one policy
    Then UI "UnSelect" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[BDOS] |

  @SID_11
  Scenario: Validate that the unselected policy isn't selected
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[pol1,SSL] |


  @SID_12
  Scenario: Select one more policy and Validate that only one policy is selected
    Then UI "Select" Scope Polices
      | devices | type:DefensePro Behavioral Protections,index:10,policies:[SSL2] |
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[SSL2] |

  @SID_13
  Scenario: select and cancel with out saving
    Then UI Click Button "Device Selection"
    And UI Set Checkbox "Device Selection.All Devices Selection" with extension "" To "false"
    Then UI Click Button "DefensePro Analytics_RationScopeSelection" with value "172.16.22.50"
    Then UI Click Button "DPScopeSelectionChange" with value "172.16.22.50"
    Then UI Click Button "DPPolicyCheck" with value "172.16.22.50,T_Server"
    Then UI Click Button "Device Selection.Cancel"
    Then UI "Validate" Scope Polices
      | devices | type:DefensePro Analytics,index:10,policies:[] |






