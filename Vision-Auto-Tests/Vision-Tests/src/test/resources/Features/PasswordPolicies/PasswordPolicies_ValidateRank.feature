@PasswordPolicy2
Feature: Verify Password Policy feature where user is assigned to multiple roles and accepts password policy of higher rank

  Scenario: Create 2 new password policies for different roles
    Given UI Login with user "radware" and password "radware"
#    Then UI Navigate to page "System"
    And UI Click Button by id "gwt-debug-TopicsStack_am.system.tree.userManagement"
    And UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.userManagement.customSettings-content"
    And UI Click Button by id "gwt-debug-usermgmtpolicyoveridetable_NEW"
    And UI Set Text field with id "gwt-debug-policyName_Widget" with "CertificateAdministratorPolicy"

    And Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Password Policies"
      | ormID | $[?(@.policyName=='DEFAULT')].ormID |

    Then Validate That Response Body has passwordRank equals to 1

    Then UI Set Text for passwordPolicyRank with id "gwt-debug-policyRank_Widget" with rank
    And UI Click Button by id "gwt-debug-Custom.Policies.Strength.Column_2_Tab"
    And UI Set Text field with id "gwt-debug-minPasswordLength_Widget" with "4"
    And UI Click Button by id "gwt-debug-Custom.Policies.RoleList.Column_3_Tab"
    And UI Click Button by id "gwt-debug-policyRolePairList_NEW"
    And UI Select "Certificate Administrator" from Vision dropdown by Id "gwt-debug-roleName_Widget-input"
    And UI Click Button by id "gwt-debug-ConfigTab_NEW_policyRolePairList_Submit"
    And UI Click Button by id "gwt-debug-ConfigTab_NEW_usermgmtpolicyoveridetable_Submit"

    And UI Click Button by id "gwt-debug-usermgmtpolicyoveridetable_NEW"
    And UI Set Text field with id "gwt-debug-policyName_Widget" with "DeviceAdministratorPolicy"

    And Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Password Policies"
      | ormID | $[?(@.policyName=='DEFAULT')].ormID |

    Then Validate That Response Body has passwordRank equals to 2

    Then UI Set Text for passwordPolicyRank with id "gwt-debug-policyRank_Widget" with rank
    And UI Click Button by id "gwt-debug-Custom.Policies.Strength.Column_2_Tab"
    And UI Set Text field with id "gwt-debug-minPasswordLength_Widget" with "6"
    And UI Click Button by id "gwt-debug-Custom.Policies.RoleList.Column_3_Tab"
    And UI Click Button by id "gwt-debug-policyRolePairList_NEW"
    And UI Select "Device Administrator" from Vision dropdown by Id "gwt-debug-roleName_Widget-input"
    And UI Click Button by id "gwt-debug-ConfigTab_NEW_policyRolePairList_Submit"
    And UI Click Button by id "gwt-debug-ConfigTab_NEW_usermgmtpolicyoveridetable_Submit"


  Scenario: Validate if password policy updated for above 2 roles
    Given UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.userManagement.roles-content"

    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Roles With Policies"
      | ormID | $[?(@.name=='CERTIF_ADMIN')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get Role With Policy details"
    And The Request Path Parameters Are
      | id | ${ormID} |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body has passwordPolicy equals to "CertificateAdministratorPolicy"

    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Roles With Policies"
      | ormID | $[?(@.name=='DEV_ADMIN')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Get Role With Policy details"
    And The Request Path Parameters Are
      | id | ${ormID} |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    And Validate That Response Body has passwordPolicy equals to "DeviceAdministratorPolicy"

  Scenario: Create User with above roles and check if it accepts password policy of lower rank
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Create Local User"
    Given The Request Body is the following Object
      | jsonPath                                    | value                |
      | $.name                                      | "SampleUser"      |
      | $.password                                  | "Ac1@"               |
      | $.requireDeviceLock                         | true                 |
      | $.userSettings.userLocale                   | "en_US"              |
      | $.parameters.roleGroupPairList[0].groupName | "Default"            |
      | $.parameters.roleGroupPairList[0].roleName  | "CERTIF_ADMIN"       |
      | $.parameters.roleGroupPairList[1].groupName | "Default (Physical)" |
      | $.parameters.roleGroupPairList[1].roleName  | "DEV_ADMIN"          |
      | $.roleGroupPairList[0].groupName            | "Default"            |
      | $.roleGroupPairList[0].roleName             | "CERTIF_ADMIN"       |
      | $.roleGroupPairList[0].groupName            | "Default (Physical)" |
      | $.roleGroupPairList[0].roleName             | "DEV_ADMIN"          |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is BAD_REQUEST
    Given UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.userManagement.localUsers-content"
    And Sleep "2"

  Scenario: Create User with above roles and check if it accepts password policy of higher rank
    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Create Local User"
    Given The Request Body is the following Object
      | jsonPath                                    | value                |
      | $.name                                      | "NewSampleUser"      |
      | $.password                                  | "Ac1@23"             |
      | $.requireDeviceLock                         | true                 |
      | $.userSettings.userLocale                   | "en_US"              |
      | $.parameters.roleGroupPairList[0].groupName | "Default"            |
      | $.parameters.roleGroupPairList[0].roleName  | "CERTIF_ADMIN"       |
      | $.parameters.roleGroupPairList[1].groupName | "Default (Physical)" |
      | $.parameters.roleGroupPairList[1].roleName  | "DEV_ADMIN"          |
      | $.roleGroupPairList[0].groupName            | "Default"            |
      | $.roleGroupPairList[0].roleName             | "CERTIF_ADMIN"       |
      | $.roleGroupPairList[0].groupName            | "Default (Physical)" |
      | $.roleGroupPairList[0].roleName             | "DEV_ADMIN"          |

    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK
    Given UI Click Button by id "gwt-debug-TopicsNode_am.system.tree.userManagement.localUsers-content"
    And Sleep "2"

  Scenario: Edit Password Policy for above selected roles to DEFAULT
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Roles With Policies"
      | ormID | $[?(@.name=='CERTIF_ADMIN')].ormID |

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
      | ormID | $[?(@.name=='DEV_ADMIN')].ormID |

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
      | ormID | $[?(@.policyName=='CertificateAdministratorPolicy')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | usermgmtpolicy |
      | id   | ${ormID}       |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Password Policies"
      | ormID | $[?(@.policyName=='DeviceAdministratorPolicy')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | usermgmtpolicy |
      | id   | ${ormID}       |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

  Scenario: Delete created Local User
    Given Create Following RUNTIME Parameters by Sending Request Specification from File "Vision/SystemConfigItemList" with label "Get Local Users"
      | ormID | $[?(@.name=='NewSampleUser')].ormID |

    Given New Request Specification from File "Vision/SystemConfigItemList" with label "Delete an Item from the Server"
    And The Request Path Parameters Are
      | item | user     |
      | id   | ${ormID} |
    When Send Request with the Given Specification
    Then Validate That Response Status Code Is OK

  Scenario: Logout and Close browser
    And UI logout and close browser