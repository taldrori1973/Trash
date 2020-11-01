

Feature: sanity new report



  Scenario: login and navigate
    When UI Login with user "sys_admin" and password "radware"
    When UI Navigate to "Reports" page via homepage
    Then UI Click Button "expand report"
    Then UI Validate the attribute "data-debug-checked" Of Label "expand report" is "EQUALS" to "true"



    Scenario: validate report name sanity
      Then UI Text of "REPORTPARAMETERS_Name" equal to "Name*"
      When UI Click Button "REPORTPARAMETERS_Name"
      Then UI Validate the attribute "data-debug-checked" Of Label "REPORTPARAMETERS_Name" is "EQUALS" to "true"
      When UI Set Text Field BY Character "ReportName_input" To "22$"
      Then UI Validate the attribute "class" Of Label "ReportName_textfiled" is "CONTAINS" to "idEgbD"


      Scenario: validate report scheduling
        Then UI Text of "REPORTPARAMETERS_Schedule" equal to "Schedule*"

      Scenario: validate report share sanity
        Then UI Text of "REPORTPARAMETERS_Share" equal to "share"
        When UI Click Button "REPORTPARAMETERS_Share"
        When UI Validate Text field with Class "EmailInputstyle__EmailContainer-sc-1e7xee5-0 fRdzwl" "Equals" To "To *"
        When UI Set Text Field BY Character "sendEmailTo_input" To "22$"
        Then UI Validate the attribute "class" Of Label "sendEmailTo_input" is "CONTAINS" to "idEgbD"




  Scenario: validate expand
  Then UI Click Button "expand report"
  Then UI Validate the attribute "data-debug-checked" Of Label "expand report" is "EQUALS" to "false"



