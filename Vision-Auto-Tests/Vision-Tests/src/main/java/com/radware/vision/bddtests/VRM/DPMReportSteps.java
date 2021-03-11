package com.radware.vision.bddtests.VRM;

import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.testhandlers.DPM.DPMReportHandler;
import com.radware.vision.infra.testhandlers.vrm.enums.vrmActions;
import cucumber.api.java.en.Given;

import java.util.Map;








public class DPMReportSteps extends BddUITestBase {
    DPMReportHandler dpmReportsHandler = new DPMReportHandler();

    public DPMReportSteps() throws Exception {
    }


    /**
     * @param operationType or Create or Validate or Edit (Enum)
     * @param reportName The name of the report (String)
     * @param reportsEntry The values that the user want to added it like:
     *  *- | reportType| DefensePro Analytics Dashboard|
     *                     The device type that you want to create the reporter with
     *  *- | devices| virts:[Rejith:88, Rejith:443]
     *                     array of virts.
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
     *  * - | Design|Delete:[ALL], Add:[Top Attacks]| (it will do the delete (if found) first always )
     *
     *
     *
     *
     *  Edit is the same thing
     *  Validate the same thing but it diffrent at the Design
     *                     | Design| Widgets:[Top Attacks]| = it is mean which widgets i want see finally
     *
     *
    you ca write all of the table or some of the columns
     *       and it will work
     *
     *
     *
     * */


    @Given("^UI \"(Create|Validate|Edit)\" DPMReport With Name \"([^\"]*)\"$")
    public void uiReportWithName(vrmActions operationType, String reportName, Map<String,String> reportsEntry) throws Throwable {
        dpmReportsHandler.VRMReportOperation(operationType, reportName, reportsEntry);
    }
}
