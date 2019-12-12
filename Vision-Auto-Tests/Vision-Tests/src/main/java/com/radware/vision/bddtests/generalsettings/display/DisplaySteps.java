package com.radware.vision.bddtests.generalsettings.display;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.base.pages.system.generalsettings.enums.GeneralSettingsEnum;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.system.generalsettings.display.DisplayHandler;
import cucumber.api.java.en.When;

public class DisplaySteps extends BddUITestBase {

    public DisplaySteps() throws Exception {
    }

    @When("^UI Set time format to \"(.*)\"$")
    public void setTimeFormat(String format) {
        try {
            GeneralSettingsEnum.TimeFormat timeFormat = GeneralSettingsEnum.TimeFormat.valueOf(format);
            String message = "";
            DisplayHandler.updateTimeFormat(timeFormat);
            if (DisplayHandler.getTimeFormat().equals(timeFormat.getFormat())) {
                BaseTestUtils.report("Drop down selected value have been set to " + timeFormat, Reporter.PASS);
            } else {
                message = "drop down value did not changed\n";
            }
            if (BasicOperationsHandler.getVisionClientTime().matches(timeFormat.getPatternOfTimeFormat())) {
                BaseTestUtils.report("time format changed to the new " + timeFormat, Reporter.PASS);

            } else {
                message += "date format did not changed";
            }

            if (message.isEmpty()) {
                BaseTestUtils.report("Test succeeded", Reporter.PASS);
            } else {
                throw new Exception(message);
            }
            BasicOperationsHandler.getVisionClientTime();

        } catch (Exception e) {
            BaseTestUtils.report("Set time format operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }

    }
}
