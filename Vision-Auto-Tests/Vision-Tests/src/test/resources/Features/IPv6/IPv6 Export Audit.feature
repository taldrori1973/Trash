@TC111502
Feature: IPv6 CLI Export Audit log

  @SID_1
  Scenario: Clear FTP server logs
    Then CLI Run remote linux Command "rm -f exportv6_*.txt" on "GENERIC_LINUX_SERVER"

  @SID_2
  Scenario: IPv6 Export audit log FTP
    When CLI Operations - Run Radware Session command "system audit-log export ftp://radware@[200a::172:17:164:10]:/home/radware/ftp/exportv6_FTP all"
    When CLI Operations - Run Radware Session command "radware"
    Then CLI Run linux Command "ll /home/radware/ftp/exportv6_FTP.txt |awk '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result GTE "3"

  @SID_3
  Scenario: IPv6 Export audit log SFTP
    When CLI Operations - Run Radware Session command "system audit-log export sftp://radware@[200a::172:17:164:10]:/home/radware/ftp/exportv6_SFTP all"
    When CLI Operations - Run Radware Session command "radware"
    Then CLI Run linux Command "ll /home/radware/ftp/exportv6_SFTP.txt |awk '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result GTE "3"

  @SID_4
  Scenario: IPv6 Export audit log SSH
    When CLI Operations - Run Radware Session command "system audit-log export ssh://radware@200a::172:17:164:10:/home/radware/ftp/exportv6_SSH all"
    When CLI Operations - Run Radware Session command "radware"
    Then CLI Run linux Command "ll /home/radware/ftp/exportv6_SSH.txt |awk '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result GTE "3"

  @SID_5
  Scenario: IPv6 Export audit log SCP
    When CLI Operations - Run Radware Session command "system audit-log export scp://radware@[200a::172:17:164:10]:/home/radware/ftp/exportv6_SCP all"
    When CLI Operations - Run Radware Session command "radware"
    Then CLI Run linux Command "ll /home/radware/ftp/exportv6_SCP.txt |awk '{print$5}'" on "GENERIC_LINUX_SERVER" and validate result GTE "3"
