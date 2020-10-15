@run
Feature: sanity new report
  @SID_1
  Scenario: Navigate to NEW REPORTS page
    Then UI Login with user "sys_admin" and password "radware"
    Then UI Navigate to "NEW REPORTS" page via homepage
#    Then UI Click Button "Report Parameter Menu"

  @SID_2
  Scenario: Validate Report Parameters Name
    Then UI Text of "Name Tab" equal to "Name*"
    Then UI Text of "Logo Tab" equal to "Logo"
    Then UI Text of "Time Tab" equal to "Time*"
    Then UI Text of "Schedule Tab" equal to "Schedule*"
    Then UI Text of "Share Tab" equal to "Share"
    Then UI Text of "Format Tab" equal to "Format"

  @SID_3
  Scenario: Report Name is selected
    Then UI Click Button "Name Tab"
    Then UI Validate the attribute "data-debug-checked" Of Label "Name Tab" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Logo Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Time Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Share Tab" is "EQUALS" to "false"

  @SID_4
  Scenario: Report Logo is selected
    Then UI Click Button "Logo Tab"
    Then UI Validate the attribute "data-debug-checked" Of Label "Name Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Logo Tab" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Time Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Share Tab" is "EQUALS" to "false"

  @SID_5
  Scenario: Report Time is selected
    Then UI Click Button "Time Tab"
    Then UI Validate the attribute "data-debug-checked" Of Label "Name Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Logo Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Time Tab" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Share Tab" is "EQUALS" to "false"

  @SID_6
  Scenario: Report Schedule is selected
    Then UI Click Button "Schedule Tab"
    Then UI Validate the attribute "data-debug-checked" Of Label "Name Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Logo Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Time Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Tab" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Share Tab" is "EQUALS" to "false"

  @SID_7
  Scenario: Report Share is selected
    Then UI Click Button "Share Tab"
    Then UI Validate the attribute "data-debug-checked" Of Label "Name Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Logo Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Time Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Tab" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Share Tab" is "EQUALS" to "true"

  @SID_8
  Scenario: Validate report name
    Then UI Validate the attribute "placeholder" Of Label "Report Name" is "EQUALS" to "Type here"
    Then UI Set Text Field "Report Name" To "Test Text"
    Then UI Set Text Field "Report Name" To "&"
    Then UI Validate the attribute "Class" Of Label "Name TextField" is "CONTAINS" to "idEgbD"
    Then UI Set Text Field "Report Name" To " "
    Then UI Validate the attribute "Class" Of Label "Name TextField" is "CONTAINS" to "idEgbD"

  @SID_9
  Scenario: Report Time - Quick Range is selected
    Then UI Click Button "Time" with value "quickrange"
    Then UI Validate the attribute "aria-selected" Of Label "Time" With Params "quickrange" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Time" With Params "absolute" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Time" With Params "relative" is "EQUALS" to "false"

  @SID_10
  Scenario: Report Time - Absolute is selected
    Then UI Click Button "Time" with value "absolute"
    Then UI Validate the attribute "aria-selected" Of Label "Time" With Params "quickrange" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Time" With Params "absolute" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Time" With Params "relative" is "EQUALS" to "false"

  @SID_11
  Scenario: Report Time - Relative is selected
    Then UI Click Button "Time" with value "relative"
    Then UI Validate the attribute "aria-selected" Of Label "Time" With Params "quickrange" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Time" With Params "absolute" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Time" With Params "relative" is "EQUALS" to "true"

  @SID_12
  Scenario: Validate Quick Range Time
    Then UI Click Button "Time" with value "quickrange"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "15m" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "30m" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "1H" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "1D" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "1W" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "1M" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "3M" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "Today" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "Yesterday" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "This Week" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "This Week" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "This Month" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Quick Range" With Params "Quarter" is "EQUALS" to "false"

  @SID_13
  Scenario: Time - Relative Hour button is selected
    Then UI Click Button "Time" with value "relative"
    Then UI Click Button "Relative Time Unit" with value "Hours"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Hours" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Days" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Weeks" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Months" is "EQUALS" to "false"

  @SID_14
  Scenario: Time - Relative Days button is selected
    Then UI Click Button "Relative Time Unit" with value "Days"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Hours" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Days" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Weeks" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Months" is "EQUALS" to "false"

  @SID_15
  Scenario: Time - Relative Weeks button is selected
    Then UI Click Button "Relative Time Unit" with value "Weeks"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Hours" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Days" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Weeks" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Months" is "EQUALS" to "false"

  @SID_16
  Scenario: Time - Relative Months button is selected
    Then UI Click Button "Relative Time Unit" with value "Months"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Hours" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Days" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Weeks" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "Relative Time Unit" With Params "Months" is "EQUALS" to "true"

  @SID_17
  Scenario: Validate Relative Time - Hours
    Then UI Click Button "Relative Time Unit" with value "Hours"
    Then UI Set Text Field "Relative Time Unit Value" and params "Hours" To "0"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Hours" is "CONTAINS" to "cCLrFi"
    Then UI Set Text Field "Relative Time Unit Value" and params "Hours" To "-1"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Hours" is "CONTAINS" to "cCLrFi"
    Then UI Set Text Field "Relative Time Unit Value" and params "Hours" To "8761"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Hours" is "CONTAINS" to "cCLrFi"

  @SID_18
  Scenario: Validate Relative Time - Days
    Then UI Click Button "Relative Time Unit" with value "Days"
    Then UI Set Text Field "Relative Time Unit Value" and params "Days" To "0"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Days" is "CONTAINS" to "cCLrFi"
    Then UI Set Text Field "Relative Time Unit Value" and params "Days" To "-1"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Days" is "CONTAINS" to "cCLrFi"
    Then UI Set Text Field "Relative Time Unit Value" and params "Days" To "366"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Days" is "CONTAINS" to "cCLrFi"

  @SID_19
  Scenario: Validate Relative Time - Weeks
    Then UI Click Button "Relative Time Unit" with value "Weeks"
    Then UI Set Text Field "Relative Time Unit Value" and params "Weeks" To "0"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Weeks" is "CONTAINS" to "cCLrFi"
    Then UI Set Text Field "Relative Time Unit Value" and params "Weeks" To "-1"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Weeks" is "CONTAINS" to "cCLrFi"
    Then UI Set Text Field "Relative Time Unit Value" and params "Weeks" To "53"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Weeks" is "CONTAINS" to "cCLrFi"

  @SID_20
  Scenario: Validate Relative Time - Months
    Then UI Click Button "Relative Time Unit" with value "Months"
    Then UI Set Text Field "Relative Time Unit Value" and params "Months" To "0"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Months" is "CONTAINS" to "cCLrFi"
    Then UI Set Text Field "Relative Time Unit Value" and params "Months" To "-1"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Months" is "CONTAINS" to "cCLrFi"
    Then UI Set Text Field "Relative Time Unit Value" and params "Months" To "53"
    Then UI Validate the attribute "Class" Of Label "Relative Time Unit Value" With Params "Months" is "CONTAINS" to "cCLrFi"

  @SID_21
  Scenario: Report Schedule Daily is selected
    Then UI Click Button "Switch button Scheduled Report"
    Then UI Click Button "Schedule Report" with value "daily"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "daily" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "weekly" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "monthly" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "once" is "EQUALS" to "false"

  @SID_22
  Scenario: Report Schedule Weekly is selected
    Then UI Click Button "Schedule Report" with value "weekly"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "daily" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "weekly" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "monthly" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "once" is "EQUALS" to "false"

  @SID_23
  Scenario: Report Schedule Monthly is selected
    Then UI Click Button "Schedule Report" with value "monthly"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "daily" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "weekly" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "monthly" is "EQUALS" to "true"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "once" is "EQUALS" to "false"

  @SID_24
  Scenario: Report Schedule Once is selected
    Then UI Click Button "Schedule Report" with value "once"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "daily" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "weekly" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "monthly" is "EQUALS" to "false"
    Then UI Validate the attribute "aria-selected" Of Label "Schedule Report" With Params "once" is "EQUALS" to "true"

#  @SID_25
#  Scenario: Validate daily schedule
#    Then UI Click Button "Schedule Report" with value "daily"
#    Then UI Set Text Field "Schedule Daily Time" To "1:31 PM"
#    Then UI Validate the attribute "Class" Of Label "dailyTime_textfiled" is "CONTAINS" to "jZCIie"
#    Then UI Set Text Field "Schedule Daily Time" To "01:3 PM"
#    Then UI Validate the attribute "Class" Of Label "dailyTime_textfiled" is "CONTAINS" to "jZCIie"
#    Then UI Set Text Field "Schedule Daily Time" To "01:03"
#    Then UI Validate the attribute "Class" Of Label "dailyTime_textfiled" is "CONTAINS" to "jZCIie"
#    Then UI Set Text Field "Schedule Daily Time" To "13:00 PM"
#    Then UI Validate the attribute "Class" Of Label "dailyTime_textfiled" is "CONTAINS" to "jZCIie"
#    Then UI Set Text Field "Schedule Daily Time" To "00:00 PM"
#    Then UI Validate the attribute "Class" Of Label "dailyTime_textfiled" is "CONTAINS" to "jZCIie"
#    Then UI Set Text Field "Schedule Daily Time" To "11:61 PM"
#    Then UI Validate the attribute "Class" Of Label "dailyTime_textfiled" is "CONTAINS" to "jZCIie"

#  @SID_26
#  Scenario: Report Schedule Day of week is selected
#    Then UI Click Button "Schedule Report" with value "weekly"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Day" With Params "MON" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Day" With Params "TUE" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Day" With Params "WED" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Day" With Params "THU" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Day" With Params "FRI" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Day" With Params "SAT" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Day" With Params "SUN" is "EQUALS" to "false"
#    Then UI Validate the attribute "Class" Of Label "ScheduleDayOfWeek" is "CONTAINS" to "jZCIie"

#  @SID_27
#  Scenario: Report Schedule Month is selected
#    Then UI Click Button "Schedule Report" with value "monthly"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "JAN" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "FEB" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "MAR" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "APR" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "MAY" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "JUN" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "JUL" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "AUG" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "SEP" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "OCT" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "NOV" is "EQUALS" to "false"
#    Then UI Validate the attribute "data-debug-checked" Of Label "Schedule Month" With Params "DEC" is "EQUALS" to "false"
#    Then UI Validate the attribute "Class" Of Label "ScheduleMonth" is "CONTAINS" to "jZCIie"

#  @SID_28
#  Scenario: Validate Share send email To
#    Then UI Set Text Field "Email" To "user@automation.local"
#    Then UI Text of "Email" equal to "To *"
#
#  @SID_29
#  Scenario: Validate send email Subject
#    Then UI Text of "Subject" equal to "Subject"
#
#  @SID_30
#  Scenario: Validate send email Type your message
#    Then UI Text of "message" equal to "Type your message"

  @SID_31
  Scenario: Report Format PDF Button is clicked
    Then UI Click Button "PDF Format"
    Then UI Validate the attribute "data-debug-checked" Of Label "PDF Format" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "HTML Format" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "CSV Format" is "EQUALS" to "false"

  @SID_32
  Scenario: Report Format HTML Button is clicked
    Then UI Click Button "HTML Format"
    Then UI Validate the attribute "data-debug-checked" Of Label "PDF Format" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "HTML Format" is "EQUALS" to "true"
    Then UI Validate the attribute "data-debug-checked" Of Label "CSV Format" is "EQUALS" to "false"

  @SID_33
  Scenario: Report Format CSV Button is clicked
    Then UI Click Button "CSV Format"
    Then UI Validate the attribute "data-debug-checked" Of Label "PDF Format" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "HTML Format" is "EQUALS" to "false"
    Then UI Validate the attribute "data-debug-checked" Of Label "CSV Format" is "EQUALS" to "true"

  @SID_35
  Scenario: Logout
    Then UI logout and close browser

