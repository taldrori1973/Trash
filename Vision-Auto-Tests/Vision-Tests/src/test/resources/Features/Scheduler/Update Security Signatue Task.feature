@TC126571
Feature: Update Security Signature Feed Scheduler Task

  @SID_1
  Scenario: Login
    Given UI Login with user "sys_admin" and password "radware"

  @SID_2
  Scenario: Add New "Update Security Signature Feed" Task
    When UI Remove All Tasks with tha Value "Update Security Signature Files" at Column "Task Type"
    Then UI Add New 'Update Security Signature' Task with Name "Update Security Signature Feed" , Schedule Run Daily at Time "01:55:00" , and the Target Device List are:
      | DefensePro_172.16.22.50|

  @SID_3
  Scenario: Run Task
    Then UI Run task with name "Update Security Signature Feed"


      # Test schedule task success + Alert
  @SID_4
  Scenario: validate task succed
    When UI Navigate to "SCHEDULER" page via homePage
    Then UI validate Vision Table row by keyValue with elementLabel "scheduledTasks" findBy columnName "Name" findBy KeyValue "Update Security Signature Feed"
      | columnName            | value   | isDate |
      | Last Execution Status | Success | false  |


      # Add lalt DP devices
  @SID_5
  Scenario: Add lalt DP devices
    When REST Add "DefensePro" Device To topology Tree with Name "DefensePro_50.50.100.1" and Management IP "50.50.100.1" into site "Default"
      | attribute | value |
#    Then REST Add "DefensePro" Device To topology Tree with Name "FakeDP" and Management IP "4.4.4.5" into site "Default"
#      | attribute | value |
    When Sleep "30"
    And Browser Refresh Page

    When UI Remove All Tasks with tha Value "Update Security Signature Files" at Column "Task Type"
    Then UI Add New 'Update Security Signature' Task with Name "Update Security Signature Feed" , Schedule Run Daily at Time "01:55:00" , and the Target Device List are:
      | DefensePro_50.50.100.1 |


      # Test schedule task Failed + Alert
  @SID_6
  Scenario: validate task succed
    When UI Navigate to "SCHEDULER" page via homePage
    Then UI validate Vision Table row by keyValue with elementLabel "scheduledTasks" findBy columnName "Name" findBy KeyValue "Update Security Signature Feed"
      | columnName            | value          | isDate |
      | Last Execution Status | Never Executed | false  |

  @SID_7
  Scenario: Remove all tasks with type Update Security Signature Files
    When UI Remove All Tasks with tha Value "Update Security Signature Files" at Column "Task Type"

  @SID_8
  Scenario: Logout
    Then UI logout and close browser
