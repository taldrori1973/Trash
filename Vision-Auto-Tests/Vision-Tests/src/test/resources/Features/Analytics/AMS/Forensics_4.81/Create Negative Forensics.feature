@TC119593
Feature: Negative Forensics tests to validate Error Messages

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



    ## Missing Criteria and different product

  @SID_11
  Scenario: Logout
    Then UI logout and close browser