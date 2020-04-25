package com.radware.vision.tests.GeneralOperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.tablepagesnavigation.NavigateTable;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;
/**
 * Created by stanislava on 9/9/2015.
 */
public class GeneralValidationTests extends WebUITestBase {

    int pageNumber;

    @Test
    @TestProperties(name = "Validate Table Page", paramsInclude = {"pageNumber"})
    public void validateTablePage() {
        try {

            if (getPageNumber() != null && !getPageNumber().equals("")) {
                if (NavigateTable.getCurrentPage() != pageNumber) {
                    BaseTestUtils.report("Page number validation has Failed : " + getPageNumber(), Reporter.FAIL);
                }
            } else {
                BaseTestUtils.report("Incorrect page number provided : " + getPageNumber(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the specified table : " + getPageNumber(), Reporter.FAIL);
        }
    }

    public String getPageNumber() {
        return String.valueOf(pageNumber);
    }

    @ParameterProperties(description = "Please, provide expected Page number to verify against!")
    public void setPageNumber(String pageNumber) {
        if(pageNumber != null) {
            this.pageNumber = Integer.valueOf(StringUtils.fixNumeric(pageNumber));
        }
    }
}
