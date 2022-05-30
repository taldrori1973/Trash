@TC126776
Feature: AMS forensic BDoS

  @SID_1
  Scenario: Clean system data
    * CLI kill all simulator attacks on current vision
    * REST Delete ES index "dp-*"
    * REST Delete ES index "forensics-*"

  @SID_2
  Scenario: generate BDoS attacks for footprint
    Given CLI simulate 1 attacks of type "vrm_bdos" on SetId "DefensePro_Set_1" and wait 120 seconds


  @SID_3
  Scenario: Login and enter forensic tab
    Given UI Login with user "radware" and password "radware"
    Then UI Navigate to "AMS Forensics" page via homepage

  @SID_4
  Scenario: Create forensic report for BDoS_csvwithdetails
    When UI "Create" Forensics With Name "BDoS_Signature_csvwithdetails"

      | Format | Select: CSVWithDetails, Check: Include All Signatures                                                     |
      | Output | Attack ID,Threat Category,Attack Name,Footprint                                                                     |
      | Share  | FTP:checked, FTP.Location:10.25.80.4, FTP.Path:/home/radware/, FTP.Username:radware, FTP.Password:radware |

  @SID_5
  Scenario: Generate the forensic report
    Then CLI Run remote linux Command "rm -rf /home/radware/BDoS_*.zip  /home/radware/BDoS_*.csv /home/radware/DNS_*.zip /home/radware/DNS_*.csv" on "GENERIC_LINUX_SERVER"
    Then UI Click Button "My Forensics" with value "BDoS_Signature_csvwithdetails"
    Then UI Click Button "Generate Snapshot Forensics Manually" with value "BDoS_Signature_csvwithdetails"
    Then Sleep "5"

  @SID_6
  Scenario: Unzip CSV file and validate footprint signature in *.csv and *signature.csv
    Then CLI Run remote linux Command "unzip -o /home/radware/BDoS_Signature_csvwithdetails*.zip -d /home/radware/" on "GENERIC_LINUX_SERVER"
    Then CLI Run linux Command "ll /home/radware/BDoS_Signature_csvwithdetails*.csv | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"
    Then CLI Run linux Command "cat /home/radware/BDoS_Signature_csvwithdetails*.csv | grep -F 'Footprint,"[ OR  sequence-number=123456,]"' | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/BDoS_Signature_csvwithdetails*_signatures.csv |grep 'Attack ID, Timestamp, BPS, PPS, Footprint' | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"
    Then CLI Run linux Command "cat /home/radware/BDoS_Signature_csvwithdetails*_signatures.csv | grep -F "[ OR  sequence-number=123456,]" | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"


#  @SID_7
#  Scenario: Create forensic report for BDoS_csv
#    When UI "Create" Forensics With Name "BDoS_Signature_csv"
#
#      | Format | Select: CSV, Check: Include All Signatures                                                                |
#      | Share  | FTP:checked, FTP.Location:10.25.80.4, FTP.Path:/home/radware/, FTP.Username:radware, FTP.Password:radware |
#
#  @SID_8
#  Scenario: Generate the forensic report
#    Then CLI Run remote linux Command "rm -rf /home/radware/BDoS_*.zip /home/radware/BDoS_*.csv /home/radware/DNS_*.zip /home/radware/DNS_*.csv" on "GENERIC_LINUX_SERVER"
#    Then UI Click Button "My Forensics" with value "BDoS_Signature_csv"
#    Then UI Click Button "Generate Snapshot Forensics Manually" with value "BDoS_Signature_csv"
#
#  @SID_9
#  Scenario: Unzip CSV file and validate footprint signature in *.csv and *signature.csv
#    Then CLI Run remote linux Command "unzip -o /home/radware/BDoS_Signature_csv*.zip -d /home/radware/" on "GENERIC_LINUX_SERVER"
#    Then CLI Run linux Command "ll /home/radware/BDoS_Signature_csv*.csv | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "2"
#    Then CLI Run linux Command "cat /home/radware/BDoS_Signature_csv*.csv | grep -F "[ OR  sequence-number=123456,]" | wc -l" on "GENERIC_LINUX_SERVER" and validate result EQUALS "1"

  @SID_10
  Scenario: close browser
    Then UI close browser
    * CLI kill all simulator attacks on current vision


