Feature: Landing Forensics
  Scenario: Login
    Then UI Login with user "radware" and password "radware"

  Scenario: Navigate to NEW REPORTS page
    Then UI Navigate to "New Forensics" page via homepage
#    Then UI Click Button "New Forensics"
    Then UI Click Button "Forensics View"

#    create new forensics


#  generate
  Scenario: Validate delivery card and generate Forensics
    Then UI Click Button "My Forensics" with value "test"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "test"
    Then Sleep "35"


  Scenario: Validate tooltip values
    Then UI Do Operation "hover" item "INFO Forensics" with value "test"
    Then Sleep "2"
    Then UI Text of "ToolTip Forensics" with extension "test" equal to "Scope:Device:172.16.22.50Number of policies:47Number of ports:8Device:172.16.22.51Number of policies:49Number of ports:8Device:172.16.22.55Number of policies:0Number of ports:1Time Periodfrom 01.08.2018, 01:00 to 23.12.2020, 08:49Filter CriteriaNot SelectedOutput FieldsStart Time; End Time; Device IP; Threat Category; Attack Name; Action; Attack ID; Policy Name; Source IP; Source Port; Destination IP; Destination Port; Direction; Protocol; Radware ID; Duration; Packets; Mbits; Physical Port; Risk; ScheduleNot SelectedFormatHTMLDeliveryNot Selected"

#edit

#  delete
    Then UI Delete Report With Name "Top Attacks by Duration 1"


