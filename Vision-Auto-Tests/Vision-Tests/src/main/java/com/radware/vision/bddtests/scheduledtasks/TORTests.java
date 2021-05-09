package com.radware.vision.bddtests.scheduledtasks;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.systemManagement.serversManagement.ServersManagement;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.testhandlers.scheduledtasks.TORTaskHandler;
import cucumber.api.java.en.When;
import enums.SUTEntryType;

import java.util.List;


public class TORTests extends VisionUITestBase {

    public TORTests() throws Exception {
    }

    @When("^UI Add TOR feed task with name \"(.*)\" description \"(.*)\" with default params( negative)?$")
    public void addUpdateTorTask(String taskName, String taskDescription, String isNegativeArg) /*throws Exception*/ {
        try {
            TORTaskHandler.addTORTask(taskName, taskDescription, true);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create task: " + taskName + parseExceptionBody(e), Reporter.FAIL);
        }
        BaseTestUtils.report("Operation was executed successfully : " + taskName, BaseTestUtils.PASS_NOR_FAIL);
    }

    /**
     * Shay Even Zor - check whether element exists
     * /
     */
    @When("^UI verify web element not exist$")
    public void isElementExists(List<String> uiElement) {
        try {
            TORTaskHandler.fieldsNotExistVerification(uiElement);
        } catch (Exception e) {
            BaseTestUtils.report("Verification failed" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @When("^CLI Operations - Verify TOR request for all Alteons and Linkproof$")
    public void isTaskHandlesAlteonAndLPDevices() {
//kVision
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "grep -oP '(?<=Fetching from MIS for mac addresses: ).*'  /opt/radware/storage/mgt-server/third-party/tomcat2/logs/torfeedservice.debug.log | tail -1 | tr -d ',' | tr ' ' '\\n'| sort | wc -l");
        String NumOfHandledDevicesBytask = CliOperations.resultLines.get(CliOperations.resultLines.size() - 1);
//       kVision
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "mysql -prad123 vision_ng -e \"select count(c.license_mac_addr) from site_tree_elem_abs as a inner join device_setup as b on a.fk_dev_setup_device_setup=b.row_id inner join hardware as c on c.row_id=b.fk_hw_hardware inner join devicestatus as d on d.row_id=a.fk_dev_status inner join software as e on e.row_id=b.fk_dev_sw_software where a.type_column='Alteon' and d.status=1\" | grep -v + | grep -v count");
        String NumOfRelevantManagedDevicesForTorTask = CliOperations.resultLines.get(CliOperations.resultLines.size() - 1);
        if (Integer.valueOf(NumOfHandledDevicesBytask).equals(Integer.valueOf(NumOfRelevantManagedDevicesForTorTask)))
            BaseTestUtils.report("Task handles all relevant machines", Reporter.PASS);
        else
            BaseTestUtils.report("Task doesn't handle all relevant machines", Reporter.FAIL);

    }

    @When("^CLI Operations - Verify TOR feed downloaded successfully$")
    // This function compares betwnn the md5sum of the actual feed file and declared md5 by MIS
    public void isFeedFileDownloadedSuccessfuly() {
//       kVision
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "rm -rf /var/tmp/tor_feed.zip");
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "mysql -N -u root -prad123 vision_ng -e \"select feed_file INTO DUMPFILE '/var/tmp/tor_feed.zip' from tor_feed\"");
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "md5sum /var/tmp/tor_feed.zip | awk '{print $1}'");
//        String md5sumOfActualDowloadedFile = CliOperations.lastRow;
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "mysql -N -u root -prad123 vision_ng -e \"select feed_response from tor_feed\" | grep -oP '(?<=md5\":\").[^\"]*'");
//        String md5sumDeclaredbyMIS = CliOperations.lastRow;
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "mysql -N -u root -prad123 vision_ng -e \"select feed_response from tor_feed\" | grep -oP '(?<=Ids\":\\[\").[^\"]*'");
        String validMac = CliOperations.lastRow;
        String visionIP = clientConfigurations.getHostIp();
        String commandToExecute = "sudo /home/radware/reputationFeed.sh " + visionIP + " " + validMac + " | grep -oP '(?<=actual file md5sum: ).*'";
//        CliOperations.runCommand(getRestTestBase().getGenericLinuxServer(),"sudo /home/radware/reputationFeed.sh 172.17.164.104 0003b2a3db00 | grep -oP '(?<=actual file md5sum: ).*'");

//       kVision
//        CliOperations.runCommand(getRestTestBase().getGenericLinuxServer(),commandToExecute);
//        String md5sumdownloadedByAlteon = CliOperations.lastRow;
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "rm -rf /var/tmp/tor_feed.zip");
//        if (md5sumDeclaredbyMIS.equals(md5sumOfActualDowloadedFile) && md5sumDeclaredbyMIS.equals(md5sumdownloadedByAlteon))
//            BaseTestUtils.report("TOR file downloaded correctly from MIS", Reporter.PASS);
//        else
//            BaseTestUtils.report("TOR file wasn't downloaded correctly from MIS: md5sum is different", Reporter.FAIL);


    }

    @When("^Run TOR request simulation script \"(.*)\" at scriptPath \"(.*)\" on (GENERIC_LINUX_SERVER|ROOT_SERVER_CLI|GENERIC_LINUX_SERVER|RADWARE_SERVER_CLI) to current SUT for Alteon (\\d+)")
    public void runTORRequestScript(String scriptName, String scriptPath, ServersManagement.ServerIds sutEntryType, int alteonIndex) {
        try {
            String visionIP = clientConfigurations.getHostIp();
        DeviceInfo deviceInfo = devicesManager.getDeviceInfo(SUTDeviceType.Alteon,alteonIndex);                 //getDeviceInfo(Alteon, alteonIndex);
        String mac_Address = deviceInfo.getMacAddress().replaceAll(":","");
        String commandToExecute = scriptPath + scriptName + " " + visionIP + " " + mac_Address;
        CliOperations.runCommand(getSUTEntryTypeByServerCliBase(sutEntryType), commandToExecute);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run script: " + scriptPath + "/" + scriptName + "\n" + parseExceptionBody(e), Reporter.WARNING);
        }
    }

}

