@TC111677
Feature: CLI System Backup TechSupport

  @SID_1
  Scenario: Remove local support file if exists
    When CLI Run remote linux Command "rm -rf /opt/radware/storage/maintenance/vision_support*.tar" on "ROOT_SERVER_CLI"

  @SID_2
  Scenario: Generate local support file
    When CLI Operations - Run Radware Session command "system backup techSupport local" timeout 300
    Then CLI Operations - Verify that output contains regex "The tech-support package was exported to /opt/radware/storage/maintenance/vision_support.*"

  @SID_3
  Scenario: validate support file created
    Then CLI Run linux Command "du -sk /opt/radware/storage/maintenance/vision_support*.tar |awk '{print$1}'" on "ROOT_SERVER_CLI" and validate result GTE "10000"

