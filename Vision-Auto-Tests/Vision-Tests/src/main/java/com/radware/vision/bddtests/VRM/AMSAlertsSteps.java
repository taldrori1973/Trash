package com.radware.vision.bddtests.VRM;

import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.testhandlers.vrm.AMSAlertsHandlers;
import com.radware.vision.infra.testhandlers.vrm.enums.vrmActions;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;

import java.util.Map;

public class AMSAlertsSteps extends BddUITestBase {
    AMSAlertsHandlers alertsHandlers = new AMSAlertsHandlers();

    public AMSAlertsSteps() throws Exception {
    }

    /**
     * @param operationType or Create or Validate or Edit (Enum)
     * @param reportName The name of the report (String)
     * @param reportsEntry The values that the user want to added it like:
     *  *- | Basic Info | Description:dsds,Impact:dsds,Severity:Major,Remedy:sad|
     *                     - The first widget name and description (here you type just the description because the name we take it from the title)
     *  *- | devices| index:10, ports:[1], policies:[pol_1]; ports: [1,3], index:11;|
     *                     - The scope selection widget - you can select any device and its ports and policies
     *                     - we seperate between the devices by ';'
     *                     - The ports and policies value should be inside [] (type of array)
     *                     - We separated between the different keys inside the same device by ','
     *  * - | Criteria   | Event Criteria:Action,Operator:Equals,Value:[Proxy,Forward,Drop]; Criteria.Any |
     *                                  - You can select more than one criteria by seperate between them with ';'
     *                                  - If you select Destination IP you can add IPType:IPv4 and IPValue: 172.17.195.1
     *                                    Or Destination Port and you can add Criteria.PortType:Port/Port Range and Criteria.PortValue:80 or if you select Port Range and Criteria.portFrom:80, Criteria.portTo:100
     *  * - | Schedule   | triggerThisRule:5,Within:7,selectTimeUnit:Hours,alertPerHour:2|
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
    @Given("^UI \"(Create|Validate|Edit|Generate|Isexist)\" Alerts With Name \"([^\"]*)\"( negative)?$")
    public void uiReportWithName(vrmActions operationType, String reportName, String negative, Map<String,String> reportsEntry) throws Throwable {
        //kvision
//        alertsHandlers.VRMAlertsOperation(operationType, reportName, reportsEntry, restTestBase.getRootServerCli());
    }

    @When("^UI Delete Alerts With Name \"([^\"]*)\"$")
    public void uiDeleteAlertsWithName(String alertsName) throws Throwable {
        alertsHandlers.deleteVRMBase(alertsName);
    }

    @When("^UI \"(Check|Uncheck)\" all the Toggle Alerts$")
    public void checkORUncheckToogleAllerts(String check)
    {
        alertsHandlers.checkORUncheckToggleAlerts(check.equalsIgnoreCase("Check"));
    }

    @When("^UI \"(Check|Uncheck)\" Toggle Alerts with name \"([^\"]*)\"$")
    public void checkORUncheckSpecificToogleAlert(String check, String alertName)
    {
        alertsHandlers.checkORUncheckSpecificToggleAlert(check.equalsIgnoreCase("Check"), alertName);
    }

}
