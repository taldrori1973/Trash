package com.radware.vision.bddtests.VRM;


import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.testhandlers.vrm.ForensicsHandler;
import com.radware.vision.infra.testhandlers.vrm.enums.vrmActions;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.util.HashMap;
import java.util.Map;

public class ForensicsSteps extends BddUITestBase {
    private ForensicsHandler forensicsHandler = new ForensicsHandler();

    public ForensicsSteps() throws Exception {
    }


    /**
     * @param operationType or Create or Validate or Edit (Enum)
     * @param reportName The name of the report (String)
     * @param reportsEntry The values that the user want to added it like:
     *  *- | Basic Info| Description:desc,forensics name:EDIT_1|
     *                     - The first widget name and description (here you type just the description because the name we take it from the title)
     *  *- | devices| index:10, ports:[1], policies:[pol_1]; ports: [1,3], index:11;|
     *                     - The scope selection widget - you can select any device and its ports and policies
     *                     - we seperate between the devices by ';'
     *                     - The ports and policies value shold be inside [] (type of array)
     *                     - We seperate between the different keys inside the same device by ','
     *  * - | Time Definitions.Date|Quick:30m|
     *                     - Second widget is time definition you can select it with 3 ways:
     *                           - Quick: you type Quick:'the time definition how it witten at the UI'
     *                             example: | Time Definitions.Date|Quick:30m|
     *                           - Absolute: you type the ket 'Absolute:' and the value will be by two ways
     *                                  - one value like '+5m' it will add 5 minutes on the machine's current time
     *                                    example:  | Time Definitions.Date | Absolute:+1d| it will add 1 day in the current time
     *                                  - two params: the first time is which date it will start - you type the format date that found at the UI
     *                                    the second is the same like the first way
     *                                    example:  | Time Definitions.Date | Absolute:[Feb 27, 1971 01:00, +1d]|
     *                           - Relative: you type Relative:[day/weeks/Hour/month/: the value]
     *                             example | Time Definitions.Date | Relative:[Hours,1]|
     *  * - | Criteria | Event Criteria:Action,Operator:Equals,Value:[Forward,Drop];Event Criteria:Risk,Operator:Equals,Value:[High,Low];Event Criteria:Attack Name,Operator:Equals,Value:Incorrect IPv4 checksum;Criteria.Any:true|
     *                                  - You can select more than one criteria by seperate between them with ';'
     *                                  - If you select Destination IP you can add IPType:IPv4 and IPValue: 172.17.195.1
     *                                    Or Destination Port and you can add Criteria.PortType:Port/Port Range and Criteria.PortValue:80 or if you select Port Range and Criteria.portFrom:80, Criteria.portTo:100
     *  * - | Output| Action,Attack ID,Risk|
     *  * - | Schedule|Run Every:Daily,On Time:+5m|
     *                     - The user have to write the Run Every value
     *                     you can select or Daily/Weekly/Monthly/Ounce
     *                     - The user can do it by two ways:
     *                                   - By type +/-[value][type of the value] after On Time key, like +2M = after 2 months from now (it works with Once/Weekly/Daily/Monthly)
     *                                   - By type all of the UI params
     *                                          - Once: | Schedule| Run Every:Once,On Time:15:30, On Day:12-08-2018|
     *                                          - Monthly: | Schedule| Run Every:Monthly,At Months:[FEB,JAN],ON Day of Month:5,On Time:10:00 |
     *                                          - Weekly: | Schedule| Run Every:Weekly, At Week Day:[TUE],On Time:10:00|
     *                                          - Daily:  | Schedule| Run Every:daily, On Time:10:00|
     *  * - | Delivery|Email:[VisionQA3@radware.com],Subject:Subject,Body:english chrarecters1# |
     *
     *
     *
     *
     *
     *  Edit is the same thing
     *  Validate no validation utility :(
     *
     *
     *
     *     you ca write all of the table or some of the columns
     *     1and it will work
     *
     *
     * */
    @Given("^UI \"(Create|Validate|Edit|Generate|Isexist)\" Forensics With Name \"([^\"]*)\"( negative)?$")
    public void uiReportWithName(vrmActions operationType, String reportName, String negative, Map<String,String> reportsEntry) throws Throwable {
        forensicsHandler.VRMForensicsOperation(operationType, reportName, reportsEntry, restTestBase.getRootServerCli());
    }

    @Then("^UI Validate max generate Forensics is (\\d+)$")
    public void uiValidateMaxGenerateForensicsIs(int maxValue) throws Exception {
        forensicsHandler.uiValidateMaxGenerateView(maxValue);
    }

    @Then("^UI Generate( and Validate)? Forensics With Name \"([^\"]*)\" with Timeout of (\\d+) Seconds$")
    public void uiGenerateAndValidateReportWithNameWithTimeoutOfSeconds(String Validate,String reportName ,int timeout) throws Exception {
        Map<String,String> map=new HashMap<>();
        map.put("validation",Validate);
        map.put("timeout",String.valueOf(timeout));
        forensicsHandler.VRMForensicsOperation(vrmActions.GENERATE,reportName,map,restTestBase.getRootServerCli());
    }
}