package com.radware.vision.tests.generalsettings.Display;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.system.generalsettings.enums.GeneralSettingsEnum;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.system.generalsettings.display.DisplayHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by vadyms on 5/20/2015.
 */
public class DisplayTests extends WebUITestBase {
    GeneralSettingsEnum.Language language = GeneralSettingsEnum.Language.ENGLISH;
    GeneralSettingsEnum.TimeFormat timeFormat = GeneralSettingsEnum.TimeFormat.DEFAULT;

    @Test
    @TestProperties(name = "setDefaultDisplayLanguage", paramsInclude = {"qcTestId", "language"})
    public void setDefaultDisplayLanguage() throws Exception {
        try {
            DisplayHandler.updateLanguage(language);
        } catch (Exception e) {
            BaseTestUtils.report("Set language operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Set time format", paramsInclude = "timeFormat")
    public void setTimeFormat() {
        try {
            String message = "";
            DisplayHandler.updateTimeFormat(timeFormat);
            if (DisplayHandler.getTimeFormat().equals(timeFormat.getFormat())) {
                BaseTestUtils.report("Drop down selected value have been set to " + timeFormat);
            } else {
                message = "drop down value did not changed\n";
            }
            if (BasicOperationsHandler.getVisionClientTime().matches(timeFormat.getPatternOfTimeFormat())) {
                BaseTestUtils.reporter.report("time format changed to the new " + timeFormat);

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


    public GeneralSettingsEnum.Language getLanguage() {
        return language;
    }

    public void setLanguage(GeneralSettingsEnum.Language language) {
        this.language = language;
    }

    public GeneralSettingsEnum.TimeFormat getTimeFormat() {
        return timeFormat;
    }

    public void setTimeFormat(GeneralSettingsEnum.TimeFormat timeFormat) {
        this.timeFormat = timeFormat;
    }


}
