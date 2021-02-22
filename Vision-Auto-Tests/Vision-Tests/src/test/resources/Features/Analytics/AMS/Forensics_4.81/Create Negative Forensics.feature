@TC119593 
Feature: Negative Forensics tests to validate Error Messages

  @Test12
  @SID_1
  Scenario: Navigate to NEW ForensicsS page
    * REST Delete ES index "forensics-*"
    Then UI Login with user "radware" and password "radware"
    Then UI Navigate to "New Forensics" page via homepage
    Then UI Click Button "New Forensics Tab"
  
  @SID_2
  Scenario: Add Forensics without Name
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "Invalid configuration. Specify a name."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  
  @SID_3
  Scenario: Add Forensics with invalid Name
    Then UI Click Button "New Forensics Tab"
    Then UI Set Text Field "Forensics Name" To "Test&"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Name contains special characters. Remove the special characters."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  
  @SID_4
  Scenario: Add Forensics without selected output
    Then UI Click Button "New Forensics Tab"
    Then UI Set Text Field "Forensics Name" To "output"
    Then select forensics Output with details ""
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Output configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_5
  Scenario: Add Forensics without Email Subject
    Then UI Click Button "New Forensics Tab"
    Then UI Set Text Field "Forensics Name" To "Share"
    Then UI Click Button "Share Tab"
    Then UI Set Text Field "Email" To "example@example.com" enter Key true
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Share configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  
  @SID_6
  Scenario: Add Forensics without Email
    Then UI Click Button "New Forensics Tab"
    Then UI Set Text Field "Forensics Name" To "Share"
    Then UI Click Button "Share Tab"
    Then UI Set Text Field "Subject" To "test test" enter Key true
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Share configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_7
  Scenario: Add Forensics with invalid FTP hostname
    Then UI Click Button "New Forensics Tab"
    Then UI Set Text Field "Forensics Name" To "Share FTP"
    Then UI Click Button "Share Tab Label" with value "ftp"
    Then UI Set Text Field "FTP input" and params "location" To ","
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Share configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_8
  Scenario: Add Forensics with invalid FTP IP
    Then UI Click Button "New Forensics Tab"
    Then UI Set Text Field "Forensics Name" To "Share FTP"
    Then UI Click Button "Share Tab Label" with value "ftp"
    Then UI Set Text Field "FTP input" and params "location" To "1.-1.1.1"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Share configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_9
  Scenario: Add Forensics with invalid FTP User Name
    Then UI Click Button "New Forensics Tab"
    Then UI Set Text Field "Forensics Name" To "Share FTP"
    Then UI Click Button "Share Tab Label" with value "ftp"
    Then UI Set Text Field "FTP input" and params "username" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Share configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_10
  Scenario: Add Forensics with invalid FTP Password
    Then UI Click Button "New Forensics Tab"
    Then UI Set Text Field "Forensics Name" To "Share FTP"
    Then UI Click Button "Share Tab Label" with value "ftp"
    Then UI Set Text Field "FTP input" and params "password" To "'"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Share configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_11
  Scenario: Add Forensics with invalid Relative Time
    Then UI Click Button "New Forensics Tab"
    Then UI Set Text Field "Forensics Name" To "Relative Time"
    Then UI Click Button "Time Tab"
    Then UI Click Button "Time Type" with value "relative"
    Then UI Click Button "Relative Time Unit" with value "Days"
    Then UI Set Text Field "Relative Time Unit Value" and params "Days" To "-1"
    Then UI Click Button "save"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Relative Time"
    Then UI Click Button "Edit Forensics" with value "Relative Time"
    Then UI Click Button "Time Tab"
    Then UI Click Button "Time Type" with value "relative"
    Then UI Validate Text field "Relative Time Unit Value" with params "Days" EQUALS "1"

    Then UI Click Button "Relative Time Unit" with value "Hours"
    Then UI Set Text Field "Relative Time Unit Value" and params "Hours" To "-1"
    Then UI Click Button "save"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Relative Time"
    Then UI Click Button "Edit Forensics" with value "Relative Time"
    Then UI Click Button "Time Tab"
    Then UI Click Button "Time Type" with value "relative"
    Then UI Validate Text field "Relative Time Unit Value" with params "Hours" EQUALS "1"

    Then UI Click Button "Relative Time Unit" with value "Weeks"
    Then UI Set Text Field "Relative Time Unit Value" and params "Weeks" To "-1"
    Then UI Click Button "save"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Relative Time"
    Then UI Click Button "Edit Forensics" with value "Relative Time"
    Then UI Click Button "Time Tab"
    Then UI Click Button "Time Type" with value "relative"
    Then UI Validate Text field "Relative Time Unit Value" with params "Weeks" EQUALS "1"

    Then UI Click Button "Relative Time Unit" with value "Months"
    Then UI Set Text Field "Relative Time Unit Value" and params "Months" To "-1"
    Then UI Click Button "save"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "true" with value "Relative Time"
    Then UI Click Button "Edit Forensics" with value "Relative Time"
    Then UI Click Button "Time Tab"
    Then UI Click Button "Time Type" with value "relative"
    Then UI Validate Text field "Relative Time Unit Value" with params "Months" EQUALS "1"
    Then UI Click Button "save"
    Then UI Delete Forensics With Name "Relative Time"
    Then UI Validate Element Existence By Label "My Forensics" if Exists "false" with value "Relative Time"



############################ Criteria DP ###################################################################
  
  @SID_12
  Scenario: Add Forensics with invalid Attack ID in Criteria - DP
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefensePro"
    Then UI Set Text Field "Forensics Name" To "DP Criteria Test Attack ID"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Attack ID"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "text" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "text,1" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"


  @SID_13
  Scenario: Add Forensics with invalid Attack Rate in bps in Criteria - DP
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefensePro"
  Then UI Set Text Field "Forensics Name" To "DP Criteria Test Attack Rate in bps"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Attack Rate in bps"
    Then UI Click Button "Criteria Attribute Selected" with value ">"
    Then UI Set Text Field "Criteria Value Input Label" and params "rate" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "rate,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_14
  Scenario: Add Forensics with invalid Attack Rate in pps in Criteria - DP
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefensePro"
    Then UI Set Text Field "Forensics Name" To "DP Criteria Test Attack Rate in pps"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Attack Rate in pps"
    Then UI Click Button "Criteria Attribute Selected" with value ">"
    Then UI Set Text Field "Criteria Value Input Label" and params "rate" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "rate,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"


  @SID_15
  Scenario: Add Forensics with invalid Destination Ip in Criteria - DP
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefensePro"
    Then UI Set Text Field "Forensics Name" To "DP Criteria Test Destination IP"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Destination IP"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "ip" To "1.1.1.1"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "ip,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_16
  Scenario: Add Forensics with invalid Destination port in Criteria - DP
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefensePro"
    Then UI Set Text Field "Forensics Name" To "DP Criteria Test Destination Port"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Destination Port"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "port-from" To "1"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "port-from,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @Test12
  @SID_17
  Scenario: Add Forensics with invalid Source IP in Criteria - DP
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefensePro"
    Then UI Set Text Field "Forensics Name" To "DP Criteria Test Source IP"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Source IP"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "ip" To "1.1.1.1"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "ip,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_18
  Scenario: Add Forensics with invalid Source Port in Criteria - DP
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefensePro"
    Then UI Set Text Field "Forensics Name" To "DP Criteria Test Source Port"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Source Port"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "port-from" To "1"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "port-from,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_19
  Scenario: Add Forensics with invalid Max bps in Criteria - DP
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefensePro"
    Then UI Set Text Field "Forensics Name" To "DP Criteria Test Max bps"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Max bps"
    Then UI Click Button "Criteria Attribute Selected" with value ">"
    Then UI Set Text Field "Criteria Value Input Label" and params "rate" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "rate,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_20
  Scenario: Add Forensics with invalid Max pps in Criteria - DP
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefensePro"
    Then UI Set Text Field "Forensics Name" To "DP Criteria Test Max pps"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Max pps"
    Then UI Click Button "Criteria Attribute Selected" with value ">"
    Then UI Set Text Field "Criteria Value Input Label" and params "rate" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "rate,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"


    ############################ Criteria DF ###################################################################
  @Test12
  @SID_21
  Scenario: Add Forensics with invalid Attack ID in Criteria - DF
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefenseFlow"
    Then UI Set Text Field "Forensics Name" To "DF Criteria Test Attack ID"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Attack ID"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "text" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "text,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"


  @SID_22
  Scenario: Add Forensics with invalid Attack Rate in bps in Criteria - DF
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefenseFlow"
    Then UI Set Text Field "Forensics Name" To "DF Criteria Test Attack Rate in bps"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Attack Rate in bps"
    Then UI Click Button "Criteria Attribute Selected" with value ">"
    Then UI Set Text Field "Criteria Value Input Label" and params "rate" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "rate,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_23
  Scenario: Add Forensics with invalid Attack Rate in pps in Criteria - DF
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefenseFlow"
    Then UI Set Text Field "Forensics Name" To "DF Criteria Test Attack Rate in pps"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Attack Rate in pps"
    Then UI Click Button "Criteria Attribute Selected" with value ">"
    Then UI Set Text Field "Criteria Value Input Label" and params "rate" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "rate,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"


  @SID_24
  Scenario: Add Forensics with invalid Destination Ip in Criteria - DF
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefenseFlow"
    Then UI Set Text Field "Forensics Name" To "DF Criteria Test Destination IP"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Destination IP"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "ip" To "1.1.1.1"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "ip,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_25
  Scenario: Add Forensics with invalid Destination port in Criteria - DF
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefenseFlow"
    Then UI Set Text Field "Forensics Name" To "DF Criteria Test Destination Port"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Destination Port"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "port-from" To "1"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "port-from,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @Test12
  @SID_26
  Scenario: Add Forensics with invalid Source IP in Criteria - DF
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefenseFlow"
    Then UI Set Text Field "Forensics Name" To "DF Criteria Test Source IP"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Source IP"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "ip" To "1.1.1.1"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "ip,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @Test12
  @SID_27
  Scenario: Add Forensics with invalid Source Port in Criteria - DF
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefenseFlow"
    Then UI Set Text Field "Forensics Name" To "DF Criteria Test Source Port"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Source Port"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "port-from" To "1"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "port-from,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_28
  Scenario: Add Forensics with invalid Max bps in Criteria - DF
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefenseFlow"
    Then UI Set Text Field "Forensics Name" To "DF Criteria Test Max bps"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Max bps"
    Then UI Click Button "Criteria Attribute Selected" with value ">"
    Then UI Set Text Field "Criteria Value Input Label" and params "rate" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "rate,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_29
  Scenario: Add Forensics with invalid Max pps in Criteria - DF
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "DefenseFlow"
    Then UI Set Text Field "Forensics Name" To "DF Criteria Test Max pps"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Max pps"
    Then UI Click Button "Criteria Attribute Selected" with value ">"
    Then UI Set Text Field "Criteria Value Input Label" and params "rate" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "rate,1" To "text"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"


    ############################ Criteria AW ###################################################################
  @Test12
  @SID_30
  Scenario: Add Forensics with invalid Attack Name in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "AW Criteria Test Attack Name"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Attack Name"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "text" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "text,1" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_31
  Scenario: Add Forensics with invalid Cluster IP in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "AW Criteria Test Cluster IP"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Cluster IP"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "ip" To "1.1.1.1"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "ip,1" To "11"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_32
  Scenario: Add Forensics with invalid Destination IP in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "AW Criteria Test Destination IP"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Destination IP"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "ip" To "1.1.1.1"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "ip,1" To "11"
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @Test12
  @SID_33
  Scenario: Add Forensics with invalid Device Host Name in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "AW Criteria Test Device Host Name"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Device Host Name"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "text" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "text,1" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @Test12
  @SID_34
  Scenario: Add Forensics with invalid Directory in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "AW Criteria Test Directory"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Directory"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "text" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "text,1" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @Test12
  @SID_35
  Scenario: Add Forensics with invalid Module in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "AW Criteria Test Module"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Module"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "text" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "text,1" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @Test12
  @SID_36
  Scenario: Add Forensics with invalid Transaction ID in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "AW Criteria Test Transaction ID"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Transaction ID"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "text" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "text,1" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_37
  Scenario: Add Forensics with invalid Source IP in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "AW Criteria Test Source IP"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Source IP"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "ip" To "1.1.1.1"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "ip,1" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_38
  Scenario: Add Forensics with invalid Source Port in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "AW Criteria Test Source Port"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Source Port"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "port-from" To "123"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "port-from,1" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @Test12
  @SID_39
  Scenario: Add Forensics with invalid Tunnel in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "AW Criteria Test Tunnel"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Tunnel"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "text" To "aaaa"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "text,1" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @Test12
  @SID_40
  Scenario: Add Forensics with invalid User Name in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "AW Criteria Test User Name"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "User Name"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "text" To "aaaa"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "text,1" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @Test12
  @SID_41
  Scenario: Add Forensics with invalid Web Application Name in Criteria - AW
    Then UI Click Button "New Forensics Tab"
    Then UI Click Button "Product Tab" with value "AppWall"
    Then UI Set Text Field "Forensics Name" To "Criteria Test Web Application Name"
    Then UI Click Button "Criteria Tab"
    Then UI Click Button "Criteria Attribute Expand"
    Then UI Click Button "Criteria Attribute Selected" with value "Web Application Name"
    Then UI Click Button "Criteria Attribute Selected" with value "="
    Then UI Set Text Field "Criteria Value Input Label" and params "text" To "aaaa"
    Then UI Click Button "Add Condition" with value "enabled"
    Then UI Set Text Field "Criteria Value Edit Value" and params "text,1" To " "
    Then UI Click Button "save"
    Then UI Text of "Error message title" equal to "Unable to Save"
    Then UI Text of "Error message description" equal to "The Criteria configuration is improper."
    Then UI Click Button "errorMessageOK"
    Then UI Click Button "cancel"
    Then UI Click Button "No"

  @SID_42
  Scenario: Logout
    Then UI logout and close browser