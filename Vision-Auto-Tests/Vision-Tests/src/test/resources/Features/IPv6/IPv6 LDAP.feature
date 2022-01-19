@TC109481
Feature: IPv6 LDAP Login

  @SID_1
  Scenario: Clear existing LDAP object setting
    Then MYSQL DELETE FROM "user_role_group_pair" Table in "VISION_NG" Schema WHERE "fk_ldap_object_perm is not null"
    Then MYSQL DELETE FROM "ldap_permission_to_net_protec_rule" Table in "VISION_NG" Schema WHERE ""
    Then MYSQL DELETE FROM "ldap_object_permission" Table in "VISION_NG" Schema WHERE ""
    Then MYSQL DELETE FROM "ldap_base_dn" Table in "VISION_NG" Schema WHERE ""

  @SID_2
  Scenario: Navigate to LDAP setting page
    Given CLI Reset radware password
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Authentication Protocols->LDAP Settings"

  @SID_3
  Scenario: LDAP IPv6 user login validation
    #LDAP setting - set Parameters
    Given UI Set Text Field "Fully Qualified Domain Name" To "directory.test.com" enter Key true
    And UI Set Text field with id "gwt-debug-primaryServerHost_Widget" with "200a:0000:0000:0000:172:17:164:52"
    And UI Set Text field with id "gwt-debug-primaryServerPort_Widget" with "636"
    And UI Set Checkbox by ID "gwt-debug-primaryServerEncrypted_Widget-input" To "true"
    And UI Click Web element with id "gwt-debug-ldapbasedn_NEW"
    And UI Set Text Field "Name" To "DC=directory,DC=test,DC=com" enter Key true
    And UI Click Button "Submit"
    And UI Click Button "Submit"
#    LDAP settings - LDAP Object Class Permissions
    And UI Navigate to page "System->User Management->LDAP Object Class Permissions"
    And UI Execute Vision table with Action ID "_NEW" by label "ldapobjectpermission" isTriggerPopupSearch event "false"
    And UI Set Text Field "Object Class Name" To "user" enter Key true
    And UI Set Text Field "Attribute" To "memberOf" enter Key true
    And UI Set Text Field "Value" To "CN=vision_users,OU=testOU,DC=directory,DC=test,DC=com" enter Key true
    And UI Execute Vision table with Action ID "_NEW" by label "Role" isTriggerPopupSearch event "false"
    And UI Select "Administrator" from Vision dropdown by Id "gwt-debug-roleName_Widget"
    And UI Click Button "Submit"
    And UI Click Button "Submit"
    And UI Logout
    #LDAP setting - set Authentication Mode LDAP
    When CLI Operations - Run Radware Session command "system user authentication-mode set LDAP"
    Then UI Login with user "shaytest" and password "radware"

  @SID_4
  Scenario: LDAP setting - set Authentication Mode LOCAL
    When CLI Operations - Run Radware Session command "system user authentication-mode set Local"

  @SID_5
  Scenario: Logout
    Then UI logout and close browser
