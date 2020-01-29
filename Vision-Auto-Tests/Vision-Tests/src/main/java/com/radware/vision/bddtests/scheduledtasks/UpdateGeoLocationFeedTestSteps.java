package com.radware.vision.bddtests.scheduledtasks;

import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.testhandlers.scheduledtasks.UpdateGeoLocationFeedTestHandler;
import cucumber.api.java.en.Then;

import java.util.List;

public class UpdateGeoLocationFeedTestSteps extends BddUITestBase {

    public UpdateGeoLocationFeedTestSteps() throws Exception {
    }

    @Then("^UI Add New 'Update GEO Location Feed' Task with Name \"([^\"]*)\" , Schedule Run Daily at Time \"((?:[01]\\d|2[0123]):(?:[012345]\\d):(?:[012345]\\d))\" , and the Target Device List are:$")
    public void uiAddNewUpdateGEOLocationFeedTaskWithNameScheduleRunDailyAtTimeAndTheTargetDeviceListAre(String taskName, String time, List<String> devices) throws Exception {
        UpdateGeoLocationFeedTestHandler.addNewTask(taskName,time,devices);

    }
}
