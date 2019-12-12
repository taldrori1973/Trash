@TC111673
 Feature: DefenseFlow API node activity

    @SID_1
    Scenario:  DELETE all DefenseFlows activities
      When REST Login with user "defenseflow" and password "defenseflow"
      Then REST Request "DELETE" for "DefenseFlow->DELETE All Nodes Activity"
        | type                 | value |
        | Returned status code | 200   |
      Then REST Request "GET" for "DefenseFlow->GET All Nodes Activity"
        | type                 | value |
        | result               | {}    |
        | Returned status code | 200   |
      Then REST Logout user "defenseflow"

   @SID_2
   Scenario:  Verify error message in case Node not exist
     When REST Login with user "defenseflow" and password "defenseflow"
     Then REST Request "GET" for "DefenseFlow->GET Node1 Activity"
       | type                 | value                                                          |
       | result               | "status":"error"                                               |
       | result               | "message":"DefenseFlow node 1.1.1.1 does not exist on Vision." |
       | Returned status code | 400                                                            |
     Then REST Logout user "defenseflow"

   @SID_3
    Scenario:  Update activity for first DefenseFlow
     When REST Login with user "defenseflow" and password "defenseflow"
     Then REST Request "POST" for "DefenseFlow->Update Node1 Activity"
       | type                 | value |
       | Returned status code | 200   |
     Then REST Request "GET" for "DefenseFlow->GET All Nodes Activity"
       | type                 | value                   |
       | result               | "1.1.1.1":1500000000013 |
       | Returned status code | 200                     |
     Then REST Logout user "defenseflow"

    @SID_4
    Scenario:  Update activity for second DefenseFlow
      When REST Login with user "defenseflow" and password "defenseflow"
      Then REST Request "POST" for "DefenseFlow->Update Node2 Activity"
        | type                 | value |
        | Returned status code | 200   |

    @SID_5
    Scenario:  Read status of all DefenseFlows activities
      Then REST Request "GET" for "DefenseFlow->GET All Nodes Activity"
        | type                 | value                   |
        | result               | "1.1.1.1":1500000000013 |
        | result               | "1.1.1.2":1500000000014 |
        | Returned status code | 200                     |
      Then REST Logout user "defenseflow"

    @SID_6
    Scenario:  Read status of one DefenseFlows activity
      When REST Login with user "defenseflow" and password "defenseflow"
      Then REST Request "GET" for "DefenseFlow->GET Node1 Activity"
        | type                 | value                   |
        | result               | "1.1.1.1":1500000000013 |
        | Returned status code | 200                     |
#      Then REST Request "GET" for "DefenseFlow->GET Node1 Activity"
#        | type                 | value                   |
#        | result               | "1.1.1.2":1500000000014 |
#        | Returned status code | 200                     |
      Then REST Logout user "defenseflow"

   @SID_7
   Scenario:  Delete one DefenseFlows activitiy
     When REST Login with user "defenseflow" and password "defenseflow"
     Then REST Request "DELETE" for "DefenseFlow->DELETE Node2 Activity"
       | type                 | value |
       | Returned status code | 200   |
     Then REST Request "GET" for "DefenseFlow->GET Node1 Activity"
       | type                 | value                   |
       | result               | "1.1.1.1":1500000000013 |
       | Returned status code | 200                     |
     Then REST Logout user "defenseflow"

   @SID_8
   Scenario:  Verify error message in case Node deleted
     When REST Login with user "defenseflow" and password "defenseflow"
     Then REST Request "GET" for "DefenseFlow->GET Node2 Activity"
       | type                 | value                                                          |
       | result               | "status":"error"                                               |
       | result               | "message":"DefenseFlow node 1.1.1.2 does not exist on Vision." |
       | Returned status code | 400                                                            |
     Then REST Logout user "defenseflow"

    @SID_9
    Scenario:  Delete all DefenseFlows activities
      When REST Login with user "defenseflow" and password "defenseflow"
      Then REST Request "DELETE" for "DefenseFlow->DELETE All Nodes Activity"
        | type                 | value |
        | Returned status code | 200   |
      Then REST Request "GET" for "DefenseFlow->GET All Nodes Activity"
        | type                 | value |
        | result               | {}    |
        | Returned status code | 200   |
      Then REST Logout user "defenseflow"

   @SID_10
   Scenario:  Verify API error for non defenseflow user
     When REST Login with user "sys_admin" and password "radware"
     Then REST Request "GET" for "DefenseFlow->GET All Nodes Activity"
       | type                 | value                                                                   |
       | result               | "message": "M_00737: You are not authorized to perform this operation." |
       | Returned status code | 403                                                                     |
     Then REST Logout user "sys_admin"
