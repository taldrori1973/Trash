@Functional @TC106065
Feature: RBAC

  @SID_1
  Scenario: Rbac Setup
#    Given REST Login with user "radware" and password "radware"
#    And REST Delete "DefensePro" device with index 2 from topology tree
#    And REST Delete "Alteon" device with index 1 from topology tree
#    And REST Delete "LinkProof" device with index 0 from topology tree
#    And REST Delete "AppWall" device with index 0 from topology tree

  @SID_2
  Scenario: Login And Go to Vision
    Given UI Login with user "radware" and password "radware"
    Given UI Go To Vision

  @SID_3
  Scenario Outline: Create users and verify
    Given UI Navigate to page "System->User Management->Local Users"
    When UI Create New User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>"
    Then  UI User With User Name "<User Name>" ,Role "<Role>" ,Scope "<Scope>" Exists

    Examples:
      | User Name             | Role                          | Scope |
      | adc_admin_certificate | ADC+Certificate Administrator | [ALL] |
      | adc_admin             | ADC Administrator             | [ALL] |
      | adc_operator          | ADC Operator                  | [ALL] |
      | certificate_admin     | Certificate Administrator     | [ALL] |
      | device_admin          | Device Administrator          | [ALL] |
      | device_configurator   | Device Configurator           | [ALL] |
      | device_operator       | Device Operator               | [ALL] |
      | device_viewer         | Device Viewer                 | [ALL] |
      | real_server_operator  | Real Server Operator          | [ALL] |
      | security_admin        | Security Administrator        | [ALL] |
      | security_monitor      | Security Monitor              | [ALL] |
      | user_admin            | User Administrator            | [ALL] |
      | vision_admin          | Vision Administrator          | [ALL] |
      | vision_reporter       | Vision Reporter               | [ALL] |
      | system_user           | System User                   | [ALL] |

  @SID_4
  Scenario Outline: Scope "All" is required for User Definition
    When Scope Is "<enabled or disabled>" For Role "<Role>"

    Examples:
      | enabled or disabled | Role                          |
      | enabled             | ADC+Certificate Administrator |
      | enabled             | ADC Administrator             |
      | enabled             | ADC Operator                  |
      | enabled             | Certificate Administrator     |
      | enabled             | Device Administrator          |
      | enabled             | Device Configurator           |
      | enabled             | Device Operator               |
      | enabled             | Device Viewer                 |
      | enabled             | Real Server Operator          |
      | enabled             | Security Administrator        |
      | enabled             | Security Monitor              |
      | disabled            | User Administrator            |
      | disabled            | Vision Administrator          |
      | disabled            | Vision Reporter               |
      | disabled            | System User                   |

  @Logout @SID_5
  Scenario: Add Multiple devices

    Then UI Add "DefensePro" with index 2 on "Default" site nowait
    Then UI Add "Alteon" with index 2 on "Default" site nowait
    Then UI Add "AppWall" with index 0 on "Default" site nowait
    Then UI Add "LinkProof" with index 0 on "Default" site nowait
    * UI Logout

  @SID_6
  Scenario: ADC+Certificate Administrator
    When UI Login with user "adc_admin_certificate" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | yes      |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | no       |
      | supports appwall                 | no       |
      | security monitoring perspective  | yes      |
      | vision settings device resources | yes      |
      | AVR                              | no       |
      | APM                              | yes      |
      | DPM                              | yes      |
      | ADC                              | yes      |
      | AMS                              | no       |
      | Alert browser                    | yes      |
      | Scheduler                        | no       |
      | Toolbox                          | yes      |
      | operator toolbox                 | yes      |
      | Appshapes                        | yes      |
      | load new Appshape                | yes      |
      | DP templates                     | no       |
      | physical tab                     | yes      |
      | dp operations                    | no       |
      | appwall operations               | no       |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | yes      |
    * UI Logout

  @SID_7
  Scenario: ADC Administrator
    When UI Login with user "adc_admin" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | yes      |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | no       |
      | supports appwall                 | no       |
      | security monitoring perspective  | yes      |
      | vision settings device resources | yes      |
      | AVR                              | no       |
      | APM                              | yes      |
      | DPM                              | yes      |
      | ADC                              | yes      |
      | AMS                              | no       |
      | Alert browser                    | yes      |
      | Scheduler                        | no       |
      | Toolbox                          | yes      |
      | operator toolbox                 | yes      |
      | Appshapes                        | yes      |
      | load new Appshape                | yes      |
      | DP templates                     | no       |
      | physical tab                     | yes      |
      | dp operations                    | no       |
      | appwall operations               | no       |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | yes      |
    * UI Logout

  @SID_8
  Scenario: ADC Operator
    When UI Login with user "adc_operator" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | yes      |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | no       |
      | supports appwall                 | no       |
      | security monitoring perspective  | no       |
      | vision settings device resources | yes      |
      | AVR                              | no       |
      | APM                              | yes      |
      | DPM                              | yes      |
      | ADC                              | yes      |
      | AMS                              | no       |
      | Alert browser                    | yes      |
      | Scheduler                        | no       |
      | Toolbox                          | yes      |
      | operator toolbox                 | no       |
      | Appshapes                        | no       |
      | load new Appshape                | no       |
      | DP templates                     | no       |
      | physical tab                     | no       |
      | dp operations                    | no       |
      | appwall operations               | no       |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | yes      |
    * UI Logout

  @SID_9
  Scenario: Administrator
    When UI Login with user "radware" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | yes      |
      | lock device                      | yes      |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | yes      |
      | supports appwall                 | yes      |
      | security monitoring perspective  | yes      |
      | vision settings device resources | yes      |
      | AVR                              | yes      |
      | APM                              | yes      |
      | DPM                              | yes      |
      | ADC                              | yes      |
      | AMS                              | yes      |
      | Alert browser                    | yes      |
      | Scheduler                        | yes      |
      | Toolbox                          | yes      |
      | operator toolbox                 | yes      |
      | Appshapes                        | yes      |
      | load new Appshape                | yes      |
      | DP templates                     | yes      |
      | physical tab                     | yes      |
      | dp operations                    | yes      |
      | appwall operations               | yes      |
      | alteon operations                | yes      |
      | security control center          | yes      |
      | app sla dashboard                | yes      |
    * UI Logout

  @SID_10
  Scenario: Certificate Administrator
    When UI Login with user "certificate_admin" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | yes      |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | no       |
      | supports appwall                 | no       |
      | security monitoring perspective  | no       |
      | vision settings device resources | yes      |
      | AVR                              | no       |
      | APM                              | no       |
      | DPM                              | no       |
      | ADC                              | no       |
      | AMS                              | no       |
      | Alert browser                    | yes      |
      | Scheduler                        | no       |
      | Toolbox                          | yes      |
      | operator toolbox                 | no       |
      | Appshapes                        | no       |
      | load new Appshape                | no       |
      | DP templates                     | no       |
      | physical tab                     | no       |
      | dp operations                    | no       |
      | appwall operations               | no       |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | no       |
    * UI Logout

  @SID_11
  Scenario: Device Administrator
    When UI Login with user "device_admin" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | yes      |
      | lock device                      | yes      |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | yes      |
      | supports appwall                 | yes      |
      | security monitoring perspective  | yes      |
      | vision settings device resources | yes      |
      | AVR                              | yes      |
      | APM                              | yes      |
      | DPM                              | yes      |
      | ADC                              | yes      |
      | AMS                              | yes      |
      | Alert browser                    | yes      |
      | Scheduler                        | yes      |
      | Toolbox                          | yes      |
      | operator toolbox                 | yes      |
      | Appshapes                        | yes      |
      | load new Appshape                | yes      |
      | DP templates                     | yes      |
      | physical tab                     | yes      |
      | dp operations                    | yes      |
      | appwall operations               | yes      |
      | alteon operations                | yes      |
      | security control center          | no       |
      | app sla dashboard                | yes      |
    * UI Logout

  @SID_12
  Scenario: Device Configurator
    When UI Login with user "device_configurator" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | yes      |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | yes      |
      | supports appwall                 | yes      |
      | security monitoring perspective  | yes      |
      | vision settings device resources | yes      |
      | AVR                              | no       |
      | APM                              | yes      |
      | DPM                              | yes      |
      | ADC                              | yes      |
      | AMS                              | yes      |
      | Alert browser                    | yes      |
      | Scheduler                        | yes      |
      | Toolbox                          | yes      |
      | operator toolbox                 | no       |
      | Appshapes                        | no       |
      | load new Appshape                | no       |
      | DP templates                     | no       |
      | physical tab                     | no       |
      | dp operations                    | yes      |
      | appwall operations               | yes      |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | yes      |
    * UI Logout

  @SID_13
  Scenario: Device Operator
    When UI Login with user "device_operator" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | yes      |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | yes      |
      | supports appwall                 | yes      |
      | security monitoring perspective  | no       |
      | vision settings device resources | yes      |
      | AVR                              | no       |
      | APM                              | yes      |
      | DPM                              | yes      |
      | ADC                              | yes      |
      | AMS                              | yes      |
      | Alert browser                    | yes      |
      | Scheduler                        | yes      |
      | Toolbox                          | yes      |
      | operator toolbox                 | no       |
      | Appshapes                        | no       |
      | load new Appshape                | no       |
      | DP templates                     | no       |
      | physical tab                     | no       |
      | dp operations                    | yes      |
      | appwall operations               | yes      |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | yes      |
    * UI Logout

  @SID_14
  Scenario: Device Viewer
    When UI Login with user "device_viewer" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | no       |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | yes      |
      | supports appwall                 | yes      |
      | security monitoring perspective  | yes      |
      | vision settings device resources | yes      |
      | AVR                              | yes      |
      | APM                              | no       |
      | DPM                              | yes      |
      | ADC                              | yes      |
      | AMS                              | yes      |
      | Alert browser                    | no       |
      | Scheduler                        | no       |
      | Toolbox                          | yes      |
      | operator toolbox                 | no       |
      | Appshapes                        | no       |
      | load new Appshape                | no       |
      | DP templates                     | no       |
      | physical tab                     | no       |
      | dp operations                    | no       |
      | appwall operations               | no       |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | yes      |
    * UI Logout

  @SID_15
  Scenario: Real server Operator
    When UI Login with user "real_server_operator" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | yes      |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | no       |
      | supports appwall                 | no       |
      | security monitoring perspective  | no       |
      | vision settings device resources | no       |
      | AVR                              | no       |
      | APM                              | no       |
      | DPM                              | no       |
      | ADC                              | no       |
      | AMS                              | no       |
      | Alert browser                    | yes      |
      | Scheduler                        | no       |
      | Toolbox                          | yes      |
      | operator toolbox                 | no       |
      | Appshapes                        | no       |
      | load new Appshape                | no       |
      | DP templates                     | no       |
      | physical tab                     | no       |
      | dp operations                    | no       |
      | appwall operations               | no       |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | no       |
    * UI Logout

  @SID_16
  Scenario: Security Administrator
    When UI Login with user "security_admin " and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | yes      |
      | supports alteon                  | no       |
      | supports linkproof               | no       |
      | supports defensepro              | yes      |
      | supports appwall                 | yes      |
      | security monitoring perspective  | yes      |
      | vision settings device resources | yes      |
      | AVR                              | yes      |
      | APM                              | no       |
      | DPM                              | no       |
      | ADC                              | no       |
      | AMS                              | yes      |
      | Alert browser                    | yes      |
      | Scheduler                        | yes      |
      | Toolbox                          | yes      |
      | operator toolbox                 | yes      |
      | Appshapes                        | no       |
      | load new Appshape                | no       |
      | DP templates                     | yes      |
      | physical tab                     | no       |
      | dp operations                    | yes      |
      | appwall operations               | yes      |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | no       |
    * UI Logout

  @SID_17
  Scenario: Security Monitor
    When UI Login with user "security_monitor" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | no       |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | yes      |
      | supports appwall                 | yes      |
      | security monitoring perspective  | yes      |
      | vision settings device resources | no       |
      | AVR                              | yes      |
      | APM                              | no       |
      | DPM                              | no       |
      | ADC                              | no       |
      | AMS                              | yes      |
      | Alert browser                    | no       |
      | Scheduler                        | no       |
      | Toolbox                          | no       |
      | operator toolbox                 | no       |
      | Appshapes                        | no       |
      | load new Appshape                | no       |
      | DP templates                     | no       |
      | physical tab                     | no       |
      | dp operations                    | no       |
      | appwall operations               | no       |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | no       |
    * UI Logout

  @SID_18
  Scenario: User Administrator
    When UI Login with user "user_admin" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | no       |
      | supports alteon                  | no       |
      | supports linkproof               | no       |
      | supports defensepro              | no       |
      | supports appwall                 | no       |
      | security monitoring perspective  | no       |
      | vision settings device resources | no       |
      | AVR                              | no       |
      | APM                              | no       |
      | DPM                              | no       |
      | ADC                              | no       |
      | AMS                              | no       |
      | Alert browser                    | no       |
      | Scheduler                        | no       |
      | Toolbox                          | no       |
      | operator toolbox                 | no       |
      | Appshapes                        | no       |
      | load new Appshape                | no       |
      | DP templates                     | no       |
      | physical tab                     | no       |
      | dp operations                    | no       |
      | appwall operations               | no       |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | no       |
    * UI Logout

  @SID_19
  Scenario: Vision Administrator
    When UI Login with user "vision_admin" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | yes      |
      | lock device                      | yes      |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | yes      |
      | supports appwall                 | yes      |
      | security monitoring perspective  | yes      |
      | vision settings device resources | yes      |
      | AVR                              | yes      |
      | APM                              | yes      |
      | DPM                              | yes      |
      | ADC                              | yes      |
      | AMS                              | yes      |
      | Alert browser                    | yes      |
      | Scheduler                        | yes      |
      | Toolbox                          | yes      |
      | operator toolbox                 | yes      |
      | Appshapes                        | yes      |
      | load new Appshape                | yes      |
      | DP templates                     | yes      |
      | physical tab                     | yes      |
      | dp operations                    | yes      |
      | appwall operations               | yes      |
      | alteon operations                | yes      |
      | security control center          | yes      |
      | app sla dashboard                | yes      |
    * UI Logout

  @SID_20
  Scenario: Vision Reporter
    When UI Login with user "vision_reporter" and password "radware"
    Then UI Validate user rbac
      | operations                       | accesses |
      | add/edit device                  | no       |
      | lock device                      | no       |
      | supports alteon                  | yes      |
      | supports linkproof               | yes      |
      | supports defensepro              | yes      |
      | supports appwall                 | yes      |
      | security monitoring perspective  | no       |
      | vision settings device resources | no       |
      | AVR                              | yes      |
      | APM                              | yes      |
      | DPM                              | yes      |
      | ADC                              | yes      |
      | AMS                              | yes      |
      | Alert browser                    | no       |
      | Scheduler                        | no       |
      | Toolbox                          | no       |
      | operator toolbox                 | no       |
      | Appshapes                        | no       |
      | load new Appshape                | no       |
      | DP templates                     | no       |
      | physical tab                     | no       |
      | dp operations                    | no       |
      | appwall operations               | no       |
      | alteon operations                | no       |
      | security control center          | no       |
      | app sla dashboard                | yes      |
    * UI Logout

  @SID_21
  Scenario: System User
    When REST Login with user "system_user" and password "radware"
    Then REST Validate user rbac
      | operations                        | accesses |
      | add/edit device                   | yes      |
      | lock device                       | yes      |
      | CONFIGURATION PERSPECTIVE         | yes      |
      | MONITORING PERSPECTIVE            | yes      |
      | SECURITY MONITORING PERSPECTIVE   | yes      |
      | DPM                               | no       |
      | ADC                               | yes      |
      | AMS                               | yes      |
      | VISION SETTINGS - DEVICE RESOURCE | yes      |
      | ALERT BROWSER                     | yes      |
      | Scheduler                         | yes      |
      | operator toolbox                  | yes      |
      | load new Appshape                 | yes      |
      | DP templates                      | yes      |
      | physical tab                      | yes      |
      | dp operations                     | yes      |
      | appwall operations                | yes      |
      | alteon operations                 | yes      |
      | security control center           | yes      |

    * UI Login with user "system_user" and password "radware" negative
    Then UI logout and close browser

  @SID_22
  Scenario:Clean up (clean configurations caused by this feature)
#    Given CLI cleanup without server Ip the vision
