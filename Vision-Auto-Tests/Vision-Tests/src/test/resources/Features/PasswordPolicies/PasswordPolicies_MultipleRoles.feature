@PasswordPolicy1
Feature: Verify Password Policy feature where policy is assigned with multiple roles

  Scenario: Create new password policy for multiple roles
    Given UI Login with user "radware" and password "radware"
#    Then UI Navigate to page "System"
    And UI Click Button by id "gwt-debug-TopicsStack_am.system.tree.userManagement"
    And UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.userManagement.customSettings-content"
    And UI Click Button by id "gwt-debug-usermgmtpolicyoveridetable_NEW"
    And UI Set Text field with id "gwt-debug-policyName_Widget" with "SamplePolicy"

    And Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Password Policies"
      | ormID | $[?(@.policyName=='DEFAULT')].ormID |

    Then Validate That Response Body has passwordRank equals to 1

    Then UI Set Text for passwordPolicyRank with id "gwt-debug-policyRank_Widget" with rank
    And UI Click Button by id "gwt-debug-Custom.Policies.Strength.Column_2_Tab"
    And UI Set Text field with id "gwt-debug-minPasswordLength_Widget" with "4"
    And UI Click Button by id "gwt-debug-Custom.Policies.RoleList.Column_3_Tab"

    And UI Click Button by id "gwt-debug-policyRolePairList_NEW"
    And UI Select "Device Viewer" from Vision dropdown by Id "gwt-debug-roleName_Widget-input"
    And UI Click Button by id "gwt-debug-ConfigTab_NEW_policyRolePairList_Submit"

    And UI Click Button by id "gwt-debug-policyRolePairList_NEW"
    And UI Select "Security Monitor" from Vision dropdown by Id "gwt-debug-roleName_Widget-input"
    And UI Click Button by id "gwt-debug-ConfigTab_NEW_policyRolePairList_Submit"

    And UI Click Button by id "gwt-debug-policyRolePairList_NEW"
    And UI Select "System User" from Vision dropdown by Id "gwt-debug-roleName_Widget-input"
    And UI Click Button by id "gwt-debug-ConfigTab_NEW_policyRolePairList_Submit"

    And UI Click Button by id "gwt-debug-ConfigTab_NEW_usermgmtpolicyoveridetable_Submit"

  Scenario: Validate if password policy updated for selected role1
    Given UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.userManagement.roles-content"

    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Roles With Policies"
      | ormID | $[?(@.name=='SEC_MON')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get Role With Policy details"
    And The Request Path Parameters Are
      | id | ${ormID} |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body has passwordPolicy equals to "SamplePolicy"

  Scenario: Validate if password policy updated for selected role2
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Roles With Policies"
      | ormID | $[?(@.name=='VIEWER')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get Role With Policy details"
    And The Request Path Parameters Are
      | id | ${ormID} |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body has passwordPolicy equals to "SamplePolicy"

  Scenario: Validate if password policy updated for selected role3
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Roles With Policies"
      | ormID | $[?(@.name=='SYSTEM_USER')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get Role With Policy details"
    And The Request Path Parameters Are
      | id | ${ormID} |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body has passwordPolicy equals to "SamplePolicy"

  Scenario: Create User with one of above roles and test password policy
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Create Local User"
    Given The Request Body is the following Object
      | jsonPath                                    | value      |
      | $.name                                      | "SampleUser2" |
      | $.password                                  | "Co3~c"     |
      | $.requireDeviceLock                         | true       |
      | $.userSettings.userLocale                   | "en_US"    |
      | $.parameters.roleGroupPairList[0].groupName | "[ALL]"    |
      | $.parameters.roleGroupPairList[0].roleName  | "SEC_MON"  |
      | $.roleGroupPairList[0].groupName            | "[ALL]"    |
      | $.roleGroupPairList[0].roleName             | "SEC_MON"  |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.userManagement.localUsers-content"
    And Sleep "2"

  Scenario: Edit Password Policy for above roles to DEFAULT
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Roles With Policies"
      | ormID | $[?(@.name=='SEC_MON')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Edit Policy of Role"
    And The Request Path Parameters Are
      | id | ${ormID} |

    And The Request Body is the following Object
      | jsonPath            | value      |
      | $.ormID             | "${ormID}" |
      | $.managementPolicy  | "DEFAULT"  |
      | $.requireDeviceLock | true       |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Roles With Policies"
      | ormID | $[?(@.name=='VIEWER')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Edit Policy of Role"
    And The Request Path Parameters Are
      | id | ${ormID} |

    And The Request Body is the following Object
      | jsonPath            | value      |
      | $.ormID             | "${ormID}" |
      | $.managementPolicy  | "DEFAULT"  |
      | $.requireDeviceLock | true       |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Roles With Policies"
      | ormID | $[?(@.name=='SYSTEM_USER')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Edit Policy of Role"
    And The Request Path Parameters Are
      | id | ${ormID} |

    And The Request Body is the following Object
      | jsonPath            | value      |
      | $.ormID             | "${ormID}" |
      | $.managementPolicy  | "DEFAULT"  |
      | $.requireDeviceLock | true       |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

  Scenario: Delete created policy
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Password Policies"
      | ormID | $[?(@.policyName=='SamplePolicy')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | usermgmtpolicy |
      | id   | ${ormID}       |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

  Scenario: Delete created Local User
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='SampleUser2')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

  Scenario: Logout and Close browser
    And UI logout and close browser
