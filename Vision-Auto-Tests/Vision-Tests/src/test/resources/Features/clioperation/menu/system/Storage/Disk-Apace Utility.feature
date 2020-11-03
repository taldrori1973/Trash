@TC117464
Feature: Disk-Space Utility

  @SID_1
  Scenario: Setup
    Then CLI copy "/home/radware/Scripts/fill_my_disk.sh" from "GENERIC_LINUX_SERVER" to "ROOT_SERVER_CLI" "/"
    When CLI Run remote linux Command "rm -rf /opt/radware/*.big" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "yes | cp -rf /opt/radware/box/bin/system_disk-usage.sh /opt/radware/box/bin/system_disk-usage.sh.bak" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: Normal State
    # No warning
    Given CLI Run remote linux Command "sed -i 's/^partition_percentage_to_search_for_largest_files=[[:digit:]]\+$/partition_percentage_to_search_for_largest_files=99/' /opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "/opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI" with timeOut 50
    Then CLI Operations - Verify that output contains regex "Large Files" negative

  @SID_3
  Scenario: Partition percentage crossed
    Given CLI Run remote linux Command "sed -i 's/^partition_percentage_to_search_for_largest_files=[[:digit:]]\+$/partition_percentage_to_search_for_largest_files=50/' /opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command "sed -i 's/^warning_partition_usage_percentage=[[:digit:]]\+$/warning_partition_usage_percentage=50/' /opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "/fill_my_disk.sh /opt/radware 51" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "/opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI" with timeOut 50
    Then CLI Operations - Verify that output contains regex "Large Files"
    Then  CLI Operations - Verify that output contains regex "150M /opt/radware/fill_my_disk"
    Then  CLI Operations - Verify that output contains regex "--- WARNING - One or more of the partitions use more than 50%"
    Then  CLI Operations - Verify that output contains regex "Warnings Found"
    Then  CLI Operations - Verify that output contains regex "Actions and recommendations for recovery may be found in the Installation and Maintenance Guide - CHAPTER 5  MAINTENANCE AND UPGRADE"

  @SID_4
  Scenario: ES index size OK
    Given CLI Run remote linux Command "sed -i 's/^warning_index_usage_size=[[:digit:]]\+$/warning_index_usage_size=99/' /opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command "sed -i 's/^warning_index_usage_unit=.*$/warning_index_usage_unit=gb/' /opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "/opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI" with timeOut 50
    Then CLI Operations - Verify that output contains regex "Total size on all shards of each index found is smaller than 99 gb"

  @SID_5
  Scenario: ES index size exceeded
    Given CLI Run remote linux Command "sed -i 's/^warning_index_usage_size=[[:digit:]]\+$/warning_index_usage_size=50/' /opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI"
    Given CLI Run remote linux Command "sed -i 's/^warning_index_usage_unit=.*$/warning_index_usage_unit=kb/' /opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "/opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI" with timeOut 50
    Then CLI Operations - Verify that output contains regex "WARNING - The total store.size of each of the above indices exceeds usage of 50 kb!"

  @SID_6
  Scenario: Cleanup
    When CLI Run remote linux Command "mv -f /opt/radware/box/bin/system_disk-usage.sh.bak /opt/radware/box/bin/system_disk-usage.sh" on "ROOT_SERVER_CLI"
    When CLI Run remote linux Command "rm -rf /opt/radware/*.big" on "ROOT_SERVER_CLI"
