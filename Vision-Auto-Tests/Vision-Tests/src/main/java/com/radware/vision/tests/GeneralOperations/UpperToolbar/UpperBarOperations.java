package com.radware.vision.tests.GeneralOperations.UpperToolbar;

import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.navigation.WebUIUpperBar;
import com.radware.vision.infra.enums.UpperBarItems;
import jsystem.framework.TestProperties;
import com.radware.automation.tools.basetest.Reporter;
import org.junit.Test;

/**
 * Created by urig on 9/9/2015.
 */
public class UpperBarOperations extends WebUITestBase {

    UpperBarItems upperBarItems;

    @Test
    @TestProperties(name = "Select Upper Bar Item", paramsInclude = {"upperBarItems"})
    public void selectUpperBarItem() {
        selectUpperBarItem(true);
    }

    @Test
    @TestProperties(name = "UnSelect Upper Bar Item", paramsInclude = {"upperBarItems"})
    public void unSelectUpperBarItem() {
        selectUpperBarItem(false);
    }

    private void selectUpperBarItem(boolean select) {
        try {
            if (!upperBarItems.toString().equals("") && upperBarItems != null) {
                if (select)
                    WebUIUpperBar.select(upperBarItems);
                else
                    WebUIUpperBar.unSelect(upperBarItems);
            } else {
                report.report("Failed to click on the specified button : " + upperBarItems.toString(), Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Failed to click on the specified button : " + upperBarItems.toString(), Reporter.FAIL);
        }
    }

    public UpperBarItems getUpperBarItems() {
        return upperBarItems;
    }
    public void setUpperBarItems(UpperBarItems upperBarItems) {
        this.upperBarItems = upperBarItems;
    }
}
