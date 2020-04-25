package com.radware.vision.tests.GeneralOperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.widgets.api.Widget;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.FindByType;
import com.radware.vision.infra.enums.WebWidgetType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsByNameIdHandler;

import java.util.List;

/**
 * Created by aviH on 8/9/2015.
 */

public class ByLabelValidations extends WebUITestBase {


    private BasicOperationsByNameIdHandler basicOperationsByNameIdHandler = new BasicOperationsByNameIdHandler();


    public boolean validateTableRecord(String deviceDriverId, String fieldLabel, String rowKey, String rowValue) {
        int result = 0;
        try {
            List<Widget> widgets = basicOperationsByNameIdHandler.findWidgetByNameId(deviceDriverId, WebWidgetType.Table, fieldLabel, FindByType.BY_NAME);
            if (widgets.isEmpty()) {
                BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
            }
            for (Widget widget : widgets) {
                if (widget == null || !widget.find(true, true)) {
                    continue;
                }
                WebUITable table = (WebUITable) widget;
                result = table.getRowIndex(rowKey, rowValue);

            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + " \n" + parseExceptionBody(e), Reporter.FAIL);
        }
        return result != -1;
    }

}
