@TC109481
Feature: IPv6 LDAP Login

  @SID_1
  Scenario: Clear existing LDAP object setting
    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from user_role_group_pair where fk_ldap_object_perm is not null;""
    Then MYSQL DELETE FROM "" Table in "VISION_NG" Schema WHERE ""

    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from ldap_permission_to_net_protec_rule;""
    Then MYSQL DELETE FROM "" Table in "VISION_NG" Schema WHERE ""

    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from ldap_object_permission;""
    Then MYSQL DELETE FROM "" Table in "VISION_NG" Schema WHERE ""

    Then CLI Operations - Run Root Session command "mysql -prad123 vision_ng -e "delete from ldap_base_dn;""
    Then MYSQL DELETE FROM "" Table in "VISION_NG" Schema WHERE ""


  @SID_2
  Scenario: Navigate to LDAP setting page
    Then CLI Operations - Run Root Session command "yes|restore_radware_user_password" timeout 15
    Given UI Login with user "radware" and password "radware"
    Then UI Go To Vision
    Then UI Navigate to page "System->General Settings->Authentication Protocols->LDAP Settings"

  @SID_3
  Scenario: LDAP setting - set Parameters
    Then UI Set Text Field "Fully Qualified Domain Name" To "directory.test.com" enter Key true
    Then UI Set Text field with id "gwt-debug-primaryServerHost_Widget" with "200a:0000:0000:0000:172:17:164:52"
    Then UI Set Text field with id "gwt-debug-primaryServerPort_Widget" with "636"
    Then UI Set Checkbox by ID "gwt-debug-primaryServerEncrypted_Widget-input" To "true"
    Then UI Click Web element with id "gwt-debug-ldapbasedn_NEW"
    Then UI Set Text Field "Name" To "DC=directory,DC=test,DC=com" enter Key true
    Then UI Click Button "Submit"
    Then UI Click Button "Submit"

  @SID_4
  Scenario: LDAP settings - LDAP Object Class Permissions
    Then UI Navigate to page "System->User Management->LDAP Object Class Permissions"
    Then UI Execute Vision table with Action ID "_NEW" by label "ldapobjectpermission" isTriggerPopupSearch event "false"
    Then UI Set Text Field "Object Class Name" To "user" enter Key true
    Then UI Set Text Field "Attribute" To "memberOf" enter Key true
    Then UI Set Text Field "Value" To "CN=vision_users,OU=testOU,DC=directory,DC=test,DC=com" enter Key true
    Then UI Execute Vision table with Action ID "_NEW" by label "Role" isTriggerPopupSearch event "false"
    Then UI Select "Administrator" from Vision dropdown by Id "gwt-debug-roleName_Widget"
    Then UI Click Button "Submit"
    Then UI Click Button "Submit"
    Then UI Logout

  @SID_5
  Scenario: LDAP setting - set Authentication Mode LDAP
    When CLI Operations - Run Radware Session command "system user authentication-mode set LDAP"

  @SID_6
  Scenario: LDAP IPv6 user login validation
    Given UI Login with user "ldapAuto" and password "radware"
    Then UI logout and close browser

  @SID_7
  Scenario: LDAP setting - set Authentication Mode LOCAL
    When CLI Operations - Run Radware Session command "system user authentication-mode set Local"
