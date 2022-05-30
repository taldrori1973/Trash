package com.radware.vision.bddtests.scheduledtasks;

import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.testhandlers.scheduledtasks.UpdateSecuritySignatureFilesHandler;
import cucumber.api.java.en.Then;

import java.util.List;

public class UpdateSecuritySignatureFilesTest extends VisionUITestBase {
    public UpdateSecuritySignatureFilesTest() throws Exception {
    }

    @Then("^UI Add New 'Update Security Signature' Task with Name \"([^\"]*)\" , Schedule Run Daily at Time \"((?:[01]\\d|2[0123]):(?:[012345]\\d):(?:[012345]\\d))\" , and the Target Device List are:$")
    public void uiAddNewUpdateSecuritySignatureFilesTaskkWithNameScheduleRunDailyAtTimeAndTheTargetDeviceListAre(String taskName, String time, List<String> devices) throws Exception {
        UpdateSecuritySignatureFilesHandler.addTask(taskName,time,devices);

    }
}
